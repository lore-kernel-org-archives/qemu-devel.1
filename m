Received: from eggs.gnu.org ([2001:4830:134:3::10]:34490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dSm1X-0005TE-8P
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dSm1W-0005Kr-EF
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:15:27 -0400
Date: Wed, 5 Jul 2017 16:15:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170705151506.GH29910@stefanha-x1.localdomain>
References: <20170704132350.11874-1-haoqf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline
In-Reply-To: <20170704132350.11874-1-haoqf@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/1] virtio-scsi-ccw: fix iotest 068 for
 s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, kwolf@redhat.com, famz@redhat.com, peterx@redhat.com, cohuck@redhat.com


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2017 at 03:23:49PM +0200, QingFeng Hao wrote:
> This commit fixes iotest 068 for s390x as s390x uses virtio-scsi-ccw.
> It's based on commit c324fd0a39c by Stefan Hajnoczi.=20
> Thanks!
>=20
> Change history:
> v4:
>     Got Cornelia Huck's Reviewed-by and take the comment to change the
>     commit message.
>=20
> v3:
>     Take Christian Borntraeger and Cornelia Huck's comment to check
>     if kvm is enabled in s390_assign_subch_ioeventfd instead of
>     kvm_s390_assign_subch_ioeventfd to as the former is a general one.
>=20
> v2:
>     Remove Stefan from sign-off list and change the patch's commit messag=
e=20
>     according to Christian Borntraeger's comment.
>=20
> QingFeng Hao (1):
>   virtio-scsi-ccw: use ioeventfd even when KVM is disabled
>=20
>  hw/s390x/virtio-ccw.c | 2 +-
>  target/s390x/cpu.h    | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)

I didn't realize s390 also has this old check.  Thanks for fixing it!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXQJ6AAoJEJykq7OBq3PIXoIIAJiabd/VWqYQaii/4AX7ZEkq
HnjOOzJPJxnY7LJgN3gfN1FWAOSBWO09pe1OjiXlHrGIO/3ETEqZFPvJJnGVay3q
aItQwBnNfP0mNjVZKVHyo5PInTVlVn7ClzZ1LfdEJdizIIFDJEIEoxegGqf2PQpo
qGsg7X/p2fKloqKteBAaA9lkc9yllKo6hn3ocVkiS4KFjMEkAjnf2p8BpW5aig8e
NhAVdz4GqD8dpTLdoy6G08hzda5ma632CkQfLqM8fRtj6JeJmVdLq9yhOxmHUQFW
SLZJwtkfhpjSi5Vrzhs5k3p3zO7iUvU8TH/DVyCceEJe1qN16PwEPDgZG8FBVHw=
=uNZm
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--
