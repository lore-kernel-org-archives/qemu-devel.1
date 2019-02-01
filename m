Received: from eggs.gnu.org ([209.51.188.92]:33459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gpTFL-0003KK-MV
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 02:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gpTFJ-0006n7-N0
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 02:28:19 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:44202
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1gpTFH-0006kn-Sg
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 02:28:16 -0500
References: <20190129113921.21599-1-berrange@redhat.com>
	<20190129113921.21599-2-berrange@redhat.com>
	<f87b8474-ade5-2586-1dcf-9eef25bb3055@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <d518919e-b071-ff15-36d1-9d9b5e5077e3@weilnetz.de>
Date: Fri, 1 Feb 2019 08:28:01 +0100
MIME-Version: 1.0
In-Reply-To: <f87b8474-ade5-2586-1dcf-9eef25bb3055@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="keP58GamwDEd21TroeN5S6HNca4Y8dPAD"
Subject: Re: [Qemu-devel] [PATCH 1/5] nsis: don't install files into /tmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Adam Baxter <voltagex@voltagex.org>, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--keP58GamwDEd21TroeN5S6HNca4Y8dPAD
From: Stefan Weil <sw@weilnetz.de>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Adam Baxter <voltagex@voltagex.org>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <d518919e-b071-ff15-36d1-9d9b5e5077e3@weilnetz.de>
Subject: Re: [Qemu-devel] [PATCH 1/5] nsis: don't install files into /tmp
References: <20190129113921.21599-1-berrange@redhat.com>
 <20190129113921.21599-2-berrange@redhat.com>
 <f87b8474-ade5-2586-1dcf-9eef25bb3055@redhat.com>
In-Reply-To: <f87b8474-ade5-2586-1dcf-9eef25bb3055@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.01.19 22:07, Eric Blake wrote:
> On 1/29/19 5:39 AM, Daniel P. Berrang=C3=A9 wrote:
>> The nsis installer target has to run 'make install' to populate a
>> directory tree with content for the package. Replace the current
>> usage of '/tmp/qemu-nsis' with a location underneath the build
>> directory. This ensures that when a developer cleans their build
>> directory, any left over files from the installer build process
>> are also purged.
>>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>  Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>=20
> Should "qemu-nsis-vroot/" be added to .gitignore for the sake of in-tre=
e
> builds?

Yes. I suggest to use INSTDIR=3D$(BUILD_DIR)/qemu-nsis-vroot.tmp. Then it=

is already covered by the existing pattern *.tmp in .gitignore.

With that modification

Signed-off-by: Stefan Weil <sw@weilnetz.de>

>=20
>> diff --git a/Makefile b/Makefile
>> index de898eab62..362a98d275 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -907,7 +907,7 @@ endif
>>  .PHONY: installer
>>  installer: $(INSTALLER)
>> =20
>> -INSTDIR=3D/tmp/qemu-nsis
>> +INSTDIR=3D$(BUILD_DIR)/qemu-nsis-vroot
>> =20
>>  $(INSTALLER): $(SRC_PATH)/qemu.nsi
>>  	$(MAKE) install prefix=3D${INSTDIR}
>>
>=20



--keP58GamwDEd21TroeN5S6HNca4Y8dPAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESSNv6nXJXWmOwreK4Iwh1Wd0UK0FAlxT9QgACgkQ4Iwh1Wd0
UK0jJA/+MwRncajYJ2dwSfIfu1T6gJ6U4Hq90AgiPId7yBKMShuWBsagtUEY6lEi
Xlj5i2qdDBLMQh7akeYx0g3OANMp8RLmyhjLsXV7rr8li1n5xO4WRSMi9lDMCh6n
wwnkxw4YTz9DZsbxsJbtJRHvKi8rKaUbP8H/9R9Fx4DIySzHRnAtx8pkivf0Thoa
WWe3MVGuyEeDxW/vXEhFZNzARfIjSj4nYo5wWvesuFisksahD1yq1mZwZM0CwuUz
alyk46zfSOGaL8YpI5ZuxIBT6aSkyNg2XC9V1j56cFuiF5GRnGHXNTRCozDlsP8x
g0Y6CBWyvLnCgtHUA0O6HmR1IxRXe1C0svJ8P2f0io+UplZnozVUdMpHL9LQrNXE
ld8EWngKZEON011lpKCBWZg6I2JqdK0wkhEbz7Pwnj8yyxxWsWWDWsR5QzCTZ+Nw
SR/7v+tbEjbPYGG2XsmHubQrEePS0HNWRojhhtysZCi6tP+A8hheRQ4bCU3rQ6in
LvcIzRij1LZb+ob8WIBQJSvmcgHrEZTFw+ZvFfzHL1mFtRCfe+4cUcIyNxJxkf0u
zowc9tW3xtBeNn/k8kEEG/84MDcDovSM//lnoH3En4oT/95S5EG4tOb3UAY7uYMS
Xs5WH2Eel6pMiYe8FDUA0Ikq4+hOtXoP2LbEhDwYtPFY0wrKqEg=
=cHJm
-----END PGP SIGNATURE-----

--keP58GamwDEd21TroeN5S6HNca4Y8dPAD--
