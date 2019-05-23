Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97C6C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CD620868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgDGhGZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CD620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33645 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlQv-000074-Q7
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:58:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTl97-0001R9-AA
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTl95-00051W-EG
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:40:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hTl94-0004zf-I6
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:40:23 -0400
Received: by mail-wm1-x343.google.com with SMTP id y3so5291284wmm.2
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=4NgpGr+K1WSXDeX/ZhMAwDwmp4J2cR4y6usBMWAJEps=;
	b=XgDGhGZUYaSQQ/fqDUP/ffY55UJCXaZloYByrXSPRIVGO6o17Nvd1ktCbQQWnMO7mh
	DXA/K+afR9Aiqomy34wnOY7p4u7h39ktam03aDwg4KF3H30memQ4RNdXWgQVNJuJI5ck
	61gEv9mpcEuZsfIkI16KsHIbznyd4XIplqT7lmV5QKt6/TQ+UzwKcqFakiCOZuxHQjaL
	+LIrmxCk1c0RjKFXOD8OnbOziq13IZezUZo758SI/5hmHJYr0WYlPWMbb94MbtvOJ6je
	LHFWFFYXhLb3s4qJl5LlDJYHtBXjDTQwO2lZ6+BKCgQPd+twhpltlQCAJCPUQcOS3rPy
	Kz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=4NgpGr+K1WSXDeX/ZhMAwDwmp4J2cR4y6usBMWAJEps=;
	b=pZERDaE2jeIGL3BgTXF4nI5TXY9/K4POTbEspR4JnKIHIvxgBVXV3RZB870qBkIziW
	IHCjXHOvmSDDd8jyCZbwM8DXbWuV30PvqxLiumWvw47w+2ZR3IluDRqk6e0gQqZoFpTU
	cw5XmoeGWqlH0pRbbnu26apA7Ur4RVvEh3xl/Dkg3vQaiF446P1dgYAsgo1iDwXodk0c
	aDmdk59NU7lf1xvSPKT5Lhz1Y/2sySLQ5B2MKrrQuyTFSigt08DyeR1ThqHhxoS57D8o
	2CTBHsXQskkdInWU54HHeubxlNuZK1RUB9qcjG22PsfW7wzz7twjbP8ErHUvF5E4Fv5h
	qxwQ==
X-Gm-Message-State: APjAAAWN6dxaKKa7adiUCB88dDBk+3g7NjVik61hqIye7ZW3Z2FFTgEF
	fvhf7fu9045PnuX+wd6XW4Y=
X-Google-Smtp-Source: APXvYqwhY81bwe1pg5cwsncpLthFXqD/D04xhUNyUOZoQK2OhskSP2SKnJyRobxaq+MUykJSZujPAg==
X-Received: by 2002:a1c:ba87:: with SMTP id
	k129mr11355624wmf.132.1558608020123; 
	Thu, 23 May 2019 03:40:20 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	j28sm54215461wrd.64.2019.05.23.03.40.18
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:40:19 -0700 (PDT)
Date: Thu, 23 May 2019 11:40:18 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jag Raman <jag.raman@oracle.com>
Message-ID: <20190523104018.GE26632@stefanha-x1.localdomain>
References: <20190307145120.GF32268@redhat.com>
	<20190307192727.GG2915@stefanha-x1.localdomain>
	<BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
	<20190308095036.GC12318@stefanha-x1.localdomain>
	<20190326080822.GC21018@stefanha-x1.localdomain>
	<e5395abf-6b41-46c8-f5af-3210077dfdd5@oracle.com>
	<CAAdtpL4ztcpf-CTx0fc5T_+VQ+8upHa2pEMoiZPcmBXOO6L3Og@mail.gmail.com>
	<c945c950-f6f1-7e2a-a6c4-399c9b728288@oracle.com>
	<20190425154421.GG17806@stefanha-x1.localdomain>
	<fe4b0b42-523d-5877-173c-3e878abd4e32@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <fe4b0b42-523d-5877-173c-3e878abd4e32@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
	John G Johnson <john.g.johnson@oracle.com>,
	sstabellini@kernel.org, konrad.wilk@oracle.com,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
	qemu-devel@nongnu.org, ross.lagerwall@citrix.com,
	liran.alon@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>,
	kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 03:00:52PM -0400, Jag Raman wrote:
