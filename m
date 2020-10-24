Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4E9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F112076A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4RvxQa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F112076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWRK5-0005BA-N5
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 17:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWRIK-0004I8-SJ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 17:41:49 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWRIH-0003YS-2S
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 17:41:48 -0400
Received: by mail-io1-xd43.google.com with SMTP id z17so6069115iog.11
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 14:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WBUq/feDPY/uqkn8c4AkXzeMq6vzpLVk1E+dKIR1Sxg=;
 b=r4RvxQa5SW2Km6MzHDi2JybaeOykeC/vTEkaB+UNxugPrSwJ5yM6fA3BUbB/LR0k/t
 pS+QKUW2KT4SJUIigZAz7AGCLn1BTB2CNTsHMIqFSz7ga5hve8ZuCmGutuizlqro6SUf
 aD+8wFja6rxLYbb8cHUdpgcthw+aoN2d49wAAXVvzQ4KwMXNyNwx2Vbvo15k0tZTxkEH
 chUUVCP5knd6nBpmkpx1Zr9H5Dq6Q82PKaKbEn8Xj4xDos1ywJ6Esfu37l638fyyOt9a
 +ZhAumjfZmodgL6cihwtZ9oY1bE5WL75MzwxdRHYfYXwNx4v+dNSi1tnZR2ojawa1RrN
 gkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WBUq/feDPY/uqkn8c4AkXzeMq6vzpLVk1E+dKIR1Sxg=;
 b=N9+BrUds0o0oGSHAF9jkhP70ni+jCcZmHf1Zwz70xMVCFH03tF9fHWJHlCt/dq1lEL
 hf3kRyt5gp4m2LSA6xZfweHDl23joRzUIRKyfOJEL8E+J+u6oeFRY4I9LKirjOyB6ezg
 7fpThmHM2/7DTvlsrXSKj/DyM/J0sunxIxM3XS8P9jjtUhjOJBZgNV3s5+dYn6RJhe34
 SHGMRuVm1H6yVNl4APIMv30/Kh1KY6osha8FV+AsiMKXJxFBRmHCPwt3tDJITDhbQtgt
 hhaJLgbVj8vuhymyaMgCcSOK6DwrhV8Ey/yAsFJ2mEzWDUun5aOThVLc3kDrZqdgl/Vq
 wWYw==
X-Gm-Message-State: AOAM533k8MzAI6RyTCSfpZtwgRjvnYLfRXfyQpwNrGdzbUGt5H3uGuFD
 J/w2vvda/n2uT+yGn10ip2sy1X9SeA+/5CSAaj4=
X-Google-Smtp-Source: ABdhPJz9Cl7t6rUANkUHkLz61vz19DE/PhuhTbRpPm63dUVnl8kwiTsWv2bT/8bn+0IbacVgOwlk1IIMv4BMFRn6JB8=
X-Received: by 2002:a05:6638:1241:: with SMTP id
 o1mr4742608jas.85.1603575703395; 
 Sat, 24 Oct 2020 14:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200821172916.1260954-1-f4bug@amsat.org>
 <20200821172916.1260954-23-f4bug@amsat.org>
 <e378932a-1de3-83c1-834f-ae6526604cb7@amsat.org>
 <CAEUhbmVFZ8aWdv48D8acdfFRp6WMYL6n=ENeo4hBZfmqE9TrDA@mail.gmail.com>
 <a0ac3805-ec48-2a0e-6511-b142bfc6f214@amsat.org>
 <CAEUhbmVLFJWND=KHexD12mrCMJSO3mcE6k7_tRE+v8pNZjhN_A@mail.gmail.com>
 <CAPan3Wqx-psi6zgz3NyM1Hu_PHaGq4Nn3_RJf_zueqwXFNKuWg@mail.gmail.com>
 <CAEUhbmXGbNNXkJYt8-sX_+nT_ReXoyerYaf+KROxx55-89wbHA@mail.gmail.com>
 <db561779-005b-c358-3e72-e1169ef49faf@amsat.org>
 <26e41113-e124-63f7-64c5-2d42011c5cfb@redhat.com>
