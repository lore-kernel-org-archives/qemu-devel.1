Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11DBC47256
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE19D2075A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPwC6MHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE19D2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVuZd-0007hj-TY
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVuYt-0007DV-86
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:12:27 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVuYr-0002tC-Hq
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:12:26 -0400
Received: by mail-wm1-x343.google.com with SMTP id 188so1637863wmc.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Y/A/hCt/113X9S7H0bhODP0hdhxbWpxh2jm+M/MuIYg=;
 b=vPwC6MHKzSpuTUINWGroYeFHn2fNjW3vKDUYZlFLstsaTowe/vpmiDjQVp8OhRFnaX
 BxJ28a1CfJ+NceM18bFYKgklVzBKV87qj3SsxD/U9k3KRY41xBZpLgVuJttQFrBGeY1a
 jLFx0V6iyUVnptvqL9E3NrODj7EaVk6dVOBhNeCzmwWoUGScGTwE512y39fcJfMFPXSh
 KhW8w4pwb2tXYTU095kv9o4d5Vg6H58aLNCoTD85wMQSxy8Hr6nyWQjI3lLgNxVkTd2t
 3/dJdhYoPCHExv070heKFfLGTPNcfFPtYW+/dplnm0y2efIT37XPr9S9BHh7i7ZqbL+D
 eiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Y/A/hCt/113X9S7H0bhODP0hdhxbWpxh2jm+M/MuIYg=;
 b=g78T/oZuSX7K58QDVNABpMG0cGfWcdutyljqItDJ8wmlcGUylioMyIPSeO/DF9F4kg
 jHfPeFZDh9O9jd/Xcmbg8FWueAKMvOKLalIusc9oWdBcCHWdNk6zq5dXFDq6wg+xVprJ
 0dZlaGGilmpIwzQosiVCplJBEpFzClJzN5qoPfWBlbou4wf4L24G9BQP3p7E5/w3iprU
 9bRZvdLpOspaFVHDbgJP9/Xpd1rAFZmCUc5eaEFB5pX25lcHbh7JN5jd9BClb7JkRuWd
 gKD8KK4fddWJ6vwJ78/N+IEUSLA2v06i1kFkAaxEYYZ39whs3fT6HxM0j5+iobEswhgk
 q84A==
X-Gm-Message-State: AGi0PuanYmZYqDyq3VxYstrTZKsAbJMQGq7rQ8NCBDjA4p+ATm8Ktwv7
 woKbyzTLP01mE9UvfouBSP44595/lBgimtUytq7JGzOr
X-Google-Smtp-Source: APiQypKUYvyEmlZD3D8P0VUFheYr1laKJ9Qfyct9iPbKrP3+Lh1E0JMWFHr18PscLP3lqM/wsAwdVhh2iyBfzwKzqZc=
X-Received: by 2002:a1c:9a13:: with SMTP id c19mr2531106wme.159.1588673542881; 
 Tue, 05 May 2020 03:12:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c3:0:0:0:0:0 with HTTP;
 Tue, 5 May 2020 03:12:22 -0700 (PDT)
In-Reply-To: <CABDp7Vp6p+M_sZp_WD+M3EeSOG1eKhX-nZzSiyc-PDKTno+iLw@mail.gmail.com>
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
 <CAHiYmc5UanJELbuo8RzODNo0+cvQ_XL-HhNC2DUMSGVKVZEBMQ@mail.gmail.com>
 <CABDp7Vp6p+M_sZp_WD+M3EeSOG1eKhX-nZzSiyc-PDKTno+iLw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 5 May 2020 12:12:22 +0200
Message-ID: <CAHiYmc63HW-P=nJyRtFYyL0Ou+dZ=LRWFJpfZ1O_+c+-gjo=aw@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V3 0/7] mips: Add Loongson-3 machine support (with
 KVM)
To: chen huacai <zltjiangshi@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000030039905a4e3e2ba"
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000030039905a4e3e2ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 05. =D0=BC=D0=B0=D1=98 2020., chen hu=
acai <zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:

