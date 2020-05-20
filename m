Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE87C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FEE206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0Q6dzcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FEE206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbQpr-0003IV-KI
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 11:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbQp4-0002o5-P0
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:39:58 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbQp3-0006jf-Mn
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:39:58 -0400
Received: by mail-ot1-x343.google.com with SMTP id z3so2793924otp.9
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uP0JZu46WiAIyy8/dtcGiSkK4L1dtQwKedNq4X5WF6I=;
 b=u0Q6dzcz70Cw4PDZYH+el8q5mNP/sc/13qgX1mwaII/ARoYe8LZ1+82mZ/C0fuRlrg
 +id8RkOiJ5lBDUjahsgO6b74hrbzf8VJGY0wcbKbzQus9OGr4XUV8wqMQIFhws0JEq1V
 cd/mlHqZ0isN3mg/iz5aQcaqJGJ4cXd69by2ONjkJcDoQzKVo8Q0rYFiV4YHjpsPgmlQ
 UKdKxBDhmzME3ryl5fIOvkzK10QXoRGVIh2WZDNCC6SxEBZgox4rJcIjsxftcb7/mUhm
 fSGS1671h3pfgtRNZP1Kwq9oslltqtQwoLEofgb27pNr7NNb6VutH7Br5S7WGFDSeMkU
 093A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uP0JZu46WiAIyy8/dtcGiSkK4L1dtQwKedNq4X5WF6I=;
 b=IBXAhraw5WAXnZRV0GaFW5ZQbGcFgq4Opp6uEf9wb1i5smndyUd6Cev6UVbskd1Ney
 zOH44+GbzXEcDTXONyzpc7GL3XGmjp/xz5Q1TU+4zMPS97ZsJhuHq/6sz8g1lg5ftWoO
 FnA9Q+stOtoABDRYCLOAvGKrOYooI3ljwo9Q4jGWLd3kO4/D4SBozA0ghUTH8fooHUl4
 Iw1wsUnaRpB/PfphpnIOQa8vb29wr2yrZydtDxrxcDT+gYd3dlXdvhKobT8ahlykovZN
 dgm3+ScZ/NgpdQANH1Ubp/rygE39nDlJ3+UohHGQUN0G7bk7dDql2dEjs18sTMH72Pok
 KJIA==
X-Gm-Message-State: AOAM530sTa4LGBu7OABYti2QSG42yTPKwGXC9AgIchxovJdeZQD7cXUj
 MUe7mPhh49AtVgxB7Nd9ecazcBt2FLPPr6r1rsHGdA==
X-Google-Smtp-Source: ABdhPJyLiH5H7I+f0eo6Gi7QwiXVbhEOq1rlERGpbpEkCOU5TfhvpMvEfLsOi36KRKlH59U4HveRhG1COPgo8scUaw4=
X-Received: by 2002:a05:6830:158b:: with SMTP id
 i11mr3703636otr.135.1589989196314; 
 Wed, 20 May 2020 08:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200520152450.200362-1-ppandit@redhat.com>
 <20200520152450.200362-3-ppandit@redhat.com>
In-Reply-To: <20200520152450.200362-3-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 May 2020 16:39:45 +0100
Message-ID: <CAFEAcA_WbJR9PWpw4f2jWecouSn7U0y9=0t4ek1rGwxtM6tXBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sd: disable sdhci-pci device by default
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alexander Bulekov <alxndr@bu.edu>, Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 at 16:28, P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Disable rarely used sdhci-pci device build by default.
>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---

Doesn't this break existing working command lines? The
device exists, some people use it. We should treat it like
other PCI devices -- if the guest arch/machine can handle
PCI the device should be built.

There's obviously scope for being more general and allowing
some kind of "only build the subset of devices we feel
more confident abut the security of" setup (don't RH do
something like this downstream?), but upstream we don't
have a concept like that, we just build everything.

thanks
-- PMM