In-Reply-To: <26e41113-e124-63f7-64c5-2d42011c5cfb@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sat, 24 Oct 2020 23:41:32 +0200
Message-ID: <CAPan3Wr2CtgSmvwjUP7UR5ATqfZ_8Rhi7NFX0UNTK-EvzOzsqg@mail.gmail.com>
Subject: Re: Should we keep using Avocado for functional testing? (was: Re:
 [PULL 22/23] hw/sd: Fix incorrect populated function switch status data
 structure)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002be19b05b27190c1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002be19b05b27190c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Fri, Oct 23, 2020 at 11:34 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> On 10/23/20 11:23 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 10/23/20 4:02 AM, Bin Meng wrote:
> >> Hi Niek,
> >>
> >> On Thu, Oct 22, 2020 at 11:20 PM Niek Linnenbank
> >> <nieklinnenbank@gmail.com> wrote:
> >>>
> >>> Hi Bin, Philippe,
> >>>
> >>> If im correct the acceptance tests for orange pi need to be run with
> >>> a flag ARMBIAN_ARTIFACTS_CACHED set that explicitly allows them to be
> >>> run using the armbian mirror. So if you pass that flag on the same
> >>> command that Philippe gave, the rests should run.
> >>
> >> Thank you for the hints. Actually I noticed the environment variable
> >> ARMBIAN_ARTIFACTS_CACHED when looking at the test codes, but after I
> >> turned on the flag it still could not download the test asset from the
> >> apt.armbian.com website.
> >
> > This patch could help you, but it use a different image [*]:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg737760.html
> > (I haven't tested the image yet but I assume the same bug is present).
> >
> >>
> >>> I have a follow up question and Im interested to hear your opinion on
> >>> that Philippe. Should we perhaps update the orange pi tests (and
> >>> maybe others) so they use a reliable mirror that we can control, for
> >>> example a github repo? I would be happy to create a repo for that, at
> >>> least for the orange pi tests. But maybe there is already something
> >>> planned as a more general solution for artifacts of other machines as
> >>> well?
> >
> > This is a technical debt between the Avocado and QEMU communities
> > (or a misunderstanding?).
> >
> > QEMU community understood the Avocado caching would be an helpful
> > feature, but it ended being more of a problem.
> >
> >
> > I.e. here Niek, Michael Roth and myself still have the image cached,
> > so we can keep running the tests committed to the repository. You
> > Bin can not, as the armbian mirror is not stable and remove the old
> > image.
> >
> > The old image (Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img)
> > has been manually tested by Niek and myself, I enabled tracing and
> > look at the SD packets for some time, was happy how the model worked
> > and decided we should keep running a test with this particular image.
> >
> > Armbian released new images, in particular the one Cleber sent in [*]:
> > Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img.xz. While it might
> > work similarly, I haven't tested it, and don't have time to do again
> > the same audit.
> >  From my experience with the Raspberry Pi, these images never work the
> > same way, as the Linux kernel evolves quickly with these kinda recent
> > embedded boards. The QEMU raspi models have to emulate new devices
> > (or complete current ones) every years, because Linux started to use
> > a device differently, or started to use a part of the SoC that was not
> > used before. Either the kernel doesn't boot, or there are side-effect
> > later when userspace program is executed. PITA to debug TBH. For this
> > reason I disagree with updating test images to the latest releases.
>

Yes, I agree that we should try to use stable artifacts for the acceptance
tests.


> >
> > It would be nice to know QEMU works with the latest Armbian, but
> > nobody popped up on the mailing list asking for it. I am personally
> > happy enough using the 19.11 release for now.
>
> Back to the cache problem, I started to ask 2 years ago,
> https://www.mail-archive.com/avocado-devel@redhat.com/msg00860.html
> note this is the exact situation we are having:
>
>  >> - What will happens if I add tests downloading running on their
>  >> compiled u-boot
>  >>
> (
> https://downloads.gumstix.com/images/angstrom/developer/2012-01-22-1750/u=
-boot.bin
> )
>  >> and the company decides to remove this old directory?
>  >> Since sometimes old open-source software are hard to rebuild with
>  >> recent compilers, should we consider to use a public storage to keep
>  >> open-source (signed) blobs we can use for integration testing?
>  >
>  > For Avocado-VT, there are the JeOS images[1], which we keep on a test
>  > "assets" directory.  We have a lot of storage/bandwidth availability,
>  > so it can be used for other assets proven to be necessary for tests.
>  >
>  > As long as distribution rights and licensing are not issues, we can
>  > definitely use the same server for kernels, u-boot images and what
>  > not.
>  >
>  > [1] - https://avocado-project.org/data/assets/
>
>
> We discussed about this again last year at the KVM forum. Various
> RFE have been filled:
> https://www.mail-archive.com/avocado-devel@redhat.com/msg01183.html
>
>
> What we need is a QEMU community file server similar to the asset
> one used by the Avocado community. The problem is who is going to
> pay and sysadmin it. IIRC Gerd suggested to use GitLab Page, but
> the artifact file size is limited to a maximum of 1GiB:
> https://docs.gitlab.com/ee/user/gitlab_com/#gitlab-pages
> Alternative is to use a git-lfs server:
> https://docs.gitlab.com/ee/topics/git/lfs/#hosting-lfs-objects-externally
> This is now a project management problem.
>
> What about the host / server where qemu.org is located? If we could
store them there in a sub-directory, that should work. Perhaps people from
the community would be willing to provide a mirror server to balance to
traffic load.


> Next week is the KVM forum 2020 and there might be a BoF session
> to talk about that:
>
> https://kvmforum2020.sched.com/overview/type/Birds+of+a+Feather+Sessions+=
(BoF)
>
>
> Now that the QEMU community started to use gitlab-ci more and more
> I received complains that Avocado is not practical (hard to
> understand how to reproduce command line to debug, options to use
> not clear, timeouts not clear, why download all artifacts to run
> a single test, various issues regarding caching, cache filled /home
> filesystem) so I have been asked to look at Avocado alternatives,
> because we want contributors run more tests and CI, not them be
> scared by it.
>
I haven't looked at alternatives yet, from the various features
> we could have use, the biggest one is the ability to interact with
> the serial console. And that feature is duplicated with the VM
> testing class: tests/vm/basevm.py.
> The SSH session used in linux_ssh_mips_malta.py is similar to the
> one from basevm.py too (see 'make vm-boot-ssh-%').
> Some tests are not 'acceptance' but simple qtest written in Python,
> such cpu_queries.py / pc_cpu_hotplug_props.py / migration.py /
> pc_cpu_hotplug_props.py / x86_cpu_model_versions.py.
>
> The classes I find practical are downloading artifact, uncompressing
> or extracting archive, and eventually the cloudinit one. But we can
> probably use them directly.
>
> Interesting to hear that. Yeah that is probably a big task that takes tim=
e
to find the best solution. There are quite some files indeed in the
tests/acceptance directory,
almost a full framework on its own. In fact it could even be something to
consider, to make
./tests/acceptance a stand-alone framework when avocado isn't used anymore
in the future?


>
> Lot of material to discuss :)
>

