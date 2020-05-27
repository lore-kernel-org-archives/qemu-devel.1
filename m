Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54368C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B82A2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pegVjvJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B82A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxkr-00024y-AE
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdxkC-0001Hk-72
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:13:24 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:45642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdxkA-0003Ig-NW
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:13:23 -0400
Received: by mail-oo1-xc44.google.com with SMTP id p123so5049790oop.12
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RoQohWwhsPwH6tuDAjp+k7Z3AKBbw6zyCf5TngciUzE=;
 b=pegVjvJFtAyBoHxWlsmtVHgm+0plLtXodRF/HpgaxaIzIrVP9PQt8JgpbxcpPRULi0
 nSzowbkiVZiYd8DHKAK2MtZPEBrrYC2B6d8sweQMrK6MP/V9HwlGq56QdJw/s1D/EUkG
 4h7XJVFwTXhdsvv66wqL+GuL+eqUGhKYgwOK2+NVcCj9Ep/o9Ju6SJ8t1QE5MJt6ZC2Y
 Av6BN429DUg1pASdlHC6ehkxq3TTKkp75A2G05RczjAzt5AoT5jet77x6HuTPD57+8uX
 C+WeCyKdmqy/JUFbiH9q/AOfphFMev8ed296PajOt1wiejib7eUHSGTBT5Esqgf10lXI
 tYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RoQohWwhsPwH6tuDAjp+k7Z3AKBbw6zyCf5TngciUzE=;
 b=MpuebpLksmKYyoJEQrHDlkgXIPCYS8bGzOI9wRyV05KGcHohinPl2ikCGkJmUPAQKR
 M0mvT0/TJyeLkOD7qwyvCpo4JnDqlfIp3Jhab6Gl5CZ/QocaTuoQsSM+TCZc+AKH7l9H
 qk0mAleCwKliuQsuwU4xeq0lSaZfCzkRX+HHNwzID+peom5l7PDVl8fiMroWDtKmRT7T
 s3gxNIVrboEu2ejHpzxsotG9jZr2RTT/3VPbILyzaqXZLJ2g/SC/njIr0uv7lCQbylyp
 crbelQvePkuz1YuFEQZGZo0tVus3j5QwMepRYzH99KOw/NWxOwBbarRNJa0C/MygeaPH
 lSYw==
X-Gm-Message-State: AOAM532tv0pLOLEfa6YlV3GjPpM+MwNTL2vxzk1Jm3xhbzC9W2F1lCGU
 pn/oM64m9a6motGn6Yd2I27HfY45RZwJpjWSjK24qA==
X-Google-Smtp-Source: ABdhPJz1DFAj6DK/qlaK27E066H+qQc3qWA0J8oWB15+e79UKC+G9ocshP22JM5sQnI2HK4LaTMPKY8XE8KQAcng1z4=
X-Received: by 2002:a05:6820:5b:: with SMTP id
 v27mr3432818oob.85.1590592400900; 
 Wed, 27 May 2020 08:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200526133247.13066-1-f4bug@amsat.org>
In-Reply-To: <20200526133247.13066-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 May 2020 16:13:10 +0100
Message-ID: <CAFEAcA_qHkz194x8zR-eQscx3JQ6DxXKbWRJDiM0EdEED3QZCg@mail.gmail.com>
Subject: Re: [PULL 00/14] mips-hw-next patches for 2020-05-26
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 May 2020 at 14:34, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The following changes since commit 8f72c75cfc9b3c84a9b5e7a58ee5e471cb2f19=
c8:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20200526-pull-r=
eque=3D
> st' into staging (2020-05-26 10:59:01 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/mips-hw-next-20200526
>
> for you to fetch changes up to 97d8974620053db5754af808583de70380f73a10:
>
>   MAINTAINERS: Change Aleksandar Rikalo's email address (2020-05-26 13:21=
:12 =3D
> +0200)
>
> ----------------------------------------------------------------
> MIPS hardware updates
>
> - MAINTAINERS updated to welcome Huacai Chen and Jiaxun Yang,
>   and update Aleksandar Rikalo's email address,
> - Trivial improvements in the Bonito64 North Bridge and the
>   Fuloong 2e machine,
> - MIPS Machines names unified without 'mips_' prefix.
>
> CI: https://travis-ci.org/github/philmd/qemu/builds/691247975
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

