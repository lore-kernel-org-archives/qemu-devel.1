Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29842CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E61E62086D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rftSiUPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61E62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP5BG-0001P9-TT
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iP587-0006nw-Qq
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 09:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iP586-0005Jg-8v
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 09:32:19 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:45867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iP586-0005Ic-2r
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 09:32:18 -0400
Received: by mail-oi1-x232.google.com with SMTP id k2so739782oij.12
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 06:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iXoDgzcs+7NR0yYllfi3a4ktjcsvxp8pYcO0MdUoBkI=;
 b=rftSiUPGNfTIMv7X304eGZMX0Ttsw2dBWkhD6rBQGSbiE98NUnoZqx40jSGCKi9d7v
 abrH1+Aj3/ib4pmHDE6ii8rvKpoUAqgxMNUreODK/pMCccAqlgNmzRsxRK8NVWolxQ8w
 +qZzAV8Gq8rqJKuF1xYvySh3iBnz1k0DAWWfi4NM9DExJHgrWBmNMHokQ4uSkact16ef
 FgGU1wAwYarsQHoc9Ve/DapuLFjiWGduHergh2pleYG5C0bJcgC+Wq7vBEfGeycrA/M1
 n2mt9i3OmWzntnOY+C+pbmbOGpz3D3Lmqbg00Wls2zn9TG1e9YuWLwt4ebf506tt2FDd
 4sWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iXoDgzcs+7NR0yYllfi3a4ktjcsvxp8pYcO0MdUoBkI=;
 b=lHiOC04O3S7PY5DcKLjJH0IhF9xViVo9OTkXE8InZ0v/uQsboKlnyDcrL56jx2uu/4
 Mp/+QglKKYypxlQyrbUAfgIQswqSS53THm7dtpsiC73tz2XGSv3AwE3E849EjaUFZxAL
 mzucCJvbaPebs21Wu/xxgXH0+PT5usPE7gyA4KoKAkdPcdgriFmbjbKVYHQcInMZFquZ
 vH4tTXtZcteeHZirXszNYkKTmFCzvfHBH5k5LmqxNrO00rJbv9G6/b+9Rm2Nui4vLrOO
 ZKfZ2BvHz8APfCFjohN+PeNuX5M1yDB2b9Dwf2FFoOahPeJEXP3Tp1pGwvtspqvYNDRr
 skAg==
X-Gm-Message-State: APjAAAWuKsznCBXSEPqmsYYlue4z9TFcUSJkV+dMpnZeB9uD1bgDpoRc
 DLjbPpi58MFlfIk4wf3N5MdlyfV7sImDY6dsEbGEDA==
X-Google-Smtp-Source: APXvYqw/qYdP/h4Q8Y4t2LRppMIKBDXaBhIAqXUIYDKBCz6TUYKqF8f3PuWmdmwQYBBfMqZICqaikB8rp9J6zwCTE9U=
X-Received: by 2002:aca:2312:: with SMTP id e18mr17746oie.98.1572269537134;
 Mon, 28 Oct 2019 06:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <1572097538-18898-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1572097538-18898-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Oct 2019 13:32:18 +0000
Message-ID: <CAFEAcA-RypiVv5Wc92FMw2pAxtNjLLrOTWQzAYb4Ps_mRKsm-g@mail.gmail.com>
Subject: Re: [PULL v2 00/39] Misc (mostly x86) patches for 2019-10-24
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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

On Sat, 26 Oct 2019 at 14:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit e9d42461920f6f40f4d847a5ba18e90d095ed0=
b9:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20191018-pull-r=
equest' into staging (2019-10-18 14:13:11 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to bf13bfab0840d34a74938ddf567d52e9010dbdc6:
>
>   i386: implement IGNNE (2019-10-25 13:18:21 +0200)
>
> ----------------------------------------------------------------
> * Bulgarian translation update (Alexander)
> * RTC and PC refactorings (Herv=C3=A9, Philippe, Sergio)
> * RTC fix (Marcelo)
> * More comprehensive MCE logging (Mario)
> * x86 IGNNE implementation (Paolo)
> * Microvm machine type (Sergio)
> * Support for UMONITOR/UMWAIT/TPAUSE (Tao)
> * Do not use %m in common code (Thomas)
> * NoNonArchitecturalCoreSharing Hyper-V enlightenment (Vitaly)
> * getpagesize cleanups (Wei)



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