Thanks for your extensive reply Philippe. Looking forward to hear what the
outcome is on that with the discussions at the KVM forum.


>
> Regards,
>
> Phil.
>
>

--=20
Niek Linnenbank

--0000000000002be19b05b27190c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,<br></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23, 2020 at 1=
1:34 AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com=
" target=3D"_blank">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On 10/23/20 11:23 AM, Philippe Mathieu=
-Daud=C3=A9 wrote:<br>
&gt; On 10/23/20 4:02 AM, Bin Meng wrote:<br>
&gt;&gt; Hi Niek,<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Oct 22, 2020 at 11:20 PM Niek Linnenbank<br>
&gt;&gt; &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">=
nieklinnenbank@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hi Bin, Philippe,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; If im correct the acceptance tests for orange pi need to be ru=
n with <br>
&gt;&gt;&gt; a flag ARMBIAN_ARTIFACTS_CACHED set that explicitly allows the=
m to be <br>
&gt;&gt;&gt; run using the armbian mirror. So if you pass that flag on the =
same <br>
&gt;&gt;&gt; command that Philippe gave, the rests should run.<br>
&gt;&gt;<br>
&gt;&gt; Thank you for the hints. Actually I noticed the environment variab=
le<br>
&gt;&gt; ARMBIAN_ARTIFACTS_CACHED when looking at the test codes, but after=
 I<br>
&gt;&gt; turned on the flag it still could not download the test asset from=
 the<br>
