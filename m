Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31FDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B583206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q85wZrEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B583206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCmz-0006x1-N8
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqCm5-00065s-9g
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:41:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqCm0-00012r-8k
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:41:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id g18so19462736wrm.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 02:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=16Q+D1ASFejaRoEQP7IQTA+5VBBHjXuC/qwKOqXsCV8=;
 b=Q85wZrEbmhQqo17vIGwrLWxhpr12lTUjcV0qMk7qzmOSQmZNxMigwFdO0NvoEUycpO
 rDCb18ihpU31aGsW8x/7WF0aH570x9ZrTX2LU1zSfviwk1CcWP1ZNF1Z8ahDPz4nPnS0
 qOGTPq8OEmmfmFuc4YgQMzs/CZnR0h/SvUMrkYU8KURV2Cq7jXNlpd0gOIlLpd/yJayV
 vDUMLD2vruvqVVJEn3O3vqEy/cTDZNtF/fmEKnpd9IK6Jw66rXcpRpMIjOkQCWTOXBm5
 9XLq+QVMn37Sf7rhfLbLSsjiTPsLih36Nk0GPG1mekStUFpEUTzHD0ieX6RfKlVOGSoi
 L4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=16Q+D1ASFejaRoEQP7IQTA+5VBBHjXuC/qwKOqXsCV8=;
 b=q8JuhYbSl+YesCBQ9djOm+W4y5BeXDXZnxezdwJO7P37lbbLDnFdds+8SR18btn8Df
 4tRvMGMz37oPGsiEe0dDheUcQ1Qmsk4TX9F6ReV+xqJUX2ogeMdvfYoyvAZ94zDq8gL/
 utGK843tsCfClv5bwGIpZK09lr7oYpOKj5ch+nfzLENPb3SIQEXvHi1G2CApBYsHj8Fm
 HR1U883OtMxuEk4Rvf1BgkuL4ZzICpRWkJTGutiIuwHr9Iq4ZD1zkdebZke+5+1fUh/r
 ZwbLw0e2waVq9Sur0raamTPsdDVHwkhNRvvrSsiS4jaERHf9RMdeVqTw6PCqItLGY0ug
 0kPQ==
X-Gm-Message-State: AOAM530GB5EGSipfQ9qWvMDkUhSTNc3bnWv3A29R5x8C95OAdCSj918Q
 8In/Pys640K54OoMDkDqwKvMorL+VcYmaXIcgec=
X-Google-Smtp-Source: ABdhPJzU51kxIun4YWzv0zIEpCe9GSAdI8h43Mizwe/BHiV/XaGZEMbvhCnmN95xbRCP+H3zr6qEddMQlwGUQJs4mks=
X-Received: by 2002:a5d:6907:: with SMTP id t7mr20952042wru.329.1593510110616; 
 Tue, 30 Jun 2020 02:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <5ff8e75e-787e-a34d-2b3c-da63e2e46e1f@redhat.com>
In-Reply-To: <5ff8e75e-787e-a34d-2b3c-da63e2e46e1f@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 30 Jun 2020 11:41:38 +0200
Message-ID: <CAHiYmc5MwdvUOOrErUmpXPiviekJnWBU-tp0wEFw0aW6_L6F4g@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 30. =D1=98=D1=83=D0=BD 2020. =D1=83 06:34 Luk=C3=A1=C5=
=A1 Doktor <ldoktor@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Dne 29. 06. 20 v 12:25 Ahmed Karaman napsal(a):
> > Hi,
> >
> > The second report of the TCG Continuous Benchmarking series builds
> > upon the QEMU performance metrics calculated in the previous report.
> > This report presents a method to dissect the number of instructions
> > executed by a QEMU invocation into three main phases:
> > - Code Generation
> > - JIT Execution
> > - Helpers Execution
> > It devises a Python script that automates this process.
> >
> > After that, the report presents an experiment for comparing the
> > output of running the script on 17 different targets. Many conclusions
> > can be drawn from the results and two of them are discussed in the
> > analysis section.
> >
> > Report link:
> > https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Dissecting-QEMU=
-Into-Three-Main-Parts/
> >
> > Previous reports:
> > Report 1 - Measuring Basic Performance Metrics of QEMU:
> > https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
> >
> > Best regards,
> > Ahmed Karaman
>
> Hello Ahmed,
>
> very nice reading, both reports so far. One thing that could be better di=
splayed is the system you used this to generate. This would come handy espe=
cially later when you move from examples to actual reports. I think it'd ma=
ke sense to add a section with a clear definition of the machine as well as=
 the operation system, qemu version and eventually other deps (like compile=
r, flags, ...). For this report something like:
>
> architecture: x86_64
> cpu_codename: Kaby Lake
> cpu: i7-8650U
> ram: 32GB DDR4
> os: Fedora 32
> qemu: 470dd165d152ff7ceac61c7b71c2b89220b3aad7
> compiler: gcc-10.1.1-1.fc32.x86_64
> flags: --target-list=3D"x86_64-softmmu,ppc64-softmmu,aarch64-softmmu,s390=
x-softmmu,riscv64-softmmu" --disable-werror --disable-sparse --enable-sdl -=
-enable-kvm  --enable-vhost-net --enable-vhost-net --enable-attr  --enable-=
kvm  --enable-fdt   --enable-vnc --enable-seccomp --block-drv-rw-whitelist=
=3D"vmdk,null-aio,quorum,null-co,blkverify,file,nbd,raw,blkdebug,host_devic=
e,qed,nbd,iscsi,gluster,rbd,qcow2,throttle,copy-on-read" --python=3D/usr/bi=
n/python3 --enable-linux-io-uring
>
> would do. Maybe it'd be even a good idea to create a script to report thi=
s basic set of information and add it after each of the perf scripts so peo=
ple don't forget to double-check the conditions, but others might disagree =
so take this only as a suggestion.
>

I just want to follow up on this observation here, and not related to
Ahmed's report at all.

We often receive bug reports of the following style: "I have Debian
10.2 system and mips emulation misbehaves". As you may imagine, I
assign the bug to myself, install Debian 10.2 system on my
experimental box, and mips emulation works like charm.
<banging-head-against-the-wall-emoji> Obviously, I need more info on
the submitter's system.

After all these years, we don't have (or at least I don't know about
it) a script that we could give the submitter, that picks up various
aspects of his system. This script, since it is not "for presentation"
could be even far more aggressive in picking ups system information
that what Lukas mentioned above. It could collect the output of
various relevant commands, and yip it in a single file. We should have
"get_system_info.py" in our scripts directory!

Sincerely,
Aleksandar


> Regards,
> Luk=C3=A1=C5=A1
>
> PS: Automated cpu codenames, hosts OSes and such could be tricky, but one=
 can use other libraries or just best-effort-approach with fallback to "unk=
nown" to let people filling it manually or adding their branch to your scri=
pt.
>
> Regards,
> Luk=C3=A1=C5=A1
>

