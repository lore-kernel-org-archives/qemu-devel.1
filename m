Received: from eggs.gnu.org ([2001:4830:134:3::10]:55726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePqmR-0002GG-Lc
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePqmN-0002Uz-0c
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:16:03 -0500
References: <20171215101651.13911-1-david@gibson.dropbear.id.au>
	<20171215101651.13911-4-david@gibson.dropbear.id.au>
	<e69f5264-9da3-2bbf-e0f9-3c1e989d7260@redhat.com>
	<20171215125640.GJ7753@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <91348bd8-fc58-327f-df24-caa5acfeb3cc@redhat.com>
Date: Fri, 15 Dec 2017 15:15:45 +0100
MIME-Version: 1.0
In-Reply-To: <20171215125640.GJ7753@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="LIEUmQJJ2uUaSqdWtpLJl4rKH077cfPMR"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/4] tests/pxe-test: Test net
 booting over IPv6 in some cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LIEUmQJJ2uUaSqdWtpLJl4rKH077cfPMR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.12.2017 13:56, David Gibson wrote:
> On Fri, Dec 15, 2017 at 12:10:56PM +0100, Thomas Huth wrote:
>> On 15.12.2017 11:16, David Gibson wrote:
>>> This adds IPv6 net boot testing (in addition to IPv4) when in slow te=
st
>>> mode on ppc64 or s390.  IPv6 PXE doesn't seem to work on x86, I'm gue=
ssing
>>> out BIOS image doesn't support it.
>>>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
>>>  tests/pxe-test.c | 26 ++++++++++++++++++++------
>>>  1 file changed, 20 insertions(+), 6 deletions(-)
>> [...]
>>>      } else if (strcmp(arch, "ppc64") =3D=3D 0) {
>>> -        test_batch(ppc64_tests);
>>> +        test_batch(ppc64_tests, g_test_slow());
>>>          if (g_test_slow()) {
>>> -            test_batch(ppc64_tests_slow);
>>> +            test_batch(ppc64_tests_slow, true);
>>>          }
>>
>> The NICs from ppc64_tests_slow are now never exercised with IPv4 ...
>> maybe it would be better to do both:
>=20
> Yes they are: the ipv6 parameter to test_batch() makes it do IPv6
> tests in addition to IPv4, unlike test_pxe_one() which just does one
> or the other.

Ah, right, my bad, I mixed that up. And since we do not have any machine
that can only do IPv6 but not IPv4, it's fine that test_batch() does
both, so never mind, please ignore my above comment.

 Thomas


--LIEUmQJJ2uUaSqdWtpLJl4rKH077cfPMR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJaM9kVAAoJEC7Z13T+cC21HJgQAJ0DTI48281xlM5jHd08TZLV
yF6gzi2oBS2ckpIc02HXL8JBc/+dFhz/0OgtEQTMcYDu8HbcsrwEBZM8DpexaWqk
BFRx9FVxUiCP+rC4RdAySHQcWv8NTjyltGG0bMv1JgzTnvymbDfDn6kV2Sj0ezB6
QfH9wDRFrVfQ1Hh7/sIC36jwlpKROUTQUGizmS9vlfoRxFDhnazeJZM6GhuE2UCH
4gfs+ocSySEgMs9KAkdUfjSD9TxT2UwwYeyOMr/THllj18pX5oGkb9YhOa8cI4Gr
2ky6zOgKB/jpJNJ0VuJW8HnS8iZ8OsajncF16eEZVG22xy05oAy7yIAyl0N8jUi9
TKjRE3gGxYmMl5HngCO/Ou6peekZQmClZuJYvlmNPVIhvdaRgvIDtf0fulDZpUn/
/vPpXHUhh7VSUyth4K8g4AUviLjlBJyOpb8YOh7ix3tvCruCnC7OOJhKOvfx4VGz
OyCpgSFfLYFlI+k6Ehwp2aqv9seMCKcKcdPWZj67+V10z7N/dl0zOa9Qlak91XLp
68cdNs+vMckIsfy9pYQria9nd8l1kDI/lfRbh/A89Iq/8EcEKJY4gQBGM1ttBI0r
eLGw6YS5dHR457hG1k1rxPho0e8hF+uet7d9Ea3XhJKoZUoPYXprDZvZKlsnEbAw
sMMS2yKpw2BC+UItpnVQ
=j/R5
-----END PGP SIGNATURE-----

--LIEUmQJJ2uUaSqdWtpLJl4rKH077cfPMR--
