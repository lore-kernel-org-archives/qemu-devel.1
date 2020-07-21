Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A74C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87BB20720
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ysFwfXYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87BB20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxvGM-0000fu-6j
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 12:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxvFX-0008Nr-OA
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:36:15 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:39492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxvFU-0000De-VI
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:36:14 -0400
Received: by mail-oi1-x234.google.com with SMTP id w17so17754722oie.6
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 09:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=53g4g+ACUrjSoP+PZBASP0ajghZPhdeS4sI046CtSCI=;
 b=ysFwfXYH8SZNRMSfGCQxsyvaSBZBpjmrdJuGj/15ozlMoW7QJcs/pVjtKo4uunpfTj
 SSZUbOvvyx2ALOwRTyBbMNnWAyd9WcFhkMnCar3HiDy4Vax67a7/g6V94i1HvQcoS5ju
 i54CF9Fca7PdkjQ0D+B+y6hwZ6FyxVo6HqV2yjIytiPE2EA1VSdeXzbbi5vD/ymqwqHA
 EX3xRthd7SCpWO9xcUstgS6ehIfn2Nj1ybAZ7cng1niUYdU+OPYQ0hJZA6scUym0cmaw
 iCFJFm19UOpWYE+JWexSyizZvw7QKwwsn563aZiqnCrtN0e18UZFrAe+JfYu+/0qQjLQ
 kZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=53g4g+ACUrjSoP+PZBASP0ajghZPhdeS4sI046CtSCI=;
 b=OfhApFbIiN+75z520PLv5q128/jEVafTdsxeUkOz7OcDqsZADbBhglK/QUR/hmNXu5
 atzXDDzaIQJyoPqyvi0FNXmPBLIhwVDPzjtYLtZMSQ/0wn45JHjGzC8Ds9OlVRsWg83t
 KG1G3DwkdDu3L7LxvIC7GKr3XdBAHt3iAcsRzD7dWidpCDG3iyCppBjxcpLg51qDwKsy
 nP0jsR/4RcaZQXVAWVwBqqHPLqACJYsHcr9UjbKPL8NxyF9RSvI1WpL6kovoiYGF5ZXb
 h71OrESOgJ7lVX8I8ctWv91l2y5Tjy4mHWmNhFP1JDaHT22iYbVRM7jSIYWVhW2iKXlY
 XAyw==
X-Gm-Message-State: AOAM5331p/vajWwYmgL8zUH9pwRIEPnCy44SfwGi03xaHcfdH/tsrKHT
 8QXmM/pbbgF8gyeyvCdY5ypGTACRyFIuq3qG2A41ug==
X-Google-Smtp-Source: ABdhPJz18eh76tOPumqzFkkPlaq+scsmaLxiVhCceNvuMAQdIgnbNrk0Lrm648j4Y4mNTW+hOOwa/TMU/CL6MyWVa+U=
X-Received: by 2002:aca:2819:: with SMTP id 25mr3511948oix.48.1595349371754;
 Tue, 21 Jul 2020 09:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <1595338467-19556-1-git-send-email-jasowang@redhat.com>
In-Reply-To: <1595338467-19556-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 17:36:00 +0100
Message-ID: <CAFEAcA9JHPTB4KuKY8a6ZXYiyj_i3k=Ej0m3a1Pw0j=ahkSHdQ@mail.gmail.com>
Subject: Re: [PULL 0/2] Net patches
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x234.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 14:34, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit 90218a9a393c7925f330e7dcc08658e2a01d3bd4:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-07-21' into staging (2020-07-21 10:24:38 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 5519724a13664b43e225ca05351c60b4468e4555:
>
>   hw/net/xgmac: Fix buffer overflow in xgmac_enet_send() (2020-07-21 21:30:39 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Andrew (1):
>       hw/net: Added plen fix for IPv6
>
> Mauro Matteo Cascella (1):
>       hw/net/xgmac: Fix buffer overflow in xgmac_enet_send()
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