&gt;&gt; <a href=3D"http://apt.armbian.com" rel=3D"noreferrer" target=3D"_b=
lank">apt.armbian.com</a> website.<br>
&gt; <br>
&gt; This patch could help you, but it use a different image [*]:<br>
&gt; <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg73776=
0.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/q=
emu-devel@nongnu.org/msg737760.html</a><br>
&gt; (I haven&#39;t tested the image yet but I assume the same bug is prese=
nt).<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt;&gt; I have a follow up question and Im interested to hear your opi=
nion on <br>
&gt;&gt;&gt; that Philippe. Should we perhaps update the orange pi tests (a=
nd <br>
&gt;&gt;&gt; maybe others) so they use a reliable mirror that we can contro=
l, for <br>
&gt;&gt;&gt; example a github repo? I would be happy to create a repo for t=
hat, at <br>
&gt;&gt;&gt; least for the orange pi tests. But maybe there is already some=
thing <br>
&gt;&gt;&gt; planned as a more general solution for artifacts of other mach=
ines as <br>
&gt;&gt;&gt; well?<br>
&gt; <br>
&gt; This is a technical debt between the Avocado and QEMU communities<br>
&gt; (or a misunderstanding?).<br>
&gt; <br>
&gt; QEMU community understood the Avocado caching would be an helpful<br>
&gt; feature, but it ended being more of a problem.<br>
&gt; <br>
&gt; <br>
&gt; I.e. here Niek, Michael Roth and myself still have the image cached,<b=
r>
&gt; so we can keep running the tests committed to the repository. You<br>
&gt; Bin can not, as the armbian mirror is not stable and remove the old<br=
>
&gt; image.<br>
&gt; <br>
&gt; The old image (Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img)<br=
>
&gt; has been manually tested by Niek and myself, I enabled tracing and<br>
&gt; look at the SD packets for some time, was happy how the model worked<b=
r>
&gt; and decided we should keep running a test with this particular image.<=
br>
&gt; <br>
&gt; Armbian released new images, in particular the one Cleber sent in [*]:=
<br>
&gt; Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img.xz. While it might=
<br>
&gt; work similarly, I haven&#39;t tested it, and don&#39;t have time to do=
 again<br>
&gt; the same audit.<br>
&gt;=C2=A0 From my experience with the Raspberry Pi, these images never wor=
k the<br>
&gt; same way, as the Linux kernel evolves quickly with these kinda recent<=
br>
&gt; embedded boards. The QEMU raspi models have to emulate new devices<br>
&gt; (or complete current ones) every years, because Linux started to use<b=
r>
&gt; a device differently, or started to use a part of the SoC that was not=
<br>
&gt; used before. Either the kernel doesn&#39;t boot, or there are side-eff=
ect<br>
&gt; later when userspace program is executed. PITA to debug TBH. For this<=
br>
&gt; reason I disagree with updating test images to the latest releases.<br=
></blockquote><div><br></div><div>Yes, I agree that we should try to use st=
able artifacts for the acceptance tests.</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; It would be nice to know QEMU works with the latest Armbian, but<br>
&gt; nobody popped up on the mailing list asking for it. I am personally<br=
>
&gt; happy enough using the 19.11 release for now.<br>
<br>
Back to the cache problem, I started to ask 2 years ago,<br>
<a href=3D"https://www.mail-archive.com/avocado-devel@redhat.com/msg00860.h=
tml" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/avoc=
ado-devel@redhat.com/msg00860.html</a><br>
note this is the exact situation we are having:<br>
<br>
=C2=A0&gt;&gt; - What will happens if I add tests downloading running on th=
eir<br>
=C2=A0&gt;&gt; compiled u-boot<br>
=C2=A0&gt;&gt; <br>
(<a href=3D"https://downloads.gumstix.com/images/angstrom/developer/2012-01=
-22-1750/u-boot.bin" rel=3D"noreferrer" target=3D"_blank">https://downloads=
.gumstix.com/images/angstrom/developer/2012-01-22-1750/u-boot.bin</a>)<br>
=C2=A0&gt;&gt; and the company decides to remove this old directory?<br>
=C2=A0&gt;&gt; Since sometimes old open-source software are hard to rebuild=
 with<br>
=C2=A0&gt;&gt; recent compilers, should we consider to use a public storage=
 to keep<br>
=C2=A0&gt;&gt; open-source (signed) blobs we can use for integration testin=
g?<br>
=C2=A0&gt;<br>
=C2=A0&gt; For Avocado-VT, there are the JeOS images[1], which we keep on a=
 test<br>
