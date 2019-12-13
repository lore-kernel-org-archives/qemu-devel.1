Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E4DC2D0BF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 03:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079AF206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 03:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ogy0Oi75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079AF206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifbyq-00048c-1b
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 22:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ifbxu-00037R-VC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 22:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ifbxt-0004R5-Ep
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 22:50:06 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:38767 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ifbxr-00048A-6t
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 22:50:05 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47YxWK3pZGz9sP6; Fri, 13 Dec 2019 14:49:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576208989;
 bh=jTQ07n6bhhDkHqXYlFmMU8HcoexHQHqh/zM9QtI82nI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ogy0Oi75qVQKtAH3b1a6ppAETFhEC7qZFpYvUeL0beJ88hV9cV+tD07LjiMGsmOwZ
 +vUfp/yhUnlxgSAx1VBQApfdG348Ys+GrYBb4/aZMOS+Jwfy/fKxe40kcQ4TO2B+Dm
 aRyIekYALnia3oouK8+RIspkyl3U5uoRAFC7R2r0=
Date: Fri, 13 Dec 2019 14:49:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Wayne Li <waynli329@gmail.com>
Subject: Re: QEMU VM crashes when enabling KVM
Message-ID: <20191213034937.GB207300@umbus.fritz.box>
References: <CAM2K0nrhkOhiJDxnANGmAu2140-TP0a9pY58i_PN1k9xAWGz9A@mail.gmail.com>
 <76b207cd-09ce-b3df-e288-a515df40677e@redhat.com>
 <CAM2K0nph2GZQkAv3tCgoP+ciPMWSzVJp0rHDXJJ2Gtqeq2Bgug@mail.gmail.com>
 <c4e14191-efe5-7713-1eac-55a6bafb027a@redhat.com>
 <CAM2K0no9-M9WRm-QKFBMRofUaNkfmMtDvop3KxrOQrU80YWSTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hgh6eN/EXvS46552"
Content-Disposition: inline
In-Reply-To: <CAM2K0no9-M9WRm-QKFBMRofUaNkfmMtDvop3KxrOQrU80YWSTA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 David Gibson <dgibson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hgh6eN/EXvS46552
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 10:40:44AM -0600, Wayne Li wrote:
> Dear David Gibson,
>=20
> I know you are under no obligation to respond, but if it's possible for y=
ou
> to find the time to respond to my question, I would be extremely grateful.
> My team at Boeing has been stuck trying to get KVM working for our project
> for the last few months.  A good explanation of why this isn't possible
> would be absolutely critical.

As you can see from that diagram, the history ppc CPUs is quite a bit
more diverse than x86.  Although they're all very similar from the
point of view of userspace code, they're quite different for
privileged kernel code: they have different MMUs, different privileged
registers amongst other things.

Because of this there are several different KVM implementations.

1) KVM HV

This one uses the virtualization facilities of BookS CPUs (present
since POWER4 / 970, but only well supported from POWER7 onwards).
Those don't allow much to virtualize the guest cpu model, so it
assumes the guest cpu is the same as the host.

So, both your guest and host CPUs rule this one out.

2) Book3E KVM

Uses the virtualization features of recent enough Freescale Book E
CPUs.  I don't know a lot about this or its limitations.  The e6500
might well have these features, but I'm pretty sure it can only
emulate BookE cpus for the guest.

So, your guest rules this one out.

3) KVM PR

This one operates by running the entire guest in user mode, and
emulating all privileged instructions.  It's slow (relative to
hardware assisted KVM models), but it's flexible.

In theory, this one can do what you want, but there are a bunch of
caveats:

  * Emulating all the privileged instructions for a whole bunch of cpu
  variants is a huge task, and KVM PR is now barely maintained.  There
  are lots of gaps in coverage.

  * I'm not sure if it was ever really implemented for BookE hosts.

  * Although there aren't many, there are a few differences between
  userland instructions between cpu variants, mostly because of new
  additions.  I think 7457 is an old enough design that this probably
  won't cause you troube, but I'm not certain.



