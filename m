Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278A0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B7D20709
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="J94a9Ufe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B7D20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joKmn-0005nm-50
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 01:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joKja-0000al-LC; Thu, 25 Jun 2020 01:47:38 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:48357 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joKjW-0004QQ-AH; Thu, 25 Jun 2020 01:47:38 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49spv46hYQz9sT2; Thu, 25 Jun 2020 15:47:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593064048;
 bh=r+Tfaf10u6+JztU+M0YXzOVRuDJqj9jnhzXznvdkc6A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J94a9Ufe0V2zmeVJBSlO4OOyVKi8TlKAiDE9fH5DTCp4VIcbtHvjYuFj3iSv9bphT
 ScqsjulCydjiOQMc+wmUajepzkETYwm5IbFDvRn1SfqKrPexYAeZrZdHPjI46uVlbf
 R1ongJeCB21HfL7932OJM9TuZ6Z4gk+IO72IJ6i4=
Date: Thu, 25 Jun 2020 15:42:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/9] Generalize memory encryption models
Message-ID: <20200625054201.GE172395@umbus.fritz.box>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <e045e202-cd56-4ddc-8c1d-a2fe5a799d32@redhat.com>
 <20200619094820.GJ17085@umbus.fritz.box>
 <a1f47bc3-40d6-f46e-42e7-9c44597c3c90@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
In-Reply-To: <a1f47bc3-40d6-f46e-42e7-9c44597c3c90@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, dgilbert@redhat.com,
 pasic@linux.ibm.com, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 pbonzini@redhat.com, mdroth@linux.vnet.ibm.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2020 at 12:04:25PM +0200, David Hildenbrand wrote:
> >> However, once we have multiple options to protect a guest (memory
> >> encryption, unmapping guest pages ,...) the name will no longer really
> >> suffice to configure QEMU, no?
> >=20
> > That's why it takes a parameter.  It points to an object which can
> > itself have more properties to configure the details.  SEV already
> > needs that set up, though for both PEF and s390 PV we could pre-create
> > a standard htl object.
>=20
> Ah, okay, that's the "platform specific object which configures and
> manages the specific details". It would have been nice in the cover
> letter to show some examples of how that would look like.

Ok, I can try to add some.

> So it's wrapping architecture-specific data in a common
> parameter. Hmm.

Well, I don't know I'd say "wrapping".  You have a common parameter
that points to an object with a well defined interface.  The available
implementations of that object will tend to be either zero or one per
architecture, but there's no theoretical reason it has to be.  Indeed
we expect at least 2 for x86 (SEV and the Intel one who's name I never
remember).  Extra ones are entirely plausible for POWER and maybe s390
too, when an updated version of PEF or PV inevitably rolls around.

Some sort of new HTL scheme which could work across multiple archs is
much less likely, but it's not totally impossible either.

> >>> For now this series covers just AMD SEV and POWER PEF.  I'm hoping it
> >>> can be extended to cover the Intel and s390 mechanisms as well,
> >>> though.
> >>
> >> The only approach on s390x to not glue command line properties to the
> >> cpu model would be to remove the CPU model feature and replace it by t=
he
> >> command line parameter. But that would, of course, be an incompatible =
break.
> >=20
> > I don't really understand why you're so against setting the cpu
> > default parameters from the machine.  The machine already sets basic
> > configuration for all sorts of devices in the VM, that's kind of what
> > it's for.
>=20
> It's a general design philosophy that the CPU model (especially the host
> CPU model) does not depend on other command line parameters (except the
> accelerator, and I think in corner cases on the machine). Necessary for
> reliable host model probing by libvirt, for example.

Ok, I've proposed a revision which doesn't require altering the CPU
model elsewhere in this thread.

> We also don't have similar things for nested virt.

I'm not sure what you're getting at there.

> >> How do upper layers actually figure out if memory encryption etc is
> >> available? on s390x, it's simply via the expanded host CPU model.
> >=20
> > Haven't really tackled that yet.  But one way that works for multiple
> > systems has got to be better than a separate one for each, right?
>=20
> I think that's an important piece. Especially once multiple different
> approaches are theoretically available one wants to sense from upper laye=
rs.

Fair point.

So... IIRC there's a general way of looking at available properties
for any object, including the machine.  So we can probe for
availability of the "host-trust-limitation" property itself easily
enough.

I guess we do need a way of probing for what implementations of the
htl interface are available.  And, if we go down that path, if there
are any pre-generated htl objects available.

> At least on s390x, it really is like just another CPU-visible feature
> that tells the guest that it can switch to protected mode.

Right.. which is great for you, since you already have a nice
orthogonal interface for that.   On POWER, (a) CPU model isn't enough
since you need a running ultravisor as well and (b) CPU feature
detection is already a real mess for.. reasons.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl70OScACgkQbDjKyiDZ
s5LYYBAAoPb5bPM7XphcHM6aWbdZ30UgWmvTPoIWr/Jxhv4zJLdl7HMVztp19G7+
krDSxxn8Wb9mWIqbOgpxiqMyhdA5IsDvxiDANR05v+jvg9YSjX+6F17oHfRP2l1a
VTpG3lk0HYR242ofRR2y1Ad9lBP28abun5rXJcoc5LvjjNcqDq7ZV5meH6jm4E5z
HDRwxqsVGya9Yafm0aYSEnhW7r7PY3R5JWzovDI3jCxvXDFXGnbm2zPV2QWp/gur
K69zTJCCi0i6RTNx2aMtZnHQagD1kU58bKlI+IwrEEyXoIhnJQa9wzGEyCaLoUgd
Rdd7O9ND+6ENEvN5+m3RgUCtID1cNOIqgGBsiyjA9tzf2z2TJpZF4H1UamJsGNhA
NdV4i3xVRBSrX44vOQ67LkK8NRbn3FdM7VrqapL83MCbkl7SO/h9nOAesStmdxKn
+Uxf7xayib5pGdzBRBQCBChOYD6497SZV1YBwZvSWwjiBABL2gyFRMCiJwpVHsgO
Ev3ZRir01R5Jt39aOtKEu3Jt1Fv1LAhNE6r6MUob2r0gzwfoi78PrarvdI2JfAaB
P0AR8z+VzP1/zyurEGTMZdSKJ6IZedumSvSVR+QION5b2Au049J6Q5XGOTT47t69
vVHuZeYFZFNSbT24E2x08ATXkji8TEuLp9zI73x41DeZld1KavQ=
=Li+j
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--