> Hi Stefan,
>=20
> Thank you very much for your feedback. Following is a summary of the
> discussions our team had regarding your feedback.
>=20
> On 4/25/2019 11:44 AM, Stefan Hajnoczi wrote:
> >=20
> > Can multiple LSI SCSI controllers be launched such that each process
> > only has access to a subset of disk images?  Or is the disk image label
> > per-VM so that there is no isolation between LSI SCSI controller
> > processes for that VM?
>=20
> Yes, it is possible to provide each process with access to a subset of
> disk images. The Orchestrator (libvirt, etc.) assigns a set of MCS
> Categories to each VM, then device instances can be isolated by being
> assigned a subset of the VM=E2=80=99s Categories.
>=20
> >=20
> > My concern with this overall approach is the practicality vs its
> > benefits.  Regarding practicality, each emulated device needs to be
> > proxied separately.  The QEMU subsystem used by the device also needs to
> > be proxied.  Global state, monitor commands, and live migration all
> > require code changes to support proxied operation.  This is very
> > invasive.
> >=20
> > Then each emulated device needs an SELinux policy to achieve the
> > benefits of confinement.  I have no idea how to correctly write a policy
> > like this and it's likely that developers who contribute a single new
> > device will not be proficient in it either.  Writing these policies is a
> > rare thing and few people will be good at this.  It also makes me worry
> > about how we test and review them.
>=20
> We also think that having an SELinux policy per device would become
> complicated. Our proposal, therefore, is to define SELinux policies for
> each device class - viz. disk, network, console, graphics, etc.
> "fedora-selinux" upstream repo. [1] will contain these policies, so the
> device developer doesn't have to worry about defining new policies for
> each device. This proposal would diminish the complexity of SELinux
> policies.

Have you considered using Linux namespaces?  I'm beginning to think that
SELinux becomes less relevant with pid and mount namespaces to isolate
processes.  The advantage of namespaces is that they are easy to
understand and can be expressed in code instead of a policy file in a
separate package.  This is the approach we're taking with virtiofsd
(vhost-user device backend for virtio-fs).

