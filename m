Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11333C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CF621835
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYPEWlMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CF621835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icuMo-0004tK-Ts
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1icuKQ-0003K0-PK
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1icuKN-0005im-Vx
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:50:10 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
 id 1icuKN-0005e9-Lj
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:50:07 -0500
Received: by mail-wr1-x444.google.com with SMTP id b6so4503782wrq.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 08:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pIYiZe3xTXQGCytMgauABRVzXtBiSOUwdK9yjvTV4JQ=;
 b=wYPEWlMQfTjd9RovCk2ixGa09GRZfrgU5CasBMcZw3oRD6cXu6e+9mMu0j96rHvwfG
 AmNvPXUNFKWtIfd41z4LHb3ScI36awSvVfLXbJlkuuYjAdNhvZWMV6DzZW9+YTf7JCgW
 cewf78CGTDlbomUStaYSj8JNCzEvDiPZ/L7paptx6nTh2P3iKqWeGvMgoo5nr4iU4X1R
 MImCm6JER43Z0kcX1w+qnAD2teh2p5Qk8QK9IfxfgIkI0/PDCBlpyjfSVh2DYITs/tOK
 f99d7R1wAwpVSuhGe52Sj2UeRZ5nH5HhIuR5ak9+MvOCxjFCFEEpJ12wk+8XPn0lVyl6
 RBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pIYiZe3xTXQGCytMgauABRVzXtBiSOUwdK9yjvTV4JQ=;
 b=Nm1L+Yg6r5CGkPh4OihGvMIlGdwUWU0M3JyCvfyQbjgU8UHCIm1rqCnSV+j+pE1trI
 nJCSlnP1ngnxWdGsy3vSK6Kz9uli1Mquj8U2wYVDlC5UZPvRI9gh3UNt0SlI+4xRzJHo
 NQnVp7XbhgEK/NIVEy7ikhE/RfQ+s0YAvotpSgs96r2rJ4bmv65K1ULiosQL+aRLLk6e
 mPqtAXz6CVkMTgy2D8mmAyvkkY9HcqOOHRfiw2jugFf45psd0vNQCof6TqC8j5jKp1Ji
 gaUgA4kq4J9hbFmWC60Gl0ZR55e+RoOv28cFBtS6s5Za+Txtiuxh9RHCrPeT6vqlC+lG
 jQTg==
X-Gm-Message-State: APjAAAUwjGWU3Gn5tUkxmM+MYc/MT+iFgwXh1gG51lCIPvEwfU25SfEl
 InwC1BzaVSDXseRPfNJdzZc3nkO5wYg+ccqrgjvFDg==
X-Google-Smtp-Source: APXvYqy8qt/LPQTBDnkSXse5PQUi8TmRUxjinXgJwHHvpgXHaFXX7lPXMif76IbzpyywHreBlwXK1DzHDDRdSp8gaak=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr10567139wrr.32.1575564605540; 
 Thu, 05 Dec 2019 08:50:05 -0800 (PST)
MIME-Version: 1.0
References: <20191204221229.30612-1-philmd@redhat.com>
 <ecbb6c69-1fc1-a730-db9f-656b0a82c3fd@redhat.com>
 <90b6b303-2cb7-aeea-8f10-8520de2511c6@redhat.com>
In-Reply-To: <90b6b303-2cb7-aeea-8f10-8520de2511c6@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 5 Dec 2019 16:50:02 +0000
Message-ID: <CAKv+Gu8jiAqWWZkUegC40X=967sCpqiKooyaWFGnX5=saf+Duw@mail.gmail.com>
Subject: Re: [PATCH-for-5.0] roms/edk2-funcs.sh: Use available GCC for
 ARM/Aarch64 targets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Dec 2019 at 16:27, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> On 12/5/19 5:13 PM, Laszlo Ersek wrote:
