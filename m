Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AB9C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 12:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6530E2083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 12:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHRELFMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6530E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWfVQ-0000pu-GS
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 08:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jWfTk-0008KK-6Z
 for qemu-devel@nongnu.org; Thu, 07 May 2020 08:18:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jWfTi-0002ml-Jx
 for qemu-devel@nongnu.org; Thu, 07 May 2020 08:18:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id w7so5280854wre.13
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 05:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=687ud2M9V+sCSk6pJaDp6YRJ4NhxszIcRO4plxkWrhg=;
 b=vHRELFMShy1nEv00G5MbEdHrQyq07agltZqHIeD8ZdvBUw1b849zJ514YHyJY+0Vo1
 1YzyWZLzC2rEzqw6pbQFFXlaMB113AZNtHKMPFikon02R6v/1Vdx7nIbL4E3ThstHibG
 nEFvrSMWC2AHRVIZQdSd9+3DLknKk0U+aY/QG50dOFPPSh8kfIkMx/7kkEBiLJT/VV/7
 Odd4PV58QMPOOXqEMUDfJhUfqX+MoYOnt1DDFR2bORPQqF+7qbcmN48Rw/pVL/X+7Ir4
 npQhXA1OB9B/3Dm1uo4juhsQKC3DZIG/E2eO2bGgRETn0FtGiFhjdPIuaKlt9Xmwzj5w
 UN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=687ud2M9V+sCSk6pJaDp6YRJ4NhxszIcRO4plxkWrhg=;
 b=hy1WsyHnxfjQlUKY5xKPNsNoLtvUrtepQ+8g5uQVTNWRP2Tpq/fv9uXfJKLsjb7PnX
 AIF24tWpjpAW60Q+Vofrc4vjBFhPyr7tMgxiYRkBy8cQaUWXAaQ/OZN5hCkw8UUQJQ0V
 PpRb+YFMmweQLGOU8sve8jFvPkFBWkdWFyf4XUQ1ul57jfPHd/gp5HSO/QTUOrVUe3R1
 05mNUi+ezf/kXXJCrgH+UCugN9X8CMP3Ls1B8RTcFCIBOyNBbKCK6c1L8CO1flPYZPWW
 eJdOTTTV7Ygvoj6/LRTArq6yrM/4UumeHGsbrIHcHDlj2raGEYcA3DhgR0e3VP5EUKWz
 mj2w==
X-Gm-Message-State: AGi0PubU69wMy9upOtAdyV6HD5vV6cS0Z+LdWmDvlvJ7v0tS+F+cPiaS
 jkCczvN4a0otNLPVm2LWPTJSAWhj08cIL8AdeR0=
X-Google-Smtp-Source: APiQypJhjNUOrSnEdEsVIvVp52faWFnLl6PbEV9jQWxNgZHdhUIbDl5BdUKnETngsI29dV93rCTvfaVFEciOZNv9HT4=
X-Received: by 2002:adf:9793:: with SMTP id s19mr14025990wrb.147.1588853892707; 
 Thu, 07 May 2020 05:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
 <CAHiYmc5UanJELbuo8RzODNo0+cvQ_XL-HhNC2DUMSGVKVZEBMQ@mail.gmail.com>
 <CABDp7Vp6p+M_sZp_WD+M3EeSOG1eKhX-nZzSiyc-PDKTno+iLw@mail.gmail.com>
 <CAHiYmc63HW-P=nJyRtFYyL0Ou+dZ=LRWFJpfZ1O_+c+-gjo=aw@mail.gmail.com>
 <CAAhV-H6vASk3-LWMijDv+ZsJqFMCdnTd9J7nHORXBoSNYX=5nA@mail.gmail.com>
In-Reply-To: <CAAhV-H6vASk3-LWMijDv+ZsJqFMCdnTd9J7nHORXBoSNYX=5nA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 7 May 2020 14:17:57 +0200
Message-ID: <CAHiYmc7XhGGb4q3RUX_-=ohsX2D7PHgax4y6nCPGtW7LLHV9dQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V3 0/7] mips: Add Loongson-3 machine support (with
 KVM)
