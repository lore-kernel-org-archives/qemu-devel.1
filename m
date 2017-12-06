Received: from eggs.gnu.org ([2001:4830:134:3::10]:55061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMctU-0001Qj-Mj
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMctQ-0000yq-Ks
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:50:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eMctQ-0000xz-CG
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:49:56 -0500
References: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<20171206170705.37cda561@bahia.lan>
	<9a0067d4-100b-b3eb-d38e-a99ab885e215@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <84bafe13-7e56-4aa5-cf48-edadd9c2d579@redhat.com>
Date: Wed, 6 Dec 2017 10:49:47 -0600
MIME-Version: 1.0
In-Reply-To: <9a0067d4-100b-b3eb-d38e-a99ab885e215@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JrdqrJdNQTihS4PlMSFAFIw2n4OH4F8d2"
Subject: Re: [Qemu-devel] [PATCH v13 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Greg Kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JrdqrJdNQTihS4PlMSFAFIw2n4OH4F8d2
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Greg Kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Manos Pitsidianakis <el13635@mail.ntua.gr>,
 jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org
Message-ID: <84bafe13-7e56-4aa5-cf48-edadd9c2d579@redhat.com>
Subject: Re: [PATCH v13 0/6] fsdev: qmp interface for io throttling
References: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <20171206170705.37cda561@bahia.lan>
 <9a0067d4-100b-b3eb-d38e-a99ab885e215@huawei.com>
In-Reply-To: <9a0067d4-100b-b3eb-d38e-a99ab885e215@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 10:15 AM, Pradeep Jagadeesh wrote:

>> I didn't have time to follow the thread, but it's been a month without=

>> activity... where do we stand now ? I've merged I/O throttle for fsdev=

>> in 2.9, is there a chance we get the QMP/HMP part in 2.12 ?
>=20
> Hi Greg,
>=20
> Yes, I am waiting for Eric's reply. Because there were some issues when=

> I merged code with Manos's throttlelimits code. So, I am waiting to see=

> how to go about it. It needs some changes to reuse in fsdev/blk qmp
> code. I am very much would like to push qmp code upstream.

We missed the window of opportunity to unify any differences in
interfaces between what Manos added in 2.11 and your code, now that 2.11
is at -rc4.  That means we are stuck with two slightly different
interface; although it would still be nice to have glue code that can
convert into and out of a preferred form, so that the bulk of the code
can be common operations on the preferred struct.

At this point, I don't know what additional information you want from
myself or Markus on the interface front; it may be easier to post a
rebased v14 and tackle it from there (even if it means our interface is
still in a state of churn).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JrdqrJdNQTihS4PlMSFAFIw2n4OH4F8d2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlooH6sACgkQp6FrSiUn
Q2p9ngf/RDvx2I/xKqJr/9Suj0GkYsyxDeOkjo+ExOSbXQYN/PHfVM2BqLMgp0I6
ufmiSG43c8L2+6BrDEcaLSrLto/PDqEGj5IQXhYbUTF0Sqj1KltI2S/FTvgkHnVO
F4kQqZ9J5DEGBuumRfSQTGf1mR64lxVXgTyVM37bbTYiFlNenfao/+uLD9TCh8+T
eNE5KTEsbA4PBhJvmv9x/HgpxtAVL/zqLuwQCllCBeozbFqOYqnzpWeU3xwnSwx4
Xv+ohCQQPbObhsT45JpJpOE8fh5bmDjEmCYe9e3V4igkZHN3EOFjemXawaqbtoqa
K2YIKi7Hhot+XKKinuItfJI73L+/BA==
=bGz9
-----END PGP SIGNATURE-----

--JrdqrJdNQTihS4PlMSFAFIw2n4OH4F8d2--
