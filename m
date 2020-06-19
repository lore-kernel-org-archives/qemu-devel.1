Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB0FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 09:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E0F2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 09:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="O9HRmw3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E0F2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmDer-0007bE-90
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 05:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jmDdT-0006zO-Pf; Fri, 19 Jun 2020 05:48:37 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jmDdQ-0008Pf-6j; Fri, 19 Jun 2020 05:48:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49pDWs72NPz9sRk; Fri, 19 Jun 2020 19:48:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592560106;
 bh=Ekm/xYDi3V6GtOmUswKGgxWYoM6fBANkvmJr7A0hObI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O9HRmw3cKjOq15hvRvKYJRavCBvwcvLMGe7Uyv2IgH5qNZHCw9N+8p5yJY4cHcuAW
 zPE9KcXx/Pbw8zLesy3xzJP1ssodf8eXXCdh8jhBdk8Wd7vLsEI/pZlQ0kwpkNyxba
 otojDE2vF2fdvGnhLMLKYnLT/Hn8EJ77zV9bWU5I=
Date: Fri, 19 Jun 2020 19:48:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/9] Generalize memory encryption models
Message-ID: <20200619094820.GJ17085@umbus.fritz.box>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <e045e202-cd56-4ddc-8c1d-a2fe5a799d32@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1ou9v+QBCNysIXaH"
Content-Disposition: inline
In-Reply-To: <e045e202-cd56-4ddc-8c1d-a2fe5a799d32@redhat.com>
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


--1ou9v+QBCNysIXaH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2020 at 10:28:22AM +0200, David Hildenbrand wrote:
> On 19.06.20 04:05, David Gibson wrote:
> > A number of hardware platforms are implementing mechanisms whereby the
> > hypervisor does not have unfettered access to guest memory, in order
> > to mitigate the security impact of a compromised hypervisor.
> >=20
> > AMD's SEV implements this with in-cpu memory encryption, and Intel has
> > its own memory encryption mechanism.  POWER has an upcoming mechanism
> > to accomplish this in a different way, using a new memory protection
> > level plus a small trusted ultravisor.  s390 also has a protected
> > execution environment.
>=20
> Each architecture finds its own way to vandalize the original
> architecture, some in more extreme/obscure ways than others. I guess in
> the long term we'll regret most of that, but what do I know :)

Well, sure, but that's no *more* true if we start from a common point.

> > The current code (committed or draft) for these features has each
> > platform's version configured entirely differently.  That doesn't seem
> > ideal for users, or particularly for management layers.
> >=20
> > AMD SEV introduces a notionally generic machine option
> > "machine-encryption", but it doesn't actually cover any cases other
> > than SEV.
> >=20
> > This series is a proposal to at least partially unify configuration
> > for these mechanisms, by renaming and generalizing AMD's
> > "memory-encryption" property.  It is replaced by a
> > "host-trust-limitation" property pointing to a platform specific
> > object which configures and manages the specific details.
>=20
> I consider the property name sub-optimal. Yes, I am aware that there are
> other approaches being discussed on the KVM list to disallow access to
> guest memory without memory encryption. (most of them sound like people
> are trying to convert KVM into XEN, but again, what do I know ... :)  )

I don't love the name, it's just the best I've thought of so far.

> "host-trust-limitation"  sounds like "I am the hypervisor, I configure
> limited trust into myself".

Which is kind of... accurate...

> Also, "untrusted-host" would be a little bit
> nicer (I think trust is a black/white thing).

> However, once we have multiple options to protect a guest (memory
> encryption, unmapping guest pages ,...) the name will no longer really
> suffice to configure QEMU, no?

That's why it takes a parameter.  It points to an object which can
itself have more properties to configure the details.  SEV already
needs that set up, though for both PEF and s390 PV we could pre-create
a standard htl object.

> > For now this series covers just AMD SEV and POWER PEF.  I'm hoping it
> > can be extended to cover the Intel and s390 mechanisms as well,
> > though.
>=20
> The only approach on s390x to not glue command line properties to the
> cpu model would be to remove the CPU model feature and replace it by the
> command line parameter. But that would, of course, be an incompatible bre=
ak.

I don't really understand why you're so against setting the cpu
default parameters from the machine.  The machine already sets basic
configuration for all sorts of devices in the VM, that's kind of what
it's for.

> How do upper layers actually figure out if memory encryption etc is
> available? on s390x, it's simply via the expanded host CPU model.

Haven't really tackled that yet.  But one way that works for multiple
systems has got to be better than a separate one for each, right?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1ou9v+QBCNysIXaH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7sieIACgkQbDjKyiDZ
s5J4mg//RS/XDakf/bfPZ+YL8in0nn6NYU2bvKSK0Ml3JM/IZY9+JB3Al005LIzW
C9+qd3GWezWKSnlUWXQv8qaI09kHvND7kPD/9/4/S+UIbKlBqn9SPY8Z1J9Cl/ny
awwOexHkg2zC5wlWPj4oQlMrR40bX6uI9AkfY9pTiVy4p97NHwNnf/uHJYEB47wX
zxPBLV13iqSdX8lIS8rs34df9dTw9H30ZlX+00Uk3SO75YJzpwUhzTVJCTjJyk2j
EmGz9SGyjzyd9eNM8CTXtnlpq5dJecAhywwcbQtedXTGqBW9nl/kXUhC7gaFkroD
KveW3sxDr8ZzKgKPCnEfBAntAH7Iz/4dBjXeQnvrCX5Km2OEkn7SNTPBBje0qMFR
JVvF924MkVM4d931lEcDdpeyBWaRBLTXJP+w1NW8wpv1M6r+Ampiaaj53liUcKQ/
b0Ro6/qDtkek8ivux4kh0DGPs4B6vQLCpZJI6NrEWBkACMZ036c0RofmpzeF57Yl
b0fegay1DBuN1XCY7OvlKYsxJjlNLo2K9tEFgZyS5kKavZwmb3FYSDwkk5Ry+QV/
Zagrj0qRvjoCPorzw2R3yUHj9jKzsUlTaWrZjXXuNVwigCHEGsUJMjE0gQOa1hUC
mQP0b4CS/JeA6wT2a/pI9wYKiTwVAhZbBVSzBHvv8MVCJKCfc5E=
=Lcwj
-----END PGP SIGNATURE-----

--1ou9v+QBCNysIXaH--

