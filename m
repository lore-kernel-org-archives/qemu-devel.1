Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550AAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 08:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2016F20885
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 08:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o4+WMPXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2016F20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmCIN-0005x7-F4
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 04:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jmCHh-0004mx-CM
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 04:22:01 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jmCHf-0002Si-HF
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 04:22:01 -0400
Received: by mail-wr1-x442.google.com with SMTP id h5so8808893wrc.7
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 01:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=GxAKAldlN7+RDgdFHkfohEPRC2IBDDPG0yuhgZJGpB4=;
 b=o4+WMPXwVGwwQWa86zF4+aR2l5VDtWGEHU1TKpV9iPWE8/vCfZErV9k2zeCgRIilr4
 9que748o2wNSQN8s5l5pVdiwbWa2R24Hq7+F2ihwBPAztvPzA5kZ1DdSGk//wpZnUAW3
 wzKDcZPyHku8nT/XUAdxi7c+JJMWwRxI5mYYYp04sze5U6P2/K3TWpxrC4/xdA92KZLW
 ScnpQJem+bYpKDGS/5ruUtwHqFvSG/dBbKQyvQ//82Uv4GKN0n1vtDO2OHSH3NSputvh
 RJCnKSj0QZWYl+M1wnef6MwssSRot7sm9rFaf3KSGwP+4gLc5OQBoISXwvlOWpWuaREU
 E01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=GxAKAldlN7+RDgdFHkfohEPRC2IBDDPG0yuhgZJGpB4=;
 b=pkl2ujNlniOabETOE0iII612zwKEgIG41gf7J3fYTxqDc+cZKHGur4SQbvAOHpyjty
 sAisW6VHpJAxhd7pXus7G8eiYSM7oSxSRZibTddqylws8A0QEIbT3D5N+cetwSrMIjfJ
 abvWzq2PGFJ1J4PbXMb64CrMd3jjyxIBq5yYWTStnqId+vyWTR8rq1OigAdP9L/d4XvC
 Q4+KM+os5K++OmjFAAqLQP3DaSJEB82SdnXUS0UIj2NG5Ix+uneYNIY25jNvdm26n3K5
 Mr9zyDT/PU9wTAuhYTzFOB0EsI5oaugQfn1UhNVEAp2jNXRQX+RXetnP5bOFiYIJxpVT
 LfPw==
X-Gm-Message-State: AOAM531O2rhyOLI+GtQD3aQBYW3GGpU4xhKzVUq04E+L/WQaoLDCpVuC
 rrFZXMnJDEwo0N/vNx9cnT3Haw==
X-Google-Smtp-Source: ABdhPJxZiC3Bb6lak90mpG3qlydOjuoDCz6M/gbvCqNOxj7UgZ6umGFLikENG/VW92cwmoFCt90ujw==
X-Received: by 2002:a5d:508e:: with SMTP id a14mr2630568wrt.335.1592554917085; 
 Fri, 19 Jun 2020 01:21:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c2sm6430644wrv.47.2020.06.19.01.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 01:21:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 493961FF7E;
 Fri, 19 Jun 2020 09:21:55 +0100 (BST)
References: <159223432851.7281.13140123017230519248.malonedeb@gac.canonical.com>
 <20200618135331.7ec861e9.cohuck@redhat.com>
 <CAHiYmc5eJDN-FmBZOtRCM9446mxLZW_JtWdZw7TmSYMsk8iz8Q@mail.gmail.com>
 <20200619081723.10594336.cohuck@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [Bug 1883560] [NEW] mips linux-user builds occasionly crash
 randomly only to be fixed by a full clean re-build
In-reply-to: <20200619081723.10594336.cohuck@redhat.com>
Date: Fri, 19 Jun 2020 09:21:55 +0100
Message-ID: <87h7v7v524.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <1883560@bugs.launchpad.net>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cornelia Huck <cohuck@redhat.com> writes:

> On Thu, 18 Jun 2020 19:00:34 +0200
> Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> wrote:
>
>> =D1=87=D0=B5=D1=82=D0=B2=D1=80=D1=82=D0=B0=D0=BA, 18. =D1=98=D1=83=D0=BD=
 2020., Cornelia Huck <cohuck@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=
=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>=20
>> > On Mon, 15 Jun 2020 15:18:48 -0000
>> > Alex Benn=C3=A9e <1883560@bugs.launchpad.net> wrote:
>> >=20=20
>> > > Public bug reported:
>> > >=20=20
>> > > >From time to time I find check-tcg crashes with a one of the MIPS=
=20=20
>> > > binaries. The last time it crashed was running the test:
>> > >
>> > >   ./mips64el-linux-user/qemu-mips64el ./tests/tcg/mips64el-linux-
>> > > user/threadcount
>> > >
>> > > Inevitably after some time noodling around wondering what could be
>> > > causing this weird behaviour I wonder if it is a build issue. I wipe=
 all
>> > > the mips* build directories, re-run configure and re-build and voila
>> > > problem goes away.
>> > >
>> > > It seems there must be some sort of build artefact which isn't being
>> > > properly re-generated on a build update which causes weird problems.
>> > > Additional data point if I:
>> > >
>> > >   rm -rf mips64el-linux-user
>> > >   ../../configure
>> > >   make
>> > >
>> > > then I see failures in mip32 builds - eg:
>> > >
>> > >     GEN     mipsn32el-linux-user/config-target.h
>> > >   In file included from /home/alex/lsrc/qemu.git/=20=20
>> > linux-user/syscall_defs.h:10,=20=20
>> > >                    from /home/alex/lsrc/qemu.git/linux-user/qemu.h:1=
6,
>> > >                    from /home/alex/lsrc/qemu.git/=20=20
>> > linux-user/linuxload.c:5:=20=20
>> > >   /home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h:1: error:=
=20=20
>> > unterminated #ifndef=20=20
>> > >    #ifndef LINUX_USER_MIPS64_SYSCALL_NR_H
>> > >
>> > >   make[1]: *** [/home/alex/lsrc/qemu.git/rules.mak:69:=20=20
>> > linux-user/linuxload.o] Error 1=20=20
>> > >   make[1]: *** Waiting for unfinished jobs....
>> > >
>> > > which implies there is a cross dependency between different targets
>> > > somewhere. If I executed:
>> > >
>> > >   rm -rf mips*
>> > >
>> > > before re-configuring and re-building then everything works again.
>> > >
>> > > ** Affects: qemu
>> > >      Importance: Undecided
>> > >          Status: New
>> > >
>> > >
>> > > ** Tags: build linux-user mips
>> > >=20=20
>> >
>> > FWIW, this does not seem to be a mips-only issue: I'm seeing the
>> > threadcount test fail with s390x-linux-user as well, and it also goes
>> > away (only) if I purge the build directory, re-configure, and re-build.
>> >
>> >
>> >=20=20
>> Alex, Cornelia,
>>=20
>> Do you perhaps recall how did you obtain the original binaries (those wi=
th
>> the problem)? What would be your typical workflow? Perhaps "git-pull +
>> make" on existing, but not latest source tree?
>
> Just a bog-standard "pull some stuff, do make, create a branch and put
> some patches on it, do make, switch to another branch, do make, etc". No
> advanced fiddling with git history, doing make on a subtree, etc.

Same here. As I say the syscall_nr breakage was a different one. I'll
regularly just advance my tree and find this sort of breakage.

--=20
Alex Benn=C3=A9e

