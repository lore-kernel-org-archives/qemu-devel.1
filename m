Received: from eggs.gnu.org ([209.51.188.92]:45576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3RPs-0003Iq-Vo
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3RG5-0006Vb-Ad
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:10:50 -0400
References: <20190311165017.32247-1-kwolf@redhat.com>
	<20190311165017.32247-11-kwolf@redhat.com>
	<2f72f4e8-879a-62a5-d131-8c6562bd4043@redhat.com>
	<20190311195925.GA21327@angien.pipo.sk>
From: Eric Blake <eblake@redhat.com>
Message-ID: <74cc34ed-a60b-75fd-3cf1-122ba485917e@redhat.com>
Date: Mon, 11 Mar 2019 15:10:36 -0500
MIME-Version: 1.0
In-Reply-To: <20190311195925.GA21327@angien.pipo.sk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HS3laJ3mheCE4nyOFQObwxRNqzfpfbYXz"
Subject: Re: [Qemu-devel] [PATCH v2 10/10] file-posix: Make auto-read-only
 dynamic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com, berto@igalia.com, qemu-devel@nongnu.org, "stefanha@redhat.com" <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HS3laJ3mheCE4nyOFQObwxRNqzfpfbYXz
From: Eric Blake <eblake@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com,
 berto@igalia.com, qemu-devel@nongnu.org,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <74cc34ed-a60b-75fd-3cf1-122ba485917e@redhat.com>
Subject: Re: [PATCH v2 10/10] file-posix: Make auto-read-only dynamic
References: <20190311165017.32247-1-kwolf@redhat.com>
 <20190311165017.32247-11-kwolf@redhat.com>
 <2f72f4e8-879a-62a5-d131-8c6562bd4043@redhat.com>
 <20190311195925.GA21327@angien.pipo.sk>
In-Reply-To: <20190311195925.GA21327@angien.pipo.sk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 3/11/19 2:59 PM, Peter Krempa wrote:

>> auto-read-only was introduced in 3.1, at which point we intentionally
>> had sufficiently loose wording to permit (but not require) dynamic sta=
te
>> checking; so you are not breaking the interface.  On the other hand, i=
s
>> libvirt going to have problems introspecting whether it can use
>> auto-read-only and get the dynamic behavior it needs?  Or is there
>> enough else in the way of libvirt's switch to -blockdev that it won't
>> attempt anything that needs auto-read-only without other 4.0 interface=
s
>> anyway, at which point detecting the presence of the field (but not
>> whether the field has a guarantee of dynamic behavior) on 3.1 doesn't
>> matter?
>=20
> I think we can use Stefan's capability detection mechanism he introduce=
d
> for the migration with cache enabled for local files to add a flag for
> this as well.

Except I thought we decided that the most recent version of his QMP
changes was now fully-introspectible, thanks to using conditional
compilation.

https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02510.html

Well, that may prove to be a short-lived hiatus, if libvirt would
happily attempt to use qemu 3.1 and fail without some other
introspectible hook to know whether auto-read-only has required semantics=
=2E

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--HS3laJ3mheCE4nyOFQObwxRNqzfpfbYXz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyGwLwACgkQp6FrSiUn
Q2oAyQgAoRF6PpnHx8Bo6NwrtDbeC724VlXsDN/wLSr2KtUjFaO5+AWSAB0RGSle
GHI/kYSbBwijhk2rlWIe0lF0K1sI/P/h1SOVgAsOHL+FvPLuzu8nSP6dYjQL+ndy
OQh/4tTkKtI+OOPmu/yWG5533kk2AMAh7LW0MggZxWlUBh/HvIMuPxJB8mb+jNpd
o0rkm9Wjyj8+j60gRwiWTvoJJyVzkT9ApjvW9pfF4QOMQosdJxF3Kcu2/Zg08Sgw
cL1odpvGAmo4jOltpaO4dU99KgID1tATOyavUf0KZHbFAqeI8YrNJBUax8KsnePl
tEokHT5IKnfiw93GJ/hYbp3j4COXtQ==
=+rT+
-----END PGP SIGNATURE-----

--HS3laJ3mheCE4nyOFQObwxRNqzfpfbYXz--
