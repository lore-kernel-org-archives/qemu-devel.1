Received: from eggs.gnu.org ([209.51.188.92]:50645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpdQx-0002Ni-2S
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpdQu-00007W-Tt
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:20:58 -0500
References: <20190125234837.2272-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <db43cde5-a0a8-1fff-f5ed-8680852d005e@redhat.com>
Date: Fri, 1 Feb 2019 12:20:25 -0600
MIME-Version: 1.0
In-Reply-To: <20190125234837.2272-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p8vraoKsoX0P7g3qbZd73C9DUJknbNOPe"
Subject: Re: [Qemu-devel] [PATCH v2] qemu-nbd: Deprecate qemu-nbd --partition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>, thuth@redhat.com, vsementsov@virtuozzo.com, rjones@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p8vraoKsoX0P7g3qbZd73C9DUJknbNOPe
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 thuth@redhat.com, vsementsov@virtuozzo.com, rjones@redhat.com,
 qemu-block@nongnu.org
Message-ID: <db43cde5-a0a8-1fff-f5ed-8680852d005e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-nbd: Deprecate qemu-nbd --partition
References: <20190125234837.2272-1-eblake@redhat.com>
In-Reply-To: <20190125234837.2272-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/25/19 5:48 PM, Eric Blake wrote:
> The existing qemu-nbd --partition code claims to handle logical
> partitions up to 8, since its introduction in 2008 (commit 7a5ca86).
> However, the implementation is bogus (actual MBR logical partitions
> form a sort of linked list, with one partition per extended table
> entry, rather than four logical partitions in a single extended
> table), making the code unlikely to work for anything beyond -P5 on
> actual guest images. What's more, the code does not support GPT
> partitions, which are becoming more popular, and maintaining device
> subsetting in both NBD and the raw device is unnecessary duplication
> of effort (even if it is not too difficult).
>=20
> Note that obtaining the offsets of a partition (MBR or GPT) can be
> learned by using 'qemu-nbd -c /dev/nbd0 file.qcow2 && sfdisk --dump
> /dev/nbd0', but by the time you've done that, you might as well
> just mount /dev/nbd0p1 that the kernel creates for you instead of
> bothering with qemu exporting a subset.  Or, keeping to just
> user-space code, use nbdkit's partition filter, which has already
> known both GPT and primary MBR partitions for a while, and was
> just recently enhanced to support arbitrary logical MBR parititions.
>=20
> Start the clock on the deprecation cycle, with examples of how
> to write device subsetting without using -P.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v2: actual nbdkit example [Rich], improved doc wording

Thanks; queued for my next NBD pull request.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--p8vraoKsoX0P7g3qbZd73C9DUJknbNOPe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxUjekACgkQp6FrSiUn
Q2rBbgf7BtWP5Dt6iIjax8D5BR+JbCQS04ykaUtZcZ9iOZpl6OTwWl3zQEL9MNRs
RJA4IBQ+F7JwqSGydNVqd9hwMlGsKlt/IkIHVhyELwCZLZiIyOyY/jSV6opPr2u+
s0u9rEAo9h+k9/V1CJj3MESEIGuR7Ix/XSYfh5diohEwwvHZq7HMHIosFDElwn0d
JnleqwvKJJswoIHGGKrz/zCjt/rLq8ylSvorXd5HKaRjNMiX13MhQxvbA2/4lJuh
qvOGAaYkxz1wRkxu/wATm0FB+p2+C910DYdjchq78G7oJk/AD/cbZAyTi35hoUuX
Z4CzjKFpviD5qRr6ehbPgWSqDPu+FA==
=WIUg
-----END PGP SIGNATURE-----

--p8vraoKsoX0P7g3qbZd73C9DUJknbNOPe--