> Hi, Aleksandar,
>
> On Sun, May 3, 2020 at 6:50 PM Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
> >
> > =D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:21 Huacai Che=
n <zltjiangshi@gmail.com> =D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >
> > > Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> > > R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, whil=
e
> > > Loongson-3A R4 is the newest and its ISA is almost the superset of al=
l
> > > others. To reduce complexity, in QEMU we just define two CPU types:
> > >
> > > 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It
> is
> > >    suitable for TCG because Loongson-3A R1 has fewest ASE.
> > > 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It
> is
> > >    suitable for KVM because Loongson-3A R4 has the VZ ASE.
> > >
> >
> > Huacai, thanks for putting together v3, which is a little better than
> v2, and
> > thanks for addressing my previous suggestions.
> >
> > Now, give us some time to digest new data on Loongson3.  We will
> > respond, but it won't happen immediately, which is, you'd agree,
> > reasonable. Just be patient.
> >
> > But again, in general, I salute your efforts very much!
> >
> > Yours, Aleksandar
> I'm sorry for this late response because I have done many tests to
> reproduce the problem reported at
> https://patchew.org/QEMU/1588501221-1205-1-git-send-
> email-chenhc@lemote.com/,
> but I don't have such a failure...
>
> What I have done:
> 1, "make check" on MIPS64 platform (distro is Fedora28 for Loongson);
> 2, "make check" on X86_64 platform (distro is RHEL8);
> 3, "make docker-test-quick@centos7 SHOW_ENV=3D1 NETWORK=3D1" on X86_64
> platform (distro is RHEL8);
> 4, "make docker-test-quick@centos7 SHOW_ENV=3D1 J=3Dn NETWORK=3D1" on X86=
_64
> platform (distro is RHEL8 and I've tried n=3D2,3,4....14);
>
> I always get the same result:
> Not run: 259
> Passed all 117 iotests
>
> And, it seems that my patchset doesn't touch anything about iotests,
> so I don't know why the build test fails on iotests 192 (Maybe your
> build test has the same problem without my patches).
>
>
From time to time, there is some instability in our automatic iotests. You
shouldn't bother too much about it, of course you retest in your
environments, that is good. But, in all likelyhood, your patchset doesn't
really have anything to do with the reported iotest failure.

Truly yours,
Aleksandar