=C2=A0&gt; &quot;assets&quot; directory.=C2=A0 We have a lot of storage/ban=
dwidth availability,<br>
=C2=A0&gt; so it can be used for other assets proven to be necessary for te=
sts.<br>
=C2=A0&gt;<br>
=C2=A0&gt; As long as distribution rights and licensing are not issues, we =
can<br>
=C2=A0&gt; definitely use the same server for kernels, u-boot images and wh=
at<br>
=C2=A0&gt; not.<br>
=C2=A0&gt;<br>
=C2=A0&gt; [1] - <a href=3D"https://avocado-project.org/data/assets/" rel=
=3D"noreferrer" target=3D"_blank">https://avocado-project.org/data/assets/<=
/a><br>
<br>
<br>
We discussed about this again last year at the KVM forum. Various<br>
RFE have been filled:<br>
<a href=3D"https://www.mail-archive.com/avocado-devel@redhat.com/msg01183.h=
tml" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/avoc=
ado-devel@redhat.com/msg01183.html</a><br>
<br>
<br>
What we need is a QEMU community file server similar to the asset<br>
one used by the Avocado community. The problem is who is going to<br>
pay and sysadmin it. IIRC Gerd suggested to use GitLab Page, but<br>
the artifact file size is limited to a maximum of 1GiB:<br>
<a href=3D"https://docs.gitlab.com/ee/user/gitlab_com/#gitlab-pages" rel=3D=
"noreferrer" target=3D"_blank">https://docs.gitlab.com/ee/user/gitlab_com/#=
gitlab-pages</a><br>
Alternative is to use a git-lfs server:<br>
<a href=3D"https://docs.gitlab.com/ee/topics/git/lfs/#hosting-lfs-objects-e=
xternally" rel=3D"noreferrer" target=3D"_blank">https://docs.gitlab.com/ee/=
topics/git/lfs/#hosting-lfs-objects-externally</a><br>
This is now a project management problem.<br>
<br></blockquote><div>What about the host / server where <a href=3D"http://=
qemu.org" target=3D"_blank">qemu.org</a> is located? If we could</div><div>=
store them there in a sub-directory, that should work. Perhaps people from<=
/div><div>the community would be willing to provide a mirror server to bala=
nce to traffic load.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
Next week is the KVM forum 2020 and there might be a BoF session<br>
to talk about that:<br>
<a href=3D"https://kvmforum2020.sched.com/overview/type/Birds+of+a+Feather+=
Sessions+(BoF)" rel=3D"noreferrer" target=3D"_blank">https://kvmforum2020.s=
ched.com/overview/type/Birds+of+a+Feather+Sessions+(BoF)</a><br>
<br>
<br>
Now that the QEMU community started to use gitlab-ci more and more<br>
I received complains that Avocado is not practical (hard to<br>
understand how to reproduce command line to debug, options to use<br>
not clear, timeouts not clear, why download all artifacts to run<br>
a single test, various issues regarding caching, cache filled /home<br>
filesystem) so I have been asked to look at Avocado alternatives,<br>
because we want contributors run more tests and CI, not them be<br>
scared by it. <br></blockquote><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
I haven&#39;t looked at alternatives yet, from the various features<br>
we could have use, the biggest one is the ability to interact with<br>
the serial console. And that feature is duplicated with the VM<br>
testing class: tests/vm/basevm.py.<br>
The SSH session used in linux_ssh_mips_malta.py is similar to the<br>
one from basevm.py too (see &#39;make vm-boot-ssh-%&#39;).<br>
Some tests are not &#39;acceptance&#39; but simple qtest written in Python,=
<br>
such cpu_queries.py / pc_cpu_hotplug_props.py / migration.py /<br>
pc_cpu_hotplug_props.py / x86_cpu_model_versions.py.<br>
<br>
The classes I find practical are downloading artifact, uncompressing<br>
or extracting archive, and eventually the cloudinit one. But we can <br>
probably use them directly.<br>
<br></blockquote><div>Interesting to hear that. Yeah that is probably a big=
 task that takes time<br></div><div>to find the best solution. There are qu=
ite some files indeed in the tests/acceptance directory,</div><div>almost a=
 full framework on its own. In fact it could even be something to consider,=
 to make</div><div>./tests/acceptance a stand-alone framework when avocado =
isn&#39;t used anymore in the future?<br></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
Lot of material to discuss :)<br></blockquote><div><br></div><div>Thanks fo=
r your extensive reply Philippe. Looking forward to hear what the outcome i=
s on that with the discussions at the KVM forum.</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Regards,<br>
<br>
Phil.<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr"><div dir=
=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div></div>

--0000000000002be19b05b27190c1--

