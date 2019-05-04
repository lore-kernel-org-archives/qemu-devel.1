Received: from eggs.gnu.org ([209.51.188.92]:53628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMoWE-0007ut-Jc
	for qemu-devel@nongnu.org; Sat, 04 May 2019 02:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMoWD-0006kS-JR
	for qemu-devel@nongnu.org; Sat, 04 May 2019 02:51:34 -0400
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
	<f1dfe2c3-2d61-e477-ac3d-37ad26d9236d@redhat.com>
	<61685a48-b84e-c379-7193-f456e82635ba@redhat.com>
	<67a38513-89af-7f54-2fc8-05b5777983ca@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <22933e94-18da-257c-7931-da511bc5a602@redhat.com>
Date: Sat, 4 May 2019 08:51:17 +0200
MIME-Version: 1.0
In-Reply-To: <67a38513-89af-7f54-2fc8-05b5777983ca@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Ox40LrtCe0BDFeiIAOsfnFjr9nVpQ1yus"
Subject: Re: [Qemu-devel] Failing QEMU iotest 175
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Nir Soffer <nirsof@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ox40LrtCe0BDFeiIAOsfnFjr9nVpQ1yus
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/05/2019 22.21, Eric Blake wrote:
> On 5/2/19 11:37 PM, Thomas Huth wrote:
>> On 02/05/2019 23.56, Eric Blake wrote:
>>> On 4/28/19 10:18 AM, Thomas Huth wrote:
>>>> QEMU iotest 175 is failing for me when I run it with -raw:
>>>>
>>>>  =3D=3D creating image with default preallocation =3D=3D
>>>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
>>>> -size=3D1048576, blocks=3D0
>>>> +size=3D1048576, blocks=3D2
>>>
>>> What filesystem?
>>
>> ext4
>=20
> Hmm, it's passing for me on ext4, but that probably means we have
> different configuration parameters. I'm not sure how to easily show wha=
t
> parameters a particular ext4 partition uses to compare the differences
> between your setup and mine (mine is tuned to whatever defaults Fedora'=
s
> installer chose on my behalf), so maybe someone else can chime in.

$ sudo tune2fs -l /dev/mapper/Home
tune2fs 1.42.9 (28-Dec-2013)
Filesystem volume name:   <none>
Last mounted on:          /home
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr dir_index filetype
needs_recovery meta_bg extent 64bit flex_bg sparse_super large_file
huge_file uninit_bg dir_nlink extra_isize
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              36700160
Block count:              146800640
Reserved block count:     5873663
Free blocks:              56266267
Free inodes:              35403275
First block:              1
Block size:               1024
Fragment size:            1024
Group descriptor size:    64
Blocks per group:         8192
Fragments per group:      8192
Inodes per group:         2048
Inode blocks per group:   256
First meta block group:   258
Flex block group size:    16
Filesystem created:       Thu Apr 19 18:34:33 2018
Last mount time:          Sat May  4 08:20:36 2019
Last write time:          Sat May  4 08:20:36 2019
Mount count:              224
Maximum mount count:      -1
Last checked:             Thu Apr 19 18:34:33 2018
Check interval:           0 (<none>)
Lifetime writes:          1826 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:	          128
Journal inode:            8
First orphan inode:       11076944
Default directory hash:   half_md4
Directory Hash Seed:      08e1be04-c3a3-4c37-a059-cf54af5c4bc0
Journal backup:           inode blocks

IIRC I talked to stefanha on IRC about this some weeks ago already, and
he was able to reproduce the problem when using a certain parameter to
create the file system. However, I fail to remember which parameter it
was. Maybe Stefan still remembers...

 Thomas


--Ox40LrtCe0BDFeiIAOsfnFjr9nVpQ1yus
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJczTZsAAoJEC7Z13T+cC210uUP/j0eCLA1uN9mjY31JYjw05Ic
ZWpRb0HBvCoghim2mkUf/3vuYYYzJWKdvGcuhNZrIx91IdTcPiqde54Qg7TPDMP7
LcjgbwkffEjDXBfdETCPyTJX1Mvmcq7++wjoNsEd2s+rgoRQt/7NB/Rc+K8aH1Wz
53CI2uFluVNcNtkUJ7J0Nku889uZVShrEwIAsqcT/Non5CwssTW5t7ZXdpAbxqLF
YU00b6FyeiY7c0BKz13wVw4RBp5VLdTSTrfIGD1E3O2br/0SNg6KlCPUhkWmpMvQ
0CpGvGbjPitDSZBSXDGcWNL9yJ/nfpUb7CPOwVlm3ndpbLqPognBj8nKmQqAKRsQ
XSaA/FzeeAVDSwMSyy5mF6uvc4ImHbcQHI4bfPXW3XzBFXYLEoo4vuXpem2cJ3Hb
p6lspR1szcEEC3TP2brtb5HKcdmxi/UZwr91got73MAWjfbL06Ykrn4wXHZHRBe7
g8TL8k3lEd40YKbAbxLzTOvKUqywSm+W/3zujefojDl2u7Q6IbGINqoWnTyFhOCR
5u3tyoflA+jxG7WdzOE+aAkRE1egIAq5bDJNREtOOmGTlEoBIzpGTFwvKMoDSwyZ
ANhfaV4YpI5n9o8Jd2TIuLRM5tGaxRUxeWOHh+bJc5YQgAgCpaX8XgjE6S2V9WS1
Mch+mjOpZ45Q55m/jINw
=QOhU
-----END PGP SIGNATURE-----

--Ox40LrtCe0BDFeiIAOsfnFjr9nVpQ1yus--