> P.S.: I have found a problem that my patchset has a build failure with
> CONFIG_KVM=3Dn, but this is another problem and I will send V4 to fix it
> (after collecting all problems in V3).
>
>
> >
> > > Loongson-3 lacks English documents. I've tried to translated them wit=
h
> > > translate.google.com, and the machine translated documents (together
> > > with their original Chinese versions) are available here.
> > >
> > > Loongson-3A R1 (Loongson-3A1000)
> > > User Manual Part 1:
> > > http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf
> > > http://ftp.godson.ac.cn/lemote/Loongson3A1000_
> processor_user_manual_P1.pdf (Chinese Version)
> > > User Manual Part 2:
> > > http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf
> > > http://ftp.godson.ac.cn/lemote/Loongson3A1000_
> processor_user_manual_P2.pdf (Chinese Version)
> > >
> > > Loongson-3A R2 (Loongson-3A2000)
> > > User Manual Part 1:
> > > http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf
> > > http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pdf (Chinese
> Version)
> > > User Manual Part 2:
> > > http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf
> > > http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pdf (Chinese
> Version)
> > >
> > > Loongson-3A R3 (Loongson-3A3000)
> > > User Manual Part 1:
> > > http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf
> > > http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual1.pdf
> (Chinese Version)
> > > User Manual Part 2:
> > > http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf
> > > http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual2.pdf
> (Chinese Version)
> > >
> > > Loongson-3A R4 (Loongson-3A4000)
> > > User Manual Part 1:
> > > http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf
> > > http://ftp.godson.ac.cn/lemote/3A4000user.pdf (Chinese Version)
> > > User Manual Part 2:
> > > I'm sorry that it is unavailable now.
> > >
> > > We are preparing to add QEMU's Loongson-3 support. MIPS VZ extension =
is
> > > fully supported in Loongson-3A R4+, so we at first add QEMU/KVM suppo=
rt
> > > in this series. And the next series will add QEMU/TCG support (it wil=
l
> > > emulate Loongson-3A R1).
> > >
> > > We already have a full functional Linux kernel (based on Linux-5.4.x
> LTS
> > > but not upstream yet) here:
> > >
> > > https://github.com/chenhuacai/linux
> > >
> > > How to use QEMU/Loongson-3?
> > > 1, Download kernel source from the above URL;
> > > 2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
> > > 3, Boot a Loongson-3A4000 host with this kernel;
> > > 4, Build QEMU-5.0.0 with this patchset;
> > > 5, modprobe kvm;
> > > 6, Use QEMU with TCG (available in future):
> > >        qemu-system-mips64el -M loongson3,accel=3Dtcg -cpu
> Loongson-3A1000 -kernel <path_to_kernel> -append ...
> > >    Use QEMU with KVM (available at present):
> > >        qemu-system-mips64el -M loongson3,accel=3Dkvm -cpu
> Loongson-3A4000 -kernel <path_to_kernel> -append ...
> > >
> > >    The "-cpu" parameter can be omitted here and QEMU will use the
> correct type for TCG/KVM automatically.
> > >
> > > V1 -> V2:
> > > 1, Add a cover letter;
> > > 2, Improve CPU definitions;
> > > 3, Remove LS7A-related things (Use GPEX instead);
> > > 4, Add a description of how to run QEMU/Loongson-3.
> > >
> > > V2 -> V3:
> > > 1, Fix all possible checkpatch.pl errors and warnings.
> > >
> > > Huacai Chen(7):
> > >  configure: Add KVM target support for MIPS64
> > >  hw/mips: Implement the kvm_type() hook in MachineClass
> > >  hw/mips: Add CPU IRQ3 delivery for KVM
> > >  target/mips: Add Loongson-3 CPU definition
> > >  target/mips: Add more CP0 register for save/restor
> > >  hw/mips: Add Loongson-3 machine support (with KVM)
> > >  MAINTAINERS: Add myself as Loongson-3 maintainer
> > >
> > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > > ---
> > >  MAINTAINERS                          |   5 +
> > >  configure                            |   2 +-
> > >  default-configs/mips64el-softmmu.mak |   1 +
> > >  hw/core/Makefile.objs                |   2 +-
> > >  hw/core/null-machine.c               |   4 +
> > >  hw/mips/Kconfig                      |  10 +
> > >  hw/mips/Makefile.objs                |   3 +-
> > >  hw/mips/common.c                     |  31 ++
> > >  hw/mips/mips_int.c                   |   4 +-
> > >  hw/mips/mips_loongson3.c             | 901
> +++++++++++++++++++++++++++++++++++
> > >  include/hw/mips/mips.h               |   3 +
> > >  target/mips/cpu.h                    |  28 ++
> > >  target/mips/internal.h               |   2 +
> > >  target/mips/kvm.c                    | 212 +++++++++
> > >  target/mips/machine.c                |   6 +-
> > >  target/mips/mips-defs.h              |   7 +-
> > >  target/mips/translate.c              |   2 +
> > >  target/mips/translate_init.inc.c     |  86 ++++
> > >  18 files changed, 1300 insertions(+), 9 deletions(-)
> > >  create mode 100644 hw/mips/common.c
> > >  create mode 100644 hw/mips/mips_loongson3.c
> > > --
> > > 2.7.0
>
>
>
> --
> Huacai Chen
>

--00000000000030039905a4e3e2ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 05. =D0=BC=D0=B0=D1=98 2020.,=
 chen huacai &lt;<a href=3D"mailto:zltjiangshi@gmail.com">zltjiangshi@gmail=
