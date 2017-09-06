Received: from eggs.gnu.org ([2001:4830:134:3::10]:43104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpctL-0002h2-2A
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpctG-0007fi-4N
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:09:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpctF-0007dL-Rn
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:09:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1F0781DFE
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 16:09:20 +0000 (UTC)
References: <20170906115143.27451-1-quintela@redhat.com>
	<20170906115143.27451-2-quintela@redhat.com>
	<7e71d190-8e49-ca6b-ef44-522100b27b8c@redhat.com>
	<87pob351o5.fsf@secure.mitica>
From: Eric Blake <eblake@redhat.com>
Message-ID: <38c3884d-8e05-596a-acb8-80ae0530910d@redhat.com>
Date: Wed, 6 Sep 2017 11:09:12 -0500
MIME-Version: 1.0
In-Reply-To: <87pob351o5.fsf@secure.mitica>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qFbGVQfn5mKejC88lJ4tPGr7xNEeeRLo5"
Subject: Re: [Qemu-devel] [PATCH v7 01/22] Revert "io: add new
 qio_channel_{readv, writev, read, write}_all functions"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qFbGVQfn5mKejC88lJ4tPGr7xNEeeRLo5
From: Eric Blake <eblake@redhat.com>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com,
 peterx@redhat.com
Message-ID: <38c3884d-8e05-596a-acb8-80ae0530910d@redhat.com>
Subject: Re: [PATCH v7 01/22] Revert "io: add new qio_channel_{readv, writev,
 read, write}_all functions"
References: <20170906115143.27451-1-quintela@redhat.com>
 <20170906115143.27451-2-quintela@redhat.com>
 <7e71d190-8e49-ca6b-ef44-522100b27b8c@redhat.com>
 <87pob351o5.fsf@secure.mitica>
In-Reply-To: <87pob351o5.fsf@secure.mitica>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/06/2017 09:42 AM, Juan Quintela wrote:
> Eric Blake <eblake@redhat.com> wrote:
>> On 09/06/2017 06:51 AM, Juan Quintela wrote:
>>> This reverts commit d4622e55883211072621958d39ddaa73483d201e.
>>
>> But with no reason why?  What bugs are you fixing by reverting this?
>=20
> I put it on the cover letter.  I am investigating *why* it fails on me.=

> It got the thread handed.

Then I think I ran into the same problems as you (NBD was hanging for me
due to the nested event loop being called from a coroutine context),...

>=20
> My plan is to fix whatever is there and see why it is failing.
>=20
>> Also, have you seen my patches, that also fix bugs in the _all functio=
ns?
>> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01053.html
>=20
> No, I have to take a look, thanks.

=2E..and hopefully my patch helps the hang you were seeing (now in a pull=

request:
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01338.html).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qFbGVQfn5mKejC88lJ4tPGr7xNEeeRLo5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwHagACgkQp6FrSiUn
Q2q04wf+IvIXbbhGw7S/n7B9fLimrebmIXnMz29eRNwRaikezhQs2CDs19RqBxW+
cO7tJIFy1911A4K7cXtXjzrdFCnRuzOKjlvB2gjLVeOfvCUytji2OtfbJr8CoNDz
rkBbXrSXALE9kYKBixA/GqxOM36ywbb6WFhZC3LcsKXBSbr/9g2urVdInOzODlcl
GF79SyC35vS1xfrp90Ir4xzATD8Re71EyWeb4ZiHHWCswPxuZpZwDMAGrV64Dyfh
NrXTE5fUt+y92N1PTHko3c2fTpKohtGAAFQ+9Cm8V/r366qPHiy1g+EdV6uv4pRq
JQYPnYyialnKoDTamRA5yKqiLlIxXQ==
=brzh
-----END PGP SIGNATURE-----

--qFbGVQfn5mKejC88lJ4tPGr7xNEeeRLo5--