To: Huacai Chen <chenhuacai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: chen huacai <zltjiangshi@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 6. =D0=BC=D0=B0=D1=98 2020. =D1=83 03:43 Huacai Chen <c=
henhuacai@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
> Hi, Aleksandar,
>
> On Tue, May 5, 2020 at 6:12 PM Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
> >
> >
> >
> > =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 05. =D0=BC=D0=B0=D1=98 2020., che=
n huacai <zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>
> >> Hi, Aleksandar,
> >>
> >> On Sun, May 3, 2020 at 6:50 PM Aleksandar Markovic
> >> <aleksandar.qemu.devel@gmail.com> wrote:
> >> >
> >> > =D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:21 Huacai =
Chen <zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:
> >> > >
> >> > > Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson=
-3B
> >> > > R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, w=
hile
> >> > > Loongson-3A R4 is the newest and its ISA is almost the superset of=
 all
> >> > > others. To reduce complexity, in QEMU we just define two CPU types=
:
> >> > >
> >> > > 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1.=
 It is
> >> > >    suitable for TCG because Loongson-3A R1 has fewest ASE.
> >> > > 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4.=
 It is
> >> > >    suitable for KVM because Loongson-3A R4 has the VZ ASE.
> >> > >
> >> >
> >> > Huacai, thanks for putting together v3, which is a little better tha=
n v2, and
> >> > thanks for addressing my previous suggestions.
> >> >
> >> > Now, give us some time to digest new data on Loongson3.  We will
> >> > respond, but it won't happen immediately, which is, you'd agree,
> >> > reasonable. Just be patient.
> >> >
> >> > But again, in general, I salute your efforts very much!
> >> >
> >> > Yours, Aleksandar
> >> I'm sorry for this late response because I have done many tests to
> >> reproduce the problem reported at
> >> https://patchew.org/QEMU/1588501221-1205-1-git-send-email-chenhc@lemot=
e.com/,
> >> but I don't have such a failure...
> >>
> >> What I have done:
> >> 1, "make check" on MIPS64 platform (distro is Fedora28 for Loongson);
> >> 2, "make check" on X86_64 platform (distro is RHEL8);
> >> 3, "make docker-test-quick@centos7 SHOW_ENV=3D1 NETWORK=3D1" on X86_64
> >> platform (distro is RHEL8);
> >> 4, "make docker-test-quick@centos7 SHOW_ENV=3D1 J=3Dn NETWORK=3D1" on =
X86_64
> >> platform (distro is RHEL8 and I've tried n=3D2,3,4....14);
> >>
> >> I always get the same result:
> >> Not run: 259
> >> Passed all 117 iotests
> >>
> >> And, it seems that my patchset doesn't touch anything about iotests,
> >> so I don't know why the build test fails on iotests 192 (Maybe your
> >> build test has the same problem without my patches).
> >>
> >
> > From time to time, there is some instability in our automatic iotests. =
You shouldn't bother too much about it, of course you retest in your enviro=
nments, that is good. But, in all likelyhood, your patchset doesn't really =
have anything to do with the reported iotest failure.
>
> Thank you for your help, and here is another question: Could
> "target/mips: Support variable page size" series be merged now? This
> Loongson-3 series depend on variable page size logically.
>

Hi, Huacei.

Please be patient. This is a significant series, and we don't do or
have a "fast track" for series of such nature. It might or might not
be that some of the patches will be accepted before the entire series,
but certainly do not rush us. This is not the way to achieve your
goal, let's put it that way. Focus on improving your series. Being
careful with reviewing and upstreaming is actually in your interest.

Yours,
Aleksandar

