Received: from eggs.gnu.org ([2001:4830:134:3::10]:49040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds1u2-0004oD-Tu
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds1u1-0001tZ-TQ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:16:06 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-11-eblake@redhat.com>
	<65cb854d-5915-dc23-cb5d-0d8b5cecb6ea@redhat.com>
	<d893ea51-b083-9c3c-9f9f-f8d7a519dfda@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2f0a077a-b62b-5a05-1cf5-88ca80d1640b@redhat.com>
Date: Wed, 13 Sep 2017 09:15:54 +0200
MIME-Version: 1.0
In-Reply-To: <d893ea51-b083-9c3c-9f9f-f8d7a519dfda@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="7Dp7N8El3Xa3dic0KU3Nq5vbJKxw6V3nK"
Subject: Re: [Qemu-devel] [PATCH v7 10/38] libqos: Move/rename
 qpci_unplug_acpi_device_test() to pci.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "open list:virtio-blk" <qemu-block@nongnu.org>, Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>, armbru@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7Dp7N8El3Xa3dic0KU3Nq5vbJKxw6V3nK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.09.2017 15:28, Eric Blake wrote:
> On 09/12/2017 02:29 AM, Thomas Huth wrote:
>> On 11.09.2017 19:19, Eric Blake wrote:
>>> Commit 2f8b2767 originally added qpci_plug_device_test() and
>>> qpci_unplug_acpi_device_test() as a pair, both in pci-pc.c.
>>> Later, commit cf716b31 moved one half of the pair to pci.c
>>> when adding PPC64 support.  Keep the implementations of the
>>> two functions together, and shorten the name to
>>> qpci_unplug_device_test(), since all callers use the two
>>> functions in tandem.
>>>
>=20
>>
>> No, that's a bad idea. ACPI and that outb() is clearly something
>> specific to x86, so this should not reside in pci.c but in pci-pc.c
>>
>> We might be able to unify this - I've had a similar patch here:
>>
>>  https://patchwork.kernel.org/patch/9905031/
>>
>> ... but I think this needs some more careful thinking and discussion, =
so
>> I'd suggest that you remove this from your already huge patch series f=
or
>> now and we fix it later instead.
>=20
> Okay, I'm fine dropping this patch, and can base my respin on top of
> your cleanup instead.

Note that my patches are currently on halt since I'm waiting for your
qemu_startf() reworks to get included first :-) ... so feel free to pick
up ideas or patches from my series into your series if that helps.

 Thomas


--7Dp7N8El3Xa3dic0KU3Nq5vbJKxw6V3nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZuNsqAAoJEC7Z13T+cC21QYAP/3kqWX15jGzfgz+qkfiJq9xg
W6UYFg5caKVd5qW1J0JCMhDXb0H2j9t3f91VilPGnDrrCC13lmoXyvhqEFhpSMEV
a2kFVOP1b/LtA0bJ9ksZG3B/CkXbEVnfJ0+QoWmpQECyNp+d7aklObgxlthYlnOQ
ZW+49KecpZeWc0Ruh2mDZOYERC+0BXEp+xcZlzYRoiGPxMeTVpjP3FUuEfSbXa6n
jsDVPe3DeN5YkhOPV1Oyrzg/NX5DTlcNolzfLTcFclXdyXnmClRh9zjFQmiaz/Vg
asxcwJASwiVMKELAIjyz/ns75YNfcsNAg54PcuiAgm/vDIpaQwxh1tHzWMszE5Q1
8ck5RBwOmANproTusM0/k9LXd8RWo82wT1DzZgPnARcdESoKYkP60n3Ix0d5Ek+g
nEOqj+1rvlsrCFc9sUWiR4UVxPwCefWU95xIyouK+X46KZDM5mHX4v1l1i2pym77
+sJXrkhxf759wnPTSjQPquT/Qm9h5hSub7b7MZfXHfJ2Sr3E4um+1k++0gz4x7z0
0qjbFEznQl8UHqARvh+WUKapI0lZ6jMAPI5f4lKGFL6yY9YrhoJ66S5TJ7xyB2m4
wWzntlNksblguxFOGs1OPWgHzKczW5cvNRsdGthmOtp9ROI6dReCdQm8UGQYwNSH
fBEbjvq+MDcfWsMWpJ0z
=9VcM
-----END PGP SIGNATURE-----

--7Dp7N8El3Xa3dic0KU3Nq5vbJKxw6V3nK--
