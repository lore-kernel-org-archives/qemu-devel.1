Received: from eggs.gnu.org ([209.51.188.92]:33344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkWfi-0004k3-Gr
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkWfh-0005gy-5w
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:07:06 -0500
References: <20190117193658.16413-1-eblake@redhat.com>
	<f10654ba-04d3-3212-94ca-e72c511d51c2@virtuozzo.com>
	<38eca33c-cbea-6948-0e05-86a5e0bbeb00@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d697c04c-486d-06e7-8047-74ec597dd6e9@redhat.com>
Date: Fri, 18 Jan 2019 10:06:23 -0600
MIME-Version: 1.0
In-Reply-To: <38eca33c-cbea-6948-0e05-86a5e0bbeb00@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pEPzQGyOcY2lesRdjfciqOIM9b3kZ8efC"
Subject: Re: [Qemu-devel] [PATCH v4 00/21] nbd: add qemu-nbd --list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pEPzQGyOcY2lesRdjfciqOIM9b3kZ8efC
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <d697c04c-486d-06e7-8047-74ec597dd6e9@redhat.com>
Subject: Re: [PATCH v4 00/21] nbd: add qemu-nbd --list
References: <20190117193658.16413-1-eblake@redhat.com>
 <f10654ba-04d3-3212-94ca-e72c511d51c2@virtuozzo.com>
 <38eca33c-cbea-6948-0e05-86a5e0bbeb00@virtuozzo.com>
In-Reply-To: <38eca33c-cbea-6948-0e05-86a5e0bbeb00@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/19 7:47 AM, Vladimir Sementsov-Ogievskiy wrote:

>>
>> Interesting, I don't get it again. Searched in outlook online, I found=
 only v2 of it,
>> checked spam folder and filters. Magic.

Weird indeed.  Maybe there's enough @ signs due to .texi content in
there that a spam filter somewhere along the line ate it silently?

>>
>> anyway, I can look at https://lists.gnu.org/archive/html/qemu-devel/20=
19-01/msg04328.html
>>
>>
>=20
> just look at it in your qemu-nbd-list-v4 tag:

Thanks for that extra effort.

>=20
>  > Only expose MBR partition @var{num}.  Understands physical partition=
s
>  > 1-4 and logical partitions 5-8.
>=20
> I'm afraid, I'm too lazy to sort out these things I don't know, so just=
 believe. It at least
> corresponds to limits in code that it should be 1 <=3D partition <=3D 8=
 ;)
>=20
>  > @item -c, --connect=3D@var{dev}
>  > Connect @var{filename} to NBD device @var{dev} (Linux only).
>  > @item -d, --disconnect
>  > Disconnect the device @var{dev} (Linux only).
>=20
> Yes, and we now have clean code which establish this limitation
>=20
>  > @item -e, --shared=3D@var{num}
>  > Allow up to @var{num} clients to share the device (default
>  > @samp{1}). Safe for readers, but for now, consistency is not
>  > guaranteed between multiple writers.
>=20
> Hmm, don't understand, why you decided to move @samp{1}). on the follow=
ing line, it looks
> better as it was. And with a period it's only 69 symbols, the file have=
 a lot longer lines.

Emacs auto-reflowed the line as I edited the paragraph.  End-of-lines
doesn't really matter in .texi files (it gets reflowed again in the
creation of output documentation from the .texi input), so if my editor
tries to stick to certain column lengths, I don't really fight it.


>  > @example
>  > qemu-nbd \
>  >   --object tls-creds-x509,id=3Dtls0,endpoint=3Dserver,dir=3D/path/to=
/qemutls \
>  >   --tls-creds tls0 -t -x subset -p 10810 \
>  >   --image-opts driver=3Draw,offset=3D1M,length=3D1M,file.driver=3Dfi=
le,file.filename=3Dfile.raw
>  > @end example
>=20
> I don't know tls-related, the other options looks fine.

I looked through past git logs to see the command lines that Dan used
when initially implementing things; as well as comparison to iotest 233.

>=20
> upd (decided to run the command, with dropped tls):
> looks fine but not work, as s/length/size.

Oh, good catch!  Will fix.

>=20
>  >
>  > Serve a read-only copy of just the first MBR partition of a guest
>  > image over a Unix socket with as many as 5 simultaneous readers, wit=
h
>  > a persistent process forked as a daemon:
>  >
>  > @example
>  > qemu-nbd --fork -t -e 5 -s /path/to/sock -p 1 -r -f qcow2 file.qcow2=

>  > @end example
>=20
> Oops. s/-s/-k/, s/-p/-P/,

Ouch. Yes, thanks for catching that.

 and idea: may be, use self-descriptive long option names in
> examples?

Hmm. The nice part about short options is that they are less typing and
shorter lines; but verbose options are also useful.  Maybe listing the
same example twice, in both the short and long form?

>=20
>  >
>  > Expose the guest-visible contents of a qcow2 file via a block device=

>  > /dev/nbd0 (and possibly creating /dev/nbd0p1 and friends for
>  > partitions found within), then disconnect the device when done.
>  > @emph{CAUTION}: Do not use this method to mount filesystems from an
>  > untrusted guest image - a malicious guest may have prepared the imag=
e
>  > to attempt to trigger kernel bugs in partition probing or file syste=
m
>  > mounting.
>  >
>  > @example
>=20
> should we note, that nbd kernel-module should be loaded for this to wor=
k?

Yes, that's worth mentioning (some distros include that module to be
running or autoload already, but it's not universal, so such a note is
indeed warranted).

>=20
>  > qemu-nbd -c /dev/nbd0 -f qcow2 file.qcow2
>  > qemu-nbd -d /dev/nbd0
>  > @end example
>=20
> With fixed wrong option names and s/length/size:
> for 03/21:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--pEPzQGyOcY2lesRdjfciqOIM9b3kZ8efC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxB+X8ACgkQp6FrSiUn
Q2q13wf6A+XqFwui699j2jnYzb6ctHy9jA0E4eERA/Hfn5tUYuKtUFGWuTRxLF6s
5V5Xf9afLS4b+xYtW1ezwE1ZjWu4jah4s3jA5Gp9pLN68LPoqS69RoRySLExVxjy
8P/Gn9GIKyI6iQiQ/t32kg2ImGirjsFeIYTkd4BfFYbc0sfWTGdDkKkxDuBOng2O
C8Ez3ZRPDR0Symxw7SpvO1O9M/jMgCNuUqY05RaeERqLDrfWU/NygOTC2L6JMTsE
pNf1mMqyIRuTifn8EgNs4sonIuFMpiODuuhZ6XL3fiM4Evi2IPmCtznduMjGEuMn
xbWy07qpLdiyeV/FZWIBERSRKIvWWQ==
=FCc2
-----END PGP SIGNATURE-----

--pEPzQGyOcY2lesRdjfciqOIM9b3kZ8efC--
