Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A98C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 425BE22281
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZRJ6kCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425BE22281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMOS-0005dP-4H
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXMNj-0005BZ-5l
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:39:11 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:39397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXMNh-0006bp-85
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:39:10 -0400
Received: by mail-ej1-x641.google.com with SMTP id bn26so1492325ejb.6
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 03:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vNrmSfvQqzUdG0nmbvUumKExQ16yAXlPQk0uN64w0sk=;
 b=WZRJ6kCbj79Ze8kLw3/Fo38glOGhUOWTnkIxUE/KmoOdFWmesdy5DfLug79nEk5RaF
 CcZO31gp4y3ydx4dbnlnCy/t3MdI3X2MCW0Z6oP9sMWSPqUIF3OmoOQoRUX07jAqBH42
 pQSqkWv1x9vVSBpoQNXfUeN+MpTx1htoBxPsK2bMtYRdP3g68Qr4NE/UyUZ26rZnSlMr
 zYZ4rutL+Xt/GeF0FJmZMOO2FCKxnQxP82Yo/nvHJZydL1Q6HCLm7wkPIFcuZNav/ay/
 1HRKUyxz9pHVbZn2tgR61xYsZgNslA9lnRS+2ySnmsbBrdCw9Rr8QxAcEFWRVVTFjDqi
 xv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vNrmSfvQqzUdG0nmbvUumKExQ16yAXlPQk0uN64w0sk=;
 b=SwGcHQHebKOBMOtjFo+OAigj6ihaEa1k5Or82aFrBcDBGbF/QBx44bszKOqHruxXUm
 v+ruxoo5GykMqID5k2LCSkuenGKIsPGqvXWZOmgjvS2Aboh2wEcbxJ48yCe6J8NALaXb
 ANUjkSzNimS5kxtOjKtQQ9ir7saNuM3W7E6I0a4VoHWH/Pyf8WxzxaJGmvKlFmrbxjR2
 WHnB7F8ZnzQjH54Od9c7b/0pRCG69DRpWRmX3dbncfXdo7UzEBELqv9ckOkU6AehSXIE
 lX8fHZo/PZ6R5c0Oxpi60ISEjye+KHzH7N1y5Gg6KsVMiZJLsJvuuJIaeNjGq6CGZ7nc
 vrYA==
X-Gm-Message-State: AOAM530yQtk3h4KoZdTdL9uHSLTwlNSSzRemRd670UwNXI4tW7CgWfyR
 SS4l37uEbdlL/YqOtXMjnaC4cgYjzAyk8flpvn2YOQ==
X-Google-Smtp-Source: ABdhPJxpAtJc/uSk/rxp383UEC29wibXFkMli8vfvDV3djQjlzQ1HVU0r2RNu/t9Bvbx6mIkKKRO51U8D1hhrjYu7KU=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr1720279ejd.250.1603795147341; 
 Tue, 27 Oct 2020 03:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201014193355.53074-1-dgilbert@redhat.com>
 <CAFEAcA8CYt-rkovgj_5kMtygsPNm3C4F6yi4s3cb0bduz7+NaA@mail.gmail.com>
 <04136efa-9229-6c7e-d43e-0033a354c2d4@redhat.com>
In-Reply-To: <04136efa-9229-6c7e-d43e-0033a354c2d4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Oct 2020 10:38:55 +0000
Message-ID: <CAFEAcA8uZZUzXq2sJFC8puGn_OZFT8kmPTmTuOB+-e-7A5ntrQ@mail.gmail.com>
Subject: Re: [PATCH] arm/trace: Fix hex printing
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 at 09:24, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Peter,
>
> On 10/19/20 9:26 PM, Peter Maydell wrote:
> > Eric, do we want to use hex here, or should we go for
> > decimal the way we do with (almost) all the other
> > tracing of stream IDs (eg mmuv3_cmdq_cfgi_ste in the line before)?
> >
> > The other odd-one-out is smmuv3_find_ste which prints a hex
> > SID; I think the other tracing of SIDs is always decimal.
> I think my preference would be to use hexa here and in the other places.

OK; I'll apply this patch to target-arm.next; feel free to send
a patch updating the other tracepoints to hex.

-- PMM

