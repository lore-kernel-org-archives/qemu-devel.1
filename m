Received: from eggs.gnu.org ([2001:4830:134:3::10]:58324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ee0Td-0006zO-Ar
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 10:27:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ee0TX-0000ua-Nt
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 10:27:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ee0TX-0000sl-E9
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 10:27:03 -0500
References: <CAK-iXgUO7LMZ7+Bvs66_yno_q6ZDEzgKS5baxG7SASVNChYyvw@mail.gmail.com>
	<982e13e4-6591-0f4c-9faa-17e0302ad350@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <662d0135-c2a4-de17-6b35-4c00ef9f3318@redhat.com>
Date: Tue, 23 Jan 2018 09:26:55 -0600
MIME-Version: 1.0
In-Reply-To: <982e13e4-6591-0f4c-9faa-17e0302ad350@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xUVY45yQKUS0LCPLZfQECBTnFdvvSnb8j"
Subject: Re: [Qemu-devel] Prevent overriding the input file with the output
 file when using qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: River Chiang <riverchiang@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xUVY45yQKUS0LCPLZfQECBTnFdvvSnb8j
From: Eric Blake <eblake@redhat.com>
To: River Chiang <riverchiang@gmail.com>, qemu-devel@nongnu.org
Message-ID: <662d0135-c2a4-de17-6b35-4c00ef9f3318@redhat.com>
Subject: Re: [Qemu-devel] Prevent overriding the input file with the output
 file when using qemu-img
References: <CAK-iXgUO7LMZ7+Bvs66_yno_q6ZDEzgKS5baxG7SASVNChYyvw@mail.gmail.com>
 <982e13e4-6591-0f4c-9faa-17e0302ad350@redhat.com>
In-Reply-To: <982e13e4-6591-0f4c-9faa-17e0302ad350@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2018 08:48 AM, Eric Blake wrote:
> On 01/22/2018 10:40 PM, River Chiang wrote:
>>     Signed-off-by: River Chiang <riverchiang@gmail.com>
>>
>> ---------------------------------- qemu-img.c
>> ----------------------------------
>> index 68b375f998..5ce594ea00 100644
>> @@ -2098,6 +2098,9 @@ static int img_convert(int argc, char **argv)
>>      if (s.src_num < 1) {
>>          error_report("Must specify image file name");
>>          goto fail_getopt;
>> +    } else if (!strcmp(argv[optind], out_filename)) {
>> +        error_report("Override the input file with the output file");=

>> +        goto fail_getopt;
>=20
> Comparing names is too prone to false negatives.  'foo' and './foo' are=

> the same file, but your test won't catch it.  Better might be checking
> if stat() reports the same dev/inode pair for the two files.
>=20
> By the way, your patch is not in proper 'git send-email' format, which
> makes it hard to test whether it even applies.  More patch submission
> hints at http://wiki.qemu.org/Contribute/SubmitAPatch

Also, is this something that our image locking patches should be able
prevent automatically, without having to special case whether the
command line arguments refer to the same file, by the two different
command line arguments triggering conflicting locks?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xUVY45yQKUS0LCPLZfQECBTnFdvvSnb8j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpnVD8ACgkQp6FrSiUn
Q2qT0wf+IeviD4m8PxS7bbAk/d8Gk0ylUOV1Ny27IoBLnATwIPBEo86KrUCvzRty
eyCXMAXNzphqJzSr/L5WdTjsTjcg/UCqLVcxgfcWQQm2sIGk4hwv3IC/WOx68twQ
qlV53bbcupK4KNG1/z+RB8RqD5qdOgcwdW4tM9NBcrFpCSMeYMzh2qjbyYQBzeLB
0GIXspvwTMjxhSAwMeA02PEAzjpgtLLSKpaEQB8P7rUIrrH0SYPWbpk9DhALz68R
hnIKh6XgeJtGnz9xX5hsUdU7hm5RiBvisW1bnGa32fRly1W22zHNS0NxUedryXyk
4uv7R4GVC+iSx/MBE60ZukjtrVs19A==
=E8Mj
-----END PGP SIGNATURE-----

--xUVY45yQKUS0LCPLZfQECBTnFdvvSnb8j--
