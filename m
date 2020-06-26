Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9AAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:31:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E3E20768
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSAfKPnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E3E20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joleC-0002Cn-FZ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jold5-0001FD-L9
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:30:43 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:41293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jold3-0002l0-Bt
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:30:43 -0400
Received: by mail-il1-x141.google.com with SMTP id c75so7994382ila.8
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QOMrcDR4U+V5T92GZcEbutx6Qmep+lKhersa8iF6bWA=;
 b=oSAfKPnzMel3+gEaHB+GZ2ZxiqMnZmTnxar5uWccr9B9n+TAIApW3iANN9Ky4A1TSw
 xbXm7n87HuFiC4lCPWsP4OqyQ/ZsA6X8TujZL9zRMKzIQyZ05mn+bQ3UUddE0S45vbjB
 59f4pT0RXaeGXi8mFGXgLnDGzxIn5Y5xEF1/YDdA4KM82er8WyUs8ivWDKMZYxDPorfz
 AHWxaPOOjGJSwu32lv2A2QW7QzQ6+E/AA8ewTSZ6iuym2ZoPsDPHT00IjVMzE0YjTvXE
 xGwrCaX7NCr63Io71L5lBIBbNGlR5r6BNLeVN40UWZrP+CyCG0kbjiKwRqL980dOj8w/
 ZOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QOMrcDR4U+V5T92GZcEbutx6Qmep+lKhersa8iF6bWA=;
 b=iyMYKh8iNGAORMGc/js25QQ1wmmGCorzVemiCa9bewtxRI78U7fs9BxyTxly4HsnU8
 k5ehEA8XRgTNLfBUGaXOtIxeqAcg9BFTmnRPLZQnw5qw5YxZBZPxYgb6MTGQssARWKpP
 rjUTrGsfVYRoGCWUVL/S9JslRP0JbgKZ2odxFskzr+UnX8VXfEUxhkTE+6n2+UlVa0kd
 XqjKSQGSecaXZ2THRBpJ9iVwgl8Hm6I50mHyDYPyVRTXMLdoR5/reU66RgbqUFrPbL4S
 SuC2xkwUO9WdyqmiEGihnM9oy6gvQ6Yb6baNKdEurAbNN+J+vaC6i/ECC3f0JBT4S7tT
 EdzQ==
X-Gm-Message-State: AOAM533fkaOyxONMg5TUFIrhiG2Fv0VvjMSgxgBAtQ7NHXL2mEN8APa8
 Nph0U2oEeoequfR2GxI1OBs2VSCqD022D1atpjk=
X-Google-Smtp-Source: ABdhPJw0V6DWQzOalHV2Ug3rpxYyd4/jnm6qlhdnkKZ4tdYnPGcjkXTtnpeiUq4KD5maobqPfJ3ohFANtDhepVwn0h8=
X-Received: by 2002:a92:9196:: with SMTP id e22mr2267999ill.147.1593167439950; 
 Fri, 26 Jun 2020 03:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <1592914438-30317-1-git-send-email-chenhc@lemote.com>
 <1592914438-30317-4-git-send-email-chenhc@lemote.com>
 <CAHiYmc7FVCu6WTyFfUdz84iBYaL9QtrQ+Mv_nFU6KzzCWbnz=Q@mail.gmail.com>
 <CAHiYmc75wGPk=rQDTw9PfFGSsEzhgTXzTKTQC0GjiHWX-kH7aw@mail.gmail.com>
In-Reply-To: <CAHiYmc75wGPk=rQDTw9PfFGSsEzhgTXzTKTQC0GjiHWX-kH7aw@mail.gmail.com>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Fri, 26 Jun 2020 18:30:28 +0800
Message-ID: <CAAhV-H5FatNAvPk5SXkGQJ7s55bvsUoYSZQQFgMon3KKcFvjBA@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V5 3/4] hw/mips: Add Loongson-3 machine support
 (with KVM)
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=chenhuacai@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Aurelien Jarno <aurelien@aurel32.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Alexandar,

On Wed, Jun 24, 2020 at 7:27 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> >
> > What exactly is missing in tcg support? Would it work if Loongson EXT is supported in QEMU?
> >
>
> Huacai, hi.
>
> I couldn't find the answer to this question in v6.
>
> Could you please clarify this aspect?
Jiaxun said that Loongson EXT is the only thing missing.

Huacai
>
> Thank you,
> Aleksandar

