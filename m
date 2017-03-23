Received: from eggs.gnu.org ([2001:4830:134:3::10]:43748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqyai-0003u8-Gp
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqyaf-0006EX-GN
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:59:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cqyaf-0006EL-6X
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:59:29 -0400
References: <1490092792-30957-1-git-send-email-thuth@redhat.com>
	<1490092792-30957-2-git-send-email-thuth@redhat.com>
	<20170323085240.GJ16717@stefanha-x1.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d2b1fe30-8b83-82c7-fae5-7a77bff02805@redhat.com>
Date: Thu, 23 Mar 2017 09:59:18 +0100
MIME-Version: 1.0
In-Reply-To: <20170323085240.GJ16717@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="XFSXw70SgdCTGL9QoDtJcVaOlbSX6I8lS"
Subject: Re: [Qemu-devel] [PATCH 1/3] libqtest: Ignore QMP events when
 parsing the response for HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XFSXw70SgdCTGL9QoDtJcVaOlbSX6I8lS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.03.2017 09:52, Stefan Hajnoczi wrote:
> On Tue, Mar 21, 2017 at 11:39:50AM +0100, Thomas Huth wrote:
>> When running certain HMP commands (like "device_del") via QMP, we
>> can sometimes get a QMP event in the response first, so that the
>> "g_assert(ret)" statement in qtest_hmp() triggers and the test
>> fails. So ignore such QMP events when looking for the real
>> return value from QMP.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/libqtest.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>=20
> qmp.py keeps a queue of events so they can be processed later.  I guess=

> an event queue will be needed eventually because discarding events make=
s
> it hard to write reliable test cases that check for events.

Yes, but in that case the test likely should not use the hmp() functions
at all and use qmp directly.

> But as long as current qtests work correctly:
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks!

 Thomas




--XFSXw70SgdCTGL9QoDtJcVaOlbSX6I8lS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY045rAAoJEC7Z13T+cC21kdwP/0Sxw22qWRg0GRobGDh360Q3
ihUnjKJjjONY3FT5Y4raRbN+hL+XVOZt/yLA5MRVxdO7yrIqepuHIHkq6WpAlZRB
RDler2nAwAEGHwQc0nXG1VHaX1+kyiylFQ80Q0u71FLxd/nCwTkyy+juSnQIQ1vC
Rgee4D7y9C5FF5f2/4UFxBSLdjHmjtevY5dLTz2QZ1MRFQi8+x7YT8kEHEDNWn5v
mUCaCHNjWUexRCVDCwlnABknw2zrJWB7zzlwXCZilXYu5fP0SCiTqb6QrZ+A1IA9
K+JC5SjiBIjAE/fIaQF+Imppn4ypcyFXBEX3SCZAcvsD7au3eucwDQ4W0QACDKxn
dUsXF1qd2e7HkuP2mYUdhzuJksU8Flemh6Hb+CoGweI1YHUPgTk6z7G908wj/EcA
8E9pyff77BHchLKQhKMl6TDUymG5l5P+ETEDc7uUgdlQFz74k13MoKKQZR4g1s9h
e3Rh5kmOkl87v1u6oSGLW7kUM+X4PPaE6F+K32jF7yIkP/G7ZaK/z9tR7ijL3TLt
oC0Z7fT/obr/f0czBWVgcF28xEocLcXqrjhw6QhfyMQbb7mFGHOpUIA8FfJ6pfud
afTK+nPZY95AdEYLcvRAsLZfA0HuZMss27I0/uLQTz2bSwpiZ+bbxMmKm2oDiZKv
KINTiwU5RKF3Ae2QuUuY
=9wl1
-----END PGP SIGNATURE-----

--XFSXw70SgdCTGL9QoDtJcVaOlbSX6I8lS--