> > Hi Phil,
> >
> > (+Ard)
> >
> > On 12/04/19 23:12, Philippe Mathieu-Daud=C3=A9 wrote:
> >> Centos 7.7 only provides cross GCC 4.8.5, but the script forces
> >> us to use GCC5. Since the same machinery is valid to check the
> >> GCC version, remove the $emulation_target check.
> >>
> >>    $ cat /etc/redhat-release
> >>    CentOS Linux release 7.7.1908 (Core)
> >>
> >>    $ aarch64-linux-gnu-gcc -v 2>&1 | tail -1
> >>    gcc version 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC)
> >
> > this patch is not correct, in my opinion. ARM / AARCH64 support in edk2
> > requires GCC5 as a minimum. It was never tested with an earlier
> > toolchain, to my understanding. Not on my part, anyway.
> >
> > To be more precise: when I tested cross-gcc toolchains earlier than
> > that, the ArmVirtQemu builds always failed. Minimally, those toolchains
> > didn't recognize some of the AARCH64 system registers.
> >
> > If CentOS 7.7 does not provide a suitable (>=3DGCC5) toolchain, then we
> > can't build ArmVirtQemu binaries on CentOS 7.7, in my opinion.
> >
> > Personally, on my RHEL7 laptop, over time I've used the following
> > toolchains, to satisfy the GCC5 requirement of ArmVirtQemu (which
> > requirement I took as experimental evidence):
> >
> > - Initially (last quarter of 2014), I used binary distributions --
> >    tarballs -- of cross-binutils and cross-gcc, from Linaro.
> >
> > - Later (last quarter of 2016), I rebuilt some SRPMs that were at the
> >    time Fedora-only for RHEL7. Namely:
> >
> >    - cross-binutils-2.27-3.fc24
> >      https://koji.fedoraproject.org/koji/buildinfo?buildID=3D801348
> >
> >    - gcc-6.1.1-2.fc24
> >      https://koji.fedoraproject.org/koji/buildinfo?buildID=3D761767
> >
> > - Most recently, I've been using cross-binutils updated from EPEL7:
> >
> >    - cross-binutils-2.27-9.el7.1
> >      https://koji.fedoraproject.org/koji/buildinfo?buildID=3D918474
> >
> > To my knowledge, there is still no suitable cross-compiler available on
> > RHEL7, from any trustworthy RPM repository. So, to this day, I use
> > gcc-6.1.1-2 for cross-building ArmVirtQemu, on my RHEL7 laptop.
> >
> > Again: I believe it does not matter if the gcc-4.8.5-based
> > cross-compiler in CentOS 7 "happens" to work. That's a compiler that I
> > have never tested with, or vetted for, upstream ArmVirtQemu.
> >
> > Now, I realize that in edk2, we have stuff like
> >
> >    GCC48_AARCH64_CC_FLAGS
> >
> > in "BaseTools/Conf/tools_def.template" -- coming from commit
> > 7a9dbf2c94d1 ("BaseTools/Conf/tools_def.template: drop ARM/AARCH suppor=
t
> > from GCC46/GCC47", 2019-01-08). That doesn't change the fact that I've
> > never built or tested ArmVirtQemu with such a compiler. And so this
> > patch makes me quite uncomfortable.
> >
> > If that rules out CentOS 7 as a QEMU project build / CI platform for th=
e
> > bundled ArmVirtQemu binaries, then we need a more recent platform
> > (perhaps CentOS 8, not sure).
>
> Unfortunately CentOS 8 is not available as a Docker image, which is a
> convenient way to build EDK2 in a CI.
>
> > I think it's also educational to check the origin of the code that your
> > patch proposes to remove. Most recently it was moved around from a
> > different place, in QEMU commit 65a109ab4b1a ('roms: lift
> > "edk2-funcs.sh" from "tests/uefi-test-tools/build.sh"', 2019-04-17).
> >
> > In that commit, for some reason I didn't keep the original code comment=
s
> > (perhaps it would have been too difficult or messy to preserve the
> > comments sanely with the restructured / factored-out code). But, they
> > went like this (originally from commit 77db55fc8155,
> > "tests/uefi-test-tools: add build scripts", 2019-02-21):
> >
> > # Expose cross_prefix (which is possibly empty) to the edk2 tools. Whil=
e at it,
> > # determine the suitable edk2 toolchain as well.
> > # - For ARM and AARCH64, edk2 only offers the GCC5 toolchain tag, which=
 covers
> > #   the gcc-5+ releases.
> > # - For IA32 and X64, edk2 offers the GCC44 through GCC49 toolchain tag=
s, in
> > #   addition to GCC5. Unfortunately, the mapping between the toolchain =
tags and
> > #   the actual gcc releases isn't entirely trivial. Run "git-blame" on
> > #   "OvmfPkg/build.sh" in edk2 for more information.
> > # And, because the above is too simple, we have to assign cross_prefix =
to an
> > # edk2 build variable that is specific to both the toolchain tag and th=
e target
> > # architecture.
> >
> > So... unless Ard feels it is really totally safe to retro-actively rely
> > on the gcc-4.8.5-based compiler in CentOS 7, I'd rather we picked a mor=
e
> > recent build platform (OS) instead. For example, we build ArmVirtQemu o=
n
> > RHEL8 regularly, so that's a reality-based "plus" for CentOS 8.
> >
> >
> > Independently of all of the above, the OVMF toolchain selection logic
> > that this patch proposes to reuse with ArmVirtQemu, is *really*
> > x86-specific. Please run "git blame" on "OvmfPkg/build.sh" in upstream
> > edk2, to see where the various branches come from (as the comments in
> > this shell script suggest as well). There had been mess like commit
> > 656ac0c7d8ea ('Revert "OvmfPkg/build.sh: select the GCC49 toolchain
> > settings for gcc-7.*"', 2017-08-25).
>
> Thanks for all the pointers, very educative indeed :)
>
> I'll see other setups I can use with GCC5+ available.
>
> I still have to figure if there are free tier CI with less limitations
> than Travis/Shippable/GitLab, so we can keep the full EDK2 build output l=
og.
>

My CI job for ArmVirtQemu/EDK2 build tested GCC48 and GCC49 until very
recently, and I never experienced any issues when running those
images, although it's been much longer that I actually tried that. So
I wouldn't recommend against it, and if we do identify any issues, we
should either deprecate GCC48 (for ArmVirtQemu or for AArch64
altogether) or fix them.

