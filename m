Received: from eggs.gnu.org ([2001:4830:134:3::10]:36673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr7Fr-00077h-18
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr7Fm-0007Tp-Sx
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:14:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cr7Fm-0007Tk-KH
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:14:30 -0400
References: <1490271635-19049-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1490271635-19049-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<29981b93-8870-eab7-bbc7-263448efb2ab@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0425b801-36e4-e655-5a19-47d19d729509@redhat.com>
Date: Thu, 23 Mar 2017 13:14:27 -0500
MIME-Version: 1.0
In-Reply-To: <29981b93-8870-eab7-bbc7-263448efb2ab@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KkbatCwWXjcbAP3fxJfQG39G8j1mIcXnP"
Subject: Re: [Qemu-devel] [PATCH 2/2 v1] throttle: factor out the redundant
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Jani Kokkonen <jani.kokkonen@huawei.com>, Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KkbatCwWXjcbAP3fxJfQG39G8j1mIcXnP
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Jani Kokkonen <jani.kokkonen@huawei.com>,
 Alberto Garcia <berto@igalia.com>,
 Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org
Message-ID: <0425b801-36e4-e655-5a19-47d19d729509@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2 v1] throttle: factor out the redundant
 code
References: <1490271635-19049-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1490271635-19049-2-git-send-email-pradeep.jagadeesh@huawei.com>
 <29981b93-8870-eab7-bbc7-263448efb2ab@redhat.com>
In-Reply-To: <29981b93-8870-eab7-bbc7-263448efb2ab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 09:46 AM, Eric Blake wrote:
> On 03/23/2017 07:20 AM, Pradeep Jagadeesh wrote:
>> This patchset removes the throttle redundant code that was present
>> in block and fsdev files.
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>> ---
>=20
> I think you want portions of this patch to come first; you want to
> refactor out the IOThrottle portion of existing types, and then extend
> IOThrottle to be used in more places.

For the record, here's a nice example of how to factor out common fields
into a new base class:

https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04649.html

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--KkbatCwWXjcbAP3fxJfQG39G8j1mIcXnP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1BCDAAoJEKeha0olJ0NqtsgH/j1RSJOiGe9cPdkESNh3swtj
W9T+EYrsPQ134TDjNRBsiawo4+E63AVPniFxDSAzxfP5k71BtwCMu3jE7V0CoJ1L
1FPNzgiu8Xb+yVF1zTKtypyXXQWVFzgRSbRClip5ip0xsYvx4NvCstJAYJ3e0K8Q
tVhRL0iLjwI+F0wzfZ88nENrX0HsTgrEBIhArIVq6+8I4qx3o9lMLvLzySuSybxP
rVddoR/ie3/cDVORoTf5AURCNOoEP1oprtGLLeVrdfuRTubPMsmoa9j+SLY+Im+J
I8mTSy/gDv+tIk6zRK7UrwELIW/eKuZHjxt+rl2wOJ6W5MzagVujhUzV9NCzDZg=
=DfiC
-----END PGP SIGNATURE-----

--KkbatCwWXjcbAP3fxJfQG39G8j1mIcXnP--
