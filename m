Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C465C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB90A23600
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD/F2u6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB90A23600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKgTU-000698-Lh
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kKgSK-0005Tg-Mz
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:27:32 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:36872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kKgSI-0008Jh-3S
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:27:32 -0400
Received: by mail-io1-xd43.google.com with SMTP id y13so19120167iow.4
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 04:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m8MvR144WLYIJuwQbZkC0Uxudma8jnVNUdE2F78H4e8=;
 b=GD/F2u6az+J0W5qquVxpJZeQl0lh0RRq2JWE3/zCuJdXzhhBz/Tel/YvM3yg6xNZCu
 /9cPLkVJbn35z0+Amw05M5s63V2uSPluvnsubZnYrlZJ6jNpF/NtpL9KTKtlfS2uRB/t
 BjUwIhi+r1ybw8dzT3U7ihz2r8wh0EeB2RxylpQxKLd9pdRZ+i7299ivSD830JTPiSks
 88ClTI3j904L3ehh2FgiDZZK+DLbaIp6Kktzf6xbRgC7ue+ChqeDVC7SA4Ryxhapc5yU
 hEnSqEmtFzqzCf7EWvP8NZW0xqJB0QMIraJiwExRKeXTerUk2pVnQHjVR14Aybv1o4wL
 8Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m8MvR144WLYIJuwQbZkC0Uxudma8jnVNUdE2F78H4e8=;
 b=WRnI0irn/qWpCDFQwALX3nHOJ2xxU1iAYGr85vcr+VYAQ6TU61g3oaT1r7I/RC7hWQ
 YL+v8WO0D80lr/Hj6TkGUF2383F9Dl5bOESevKfgCP7IFyhVOwhApIYxjqBn5IPCog9E
 4BKt+E711PktfmB5Jo/4EzN9L82uhWUXZndfDHXeQGpxg3JkvHJRVXwcfCfICzC2jp57
 Wp1dT8RP3rofCwyENVXE30FwfJ37+3jwF6L2/ccsDAwq7xUAwnXJVzH0OcexWEDz1ZQW
 MrophSsWIcIHiQiYrnOxrEhWSNcDO3abHHP2bmB+NREvqnfmATHSxZIhtTZdioN+TwHl
 ecCg==
X-Gm-Message-State: AOAM530uCZ89nfudz8P4glCyfTTVTAqf34Gk3wRmRBVUTD29Wr4N9Uwc
 +cyFML90bdlRf4zBp0Gkf6hr8Qxu5AExbx3e/vE=
X-Google-Smtp-Source: ABdhPJytUmxnH6r8ELa+ycGuh22cmvFuRJ4MLKsyIqiPuUzO5VDWdAw8fEyTTi35vjA9ZdFJHdfwhzUcNLuI+OSH5TE=
X-Received: by 2002:a05:6638:4:: with SMTP id z4mr3533463jao.123.1600774048411; 
 Tue, 22 Sep 2020 04:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <1600742967-12933-1-git-send-email-chenhc@lemote.com>
 <1600742967-12933-3-git-send-email-chenhc@lemote.com>
 <CAPUEspjsv09JhMgurc+rS-ds0drn9ZviN6UBmo+mmPUDH3j7Cw@mail.gmail.com>
In-Reply-To: <CAPUEspjsv09JhMgurc+rS-ds0drn9ZviN6UBmo+mmPUDH3j7Cw@mail.gmail.com>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Tue, 22 Sep 2020 19:27:16 +0800
Message-ID: <CAAhV-H7X_GLyRtw+sM0k-PZr3C0nTFnn+PtU=3-VzCm3LixEmw@mail.gmail.com>
Subject: Re: [PATCH V10 2/8] target/mips: Fix PageMask with variable page size
To: Carlo Arenas <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=chenhuacai@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Carlo,

On Tue, Sep 22, 2020 at 4:00 PM Carlo Arenas <carenas@gmail.com> wrote:
>
> On Mon, Sep 21, 2020 at 7:53 PM Huacai Chen <zltjiangshi@gmail.com> wrote:
> > was just added to mips target and that's nolonger true.
> s/nolonger/no longer/
>
> IMHO might be worth also mentioning that it was added with ee3863b9d4
> (target/mips: Support variable page size, 2020-04-08) to give a little
> more context.
>
> some other typos below might have been raised earlier as well.
>
> > +     * When invalid, ensure the value is bigger tan or equel to
>
> s/bigger tan or equel/bigger than or equal
>
> > +     * the minimal but smaller than or equel to the maxium.
>
> s/equel to the maxium/equal to the maximum
OK, this will be improved.

>
> Carlo

