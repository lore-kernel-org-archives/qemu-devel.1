Received: from eggs.gnu.org ([2001:4830:134:3::10]:59048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXUa2-0003Ix-3J
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXUZy-00052R-TR
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:10:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eXUZy-000519-Is
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:10:46 -0500
References: <20180103214925.16677-1-f4bug@amsat.org>
	<20180103214925.16677-2-f4bug@amsat.org>
	<58860a06-3d3f-ab2a-90ea-dd56dfbe9d79@redhat.com>
	<d393de05-84a7-4053-65be-dfdbdbdb4e43@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7a1740ae-37af-7b1b-85c9-ca491c078378@redhat.com>
Date: Fri, 5 Jan 2018 10:10:35 -0600
MIME-Version: 1.0
In-Reply-To: <d393de05-84a7-4053-65be-dfdbdbdb4e43@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="R3GllQEIR9lnOIydC7MUTKCY4ID0DJRX5"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] sdbus: add a QMP command to access
 a SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R3GllQEIR9lnOIydC7MUTKCY4ID0DJRX5
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Alistair Francis <alistair.francis@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <7a1740ae-37af-7b1b-85c9-ca491c078378@redhat.com>
Subject: Re: [PATCH v2 1/4] sdbus: add a QMP command to access a SDBus
References: <20180103214925.16677-1-f4bug@amsat.org>
 <20180103214925.16677-2-f4bug@amsat.org>
 <58860a06-3d3f-ab2a-90ea-dd56dfbe9d79@redhat.com>
 <d393de05-84a7-4053-65be-dfdbdbdb4e43@amsat.org>
In-Reply-To: <d393de05-84a7-4053-65be-dfdbdbdb4e43@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2018 10:06 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Eric,
>=20
> On 01/05/2018 12:29 PM, Eric Blake wrote:
>> On 01/03/2018 03:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Use Base64 to serialize the binary blobs in JSON.
>>> So far at most 512 bytes will be transfered, which result
>>
>> s/transfered/transferred/
>>
>>> in a 684 bytes payload.
>>> Since this command is intented for qtesting, it is acceptable.
>>
>> s/intented/intended/
>>
>> Might be worth mentioning the actual command name,
>> x-debug-sdbus-command, in the commit message to make future git log
>> trawling easier.
>=20
> Ok.
>=20
> What about using 'x-qtest-sdbus-command'?

x-debug matches existing practice, x-qtest does not.  I'm fine with the
name you had chosen, and was just asking that it be mentioned in the
commit log.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--R3GllQEIR9lnOIydC7MUTKCY4ID0DJRX5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpPo3sACgkQp6FrSiUn
Q2oSBgf+OevDu2FxuHJYu5ioHPLoO0EuOmsqDRzsFm2XQB1XlpRLVD4uiXImAFH1
h+TSgfpyBRailWyIVWU1H5Ot3/H7aGW90GsnX4Uh0WkntJuPPeqbyrRO64hF1MSW
wIgN7rt9ttTVGI+9yftvmaXG/tw5HPC1dUvTFHzLz49jmOQXjufyDS8tfpJYH2lF
yFAfi8SAcFWvYcLTyA7tsLpCConndag3GQIfSR5KXTcoQAZs/6qHWVL860QDYJw4
lqtRQufOsuEZtTwRLJnQaQ6fxnzMvTAQPPFuLp3QknraYQTTtMNmIXoPI7F8/al6
shQXzXPb8uRQkDRhneDj9JnoNOdy5Q==
=LnSr
-----END PGP SIGNATURE-----

--R3GllQEIR9lnOIydC7MUTKCY4ID0DJRX5--