>=20
> -Thanks, Wayne Li
>=20
> On Thu, Dec 12, 2019 at 1:17 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> > On 12/12/19 02:59, Wayne Li wrote:
> > > We wrote a project that is created on top of the QEMU source code; it
> > > calls functions from the QEMU code.  I run the executable created by
> > > compiling that project/QEMU code.  Anyway, looking at the following
0> > > documentation:
> > >
> > > https://www.kernel.org/doc/Documentation/powerpc/cpu_families.txt
> > >
> > > It looks like the PowerPC 7457 is Book3S and the PowerPC e6500 is
> > > BookE.  Is that why you think I require a Book3S KVM?  Exactly why do
> > > you feel this way?  Also would that mean my team would need to go and
> > > buy a board with a Book3S processor?
> >
> > CCing the PPC maintainer.  There are aspects of BookE and Book3S that
> > are different and not really interchangeable in the privileged interfac=
e.
> >
> > Paolo
> >
> > > -Thanks!, Wayne Li
> > >
> > > From my understanding
> > >
> > > On Wed, Dec 11, 2019 at 7:16 PM Paolo Bonzini <pbonzini@redhat.com
> > > <mailto:pbonzini@redhat.com>> wrote:
> > >
> > >     On 11/12/19 22:23, Wayne Li wrote:
> > >     >
> > >     > Now I am fairly sure KVM is actually enabled on the system.
> > Finding
> > >     > that out was another story that spanned a couple of months.  But
> > long
> > >     > story short, lsmod doesn't show that the KVM kernel module is
> > >     running.
> > >     > But that's because KVM is built-in and it can't actually be bui=
lt
> > as a
> > >     > loadable kernel module in this particular system.
> > >     >
> > >     > So I'm not really sure what could be the problem.  Though I was
> > >     thinking
> > >     > if I understood the error better that might help?  Following the
> > >     code I
> > >     > see that the "Missing PVR setting capability." is called when a
> > >     variable
> > >     > called "cap_segstate" is 0:
> > >     >
> > >     > if (!cap_segstate) {
> > >     >             fprintf(stderr, "kvm error: missing PVR setting
> > >     capability\n");
> > >     >             return -ENOSYS;
> > >     > }
> > >     >
> > >     > And the cap_segstate variable is set by the following function:
> > >     >
> > >     > cap_segstate =3D kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
> > >
> > >     You are not saying how you are running QEMU.  I think you are usi=
ng a
> > >     CPU model that requires a Book3S KVM.
> > >
> > >     Paolo
> > >
> >
> >

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hgh6eN/EXvS46552
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3zCk4ACgkQbDjKyiDZ
s5Kz3BAA0lgareU2jmbZ1EErMg5g+wodHNhJxSDnPKlf+6t2wfym1AlZyF6zEnws
+IKaDetPu0uUgLepUdtLlJGvLIoqemQq1NLIepYF90tuTGZ6DoUIk7OWOFSn4v8u
wTe8Kb7zTSPzegJE3rL9Kk2tjR3g59bN9Tcq9zBX5QDqg+C/XcrXQcL5B1ZMhEhX
BRdRtUccNmPfoEE4atz6yREHTPgFfaOGXlAXgMHlMy9Eq2DYAZ630e3Q6nPXPA5Z
oRReCg2LVoH/VmJ/de4qMGr5wYAHgmWqYZw27tOOzKAtW6YLeSoaL0xRPwGEZvNr
vwjfMdzwYJB8UHR5hqyHqIqbfKDA8TQzvc97PlQVi2tEmqOt+fo5sA5scvdCY1S+
nvqFzGh7/OFiSaTy5yVZk0iSbTLCU0kaX1edt7FgK35Sb7tBfqk1tZdMkomLLY83
nTkgPQC+ygCuga2XMOo6mErqXz7MIqjoWLt4YjYUf8Op1X20ebQ/yiPQGYGk3dXB
Hn6aehq/Te33hWlC2VqI1ialSF8j+qNLnwNdLskenF0wvzco9HgQF7p8sRWDNPEA
NZJsvc6ZeuOq4eS/Nm+pajj6kHgR6hWXBY7Ln8ctbL4gHKEsi1S+TAR/UB5gJGT5
UgmHWVm7d3FLPoSsUe6rQ4ujHaLK+ilFmYanFUVO/W2/Uj0h/xM=
=oAwn
-----END PGP SIGNATURE-----

--hgh6eN/EXvS46552--

