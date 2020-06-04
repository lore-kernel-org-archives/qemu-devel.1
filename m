Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136D8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C32206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="j5FCpNMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C32206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjHC-0002HP-41
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjFx-0001Ny-Os; Thu, 04 Jun 2020 02:21:37 -0400
Received: from ozlabs.org ([203.11.71.1]:54821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjFw-0004jn-9s; Thu, 04 Jun 2020 02:21:37 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cwf4269Bz9sSf; Thu,  4 Jun 2020 16:21:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591251692;
 bh=WSRKKxwETOCL+crXoR6uGU8KuKdkAgnCfOE8wqV8RE0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j5FCpNMk28ZK2Qz5mLZ4CworPhHz0W2adiMFNuKj/AsinD3MMISMJJjGtkhGc3xo2
 mcYWyekrjk+aFxXcJxycUpaDgsN2u6/zcqQ4Hyj5Xa4mSCnOMsKp/2SS30DCWYe+zf
 HRYK1aL4oJn0SE+9zUu6zsbh8dzp8j4TWeVUcv+0=
Date: Thu, 4 Jun 2020 16:21:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC v2 00/18] Refactor configuration of guest memory protection
Message-ID: <20200604062124.GG228651@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <87tuzr5ts5.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Content-Disposition: inline
In-Reply-To: <87tuzr5ts5.fsf@morokweng.localdomain>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 02:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2020 at 01:39:22AM -0300, Thiago Jung Bauermann wrote:
>=20
> Hello David,
>=20
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > A number of hardware platforms are implementing mechanisms whereby the
> > hypervisor does not have unfettered access to guest memory, in order
> > to mitigate the security impact of a compromised hypervisor.
> >
> > AMD's SEV implements this with in-cpu memory encryption, and Intel has
> > its own memory encryption mechanism.  POWER has an upcoming mechanism
> > to accomplish this in a different way, using a new memory protection
> > level plus a small trusted ultravisor.  s390 also has a protected
> > execution environment.
> >
> > The current code (committed or draft) for these features has each
> > platform's version configured entirely differently.  That doesn't seem
> > ideal for users, or particularly for management layers.
> >
> > AMD SEV introduces a notionally generic machine option
> > "machine-encryption", but it doesn't actually cover any cases other
> > than SEV.
> >
> > This series is a proposal to at least partially unify configuration
> > for these mechanisms, by renaming and generalizing AMD's
> > "memory-encryption" property.  It is replaced by a
> > "guest-memory-protection" property pointing to a platform specific
> > object which configures and manages the specific details.
> >
> > For now this series covers just AMD SEV and POWER PEF.  I'm hoping it
>=20
> Thank you very much for this series! Using a machine property is a nice
> way of configuring this.
>=20
> >From an end-user perspective, `-M pseries,guest-memory-protection` in
> the command line already expresses everything that QEMU needs to know,
> so having to add `-object pef-guest,id=3Dpef0` seems a bit redundant. Is
> it possible to make QEMU create the pef-guest object behind the scenes
> when the guest-memory-protection property is specified?

Not exactly - the object needs to exist for the QOM core to resolve it
before we'd have a chance to look at the value to conditionally create
the object.

What we could do, however, is always create a PEF object in the
machine, and it would just have no effect if the machine parameter
wasn't specified.

I did consider that option, but left it this way for greater
consistency with AMD SEV - there the object can't be auto-created,
since it has mandatory parameters needed to configure the encryption.

I'm open to persuasion about changing that, though.

> Regardless, I was able to successfuly launch POWER PEF guests using
> these patches:
>=20
> Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Ah, great.

> > can be extended to cover the Intel and s390 mechanisms as well,
> > though.
> >
> > Note: I'm using the term "guest memory protection" throughout to refer
> > to mechanisms like this.  I don't particular like the term, it's both
> > long and not really precise.  If someone can think of a succinct way
> > of saying "a means of protecting guest memory from a possibly
> > compromised hypervisor", I'd be grateful for the suggestion.
>=20
> Is "opaque guest memory" any better? It's slightly shorter, and slightly
> more precise about what the main characteristic this guest property conve=
ys.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7YkuIACgkQbDjKyiDZ
s5J0eQ/+L0GJOeaVIQ6a2gJ+4H9gL8D/Dt7PydH5X7r9Aii9IjO+bGGEq1ZiabbV
q9p1WdYe4DrYSMr6rx/CFoBPsJ/HuoYtlO52k/Pz0kH7YpzlerTCKeZgeD6nIan6
lKaG6nXQVBz7HSMAo5QSd/PIa/oxGyf0P76efyhuAI+vwVsEQ3krLs9uEeGcCB6s
mKDFy55vkiyAXMyjvJlnAAiusrZEpWjr1Qt6S1HFtBu/DKJ9QqlJCY0tKiOWOOmv
4CEO8fYjFoPu9q/BjaPnO+HQnLpc4zwcaIf61osVxV1ix8gOGlf/P4ZeC54K5wDO
XM4IH2zQRfIhTqsQ7sh8I1kgczyULKH/f8w2O9j+uGMfgn3tIla63e/Bq42IygWh
6JXf1ypUe2RYO897eVJrgT9UVg3zQqAKgKv77LMX+tpUkUxke77pfT7xPPVcSIGz
JLqdre0rUwWI06ykdPnoe98GiyF1Zz4TtjwvEylERegBAZaF192MZWiBIqyq3Ncb
wUSekLQQobsLikgHPezYmEhGXfYQp/+4XP9Bt/uCyoViMw+BqkdEuddg81N2P4tY
kjz2zPvoC1HW3/EHwOfsIgsP30lvprLEhFvWwJSvnP5FX6qtevvSIwpKEYIZRLF/
99BC5nX/76JZW2z/jVkfWzRfKEnQFs9MTZPzW4cfdvUrbIdiWaM=
=s9HP
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--

