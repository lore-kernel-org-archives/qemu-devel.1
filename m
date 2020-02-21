Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183A1C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEA620578
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NFrGUoFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEA620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58nh-0006r1-1m
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j58mw-0005vu-10
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j58mu-00033K-Rl
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:56:17 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j58mu-00032M-MG
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:56:16 -0500
Received: by mail-ot1-x341.google.com with SMTP id r16so2056185otd.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c4760tBMjRqhqroGKwzEfY8GzOZj9O6HB76lR+c+SFg=;
 b=NFrGUoFNSIdGqDfAVZhihtnr7cD3fv6fqPJeNRGRwpq5GTgdInFDsU9ccEEFa2+oGA
 X5HHIO5kbrPGti6whwmX0djXPSb/woOoDMiOd5Vcj6bpDc3Ypo1N5f8XlCTFw6Wo07O9
 WlbPy+ehHO1l7zGxe5R96sndT5OWzfnMeEPccREyjsH5KahTsZVeHS1uPNjA4yg3H8Ny
 lTODPN1KzdROdDoBWRgBb74Jrp2w+GI9fhL9SV8XWmZGF/3GuvLDX4VrcekuOMty9JH3
 NUw/Cb1OIG4PitbRj3VNXz0q25wCRxPBRAv5peQXerunqn3ZiB7Me4zvLj7u47s/b+yh
 DzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c4760tBMjRqhqroGKwzEfY8GzOZj9O6HB76lR+c+SFg=;
 b=UHyLXUrEwEAkYQcF0BzcG2qx4kn4WGDTvmk8mJrzAB46v7MlcjiipnMT2Br/OfVDfY
 l1XZ3QW/1mSq7euCw/adPFJKzoW2wWnC/fpoFUoN8wThpIckNrdxo6cjffQpW4IxuKC/
 aDGSlY80M8OruGl1L0/CA9xdzQU8m9zsEimk5Koo5nRfFLllI3Pq/Hdsmt4BGANGKx8H
 uF3pkgHhrL2lZYOvGB3+0Z/vKDkM1TI9CdFzM4XbClAMr/DLaQz/ggwpxLNTQ1cNFcM/
 /+yGjMVRa7mjAhx4MNp6FdJ/NWyXSNalD7l/znN+W8MmLnZToZG40e6CMkTdMe5S21jq
 ONmQ==
X-Gm-Message-State: APjAAAXIDFi9S3IoprFCsn2CLmAo9T+Wd6OojOOCq8QjV6E6JNJp/Ovg
 cyJUFQ89Z/TOcaGv3PBitVDikDn31pdSl6327s5kOg==
X-Google-Smtp-Source: APXvYqysYCuli2degmyMzWwW+R2/BUsYiFMOLUHTOy6V9LYxzPDdkQlLVzkTyjDPGcnG2sGaS8Pfu3OQlj3uu2rlUSI=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr26452878otq.97.1582293375527; 
 Fri, 21 Feb 2020 05:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20200219220333.1411905-1-laurent@vivier.eu>
 <CAFEAcA8g+uRrGuNLdURegmpjRLtk=vVC9zUE1+QVKRitPjJy7A@mail.gmail.com>
In-Reply-To: <CAFEAcA8g+uRrGuNLdURegmpjRLtk=vVC9zUE1+QVKRitPjJy7A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 13:56:04 +0000
Message-ID: <CAFEAcA9xfrevtS=KupC1H2oMCG3p2LUqDvKN9KX-cW12OhJbGA@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] linux-user: generate syscall_nr.sh
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Feb 2020 at 13:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 19 Feb 2020 at 22:07, Laurent Vivier <laurent@vivier.eu> wrote:
> >
> > This series copies the files syscall.tbl from linux v5.5 and generates
> > the file syscall_nr.h from them.
> >
> > This is done for all the QEMU targets that have a syscall.tbl
> > in the linux source tree: mips, mips64, i386, x86_64, sparc, s390x,
> > ppc, arm, microblaze, sh4, xtensa, m68k, hppa and alpha.
> >
> > tilegx and cris are depecrated in linux (tilegx has no maintainer in QEMU)
> >
> > aarch64, nios2, openrisc and riscv have no syscall.tbl in linux.
>
> Is it the case that all our architectures either:
>  (1) have a syscall.tbl
>  (2) are using the asm-generic common numbering system ?

I think that for asm-generic we should be able to generate
the syscall_nr.h by suitably defining a __SYSCALL macro
before #including linux-headers/asm-whatever/unistd.h --
They basically define syscall numbers like this:
#define __NR_setxattr 5
__SYSCALL(__NR_setxattr, sys_setxattr)

so a C program that just did the autogeneration has the
info it needs.

thanks
-- PMM

