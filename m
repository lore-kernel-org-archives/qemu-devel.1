Received: from eggs.gnu.org ([2001:4830:134:3::10]:55437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtEWW-0004dp-NZ
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 10:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtEWV-0000RE-QK
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 10:56:48 -0400
References: <20170817091542.9403-1-pbutsykin@virtuozzo.com>
	<9e6b08b2-6f01-3d35-2644-a86955770844@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f67eb552-e0d1-c566-a798-2e9c73a69cd2@redhat.com>
Date: Sat, 16 Sep 2017 16:56:32 +0200
MIME-Version: 1.0
In-Reply-To: <9e6b08b2-6f01-3d35-2644-a86955770844@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7voR1JQP4QlSLKpsflKBmEuFIKV5MGsun"
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
--7voR1JQP4QlSLKpsflKBmEuFIKV5MGsun
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <f67eb552-e0d1-c566-a798-2e9c73a69cd2@redhat.com>
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

Now I found that I was waiting for my own R-b for patch 3.  I hadn't yet
reviewed that patch in its current state (I had reviewed it for v5, but
it has changed quite a bit in v6).

Max


--7voR1JQP4QlSLKpsflKBmEuFIKV5MGsun
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm9O6ASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A17EH/0q9nhM33zRaqMmfHzld9EhTNOCfZIwI
BfaQan3FECbOj/9MrX0K1HNe0JC7m2hiGk37+IWqDqG0KSmmkaVnMgRpv2GYUIlR
ai/+7BEb8QaFAq2IGlluIncFbxsCnTLJgy6meVqaWrE/xUSCKc3txL6Ed6zopomW
UGVwIQQDkTSgG88KDpcAI8D0gsoVUvLV3EEYdhpl4Nn89afDw/yO1hLDxMzTBbBU
3FMcIcb+62e+0gLk6sk2MmjCZ70cMcR3D8lBE3LloxjA9hLA0daXgyrfQzVKaEoM
Pcn9CY8bI/QE/DSHr07j7K0WRAFa5I4Wd56Gkqz3gLdwX3Gbx1D3PYg=
=i1Vl
-----END PGP SIGNATURE-----

--7voR1JQP4QlSLKpsflKBmEuFIKV5MGsun--
