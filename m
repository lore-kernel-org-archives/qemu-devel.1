Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C06C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 06:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710D12086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 06:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="X1XkKUDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710D12086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huWkv-0007eW-L8
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 02:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32947)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1huWk9-00078J-01
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 02:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1huWk7-0003mP-Mz
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 02:45:16 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36653 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1huWk6-0003iG-Lh; Mon, 05 Aug 2019 02:45:15 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4627Yc4tSWz9sN6; Mon,  5 Aug 2019 16:45:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564987508;
 bh=1/cCr+d0iBBs71q9wtkFrq6FJIgriIpoe91TGbpbEHc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X1XkKUDgcyVHAnZTDNlmvL5Q2Ry22B9KwBWm/6g4J9DHP81VcKZXxEs8DIJAbTQFR
 +1m8mAl/tqVof2AMnlWpTeBjsTRZ6bxnkaYZH0p0FcXQ2hqisWATmSacTkfJIRTwEa
 7OkaRjQfVNQ785El94lZN9ysmiXyx2i8dYO/OZho=
Date: Mon, 5 Aug 2019 16:40:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190805064040.GB29381@umbus.fritz.box>
References: <20190801075258.19070-1-tao3.xu@intel.com>
 <20190802065538.GA2031@umbus.fritz.box>
 <27846884-9bf4-7729-7a9e-0392280ee67f@intel.com>
 <20190805025844.GA29381@umbus.fritz.box>
 <6d051cbd-fa46-08ec-697e-56b42f1f5fa2@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <6d051cbd-fa46-08ec-697e-56b42f1f5fa2@intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [RFC PATCH] numa: add auto_enable_numa to fix
 broken check in spapr
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
Cc: imammedo@redhat.com, qemu-ppc@nongnu.org, ehabkost@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2019 at 11:37:14AM +0800, Tao Xu wrote:
> On 8/5/2019 10:58 AM, David Gibson wrote:
> > On Mon, Aug 05, 2019 at 08:56:40AM +0800, Tao Xu wrote:
> > > On 8/2/2019 2:55 PM, David Gibson wrote:
> > > > On Thu, Aug 01, 2019 at 03:52:58PM +0800, Tao Xu wrote:
> > > > > Introduce MachineClass::auto_enable_numa for one implicit NUMA no=
de,
> > > > > and enable it to fix broken check in spapr_validate_node_memory()=
, when
> > > > > spapr_populate_memory() creates a implicit node and info then use
> > > > > nb_numa_nodes which is 0.
> > > > >=20
> > > > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > > > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > > Signed-off-by: Tao Xu <tao3.xu@intel.com>
> > > >=20
> > > > The change here looks fine so,
> > > >=20
> > > > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > > >=20
> > > > However, I'm not following what check in spapr is broken and why.
> > > >=20
> > > Sorry, may be I should update the commit message.
> > >=20
> > > Because in spapr_populate_memory(), if numa node is 0
> > >=20
> > >      if (!nb_nodes) {
> > >          nb_nodes =3D 1;
> > >          ramnode.node_mem =3D machine->ram_size;
> > >          nodes =3D &ramnode;
> > >      }
> > >=20
> > > it use a local 'nb_nodes' as 1 and update global nodes info, but
> > > inpapr_validate_node_memory(), use the global nb_numa_nodes
> > >=20
> > >      for (i =3D 0; i < nb_numa_nodes; i++) {
> > >      	if (numa_info[i].node_mem % SPAPR_MEMORY_BLOCK_SIZE) {
> > >=20
> > > so the global is 0 and skip the node_mem check.
> >=20
> > Well, not really.  That loop is that each node has memory size a
> > multiple of 256MiB.  But we've already checked that the whole memory
> > size is a multiple of 256MiB, so in the case of one NUMA node, the
> > per-node check doesn't actually do anything extra.
> >=20
> > And in the "non-NUMA" case, nb_numa_nodes =3D=3D 0, then I don't believe
> > numa_info[] is populated anyway, so we couldn't do the check like
> > this.
> >=20
> Thank you David. I understand. I will modify the commit message. So can I
> modify and keep this patch as a feature? Because it can reuse the generic
> numa code.

Yes, the patch itself looks fine, just the comment is misleading.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1Hz2YACgkQbDjKyiDZ
s5JWExAA0b/rT/JDUCxc6NXdCuH4/F/efrocfjKqOekoJDTVNtAd1o8oMoRB8x5s
bKm3Du9PE5PO6hNFjPKCW/3rzPft3MSOq7xqxqbpOw1/0zXUGzHM9Lom9aUOSkog
0pQKEfGGfaNjdrxxdfXZSCQdvukPzKZbL5W4LP9+hG1OL6TQIuqGxpPUZgDLaAg6
AhqaYEdSOqKwzn5Nk1SEjQ+qBmIj7dlaKOP9hkicj3knhrbsjIx3a0u7i7i5D6aX
XHNo7gJGX5cPzPcYIJpvRw1h5dRqSvhud76MIt5KO/OwgMmBXEvoTpqRVh9Tutps
fUlIAGvKdJQauGxb5kAP8OiU3Iato/3gQyQfMlvXfO3TDn1Ha2m2SV4a6hJ9Gr3K
C0lfQmqq2898l5P94+aSJ0cLrf8G3pU1mEXtbnOaDZl3swNy5hBJBqcUBUMd6LGT
NVtmojDrqNi0tFeJUfseli9UFtsY5Ra7DkHnG6X6TXV6xMwUdR0cerpy0jr2h4Bo
GzSD2zWR6utlZZjuOEJPYmU3L0nJJpl7u8LdSK3ODB/ZOjVMgs1mhOodCMa4mYPg
E4jnB5/mwl02eOODch7OW/NGLiXc5b70PkeSEY9Qhj7dNjvwRBL+i6gi1nP2qfQz
aVrgxzL+x2I69+iU7JheHfo+ruBh5Ya8+Cn0QmPWpbFT2G5o/P4=
=wSUE
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--

