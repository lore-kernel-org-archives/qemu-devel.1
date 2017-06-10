Received: from eggs.gnu.org ([2001:4830:134:3::10]:38204)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dJiDl-0000it-NN
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 11:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dJiDi-0001BM-Jt
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 11:22:37 -0400
References: <20170531120049.14111-1-n54@gmx.com>
	<26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
	<df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
	<877f0p38tr.fsf@dusky.pond.sub.org>
	<b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
	<55dd32a9-7f01-93e3-e22e-3826dcef1d9d@gmx.com>
	<CAFEAcA_2X6QRBS_mbL15Rkq51HxTAX-vb9TJQxKMnwuRsixkiw@mail.gmail.com>
	<6620e2b9-6cc7-48fc-6ecf-4065718d765d@gmx.com>
	<cdc49669-c996-b84d-8110-b7b62ada8ad0@gmx.com>
	<87lgoz98mc.fsf@dusky.pond.sub.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <03bf9574-79a4-0778-bb6d-e0a6da7d1d86@gmx.com>
Date: Sat, 10 Jun 2017 17:24:28 +0200
MIME-Version: 1.0
In-Reply-To: <87lgoz98mc.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2juiJkaEGlkhpUkVj9t3SuFM1Mr1fhhCr"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v3] ivshmem-server:
 ivshmem-client: Build when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2juiJkaEGlkhpUkVj9t3SuFM1Mr1fhhCr
From: Kamil Rytarowski <n54@gmx.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Message-ID: <03bf9574-79a4-0778-bb6d-e0a6da7d1d86@gmx.com>
Subject: Re: [Qemu-trivial] [Qemu-devel] [PATCH v3] ivshmem-server:
 ivshmem-client: Build when eventfd() is available
References: <20170531120049.14111-1-n54@gmx.com>
 <26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
 <df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
 <877f0p38tr.fsf@dusky.pond.sub.org>
 <b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
 <55dd32a9-7f01-93e3-e22e-3826dcef1d9d@gmx.com>
 <CAFEAcA_2X6QRBS_mbL15Rkq51HxTAX-vb9TJQxKMnwuRsixkiw@mail.gmail.com>
 <6620e2b9-6cc7-48fc-6ecf-4065718d765d@gmx.com>
 <cdc49669-c996-b84d-8110-b7b62ada8ad0@gmx.com>
 <87lgoz98mc.fsf@dusky.pond.sub.org>
In-Reply-To: <87lgoz98mc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10.06.2017 17:15, Markus Armbruster wrote:
> Kamil Rytarowski <n54@gmx.com> writes:
>=20
>> On 06.06.2017 16:56, Kamil Rytarowski wrote:
>>> On 06.06.2017 16:34, Peter Maydell wrote:
>>>> On 6 June 2017 at 14:38, Kamil Rytarowski <n54@gmx.com> wrote:
>>>>> I've linked qemu with the original patch and:
>>>>> ./configure --disable-linux-user --disable-system --static
>>>>>
>>>>> I got some warnings, I think they are originated from our libc and =
are
>>>>> not related to qemu:
>>>>>   LINK    sparc64-bsd-user/qemu-sparc64
>>>>> /usr/lib/libc.a(initfini.o): warning: common of `__ps_strings'
>>>>> overridden by definition
>>>>> /usr/lib/crt0.o: warning: defined here
>>>>> /usr/lib/libc.a(_env.o): warning: multiple common of `environ'
>>>>> /usr/lib/crt0.o: warning: previous common is here
>>>>> /usr/lib/libc.a(getprogname.o): warning: common of `__progname'
>>>>> overridden by definition
>>>>> /usr/lib/crt0.o: warning: defined here
>>>>
>>>> Yes, I think I've seen those before on NetBSD -- they look
>>>> like a bug in your libc to me, it shouldn't be confusing itself
>>>> with itself like that :-)
>>>>
>>>> thanks
>>>> -- PMM
>>>>
>>>
>>> I have filed this bug upstream: http://gnats.netbsd.org/52278
>>>
>>>
>>
>>
>> What's the status with this patch?
>>
>> NetBSD build still breaks due to ivshmem-*.
>=20
> I guess Michael expects a v4 that doesn't break the static build.
>=20

-static works for me, I have restricted options to test build on !NetBSD
systems.

Was this patch ok?

diff --git a/Makefile b/Makefile
index c830d7a..2ef5a78 100644
--- a/Makefile
+++ b/Makefile
@@ -469,10 +469,12 @@ ifneq ($(EXESUF),)
 qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif

+ifdef CONFIG_IVSHMEM
 ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
+endif


So I could amend it.


--2juiJkaEGlkhpUkVj9t3SuFM1Mr1fhhCr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZPA8yAAoJEEuzCOmwLnZsGcoP/RYXz5nV9ax0Cc/ahNpTtvUv
nbhhQB7mfdd9NXpL/1I+mLMP/wT49IFMVQWfhmzPlLtlJiCCSJrTGgjsFuOzRdeF
ZGV09U/kMFhCCanO+ijSJV+GzKGzml3K99vAraz3RNpnEGlAeZWfOXNlIYJkdc7v
v45ipeYL90Ppxl1+BTZeSUyTXI8Tr2wwScKtbFqNi7OQ6oDGc4vUC4AfyfwmTFLU
jHJx5SdKjmoSws4oS1UD/gxzTUnbWUeYkBPhlDOqO/odnXa1/hA+5XLDCefHcwBN
TEw3BwfuTnNDACVLUmxkn5f/JbH0uoXmNGC+UMotdEmTLq+v93Z3rK+bIjYCxWiJ
w4aaEgs/bkJMYV0JQZaOe/1Mt+wwP20nFt7s9ViljujDj8mhYouPXDMnnUHQJsZ4
oGzo7/dVlOUqMlYNBqapUcDeesSQBgk8wClPBlkS87tB8P7o9XMhrgJEfBGs8UHV
w7x2QEw9KJ7kjCagRpnoI/cvW5fQFL/RAHqMUuiPMsJbqqaOtFY/BeG6lrZgIrSJ
NLA1HVaMwGxUpyLbaipTwfSig3GgexlFCtbvgKoOrRdzCsx1AZPvO5oTM0YrmVKn
5pf9IsKsBzH5gWi7vy+KlQLFFd+SqF4px1bI4i8stYtK52c7Z01OGoIuIzYPOmGZ
wk8vRXjx/iXTLYd891kC
=Y17P
-----END PGP SIGNATURE-----

--2juiJkaEGlkhpUkVj9t3SuFM1Mr1fhhCr--