> >
> > Truly yours,
> > Aleksandar
> >
> >
> >>
> >> P.S.: I have found a problem that my patchset has a build failure with
> >> CONFIG_KVM=3Dn, but this is another problem and I will send V4 to fix =
it
> >> (after collecting all problems in V3).
> >>
> >>
> >> >
> >> > > Loongson-3 lacks English documents. I've tried to translated them =
with
> >> > > translate.google.com, and the machine translated documents (togeth=
er
> >> > > with their original Chinese versions) are available here.
> >> > >
> >> > > Loongson-3A R1 (Loongson-3A1000)
> >> > > User Manual Part 1:
> >> > > http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf
> >> > > http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manua=
l_P1.pdf (Chinese Version)
> >> > > User Manual Part 2:
> >> > > http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf
> >> > > http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manua=
l_P2.pdf (Chinese Version)
> >> > >
> >> > > Loongson-3A R2 (Loongson-3A2000)
> >> > > User Manual Part 1:
> >> > > http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf
> >> > > http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pdf (Chinese V=
ersion)
> >> > > User Manual Part 2:
> >> > > http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf
> >> > > http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pdf (Chinese V=
ersion)
> >> > >
> >> > > Loongson-3A R3 (Loongson-3A3000)
> >> > > User Manual Part 1:
> >> > > http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf
> >> > > http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual1.pd=
f (Chinese Version)
> >> > > User Manual Part 2:
> >> > > http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf
> >> > > http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual2.pd=
f (Chinese Version)
> >> > >
> >> > > Loongson-3A R4 (Loongson-3A4000)
> >> > > User Manual Part 1:
> >> > > http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf
> >> > > http://ftp.godson.ac.cn/lemote/3A4000user.pdf (Chinese Version)
> >> > > User Manual Part 2:
> >> > > I'm sorry that it is unavailable now.
> >> > >
> >> > > We are preparing to add QEMU's Loongson-3 support. MIPS VZ extensi=
on is
> >> > > fully supported in Loongson-3A R4+, so we at first add QEMU/KVM su=
pport
> >> > > in this series. And the next series will add QEMU/TCG support (it =
will
> >> > > emulate Loongson-3A R1).
> >> > >
> >> > > We already have a full functional Linux kernel (based on Linux-5.4=
.x LTS
> >> > > but not upstream yet) here:
> >> > >
> >> > > https://github.com/chenhuacai/linux
> >> > >
> >> > > How to use QEMU/Loongson-3?
> >> > > 1, Download kernel source from the above URL;
> >> > > 2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config=
;
> >> > > 3, Boot a Loongson-3A4000 host with this kernel;
> >> > > 4, Build QEMU-5.0.0 with this patchset;
> >> > > 5, modprobe kvm;
> >> > > 6, Use QEMU with TCG (available in future):
> >> > >        qemu-system-mips64el -M loongson3,accel=3Dtcg -cpu Loongson=
-3A1000 -kernel <path_to_kernel> -append ...
> >> > >    Use QEMU with KVM (available at present):
> >> > >        qemu-system-mips64el -M loongson3,accel=3Dkvm -cpu Loongson=
-3A4000 -kernel <path_to_kernel> -append ...
> >> > >
> >> > >    The "-cpu" parameter can be omitted here and QEMU will use the =
correct type for TCG/KVM automatically.
> >> > >
> >> > > V1 -> V2:
> >> > > 1, Add a cover letter;
> >> > > 2, Improve CPU definitions;
> >> > > 3, Remove LS7A-related things (Use GPEX instead);
> >> > > 4, Add a description of how to run QEMU/Loongson-3.
> >> > >
> >> > > V2 -> V3:
> >> > > 1, Fix all possible checkpatch.pl errors and warnings.
> >> > >
> >> > > Huacai Chen(7):
> >> > >  configure: Add KVM target support for MIPS64
> >> > >  hw/mips: Implement the kvm_type() hook in MachineClass
> >> > >  hw/mips: Add CPU IRQ3 delivery for KVM
> >> > >  target/mips: Add Loongson-3 CPU definition
> >> > >  target/mips: Add more CP0 register for save/restor
> >> > >  hw/mips: Add Loongson-3 machine support (with KVM)
> >> > >  MAINTAINERS: Add myself as Loongson-3 maintainer
> >> > >
> >> > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> >> > > ---
> >> > >  MAINTAINERS                          |   5 +
> >> > >  configure                            |   2 +-
> >> > >  default-configs/mips64el-softmmu.mak |   1 +
> >> > >  hw/core/Makefile.objs                |   2 +-
> >> > >  hw/core/null-machine.c               |   4 +
> >> > >  hw/mips/Kconfig                      |  10 +
> >> > >  hw/mips/Makefile.objs                |   3 +-
> >> > >  hw/mips/common.c                     |  31 ++
> >> > >  hw/mips/mips_int.c                   |   4 +-
> >> > >  hw/mips/mips_loongson3.c             | 901 ++++++++++++++++++++++=
+++++++++++++
> >> > >  include/hw/mips/mips.h               |   3 +
> >> > >  target/mips/cpu.h                    |  28 ++
> >> > >  target/mips/internal.h               |   2 +
> >> > >  target/mips/kvm.c                    | 212 +++++++++
> >> > >  target/mips/machine.c                |   6 +-
> >> > >  target/mips/mips-defs.h              |   7 +-
> >> > >  target/mips/translate.c              |   2 +
> >> > >  target/mips/translate_init.inc.c     |  86 ++++
> >> > >  18 files changed, 1300 insertions(+), 9 deletions(-)
> >> > >  create mode 100644 hw/mips/common.c
> >> > >  create mode 100644 hw/mips/mips_loongson3.c
> >> > > --
> >> > > 2.7.0
> >>
> >>
> >>
> >> --
> >> Huacai Chen
> Best regards,
> Huacai

