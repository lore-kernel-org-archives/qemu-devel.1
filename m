Received: from eggs.gnu.org ([2001:4830:134:3::10]:54192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOSKo-0007Bc-2x
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOSKk-00041R-1Y
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:53:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOSKj-00041M-Os
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:53:09 -0500
References: <CAP8dc_acqeqpio7fVK4XSAxoH8QaGp9L=S1h2OCCWgrj=Q7VCw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e57c4b44-ac0c-a937-e088-1f4e086080d8@redhat.com>
Date: Tue, 3 Jan 2017 10:53:06 -0600
MIME-Version: 1.0
In-Reply-To: <CAP8dc_acqeqpio7fVK4XSAxoH8QaGp9L=S1h2OCCWgrj=Q7VCw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6Xm9QaCM7HeOaEPa4gxNooCTCV2nq2w2m"
Subject: Re: [Qemu-devel] [RFC]virtio-blk: add disk-name device property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Junkang Fu <fujunkang@gmail.com>, stefanha@redhat.com
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Xm9QaCM7HeOaEPa4gxNooCTCV2nq2w2m
From: Eric Blake <eblake@redhat.com>
To: Junkang Fu <fujunkang@gmail.com>, stefanha@redhat.com
Cc: qemu-devel@nongnu.org
Message-ID: <e57c4b44-ac0c-a937-e088-1f4e086080d8@redhat.com>
Subject: Re: [Qemu-devel] [RFC]virtio-blk: add disk-name device property
References: <CAP8dc_acqeqpio7fVK4XSAxoH8QaGp9L=S1h2OCCWgrj=Q7VCw@mail.gmail.com>
In-Reply-To: <CAP8dc_acqeqpio7fVK4XSAxoH8QaGp9L=S1h2OCCWgrj=Q7VCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/29/2016 08:41 PM, Junkang Fu wrote:
>>From 74e913fc41ea98d1dde692175f1e3fb6729342aa Mon Sep 17 00:00:00 2001
> From: "junkang.fjk" <junkang.fjk@alibaba-inc.com>
> Date: Wed, 24 Aug 2016 19:36:53 +0800
> Subject: [PATCH] virtio-blk: add disk-name device property
>=20
> Current virtio-blk disk name(ex. /dev/vdb) has nothing to do with the
> target dev
> name specified in libvirt xml file. For example, we may get disk name
> /dev/vdb in
> VM while target dev specified in libvirt xml is vdc.

It's not really libvirt's fault.  The libvirt XML names are for
convenience, but nothing on the host side requires the guest to pick the
same naming scheme as the host.

I guess your proposal is to enhance the virtio spec such that clients
that are new enough to honor the new addition to the virtio spec will
change their name-picking algorithm to use the name provided by the
host, rather than their current approach of picking whatever name they
feel like, and then enhance libvirt to pass the XML name on down to the
guest?  It might work, but as others have pointed out, it will require a
virtio spec change first.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6Xm9QaCM7HeOaEPa4gxNooCTCV2nq2w2m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYa9byAAoJEKeha0olJ0Nq5o0H/2OFqxJmwIniG5plKBRLwqVT
ewoBFf0vQJgDh/a+pmIseQqTbdKfMBGnyum+RE+35gFZ2ejbc1SLD07sEO3JJ+u7
ov1RLbAt6Fc1vq30gvxvlod/3lzREG5SU5x448fB0HjxUDUqJa/5kV9zNPf83eFt
KHJ05AAvEkkAFFOSUizthbeH1xLzCjwdq/TuLE4Y+uW5bcA8je3q7ynNh+7p6Ljo
z5eyH+exup1oR69pSshV6slw3AThXJobeVy1TMwC4CGKmmGRHx66tFtMjGcvFAPc
x0FnRs4Tz00W/KCRb8A2j2iuGDONYSu1iZ8yF0BCurGu1H+7Di2+i8SfV/QZBlA=
=vvaX
-----END PGP SIGNATURE-----

--6Xm9QaCM7HeOaEPa4gxNooCTCV2nq2w2m--