.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=
=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Hi, Aleksandar,<br>
<br>
On Sun, May 3, 2020 at 6:50 PM Aleksandar Markovic<br>
&lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.deve=
l@gmail.<wbr>com</a>&gt; wrote:<br>
&gt;<br>
&gt; =D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:21 Huacai Ch=
en &lt;<a href=3D"mailto:zltjiangshi@gmail.com">zltjiangshi@gmail.com</a>&g=
t; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br=
>
&gt; &gt;<br>
&gt; &gt; Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongso=
n-3B<br>
&gt; &gt; R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, =
while<br>
&gt; &gt; Loongson-3A R4 is the newest and its ISA is almost the superset o=
f all<br>
&gt; &gt; others. To reduce complexity, in QEMU we just define two CPU type=
s:<br>
&gt; &gt;<br>
&gt; &gt; 1, &quot;Loongson-3A1000&quot; CPU which is corresponding to Loon=
gson-3A R1. It is<br>
&gt; &gt;=C2=A0 =C2=A0 suitable for TCG because Loongson-3A R1 has fewest A=
SE.<br>
&gt; &gt; 2, &quot;Loongson-3A4000&quot; CPU which is corresponding to Loon=
gson-3A R4. It is<br>
&gt; &gt;=C2=A0 =C2=A0 suitable for KVM because Loongson-3A R4 has the VZ A=
SE.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Huacai, thanks for putting together v3, which is a little better than =
v2, and<br>
&gt; thanks for addressing my previous suggestions.<br>
&gt;<br>
&gt; Now, give us some time to digest new data on Loongson3.=C2=A0 We will<=
br>
&gt; respond, but it won&#39;t happen immediately, which is, you&#39;d agre=
e,<br>
&gt; reasonable. Just be patient.<br>
&gt;<br>
&gt; But again, in general, I salute your efforts very much!<br>
&gt;<br>
&gt; Yours, Aleksandar<br>
I&#39;m sorry for this late response because I have done many tests to<br>
reproduce the problem reported at<br>
<a href=3D"https://patchew.org/QEMU/1588501221-1205-1-git-send-email-chenhc=
@lemote.com/" target=3D"_blank">https://patchew.org/QEMU/<wbr>1588501221-12=
05-1-git-send-<wbr>email-chenhc@lemote.com/</a>,<br>
but I don&#39;t have such a failure...<br>
<br>
What I have done:<br>
1, &quot;make check&quot; on MIPS64 platform (distro is Fedora28 for Loongs=
on);<br>
2, &quot;make check&quot; on X86_64 platform (distro is RHEL8);<br>
3, &quot;make docker-test-quick@centos7 SHOW_ENV=3D1 NETWORK=3D1&quot; on X=
86_64<br>
platform (distro is RHEL8);<br>
4, &quot;make docker-test-quick@centos7 SHOW_ENV=3D1 J=3Dn NETWORK=3D1&quot=
; on X86_64<br>
platform (distro is RHEL8 and I&#39;ve tried n=3D2,3,4....14);<br>
<br>
I always get the same result:<br>
Not run: 259<br>
Passed all 117 iotests<br>
<br>
And, it seems that my patchset doesn&#39;t touch anything about iotests,<br=
>
so I don&#39;t know why the build test fails on iotests 192 (Maybe your<br>
build test has the same problem without my patches).<br>
<br></blockquote><div><br></div><div>From time to time, there is some insta=
bility in our automatic iotests. You shouldn&#39;t bother too much about it=
, of course you retest in your environments, that is good. But, in all like=
lyhood, your patchset doesn&#39;t really have anything to do with the repor=
ted iotest failure.</div><div><br></div><div>Truly yours,</div><div>Aleksan=
dar</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
P.S.: I have found a problem that my patchset has a build failure with<br>
CONFIG_KVM=3Dn, but this is another problem and I will send V4 to fix it<br=
>
(after collecting all problems in V3).<br>
<br>
<br>
&gt;<br>
&gt; &gt; Loongson-3 lacks English documents. I&#39;ve tried to translated =
them with<br>
&gt; &gt; <a href=3D"http://translate.google.com" target=3D"_blank">transla=
te.google.com</a>, and the machine translated documents (together<br>
&gt; &gt; with their original Chinese versions) are available here.<br>
&gt; &gt;<br>
&gt; &gt; Loongson-3A R1 (Loongson-3A1000)<br>
&gt; &gt; User Manual Part 1:<br>
&gt; &gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf" target=
=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/3A1000_p1.pdf</a><br>
&gt; &gt; <a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A1000_processo=
r_user_manual_P1.pdf" target=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote=
/Loongson3A1000_<wbr>processor_user_manual_P1.pdf</a> (Chinese Version)<br>
&gt; &gt; User Manual Part 2:<br>
&gt; &gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf" target=
=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/3A1000_p2.pdf</a><br>
&gt; &gt; <a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A1000_processo=
r_user_manual_P2.pdf" target=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote=
/Loongson3A1000_<wbr>processor_user_manual_P2.pdf</a> (Chinese Version)<br>
&gt; &gt;<br>
&gt; &gt; Loongson-3A R2 (Loongson-3A2000)<br>
&gt; &gt; User Manual Part 1:<br>
&gt; &gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf" target=
=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/3A2000_p1.pdf</a><br>
&gt; &gt; <a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pd=
f" target=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/Loongson3A2000_use=
r1.<wbr>pdf</a> (Chinese Version)<br>
&gt; &gt; User Manual Part 2:<br>
&gt; &gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf" target=
=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/3A2000_p2.pdf</a><br>
&gt; &gt; <a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pd=
f" target=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/Loongson3A2000_use=
r2.<wbr>pdf</a> (Chinese Version)<br>
&gt; &gt;<br>
&gt; &gt; Loongson-3A R3 (Loongson-3A3000)<br>
&gt; &gt; User Manual Part 1:<br>
&gt; &gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf" target=
=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/3A3000_p1.pdf</a><br>
&gt; &gt; <a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000us=
ermanual1.pdf" target=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/Loongs=
on3A3000_<wbr>3B3000usermanual1.pdf</a> (Chinese Version)<br>
&gt; &gt; User Manual Part 2:<br>
&gt; &gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf" target=
=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/3A3000_p2.pdf</a><br>
&gt; &gt; <a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000us=
ermanual2.pdf" target=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/Loongs=
on3A3000_<wbr>3B3000usermanual2.pdf</a> (Chinese Version)<br>
&gt; &gt;<br>
&gt; &gt; Loongson-3A R4 (Loongson-3A4000)<br>
&gt; &gt; User Manual Part 1:<br>
&gt; &gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf" target=
=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/3A4000_p1.pdf</a><br>
&gt; &gt; <a href=3D"http://ftp.godson.ac.cn/lemote/3A4000user.pdf" target=
=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/3A4000user.pdf</a> (Chinese=
 Version)<br>
