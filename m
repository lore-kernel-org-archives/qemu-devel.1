Received: from eggs.gnu.org ([2001:4830:134:3::10]:53075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsLsd-0008Vs-T8
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 00:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsLsc-0001NY-UJ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 00:35:59 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-32-eblake@redhat.com>
	<1a629362-ebc5-7d28-463c-f6ec4639d29b@redhat.com>
	<2bd66aa2-6052-bf14-4f7d-c30fdcaff07d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ef215900-db07-c18f-f01a-fc6e9b0d224b@redhat.com>
Date: Thu, 14 Sep 2017 06:35:42 +0200
MIME-Version: 1.0
In-Reply-To: <2bd66aa2-6052-bf14-4f7d-c30fdcaff07d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="RUsmh0Avqr8U1VPXF1K317ab7tR72kSmv"
Subject: Re: [Qemu-devel] [PATCH v7 31/38] libqtest: Merge qtest_clock_*()
 with clock_*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, John Snow <jsnow@redhat.com>, armbru@redhat.com, "open list:Floppy" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RUsmh0Avqr8U1VPXF1K317ab7tR72kSmv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.09.2017 15:35, Eric Blake wrote:
> On 09/12/2017 05:45 AM, Thomas Huth wrote:
>> On 11.09.2017 19:20, Eric Blake wrote:
>>> Maintaining two layers of libqtest APIs, one that takes an explicit
>>> QTestState object, and the other that uses the implicit global_qtest,=

>>> is annoying.  In the interest of getting rid of global implicit
>>> state and having less code to maintain, merge:
>>>  qtest_clock_set()
>>>  qtest_clock_step()
>>>  qtest_clock_step_next()
>>> with their short counterparts.  All callers that previously
>>> used the short form now make it explicit that they are relying on
>>> global_qtest, and later patches can then clean things up to remove
>>> the global variable.
>>>
>=20
>>> @@ -446,7 +446,7 @@ int64_t qtest_clock_step(QTestState *s, int64_t s=
tep);
>>>   *
>>>   * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanosecon=
ds.
>>>   */
>>> -int64_t qtest_clock_set(QTestState *s, int64_t val);
>>> +int64_t clock_set(QTestState *s, int64_t val);
>>  Could we please keep the "qtest" prefix here and rather get rid of th=
e
>> other ones? Even if it's more to type, I prefer to have a proper prefi=
x
>> here so that it is clear at the first sight that the functions belong =
to
>> the qtest framework.
>=20
> I suppose we can, although it makes more lines that are likely to bump
> up against 80 columns, and thus slightly more churn to reformat things
> to keep checkpatch happy.  I like the shorter name, because less typing=

> is easier to remember.  I'd prefer a second opinion on naming before
> doing anything about it though - Markus or Paolo, do you have any
> preference?

IMHO you should at least keep the qtest prefix in patch 33/38 to avoid
confusion with the system definitions that have the same names (see "man
2 outb" for example).

 Thomas


--RUsmh0Avqr8U1VPXF1K317ab7tR72kSmv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZugcjAAoJEC7Z13T+cC21k8EP+QF2SBaT5aWSjOTnUdkGc8zZ
r9XtQaXZoWkmTxl2fYQpz1NkFw/K/4B//q9eNVlPM9xMAMKPn3mg2tL7qoMKwstv
LyVbWv1ce/SdRK7n8VE4/QssEr2Nevl1irTRSeS+30azhoP6YDQItrYPKFF4yaSg
kLSIfKJaK6hpnl5x3CBeGf5lh+Ntp3rduiTf6g7WaJ9pSrwNbybevCPou7lpO/jn
Gdfv2AtSWFUETFH0OM97yqniWIRccgumgQoxx1ItqRPeY/NJcKd1IFeaxZxjQWPA
9wRDBu0bU6gEFPKAjxiPNJ7Tqg7lbcuS3Y9QNGepX2SPS9sZcWj0LU88eg9ZJ+JH
JQst3GxqnbAl47IXZcG9PZPdU4zJsBecX5iUlYVcrQMXquqWF8fI9BxDJmHEYJei
qiumKXaeWvGKal32SCs4g0iCrhU615WEvl1587wUvDR97cSSNCPYbXKuNXw1IcA3
b9/6GmlSqPlDTfkVcigENC1ZTpt39m736wLfuwsofDLRE+6DToZBSRcmk1aP5aLR
+zxYIr1Gt8zB6Y3jpu0xsFRGjr/SEhvikUXewJBAh70O6wMRwYJqZe8JBtiR2Pch
x1mgp6sbsjSjPCxRfJtG3M70pAMQL8kYJg3Kd2FHCFnlWqrx+ynSSfioSXL/wSAH
0Qmq4za+QzZ3FUg0rqnd
=pMhj
-----END PGP SIGNATURE-----

--RUsmh0Avqr8U1VPXF1K317ab7tR72kSmv--
