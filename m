Received: from eggs.gnu.org ([209.51.188.92]:59299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkWVx-0006JS-7s
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkWVw-0006Du-Fy
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:57:01 -0500
References: <20190117193658.16413-1-eblake@redhat.com>
	<20190117193658.16413-2-eblake@redhat.com>
	<20190118100257.GC20660@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <273740c7-c347-f79c-a776-c229bf35fcbf@redhat.com>
Date: Fri, 18 Jan 2019 09:56:51 -0600
MIME-Version: 1.0
In-Reply-To: <20190118100257.GC20660@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aEhI6DyYNtAF1ssnuEtZZHLNYiAz0gVc0"
Subject: Re: [Qemu-devel] [PATCH v4 01/21] iotests: Make 233 output more
 reliable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, nsoffer@redhat.com, rjones@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aEhI6DyYNtAF1ssnuEtZZHLNYiAz0gVc0
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, nsoffer@redhat.com, rjones@redhat.com,
 jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <273740c7-c347-f79c-a776-c229bf35fcbf@redhat.com>
Subject: Re: [PATCH v4 01/21] iotests: Make 233 output more reliable
References: <20190117193658.16413-1-eblake@redhat.com>
 <20190117193658.16413-2-eblake@redhat.com>
 <20190118100257.GC20660@redhat.com>
In-Reply-To: <20190118100257.GC20660@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/19 4:02 AM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Jan 17, 2019 at 01:36:38PM -0600, Eric Blake wrote:
>> We have a race between the nbd server and the client both trying
>> to report errors at once which can make the test sometimes fail
>> if the output lines swap order under load.  Break the race by
>> collecting server messages into a file and then replaying that
>> at the end of the test.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> CC: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>
>> ---
>> An alternative solution might be to silence the message from the
>> server by default, and output it only when -v was passed
>=20
> I wouldn't consider this an either/or situation. It is probably
> good practice to qemu-nbd to be completely silent wrt client
> problems so a malicious client can't spam the qemu-nbd log (if
> any). None the less it is also useful to have the iotests validate
> that this log message is printed.

Thus, the idea for future patches is to:
- teach qemu-nbd to be silent on client disconnects by default to avoid
a malicious client performing DoS by excessive logging,
- teach iotests to run qemu-nbd with -v to double-check what server
logs, as verbose server logs are quite handy when debugging why a
particular client can't connect

Now that the issue is public, is this something I should report to
secalert, or is it not at the level of a CVE?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--aEhI6DyYNtAF1ssnuEtZZHLNYiAz0gVc0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxB90MACgkQp6FrSiUn
Q2rzpwgAqOi13RIQM+dqLafOWmnX8qO9oSnhHgD9Pe7VJS1wLK/q8S8TMrxMBd5o
wwykvjiSvGTFXxEd6f43vPyNFDX7Hwnr4gwSq9CW0Yw1Kp0K6QKAfi5yIw41gFyE
FnLxoOz0aMi5OltETRXq/7+Y/q+KPGai3YPIRlW+59J74UK1r9cZepZe/3rZ/MUJ
Ir1+WAnijbXdZJXS6qcntPXPLcLLp2bsaY74KzQ4YzSWAOhjP0VodNsxwMBkl7GI
ZjWl59gL/n6HpowAKqLf9vE2NvxCVZmkwAn8HI59F17RejPu/JyHKK6N0HmXVkr0
VMreFG8te2qHyQd4RNTKgKnKQwZrfg==
=f+Y7
-----END PGP SIGNATURE-----

--aEhI6DyYNtAF1ssnuEtZZHLNYiAz0gVc0--