&gt; &gt; User Manual Part 2:<br>
&gt; &gt; I&#39;m sorry that it is unavailable now.<br>
&gt; &gt;<br>
&gt; &gt; We are preparing to add QEMU&#39;s Loongson-3 support. MIPS VZ ex=
tension is<br>
&gt; &gt; fully supported in Loongson-3A R4+, so we at first add QEMU/KVM s=
upport<br>
&gt; &gt; in this series. And the next series will add QEMU/TCG support (it=
 will<br>
&gt; &gt; emulate Loongson-3A R1).<br>
&gt; &gt;<br>
&gt; &gt; We already have a full functional Linux kernel (based on Linux-5.=
4.x LTS<br>
&gt; &gt; but not upstream yet) here:<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://github.com/chenhuacai/linux" target=3D"_blank"=
>https://github.com/chenhuacai/<wbr>linux</a><br>
&gt; &gt;<br>
&gt; &gt; How to use QEMU/Loongson-3?<br>
&gt; &gt; 1, Download kernel source from the above URL;<br>
&gt; &gt; 2, Build a kernel with arch/mips/configs/loongson3_{<wbr>def,hpc}=
config;<br>
&gt; &gt; 3, Boot a Loongson-3A4000 host with this kernel;<br>
&gt; &gt; 4, Build QEMU-5.0.0 with this patchset;<br>
&gt; &gt; 5, modprobe kvm;<br>
&gt; &gt; 6, Use QEMU with TCG (available in future):<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-system-mips64el -M loongson3,acce=
l=3Dtcg -cpu Loongson-3A1000 -kernel &lt;path_to_kernel&gt; -append ...<br>
&gt; &gt;=C2=A0 =C2=A0 Use QEMU with KVM (available at present):<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-system-mips64el -M loongson3,acce=
l=3Dkvm -cpu Loongson-3A4000 -kernel &lt;path_to_kernel&gt; -append ...<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 The &quot;-cpu&quot; parameter can be omitted here a=
nd QEMU will use the correct type for TCG/KVM automatically.<br>
&gt; &gt;<br>
&gt; &gt; V1 -&gt; V2:<br>
&gt; &gt; 1, Add a cover letter;<br>
&gt; &gt; 2, Improve CPU definitions;<br>
&gt; &gt; 3, Remove LS7A-related things (Use GPEX instead);<br>
&gt; &gt; 4, Add a description of how to run QEMU/Loongson-3.<br>
&gt; &gt;<br>
&gt; &gt; V2 -&gt; V3:<br>
&gt; &gt; 1, Fix all possible <a href=3D"http://checkpatch.pl" target=3D"_b=
lank">checkpatch.pl</a> errors and warnings.<br>
&gt; &gt;<br>
&gt; &gt; Huacai Chen(7):<br>
&gt; &gt;=C2=A0 configure: Add KVM target support for MIPS64<br>
&gt; &gt;=C2=A0 hw/mips: Implement the kvm_type() hook in MachineClass<br>
&gt; &gt;=C2=A0 hw/mips: Add CPU IRQ3 delivery for KVM<br>
&gt; &gt;=C2=A0 target/mips: Add Loongson-3 CPU definition<br>
&gt; &gt;=C2=A0 target/mips: Add more CP0 register for save/restor<br>
&gt; &gt;=C2=A0 hw/mips: Add Loongson-3 machine support (with KVM)<br>
&gt; &gt;=C2=A0 MAINTAINERS: Add myself as Loongson-3 maintainer<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.co=
m">chenhc@lemote.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
&gt; &gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt; &gt;=C2=A0 default-configs/mips64el-<wbr>softmmu.mak |=C2=A0 =C2=A01 +=
<br>
&gt; &gt;=C2=A0 hw/core/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt; &gt;=C2=A0 hw/core/null-machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt; &gt;=C2=A0 hw/mips/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br>
&gt; &gt;=C2=A0 hw/mips/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
&gt; &gt;=C2=A0 hw/mips/common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 31 ++<br>
&gt; &gt;=C2=A0 hw/mips/mips_int.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt; &gt;=C2=A0 hw/mips/mips_loongson3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 901 ++++++++++++++++++++++++++++++<wbr>+++++<br>
&gt; &gt;=C2=A0 include/hw/mips/mips.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt; &gt;=C2=A0 target/mips/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 28 ++<br>
&gt; &gt;=C2=A0 target/mips/internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt; &gt;=C2=A0 target/mips/kvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 212 +++++++++<br>
&gt; &gt;=C2=A0 target/mips/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt; &gt;=C2=A0 target/mips/mips-defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A07 +-<br>
&gt; &gt;=C2=A0 target/mips/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
&gt; &gt;=C2=A0 target/mips/translate_init.<wbr>inc.c=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 86 ++++<br>
&gt; &gt;=C2=A0 18 files changed, 1300 insertions(+), 9 deletions(-)<br>
&gt; &gt;=C2=A0 create mode 100644 hw/mips/common.c<br>
&gt; &gt;=C2=A0 create mode 100644 hw/mips/mips_loongson3.c<br>
&gt; &gt; --<br>
&gt; &gt; 2.7.0<br>
<br>
<br>
<br>
--<br>
Huacai Chen<br>
</blockquote>

--00000000000030039905a4e3e2ba--

