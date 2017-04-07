Received: from eggs.gnu.org ([2001:4830:134:3::10]:45869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwUIK-0008Uz-7j
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwUIG-0004wQ-6n
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:51:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cwUIF-0004w9-UX
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:51:16 -0400
References: <1491548326-60072-1-git-send-email-weiqi4@huawei.com>
	<20170407083849.GA26482@redhat>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf5ca19e-7de9-c13f-fa7f-b2f3e0d24fbc@redhat.com>
Date: Fri, 7 Apr 2017 08:51:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170407083849.GA26482@redhat>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0xCOls11OCKFCsDo9Hdw0NaTKMWFBpgGP"
Subject: Re: [Qemu-devel] [PATCH 1/3] vhost: simple clean up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sahid Orentino Ferdjaoui <sferdjao@redhat.com>, weiqi <weiqi4@huawei.com>
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, mst@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0xCOls11OCKFCsDo9Hdw0NaTKMWFBpgGP
From: Eric Blake <eblake@redhat.com>
To: Sahid Orentino Ferdjaoui <sferdjao@redhat.com>, weiqi <weiqi4@huawei.com>
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, mst@redhat.com
Message-ID: <cf5ca19e-7de9-c13f-fa7f-b2f3e0d24fbc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] vhost: simple clean up
References: <1491548326-60072-1-git-send-email-weiqi4@huawei.com>
 <20170407083849.GA26482@redhat>
In-Reply-To: <20170407083849.GA26482@redhat>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/07/2017 03:38 AM, Sahid Orentino Ferdjaoui wrote:
> On Fri, Apr 07, 2017 at 02:58:46PM +0800, weiqi wrote:
>> From: Wei Qi <weiqi4@huawei.com>
>>
>> It is unnecessary to assign 'hdev->nvqs' to 'i', because 'hdev->nvqs' =
unused after assignment, so remove it.
>=20
> nit: The line should not be longer than 76 characters [0].
>=20
> [0] http://wiki.qemu-project.org/Contribute/SubmitAPatch#Write_a_meanin=
gful_commit_message

Also, make sure you have proper threading.  Although you sent a 0/3
cover letter (with Message-ID:
<1491548305-75464-1-git-send-email-weiqi4@huawei.com>), this 1/3 message
is lacking both References: and In-Reply-To: headers, and therefore
appears as its own top level thread.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0xCOls11OCKFCsDo9Hdw0NaTKMWFBpgGP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY55lOAAoJEKeha0olJ0NquS4H/REsfvejoD75TR9MvTIY4tLP
kT73mXNcD8myTfoCm3jyg1JLX3Gq5fNZgAEtAqUo/0goOCO6sdQ+wdiJZzYulkwt
/cEomDdf3c8nfXcfoRrdY32TuEfghvWgnaeOBrHgvRzxcyJB4NTaXE/Ic+zjv4z5
iY2vgoo7HLRm5A6IfmzhBUzBJggRNfRjTRhOEg0T9PMsdza9Jf95uW52UlAdqWEA
fAFxsYnTki7b30ajWDfgVZD6UYzFFOupRCpEMiip09/f6n4/SD59ixhK2zVW/MC0
6U4sd2i3JRn4oKtrTrIinrJ1jb0kiWRkwchsGD3zRH3eZ6vAxA6JEsAqA1Dcb2M=
=z8f0
-----END PGP SIGNATURE-----

--0xCOls11OCKFCsDo9Hdw0NaTKMWFBpgGP--
