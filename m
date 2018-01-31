Received: from eggs.gnu.org ([2001:4830:134:3::10]:34543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egxLj-0002rP-Nc
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egxLi-00014d-Ks
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:43:11 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-9-git-send-email-anton.nefedov@virtuozzo.com>
	<7b84e8fe-2141-5609-3f86-1890fc314b6d@redhat.com>
	<2e58f0a9-7db4-b562-e1d0-b8c712a67b21@virtuozzo.com>
	<4b7846c3-bec4-b1a0-50e3-58aa337028ac@redhat.com>
	<cfcdb124-b343-ae2f-726d-5b084c9b86bb@redhat.com>
	<7b4ac9d9-1e51-43d4-0d55-488ac5593263@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f5c69848-9c63-b9cb-4f5e-0424d2bd5861@redhat.com>
Date: Wed, 31 Jan 2018 12:43:01 -0600
MIME-Version: 1.0
In-Reply-To: <7b4ac9d9-1e51-43d4-0d55-488ac5593263@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Y21qrN9o550vQG1BFpNXyEKwZr5uh4534"
Subject: Re: [Qemu-devel] [PATCH v7 8/9] qcow2: skip writing zero buffers to
 empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y21qrN9o550vQG1BFpNXyEKwZr5uh4534
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Anton Nefedov
 <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 berto@igalia.com
Message-ID: <f5c69848-9c63-b9cb-4f5e-0424d2bd5861@redhat.com>
Subject: Re: [PATCH v7 8/9] qcow2: skip writing zero buffers to empty COW
 areas
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-9-git-send-email-anton.nefedov@virtuozzo.com>
 <7b84e8fe-2141-5609-3f86-1890fc314b6d@redhat.com>
 <2e58f0a9-7db4-b562-e1d0-b8c712a67b21@virtuozzo.com>
 <4b7846c3-bec4-b1a0-50e3-58aa337028ac@redhat.com>
 <cfcdb124-b343-ae2f-726d-5b084c9b86bb@redhat.com>
 <7b4ac9d9-1e51-43d4-0d55-488ac5593263@redhat.com>
In-Reply-To: <7b4ac9d9-1e51-43d4-0d55-488ac5593263@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2018 12:35 PM, Max Reitz wrote:

>>> Not sure how useful 2 is, though.  (I don't know.  I always hear abou=
t
>>> people wanting to optimize for such a case where a backing file is
>>> shorter than the overlay, but I can't imagine a real use case for tha=
t.)
>>
>> I can; here's what's happened to me personally.  I created an image, a=
nd
>> took internal snapshots (yeah, I know those aren't in fashion these
>> days, but this was long ago).  Later, I ran out of space.  I wanted to=

>> resize the image, but am not convinced whether resizing the image will=

>> play nicely with the internal snapshots (in fact, I don't recall
>> off-hand whether this was something we prevented in the past and now
>> support, or if it is still unsupported now...) - so the easiest way is=

>> to create a larger overlay image.
>=20
> But you were convinced that creating an overlay would play nicely with
> the internal snapshots? ;-)

Yes. As long as I don't mind pointing back to the original file (rather
than the overlay) at the point I attempt to revert to the internal
snapshot, then loading the snapshot doesn't have to worry about a size
change.

>=20
> I'm not sure whether that sounds like a use case I'd want to optimize
> for, but, well.

I guess it boils down to whether the optimization is a low-maintenance
freebie.  There's no reason to reject the optimization if a patch
demonstrates it is easy to support and it has iotests coverage.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Y21qrN9o550vQG1BFpNXyEKwZr5uh4534
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpyDjUACgkQp6FrSiUn
Q2oCnAgAlKiBARHGoRmfhQ8XSd+1CRcthWru1TOZfzg7oaofD/J+l/7vtRzIwHqP
H9wI3Ed6H3cc+exQcbVBCHNPwmrW01CvvxmrBe8cdbEtsytf6jDgB/jflNrCutpL
Whu/C6yMX+Zs4owpAvtS0ui2BJkACwCSMdicAYeMe6z0qewI4yvGDgeQ4No1t5sW
TZfEmIfoqwB3+R8+sQtkAbdm9awT8m1beFIagu7h0gK+OiS6ASCBeiFGlbbuagnO
6UYm90guJsyG0AcdO89rfb4oiGVuC93RuGamrpdIsEKj+aeH43oUUzO0fTC1xIuo
9Bwj08tZX0GJQsg/FiL7pDv0MTpgJw==
=ViAO
-----END PGP SIGNATURE-----

--Y21qrN9o550vQG1BFpNXyEKwZr5uh4534--
