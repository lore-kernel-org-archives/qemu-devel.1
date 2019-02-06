Received: from eggs.gnu.org ([209.51.188.92]:40953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grRS5-0004xL-4x
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grRS3-0005ns-KN
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:57:36 -0500
References: <CAMAMwPB1GJNxsgcvZLHwHuLp-AjuWtnYCGOm6+U4DwdLsNrU8A@mail.gmail.com>
	<e169e116-1ab3-692c-5320-eb4da9abb623@redhat.com>
	<CAMAMwPBiy7MsZzmkOPZoh+KNHfpsfA+WcRA7ZfQa0457+au99w@mail.gmail.com>
	<9aef3157-e49e-4b53-f0de-75593df06da9@redhat.com>
	<20190124091649.GF23279@paraplu>
	<CAMAMwPA_H77fnC+dOzBt+nRQ+=oPHtpw2DRYMCEtnGdo1OU0Hw@mail.gmail.com>
	<CAJjBnT+dL8aamDoqMHDaq1GUTrvd+Yp3h0=zqcMy9HRLzXVtXg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c9abbd4-5317-446e-d9e4-d0e02cd9f706@redhat.com>
Date: Wed, 6 Feb 2019 11:57:29 -0600
MIME-Version: 1.0
In-Reply-To: <CAJjBnT+dL8aamDoqMHDaq1GUTrvd+Yp3h0=zqcMy9HRLzXVtXg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KxjoYrASNh5ZuowGdWoHWMeuZcndUe8Gb"
Subject: Re: [Qemu-devel] Incremental drive-backup with dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suman Swaroop <suman.swaroop@rubrik.com>, Bharadwaj Rayala <bharadwaj.rayala@rubrik.com>, qemu-discuss@nongnu.org, qemu-devel@nongnu.org
Cc: Kashyap Chamarthy <kchamart@redhat.com>, Kashyap Chamarthy <kashyap.cv@gmail.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KxjoYrASNh5ZuowGdWoHWMeuZcndUe8Gb
From: Eric Blake <eblake@redhat.com>
To: Suman Swaroop <suman.swaroop@rubrik.com>,
 Bharadwaj Rayala <bharadwaj.rayala@rubrik.com>, qemu-discuss@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 Kashyap Chamarthy <kashyap.cv@gmail.com>, John Snow <jsnow@redhat.com>
Message-ID: <9c9abbd4-5317-446e-d9e4-d0e02cd9f706@redhat.com>
Subject: Re: [Qemu-devel] Incremental drive-backup with dirty bitmaps
References: <CAMAMwPB1GJNxsgcvZLHwHuLp-AjuWtnYCGOm6+U4DwdLsNrU8A@mail.gmail.com>
 <e169e116-1ab3-692c-5320-eb4da9abb623@redhat.com>
 <CAMAMwPBiy7MsZzmkOPZoh+KNHfpsfA+WcRA7ZfQa0457+au99w@mail.gmail.com>
 <9aef3157-e49e-4b53-f0de-75593df06da9@redhat.com>
 <20190124091649.GF23279@paraplu>
 <CAMAMwPA_H77fnC+dOzBt+nRQ+=oPHtpw2DRYMCEtnGdo1OU0Hw@mail.gmail.com>
 <CAJjBnT+dL8aamDoqMHDaq1GUTrvd+Yp3h0=zqcMy9HRLzXVtXg@mail.gmail.com>
In-Reply-To: <CAJjBnT+dL8aamDoqMHDaq1GUTrvd+Yp3h0=zqcMy9HRLzXVtXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 11:20 AM, Suman Swaroop wrote:
>   Hey, some continuation questions from above discussion,
>=20

What above discussion?  Oh, you top-posted, so you mean the below
discussion.  (On technical lists, it's best to avoid top-posting, and to
instead reply inline to make the conversation easier to follow; it's
also okay to trim quoted parts irrelevant to your reply, as it can be
assumed that anyone joining the conversation can find the public list
archives to catch up on the full thread).

>=20
>    1.
>=20
>    Comments in blockdev-add command section in patch
>    https://patchwork.kernel.org/patch/9638133/ says that
>    =E2=80=9CNote: This command is still a work in progress. It doesn't =
support all
>    block drivers among other things. Stay away from it unless you want =
to help
>    with its development.=E2=80=9D Does it work with qcow2 and raw from =
version 2.3?

blockdev-add was declared stable in commit 79b7a77ed, v2.9 and beyond.
You are correct that for simpler uses, you could probably get raw and
qcow2 actions to work in 2.3, but working with older versions is more of
a downstream task so you may get less support figuring out how to target
older and newer versions simultaneously from this list.

Meanwhile, there have been enough other fixes with incremental backups
that you probably want to be using 3.1 or newer.  For that matter, a lot
of bitmap commands were still experimental in 3.1, but have been
converted to stable for the upcoming 4.0; depending on what you plan on
doing with dirty bitmaps, having to implement something twice to use
x-block-dirty-bitmap-merge from 3.1 and block-dirty-bitmap-merge from
4.0 can be a pain.

>    2.
>=20
>    When new nodes are added in chain, there is an associated backing im=
age
>    file as well. Some of these image files become redundant when a node=
 is
>    merged with other nodes. While issuing qmp commands to qemu via libv=
irt tls
>    socket, there does not seem to be any functionality available to del=
ete the
>    redundant image files. Basically when a node is streamed or committe=
d, the
>    node and its backing image file can be deleted as they are not requi=
red
>    anymore. Is there any qmp command to achieve the same with the const=
raint
>    that we only have access to libvirt tls socket and cannot ssh to the=
 host?

Trying to diagram what you are asking, to make sure I understand:

You stared with:

base <- image1 <- image2

and later did a block stream to get:

base <- image2 (contents of image1 now in image2)

or a block commit to get:

base <- image2 (contents of image1 now in base)

and are trying to figure out how to delete image1 from the file system,
now that it is no longer in use by the backing chain?  Why can't you
just 'rm image1'? Or if you are using libvirt to manage the storage pool
that image1 lives in, can't you use libvirt virStorage* APIs to remove
it?  Yes, it might be nice it the libvirt APIs for external snapshot
management had a bit more power to optionally auto-delete images that
are no longer in use - but that's more a question for the libvirt list
than this list.

Or are you asking about a node still in qemu's memory, that would show
up via the query-block command?

If it is something owned by qemu, you can always experiment with the
libvirt backdoor of 'virsh qemu-monitor-command' to send QMP commands to
qemu that libvirt has not yet coded up official support for; but it puts
you squarely in unsupported territory (if it works, great; if it breaks,
you get to keep both pieces).

In the meantime, I've cc'd you on my v3 posting of what I hope will
stabilize into the libvirt incremental backup APIs in time for libvirt
5.1 (I'm down to a couple of weeks, with still quite a few things to
shake out).

>    3.
>=20
>    In filename path of blockdev-add command or target path of drive-bac=
kup
>    command can we provide nfs urld directly for the image path i.e
>    nfs://<ip>/foo(not a mounted directory)? This is related to the poin=
t 2
>    above that we do not have root ssh access to the host but only acces=
s to
>    its tls socket

The point of blockdev-add is that you should supply the parameters
needed by a particular driver.  An image path that can be short-cutted
to nfs:// for qemu-img also has a long form described by
BlockdevOptionsNfs (present since 2.9); so where you use:

{ "driver": "file", "filename": "/path/to/local" }

to get the file driver, you would instead use:

{ "driver": "nfs", "server": "<ip>", "path": "foo", ... }

for an NFS access.  If you are using libvirt to manage qemu, then
libvirt should be able to do all this on your behalf - except that
getting libvirt to use blockdev-add has been a multi-year project, and
Peter Krempa is still producing patches that will hopefully land in
libvirt 5.1 along those lines.  But again, libvirt questions may be
better asked on the libvirt list.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--KxjoYrASNh5ZuowGdWoHWMeuZcndUe8Gb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxbIAkACgkQp6FrSiUn
Q2pj0Af+MIRzoFr24C8J4w5+sN/z4mZWMwtqVeX+sZIMMT/eeQDdsgEv9SS49iRi
IabJxIYRxtdJg6vy80b/021zVxBkzGmcUJbkyXbuKu1JxIKFE7i0rP2ttL6N7e8Y
WDDoZHmunShu6aTgXUKV6vAenU6jIUObKuaEGeHiui1xkCdXCT27nW+W4fS9V9Wm
YXb2pBWDlabswfeIGRwLhLL7ncBAH84LEWH9Xil4siI21NKeQq0ez/VxzRKjtR5m
I2YDJcyfbImHBWD7izc5GzEcK1Zpljjx8H3pYpTpPdzI5u6GcKyOupRoImAPTcSO
gWeiar7t5TGt7bOE3C77UJWH5MRNWg==
=eaid
-----END PGP SIGNATURE-----

--KxjoYrASNh5ZuowGdWoHWMeuZcndUe8Gb--
