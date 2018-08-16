Received: from eggs.gnu.org ([2001:4830:134:3::10]:51526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fq8Wh-0007zi-EH
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 23:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fq8Wg-0002US-JY
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 23:00:43 -0400
References: <20180815025614.53588-1-eblake@redhat.com>
	<20180815025614.53588-3-eblake@redhat.com>
	<48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
	<4aa899d3-c622-6acf-128c-513f95c55ed5@redhat.com>
	<d8c5df8d-7ae2-8ddc-aa71-38ec06b79988@redhat.com>
	<58ddf808-3d02-92e8-fa8e-a25339577bfb@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <27e8f254-0ab0-b680-d370-f60368ab380e@redhat.com>
Date: Thu, 16 Aug 2018 05:00:33 +0200
MIME-Version: 1.0
In-Reply-To: <58ddf808-3d02-92e8-fa8e-a25339577bfb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="okstevqpxQJ0NvrGnSsnKfcXKvQ6Ky05c"
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: Add dd seek= option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: fullmanet@gmail.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--okstevqpxQJ0NvrGnSsnKfcXKvQ6Ky05c
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: fullmanet@gmail.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <27e8f254-0ab0-b680-d370-f60368ab380e@redhat.com>
Subject: Re: [PATCH 2/2] qemu-img: Add dd seek= option
References: <20180815025614.53588-1-eblake@redhat.com>
 <20180815025614.53588-3-eblake@redhat.com>
 <48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
 <4aa899d3-c622-6acf-128c-513f95c55ed5@redhat.com>
 <d8c5df8d-7ae2-8ddc-aa71-38ec06b79988@redhat.com>
 <58ddf808-3d02-92e8-fa8e-a25339577bfb@redhat.com>
In-Reply-To: <58ddf808-3d02-92e8-fa8e-a25339577bfb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-16 04:57, Eric Blake wrote:
> On 08/15/2018 09:49 PM, Max Reitz wrote:
>=20
>>>> In my opinion, we do not want feature parity with dd.=C2=A0 What we =
do want
>>>> is feature parity with convert.
>>>
>>> Well, convert is lacking a way to specify a subset of one file to mov=
e
>>> to a (possibly different) subset of the other.=C2=A0 I'm fine if we w=
ant to
>>> enhance convert to do the things that right now require a dd-alike
>>> interface (namely, limiting the copying to less than the full file, a=
nd
>>> choosing the offset at which to start [before this patch] or write to=

>>> [with this patch]).
>>
>> Yes, I would want that.
>>
>>> If convert were more powerful, I'd be fine dropping 'qemu-img dd' aft=
er
>>> a proper deprecation period.
>>
>> Technically it has those features already, with the raw block driver's=

>> offset and size parameters.
>=20
> Perhaps so, but it will be an interesting exercise in rewriting the
> shorthand nbd://host:port/export into the proper longhand driver syntax=
=2E

Don't dare me! :-)

>>> Because of performance: qemu-nbd + Linux nbd device + real dd is one
>>> more layer of data copying (each write() from dd goes to kernel, then=
 is
>>> sent to qemu-nbd in userspace as a socket message before being sent b=
ack
>>> to the kernel to actually write() to the final destination) compared =
to
>>> just doing it all in one process (write() lands in the final destinat=
ion
>>> with no further user space bouncing).=C2=A0 And because the additiona=
l steps
>>> to set it up are awkward (see my other email where I rant about losin=
g
>>> the better part of today to realizing that 'dd ...; qemu-nbd -d
>>> /dev/nbd1' loses data if you omit conv=3Dfdatasync).
>>
>> I can see the sync problems, but is the performance really that much
>> worse?
>=20
> When you don't have sparse file support, reading or writing large block=
s
> of zeroes really is worse over /dev/nbd* than over a server/client pair=

> that know how to do it efficiently.=C2=A0 But for non-sparse data, I do=
n't
> know if a benchmark would be able to consistently note a difference
> (might be a fun benchmark for someone to try, but not high on my curren=
t
> to-do list).

Hm.  Yeah.  Well, for me, it remains that it would be better to have a
good way of exposing image contents to all of the rest of the system and
all of the nice tools there already are instead of re-implementing them
in qemu.

Max


--okstevqpxQJ0NvrGnSsnKfcXKvQ6Ky05c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt06NEACgkQ9AfbAGHV
z0AVyQgAqElFZgsz7f3C+v05clD0FupWCmPUw0Y2pHvWZtQheIOQwFl/isGjkAQv
X/Lqnks9SwyaSa3D78KsymfcS3lAPi3FbsMYLde5K3EAvRJIudD5PKTrA4wgxA/+
XVwl/5qGj36OHQWSSinLFyJ4om0SCzjyYEBpqqtu/a+sl2Gh1JgM3v03L+qtKyRn
DB0aQYCA1SPE7n/9HmQK/O98/yO4FDsFPv8a76geJz49QTBG3DNQ7zznsHfP9R9U
WK0vL2QEyQMV4POCH+f7iQpjjSTiQg71gUxdEqgaN8bprvMd88XfyD7y68/deucF
ViLO0d0XkoU7JQsRjJyuelzQcBjfFA==
=IHyM
-----END PGP SIGNATURE-----

--okstevqpxQJ0NvrGnSsnKfcXKvQ6Ky05c--
