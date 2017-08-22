Received: from eggs.gnu.org ([2001:4830:134:3::10]:40304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dkCo2-0005UX-6t
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dkCo1-0005r5-79
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:17:34 -0400
References: <20170817091542.9403-1-pbutsykin@virtuozzo.com>
	<9e6b08b2-6f01-3d35-2644-a86955770844@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <603e29d3-5e65-cca6-65ea-933ec4290cef@redhat.com>
Date: Tue, 22 Aug 2017 19:17:13 +0200
MIME-Version: 1.0
In-Reply-To: <9e6b08b2-6f01-3d35-2644-a86955770844@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WMqCKP9FDT9scqFsireD4QCtAF6m1PxFm"
Subject: Re: [Qemu-devel] [PATCH v7 0/4] Add shrink image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WMqCKP9FDT9scqFsireD4QCtAF6m1PxFm
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <603e29d3-5e65-cca6-65ea-933ec4290cef@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/4] Add shrink image for qcow2
References: <20170817091542.9403-1-pbutsykin@virtuozzo.com>
 <9e6b08b2-6f01-3d35-2644-a86955770844@redhat.com>
In-Reply-To: <9e6b08b2-6f01-3d35-2644-a86955770844@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-08-22 01:31, John Snow wrote:
>=20
>=20
> On 08/17/2017 05:15 AM, Pavel Butsykin wrote:
>> This patch add shrinking of the image file for qcow2. As a result, thi=
s allows
>> us to reduce the virtual image size and free up space on the disk with=
out
>> copying the image. Image can be fragmented and shrink is done by punch=
ing holes
>> in the image file.
>>
>> # ./qemu-img create -f qcow2 image.qcow2 4G
>> Formatting 'image.qcow2', fmt=3Dqcow2 size=3D4294967296 encryption=3Do=
ff cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>
>> # ./qemu-io -c "write -P 0x22 0 1G" image.qcow2
>> wrote 1073741824/1073741824 bytes at offset 0
>> 1 GiB, 1 ops; 0:00:04.59 (222.886 MiB/sec and 0.2177 ops/sec)
>>
>> # ./qemu-img resize image.qcow2 512M
>> warning: qemu-img: Shrinking an image will delete all data beyond the =
shrunken image's end. Before performing such an operation, make sure ther=
e is no important data there.
>> error: qemu-img: Use the --shrink option to perform a shrink operation=
=2E
>>
>> # ./qemu-img resize --shrink image.qcow2 128M
>> Image resized.
>>
>> # ./qemu-img info image.qcow2
>> image: image.qcow2
>> file format: qcow2
>> virtual size: 128M (134217728 bytes)
>> disk size: 128M
>> cluster_size: 65536
>> Format specific information:
>>     compat: 1.1
>>     lazy refcounts: false
>>     refcount bits: 16
>>     corrupt: false
>>
>> # du -h image.qcow2
>> 129M    image.qcow2
>>
>=20
> It looks sane to me, and already has a full set of R-Bs from Max. Are w=
e
> waiting for Kevin?

We were waiting for Kevin to handle 2.10 patches so he could go into PTO
and for me to come back from PTO. ;-)

I'm still sifting through my inbox... When I'm done, I'll take a look,
but I have no idea how long that might last.
(Since 2.10 isn't out yet, there might be more pressing issues still...?
I don't quite now yet, to be honest...)

> It looks like in Vladimir's series we sidestepped the problem of what
> happens if we resize with persistent bitmaps: we deny the operation,
> regardless of if we are shrinking, growing, or have bitmaps that are
> read-only, frozen, or what-have-you.
>=20
> It shouldn't be too hard to add soon, but this is fine for now.
> (I think for adding it we just need to make sure the bitmaps aren't
> frozen and are not read-only, and the implementation bitmap structure
> can already handle truncation in either direction just fine.)
>=20
> Anyway;
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>

Thanks, in any case. :-)

Max


--WMqCKP9FDT9scqFsireD4QCtAF6m1PxFm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlmcZxkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AfcIIAIntX5L1BIz3g9naZ7ooX7gBDPchjNKu
uX9PcsPWxr63i2JOJJnMPVSSS0lmNP6bjTP+jHPzkvzYBeMhsd+QgV0wYGsuD7+e
KR550XdAHkaEXXYBLf6Yk5Gw+bX1s/lehIbWE8wl01TK0+9y6T/WiRQMdN9NWUod
Y9N/siXA2OlSfR6x67Oqp0b+o+nSGYSiBqW4bLFBGEHa/nO+dO/A9PuctYQeAqTA
n5QzFDd88GU74f4M4DUkKluhYWgAzOGFJyyLoHuIBZrEeGsBo/m0ftbEn3icFAZs
HgCdwVtxUDmGcEE5Ne3KSmD2eigpx8QrvbcdfPCKA8oyHfGP23NiXw4=
=hApv
-----END PGP SIGNATURE-----

--WMqCKP9FDT9scqFsireD4QCtAF6m1PxFm--
