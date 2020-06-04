Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71161C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE5B207DA
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pi+L8mEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE5B207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjdX-00021t-Fl
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjc3-0008Af-Fk; Thu, 04 Jun 2020 02:44:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjc2-000127-Gb; Thu, 04 Jun 2020 02:44:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cx8R3zJ9z9sV7; Thu,  4 Jun 2020 16:44:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591253063;
 bh=Mc7WOmLvkTipmSQpkZ8c85cerVEcMMCMxKm/JInS22I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pi+L8mEw94m1b47hZrrzhV01IO+Y9HKptc7fdjSGP32vaR08vYjAM784unywZb5Yh
 897QuM226e7RaBg60WRl6vVguBmR246YCnS1sp8wRyJaEWQvhrHna3FHS5Lo0eg423
 gayPUgNuJKVb8jAp6RBUplrx2tGVbHxJN6xeVu7g=
Date: Thu, 4 Jun 2020 16:44:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC v2 00/18] Refactor configuration of guest memory protection
Message-ID: <20200604064414.GI228651@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <87tuzr5ts5.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4BlIp4fARb6QCoOq"
Content-Disposition: inline
In-Reply-To: <87tuzr5ts5.fsf@morokweng.localdomain>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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


--4BlIp4fARb6QCoOq
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
>=20
> Regardless, I was able to successfuly launch POWER PEF guests using
> these patches:
>=20
> Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>=20
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

That's not a bad one, but for now I'm going with "host trust
limitation", since this might end up covering things other than just
memory protection.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4BlIp4fARb6QCoOq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7YmDwACgkQbDjKyiDZ
s5I9XA/8Ch2ePqa6dC1C0UY+N36zI1Evzcryyl53MbEkYBAzCnNQWtbCUYy88uWI
HWyaw6W/HcTcuHSh5bBPC+H7sKkHpUFguUCdp5uIzGdWr4Bm3uTp+lWvgxJQmnmh
SopkxbIyASuNWLonBK6CaS/2p+60vwcIkWcrHccF1r6N11aPpUCuKQbkwOImnD1W
JTgUWN0LPSI6qdBLA0wAL/3vtUVGSqDT8O2VxldJBQbeDOu0w8Vog4euO3RhEZEV
85Of/utWgwKJScfNaXvOmiZ9cBMFs3Nu6pwQdVfOsFnOkGznaTDZIGd37/4CPFf8
lKYdpaX0qaP4w2qThZLqi8asayZDmYfkarxaDlYBlGBsd9m0iwMXalvBzteoiNrz
9FbObSoCIWbnhAoKsUuEbD/D+sGBMl1yIb5jwgiSTTYMaTM/9/Lwh2WKsG3LpS6I
plxNdA5vzSOboff9IftBlcDfxjBZB+4/x6ULDfWBHyViCY9BLlvoBD8vKSDGok+d
gVjXHR0Du3FcwZA3VVZuggO28zObVGx5d6i47zqwL0eo51XXrL3bCg/TytTrg4v0
Uc0j6PeUlyeo6epdzjrXlwluaHJjm/39sKNb/YJlFEg8XywHTRd1/Va5c67SikLS
USYa4hQqkTinT3yUsojh3p/5Nu+JqocYmpeqKyH6KJHVA1208Rg=
=HHjA
-----END PGP SIGNATURE-----

--4BlIp4fARb6QCoOq--

