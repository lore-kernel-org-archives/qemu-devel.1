Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49579C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 23:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05ACB2077D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 23:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Hwfz1Xtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05ACB2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK9Sj-0005XO-4r
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 19:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jK9S6-0004zG-FQ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 19:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jK9S5-00050Z-0i
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 19:40:50 -0400
Received: from ozlabs.org ([203.11.71.1]:55799)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jK9S3-0004qH-Uc; Thu, 02 Apr 2020 19:40:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48tfhC4xbXz9sR4; Fri,  3 Apr 2020 10:40:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585870843;
 bh=1valn41FS9kXVhMw0dFmJ1rJTz0Gfp1crYjPjUGApVA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hwfz1XtjUHb6Xs7ZS4agba4VKn5y9336eV/p5iEDtsRu7aldno/XgxcK/e9T1QB6L
 Z/h9UE0vysBR7C9ZyChBmlx2aFRJfVNmg5m/BWQOvBBJoBxM8W4aOZ/0sHR421dBpB
 ub0AvJ1aqG9thEYZT9kmgCDoo+tsU1siKbnviUeo=
Date: Fri, 3 Apr 2020 10:40:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] ppc/spapr: Add hotremovable flag on DIMM LMBs on
 drmem_v2
Message-ID: <20200402234038.GU47772@umbus.fritz.box>
References: <20200402172339.622720-1-leonardo@linux.ibm.com>
 <20200402224925.GN47772@umbus.fritz.box>
 <6eaedb1c412f1e5194b5e9a6e6718af98da5abdd.camel@linux.ibm.com>
 <20200402231645.GT47772@umbus.fritz.box>
 <2cf25efdae30ea7a728c1a1e62e41c65f9073d5c.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nLMor0SRtNCuLS/8"
Content-Disposition: inline
In-Reply-To: <2cf25efdae30ea7a728c1a1e62e41c65f9073d5c.camel@linux.ibm.com>
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
Cc: Bharata B Rao <bharata.rao@in.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--nLMor0SRtNCuLS/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2020 at 08:19:34PM -0300, Leonardo Bras wrote:
> On Fri, 2020-04-03 at 10:16 +1100, David Gibson wrote:
> > On Thu, Apr 02, 2020 at 08:00:57PM -0300, Leonardo Bras wrote:
> > > Hello David,
> > >=20
> > > On Fri, 2020-04-03 at 09:49 +1100, David Gibson wrote:
> > > > The change looks reasonable.  Is there a PAPR RFC I can see describ=
ing
> > > > the new bit, though?
> > >=20
> > > The ACR is approved and I already added the change to LoPAPR/LOPAR,
> > > it's just a matter of time to get it released.
> > > (I think it's accessible to members of OpenPower Foundation)
> >=20
> > Hrm.  The latest LoPAPR I can find is from 2016, so a "matter of time"
> > isn't very encouraging.
>=20
> I understand the feeling.
> There is a new initiative inside the OpenPower Foundation to keep these
> documents updated.=20
>=20
> I think we will be able to have more frequent updates of the
> documentation soon.

Urgh.  Ok, I'm sorry Leonardo, but,

Nack.  I will not merge a change where my only knowledge of the spec
has to be based on hearsay.

By all means use this as ammunition to convince IBM and/or the
openpower foundation to expedite getting a workable document release
process up and running.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nLMor0SRtNCuLS/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6Gd/QACgkQbDjKyiDZ
s5LFaxAArkMO04eQh9QlOWPq+1NX3E2jtQEz7703YS01k4L84pgSSrfQ+vuxQ0G4
O7muvEM0TbG3FZUhOWtB15oq+qVuED63ttVtJbjO6lcpcMRjrDFnrA+TIW/hdDSh
xO+TgWWRxMBBzkBPyUXuEv5OhYKyLj5ErGBY99arfUeKMvdXua9/qxRSCJb3uPuC
nfXBJI/gmJ1C7M7hbEgNQ/k5FKtsKG3/zgdtcbdChCWyA+7BJUgk4aFh59P4/pGi
x2KkkvwJzfUOz3/zkQli4AMGucliX3ufEzgFJfI8t2vIMj9KYQbUBPYE0KKwR4YW
JErtJHFloBd0xwcC6LOwkqIl0MW6DDD/9hNSMBQjhmvAFeLh7gRKnoSmKxTU9CPh
qEjJdfk5SCb3B1grnjJVp4BWeTYa7CYSfnshv/HQlX+nBhF5mpNih2NXVGDWLVB/
GcfxZ2Ds7S1qO3RzwHJ5wucIb7FZsd8qaSSK49WL5VL7tYi1iWW2DwXwVU4tq/WU
v1IHVzk3EAWidobutkUpS/6aVAikZVhStySJ51JW4Vp2aorQrjDzqndUqEixbOfS
o4wX7SJ3HjdzMJie/YTITQMhDQCRXE0oScJOpRexzHFvGfnx3NL/LsZDbwmPcyIt
uExQ2ssjzGlTex5qEMDuGluk6GWP/JoMPbUIpqYVBA1BRznGKJ4=
=Ybvx
-----END PGP SIGNATURE-----

--nLMor0SRtNCuLS/8--

