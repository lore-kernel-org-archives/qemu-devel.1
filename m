Received: from eggs.gnu.org ([2001:4830:134:3::10]:57669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbS6d-0007g9-8a
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:16:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbS6b-0003AF-He
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:16:19 -0500
References: <20170126123530.GB23095@lemon.Home>
	<20170126132708.GB29127@redhat.com>
	<6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
	<8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
	<20170201121658.GF3232@redhat.com>
	<c4d38998-b862-90e6-6c4b-4b96a8d17bb4@redhat.com>
	<20170201122854.GG3232@redhat.com>
	<37f445c0-c174-bca4-7073-7aa6c64046b0@redhat.com>
	<87bmul9hfc.fsf@dusky.pond.sub.org>
	<d03de140-db6b-26ed-6cc9-958591843483@redhat.com>
	<20170206103104.GD3029@redhat.com>
	<c7b5df9b-f235-ee36-4ab1-3023245b9cd1@redhat.com>
	<87inolujjv.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <26984f4a-074d-a25c-6182-8d179204acd0@redhat.com>
Date: Wed, 8 Feb 2017 14:16:06 +0100
MIME-Version: 1.0
In-Reply-To: <87inolujjv.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WclMICb7LVJVPm5CRmHQVFmwvMrxF2oBE"
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WclMICb7LVJVPm5CRmHQVFmwvMrxF2oBE
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <26984f4a-074d-a25c-6182-8d179204acd0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
References: <20170126123530.GB23095@lemon.Home>
 <20170126132708.GB29127@redhat.com>
 <6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
 <8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
 <20170201121658.GF3232@redhat.com>
 <c4d38998-b862-90e6-6c4b-4b96a8d17bb4@redhat.com>
 <20170201122854.GG3232@redhat.com>
 <37f445c0-c174-bca4-7073-7aa6c64046b0@redhat.com>
 <87bmul9hfc.fsf@dusky.pond.sub.org>
 <d03de140-db6b-26ed-6cc9-958591843483@redhat.com>
 <20170206103104.GD3029@redhat.com>
 <c7b5df9b-f235-ee36-4ab1-3023245b9cd1@redhat.com>
 <87inolujjv.fsf@dusky.pond.sub.org>
In-Reply-To: <87inolujjv.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 08.02.2017 10:19, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> First, because this is perhaps the most important thing: I think I
>> remembered what the original proposal to solve all this mess, or at
>> least move it to a later point:
>>
>> We wanted to just disallow overwriting existing files without
>> conv=3Dnotrunc. I think.
>>
>> The thing is that it's pretty much impossible with the qemu block laye=
r
>> to determine whether a file exists or not. Maybe you cannot open it bu=
t
>> it would be possible to overwrite it. This is the reason the patches f=
or
>> this did not make it into 2.8.
>=20
> The only sane way to do "create unless it already exists" is
> O_CREAT|O_EXCL.  Either you can do that, or you can't.

All the more reason why we couldn't implement it in time.

(Also, implementing that just for qemu-img dd... Well, no.)

>> On 06.02.2017 11:31, Daniel P. Berrange wrote:
>>> On Fri, Feb 03, 2017 at 07:56:11PM +0100, Max Reitz wrote:
>>>>> In case you say that's inconvenient: pretty much everything about d=
d's
>>>>> archaic user interface is inconvenient.  If you want convenient, ro=
ll
>>>>> your own.  If you want familiar, stick to the original.
>>>>
>>>> I agree. But qemu-img dd already is not dd. It interprets disk image=

>>>> files as virtual disks instead of as plain files. The question is
>>>> whether virtual disks are to be treated as block devices or as files=
=2E
>>>>
>>>> I don't have a strong opinion on the matter. Either way will surpris=
e
>>>> some people. The original issue was whether to make nocreat/notrunc =
a
>>>> mandatory option, so if we didn't have any backwards compatibility
>>>> issues, it would be the following two surprises:
>>>>
>>>> (1) Don't make nocreat/notrunc mandatory (as it is now). Then people=

>>>>     who expect qemu-img dd to treat image files as block devices wil=
l
>>>>     be surprised that all their data is gone. Bad.
>>>
>>> I don't think people really expect qemu-img to treat image file as if=

>>> they were block devices when operating on the host.
>>>
>>> It is like saying people expect /usr/bin/dd to treat a plain file
>>> as a block device, because they might use it with losetup later.
>>
>> That's not a good comparison. Disk images are meant to be used with qe=
mu
>> (or some other VMM, or, yes, with losetup if it's a raw image). Plain
>> files can be anything. No, dd does not look into the file to determine=

>> whether it may be a raw disk image or not, but it does execute fstat()=

>> to find out whether it's a plain file or a block device.
>=20
> Actually, it doesn't.  coreutils-8.26/src/dd.c:
>=20
>       mode_t perms =3D MODE_RW_UGO;
>       int opts
>         =3D (output_flags
>            | (conversions_mask & C_NOCREAT ? 0 : O_CREAT)
>            | (conversions_mask & C_EXCL ? O_EXCL : 0)
>            | (seek_records || (conversions_mask & C_NOTRUNC) ? 0 : O_TR=
UNC));
>=20
>       /* Open the output file with *read* access only if we might
>          need to read to satisfy a 'seek=3D' request.  If we can't read=

>          the file, go ahead with write-only access; it might work.  */
>       if ((! seek_records
>            || ifd_reopen (STDOUT_FILENO, output_file, O_RDWR | opts, pe=
rms) < 0)
>           && (ifd_reopen (STDOUT_FILENO, output_file, O_WRONLY | opts, =
perms)
>               < 0))
>         die (EXIT_FAILURE, errno, _("failed to open %s"),
>              quoteaf (output_file));
>=20
> ifd_reopen() is a wrapper around open() that forces the file descriptor=

> to a desired value (here: STDOUT_FILENO) and protects against EINTR.
>=20
> If this doesn't truncate block special for you, it's simply because you=
r
> OS interprets it that way, under license from POSIX:
>=20
>     O_TRUNC
>         If the file exists and is a regular file, and the file is
>         successfully opened O_RDWR or O_WRONLY, its length is truncated=

>         to 0 and the mode and owner are unchanged.  It will have no
>         effect on FIFO special files or terminal device files.  Its
>         effect on other file types is implementation-dependent.  The
>         result of using O_TRUNC with O_RDONLY is undefined.
>=20
>     http://pubs.opengroup.org/onlinepubs/7990989775/xsh/open.html
>=20
> Ignoring O_TRUNC is the traditional behavior.  But the OS is free to
> surprise its applications and users with non-traditional behavior.

Interesting. Thanks for the insight.

Well, then I have less issues about auto-truncate. "What? Your OS does
not truncate your hard disk?"

Not that this changes my course of action (not going to change the
default at this point), but maybe this will help me sleep better.

(Although arguing with what tools on POSIX-compatible OS are technically
allowed to do compared to what they are usually expected to do is a bit
of an issue still...)

Max


--WclMICb7LVJVPm5CRmHQVFmwvMrxF2oBE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlibGhYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Af2IH/0toPe1KVMZF3mDN+DcAp0wJQNV8BsUi
eCwWczdaEYLy2hcFtdLBCxcUgPgPz4itYCw+76hS/KCoSxGhMWroiTwe1vsVtBvn
rtcWAt8M2AUG9XwIotGounTVjxUA4+vN6SkLR3vEUwV6D60NFUUemL8XDJImPzJT
zmb+8pxOgiSKG8lK/sMnq8hkVdxEaneLz6rlyath3qNiyUhQ3RUUp69IB7QvcRE4
q10jc/I+1o/BU9DzVlI8jX3oOsF2TQ5z3md9S/u4jYFHFDpQ1nnAvp9CLpOwdFIj
zVop3Iu7bNkxf6aqTG7F0v1gLmQSUh0YVY9ZfFZLUBkeKbFSPcUB6ag=
=6/hE
-----END PGP SIGNATURE-----

--WclMICb7LVJVPm5CRmHQVFmwvMrxF2oBE--