> >=20
> > Despite the efforts required in making this work, all processes still
> > effectively have full access to the guest since they can access guest
> > RAM.  What I mean is that the device is actually not confined to its
> > host process (e.g. LSI SCSI controller process) because it can write
> > code to executable guest RAM pages.  The guest will then execute that
> > code and therefore all guest I/O (networking, disk, etc) is still
> > available indirectly to the "confined" processes.  They are not really
> > sandboxed from the outside world, regardless of how strict the SELinux
> > policy is :(.
> >=20
> > There are performance issues due to proxying as well, but let's ignore
> > them for now and focus on security.
>=20
> We are also focusing on performance. Please take a look at the following
> blog for an initial report on performance. The results are for an iSCSI
> backend in Oracle Cloud. We are working on collecting data on a much
> heavier IOPS workload like an NVMe backend.
>=20
> https://blogs.oracle.com/linux/towards-a-more-secure-qemu-hypervisor%2c-p=
art-3-of-3-v2

Hard to reach a conclusion without also looking at CPU utilization.
IOPS alone don't tell the story.

If the system had spare CPU cycles then the performance results between
built-in LSI and separate LSI will be similar but the efficiency
(IOPS/CPU%) has actually decreased due to the extra CPU cycles required
to forward the hardware register access to the device emulation process.

If you rerun on a system without spare CPU cycles then IOPS degradation
would become apparent.  I'm not saying this is necessarily the case,
maybe the overhead is really doesn't have a significant effect, but the
graph shown in the blog post isn't enough to draw a conclusion either
way.

Regarding the proposed QEMU bypass, these already exist in some form via
kvm.ko's ioeventfd and coalesced MMIO features.

Today ioeventfd is only used for performance-critical hardware
registers, so kvm.ko doesn't use a sophisticated dispatch mechanism.  If
you want to use it for all hardware register accesses handled by a
separate process then ioeventfd probably needs to be tweaked somewhat to
make it more scalable for that case.

Coalesced MMIO is also cool.  kvm.ko can accumulate guest MMIO writes in
a buffer that is only collected at a later point in time.  This improves
performance for devices that require multiple hardware register writes
to kick off an I/O operation (only the last one really needs to be
trapped by the device emulation code!).  This sounds similar to an MMIO
access shared ring buffer.

> >=20
> > How do the benefits compare against today's monolithic approach?  If the
> > guest exploits monolithic QEMU it has full access to all host files and
> > APIs available to QEMU.  However, these are largely just the resources
> > that belong to the guest anyway - not resources we are trying to keep
> > away from the guest.  With multi-process QEMU each process still has
> > access to all guest interfaces via the code injection I mentioned above,
> > but the SELinux policy could restrict access to some resources.  But
> > this benefit is really small in my opinion, given that the resources
> > belong to the guest anyway and the guest can already access them.
>=20
> The primary focus of our project is to defend the host from malicious
> guest. The code injection problem you outlined above involves part of
> the guest attacking itself, but not the host. Therefore, this wouldn't
> compromise our objective.
>=20
> Like you know, there are some parts of QEMU which are not directly
> accessible from the guest (via drivers, etc.), which we prefer to call
> the control plane. It executes ioctls to the host kernel and has access
> to a broader set of syscalls, which the device emulation code doesn=E2=80=
=99t
> need. We want to protect the control plane from emulated devices. In the
> case where a device injects code into the RAM to attack another device
> on the same VM, the control plane would still be protected.

Are you aware of any cases where the syscall attack surface led to an
exploitable bug in QEMU?  Any proof-of-concept exploit code or a CVE?

> Another benefit with the project would be regarding detecting and
> reporting failures in the emulated devices. For instance, in cases like
> CVE-2018-18849, where an emulated device hangs/crashes, it wouldn't
> directly crash the QEMU process as well. QEMU could detect the failure,
> log the problem and exit, instead of generating coredump/hang.

Debugging is a lot easier with a coredump though :).  I would rather
have a coredump than a nice message that says "LSI died".

> >=20
> > I think you can implement this for a handful of devices as a one-time
> > thing, but the invasiveness and the impracticality of getting wide cover
> > of QEMU make this approach questionable.
> >=20
> > Am I mistaken about the invasiveness or impracticality?
>=20
> We are not planning to implement this for all devices since it would be
> impractical. But the project adds a framework for implementing more
> devices in the future.
>=20
> One other thing we would like to bring your attention to is that the
> project doesn't affect the current usage. The same devices could still
> be used as part of monolithic QEMU if the user chooses to do so.

I don't follow, to me this proposal seems extremely invasive and
requires awareness from all developers.

QEMU contains global state (like net/net.c:net_clients or
block.c:all_bdrv_states) and QMP commands that access global state.  All
of this needs to be carefully proxied to avoid losing functionality as
fundamental as the QMP monitor.

This is what worries me about this project.  There are amazing niche
features like record/replay that have been integrated into QEMU without
requiring all developers to be aware of how they work.  If you can
achieve this then I would have no reservations.

Right now I don't see that this will be possible and that's why I'm
challenging you to justify that the reduction in system call attack
surface is actually worth the invasive changes required.

Do you see a way to solve the issues I've mentioned?

Stefan

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzmeJEACgkQnKSrs4Gr
c8huLQf/RjAUDtG6hIRSiORcI/dG3f19zkZi0xxWBIz4vy/PG4qQj6pEAsE1KzNV
ucmErb8Uh5WnCzMH0hq/PV8/nQacPYmTzSvFdMi+PpqrdfDV0ACjoL/VRX5o6Hj4
2Dorz8iwTJj4nQAGi9uvdQFdlHN6gcjbBrO8Bs3yostKb2lXICf6cfN5wdQQsNGC
iJ9pyQrfYUpwi+r9+2zYVfTIf40h/iqUaw6ve6OahuNHqBOqPIcmY8DXGHT1WyvH
xT7GGj9xuSl7phciAIwNgOfvrCUJ8Oc/GJDyCrb3TIrxubr2CqyNRDCqahLitHDz
eDTzKDfMWracZDMocnTjgZwD0/i94w==
=JvpG
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--

