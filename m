Received: from eggs.gnu.org ([2001:4830:134:3::10]:48923)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dIEfG-0007sW-Tx
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dIEfF-0004bu-WA
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:36:54 -0400
References: <20170531120049.14111-1-n54@gmx.com>
	<26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
	<df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
	<877f0p38tr.fsf@dusky.pond.sub.org>
	<b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <55dd32a9-7f01-93e3-e22e-3826dcef1d9d@gmx.com>
Date: Tue, 6 Jun 2017 15:38:36 +0200
MIME-Version: 1.0
In-Reply-To: <b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dVSm9psSvxvO3Pti0XiqNDm8uxMKWtbeh"
Subject: Re: [Qemu-devel] [PATCH v3] ivshmem-server: ivshmem-client: Build
 when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, marcandre.lureau@gmail.com, Peter Maydell <peter.maydell@linaro.org>, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dVSm9psSvxvO3Pti0XiqNDm8uxMKWtbeh
From: Kamil Rytarowski <n54@gmx.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 marcandre.lureau@gmail.com, Peter Maydell <peter.maydell@linaro.org>,
 f4bug@amsat.org
Message-ID: <55dd32a9-7f01-93e3-e22e-3826dcef1d9d@gmx.com>
Subject: Re: [PATCH v3] ivshmem-server: ivshmem-client: Build when eventfd()
 is available
References: <20170531120049.14111-1-n54@gmx.com>
 <26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
 <df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
 <877f0p38tr.fsf@dusky.pond.sub.org>
 <b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
In-Reply-To: <b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.06.2017 09:10, Michael Tokarev wrote:
> 06.06.2017 09:54, Markus Armbruster wrote:
>=20
> [ ./configure --disable-linux-user --disable-system --static ]
>=20
>> I haven't, but here's a quick guess on what we need to squash into the=

>> patch:
>>
>> diff --git a/Makefile b/Makefile
>> index c830d7a..2ef5a78 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -469,10 +469,12 @@ ifneq ($(EXESUF),)
>>  qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
>>  endif
>> =20
>> +ifdef CONFIG_IVSHMEM
>>  ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
>>  	$(call LINK, $^)
>>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
>>  	$(call LINK, $^)
>> +endif
>=20
> This effectively disables building ivshmem executables on this config
> on linux, while previously they were building fine. Hmm..
>=20
> /mjt
>=20

I've linked qemu with the original patch and:
=2E/configure --disable-linux-user --disable-system --static

I got some warnings, I think they are originated from our libc and are
not related to qemu:
  LINK    sparc64-bsd-user/qemu-sparc64
/usr/lib/libc.a(initfini.o): warning: common of `__ps_strings'
overridden by definition
/usr/lib/crt0.o: warning: defined here
/usr/lib/libc.a(_env.o): warning: multiple common of `environ'
/usr/lib/crt0.o: warning: previous common is here
/usr/lib/libc.a(getprogname.o): warning: common of `__progname'
overridden by definition
/usr/lib/crt0.o: warning: defined here
  LINK    x86_64-bsd-user/qemu-x86_64
/usr/lib/libc.a(initfini.o): warning: common of `__ps_strings'
overridden by definition
/usr/lib/crt0.o: warning: defined here
/usr/lib/libc.a(_env.o): warning: multiple common of `environ'
/usr/lib/crt0.o: warning: previous common is here
/usr/lib/libc.a(getprogname.o): warning: common of `__progname'
overridden by definition
/usr/lib/crt0.o: warning: defined here
  LINK    i386-bsd-user/qemu-i386
/usr/lib/libc.a(initfini.o): warning: common of `__ps_strings'
overridden by definition
/usr/lib/crt0.o: warning: defined here
/usr/lib/libc.a(_env.o): warning: multiple common of `environ'
/usr/lib/crt0.o: warning: previous common is here
/usr/lib/libc.a(getprogname.o): warning: common of `__progname'
overridden by definition
/usr/lib/crt0.o: warning: defined here

I will ask other NetBSD developers about __ps_strings, environ and
__progname.


--dVSm9psSvxvO3Pti0XiqNDm8uxMKWtbeh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZNrBmAAoJEEuzCOmwLnZsOM4P/2QJ1YoTP7wVrRWg26qEJUGn
+T3phNVp/9qY0FKOXyW/SsjM4M/ObBTe+PTphOwiZ+kGOCpW8vIKkUCjq8Q1f2ID
Zy2MfSmhPT5HjcVsMK2eeTeGGRHQuTPhGPFA+ZLXtc/BbDT8Hth60VYb7xxeJ363
R8s/FcpyzuraB0S03XBCMSPOGq53sjV8nPrNzDFVHxKLqcCtx7W/lZXxa17RMwVw
BFoUQxMt+iiugk6VpY45z7ODKIRZpICGyiIkFQWQXgOUbMCLnObpJsK25C0VB0N2
5+Kf4YBA3/C0+dGgfk13VU9T1BziB97VllJ7F68rESvfVnCHw7REqBZhp1tgxA6/
ozZCVyxia7jwd5Q66Xp7fFUA36FC2CTo6VKBF8svbw6QICZMZOHKxCIQ//OhUjg/
HfIG9GK7m6HKJi3jexOVTNuxI3kX2b2aty5MAA9AH18vjqMmz533ie1915Kz3Bfk
DsqIIe5YakPaxoB0+QEMwsrgP+x20oQP2psrv7vlB8ipTryQVAGL2AP+UFhFWGiv
fAR7dhmGoujgKPB0jhZT3whZI+cs+gtpl2raJ0Mocw7pYTSoFt2Wj61jSpNcwnSg
VoT+ntIePr1sDM+hI6tZnMjehEPC94nHO24lr9cR0Y7CfXkY7hTrvzwS1fZY9Qn7
ceYZbIG+fSgOdfQZrgsw
=1XN0
-----END PGP SIGNATURE-----

--dVSm9psSvxvO3Pti0XiqNDm8uxMKWtbeh--
