Received: from eggs.gnu.org ([2001:4830:134:3::10]:48193)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dwrUz-00050g-S3
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 11:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dwrUt-0004T4-Md
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 11:10:13 -0400
Received: from mout.gmx.net ([212.227.17.20]:57151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dwrUt-0004SR-CD
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 11:10:07 -0400
References: <CAEgYsbFZGT3GARy7LEkU7uvb4__Xg6AdA2oU9wHtctmKhewkmw@mail.gmail.com>
	<CAFEAcA_UDk4cwtq4G_XArGCH4LC3hLUnmVHO28RJnm+7=YD_BA@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <d7ee828f-bb57-0543-ceba-aaaf82d550d9@gmx.com>
Date: Tue, 26 Sep 2017 17:12:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_UDk4cwtq4G_XArGCH4LC3hLUnmVHO28RJnm+7=YD_BA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bq5dnamrWct8F2UCdaOAXCcQjv6Q4vGxM"
Subject: Re: [Qemu-devel] SunOS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Peter Tribble <peter.tribble@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jonathan Perkin <jperkin@joyent.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bq5dnamrWct8F2UCdaOAXCcQjv6Q4vGxM
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Peter Tribble <peter.tribble@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Jonathan Perkin <jperkin@joyent.com>
Message-ID: <d7ee828f-bb57-0543-ceba-aaaf82d550d9@gmx.com>
Subject: Re: [Qemu-devel] SunOS support
References: <CAEgYsbFZGT3GARy7LEkU7uvb4__Xg6AdA2oU9wHtctmKhewkmw@mail.gmail.com>
 <CAFEAcA_UDk4cwtq4G_XArGCH4LC3hLUnmVHO28RJnm+7=YD_BA@mail.gmail.com>
In-Reply-To: <CAFEAcA_UDk4cwtq4G_XArGCH4LC3hLUnmVHO28RJnm+7=YD_BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Peter Tribble,

Please see in-line.

On 22.09.2017 14:05, Peter Maydell wrote:
> On 20 September 2017 at 19:50, Peter Tribble <peter.tribble@gmail.com> =
wrote:
>> To introduce myself: I'm a member of the illumos community (the succes=
sor
>> to OpenSolaris, to those unfamiliar with us), and I maintain my own il=
lumos
>> distribution.
>>
>> Having seen the scary 'SUPPORT FOR THIS HOST OS WILL GO AWAY'
>> message, I'm reaching out to see what needs to be done so that support=
 for
>> SunOS (not just illumos, I include Oracle's Solaris in the same family=
)
>> needs to be kept and, where possible, enhanced.
>>

Sorry, this is harsh but Oracle Solaris support is now irrelevant. It's
impossible (or harder) to buy new licenses, it's dead now. There is no
evidence that qemu worked on it in the last ~10 years...

Solaris10 will be soon EOL'ed for Premier Support customers..

Solaris in pkgsrc has problems with basic packages (like toolchain).. I
would be surprised that it can build all qemu's dependencies..

>> I'm willing to act as a contact in this effort, and can work with othe=
rs in
>> the illumos community to see if there are other resources we can bring=
 to bear.
>=20
> Hi; thanks for getting in touch with us. Kamil Rytarowski (who I've
> cc'd) is also interested in keeping Solaris-variant support working.
>=20

My interest starts on OSes using pkgsrc, and ends in the particular
SunOS case on SmartOS. Jonathan Perkin proposed to just fork older qemu
package for SmartOS in pkgsrc and I don't want to allow this to happen.
This motivates me to keep it alive upstream and retain 0 local patches.

I'm in process of upstreaming SmartOS support that should help to all
Illumos distributions. To reenable Illumos as a supported OS, please
follow the notes from Peter Maydell. I won't apply as a SmartOS
maintainer myself... at least in my free time.

> Essentially what we need as upstream is:
>  * access to a machine which we can use for our continuous
>    integration build testing, so we don't break compile
>    support for the platform. This is ideally a machine that
>    somebody else admins and we just use (because we don't
>    want to become solaris/illumos admins ;-)), but failing
>    that, instructions on how to get a VM running under
>    KVM on Linux would also be OK (that's how we've ended
>    up handling the BSDs)
>  * somebody to look at the places where 'make && make check'
>    currently fails and submit upstream patches for them. Kamil
>    has been doing a great job here but would probably
>    appreciate extra help :-)
>  * somebody who's willing to be listed in our MAINTAINERS file
>    as maintaining the port, so we can ask them questions if/when
>    any platform-specific issues come up in future
>=20
> Overall we're happy to continue to support hosts that people
> are still using -- we just want to avoid blindly maintaining
> code for platforms we can't test and where we don't have
> any idea if anybody's even using it (for instance we just
> dropped the support for AIX and for Itanium CPUs...)
>=20
> thanks
> -- PMM
>=20



--bq5dnamrWct8F2UCdaOAXCcQjv6Q4vGxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZym5mAAoJEEuzCOmwLnZsokIQALx77evvmDDqYHLKEB7YYMGI
w8aDX3wJHCokyJqli/V86WsD7hrXCAD50LkJfLAgIE+cS4UlxEILe3CDCjtiiIH6
zCHqFDruucCu1ZqIDAopcZY53ne3U4p7ee16Kn/nU+1UJo7kvrbXDaLdQkwXAUcU
owHmz/y8Lx4WkgbAXiAw4zG8B1DnIEYB2R6vT+66lB95Z0x9wk76yHSI5qgpFRDf
mNK6vpJjC5va4hDvofJPmqDZOhavHsQEfR/cSEhUYHMYbM/unRwdOd4KcPeRvmNU
h6W5fpP0zyUMzXhVo64a/jfD2BNukl7GdxDaG8k55DD5nf7EwbxHSVwNPSGJ7k2j
QupWtqN3Q+hz1B5nLbyGkQMF/zi7jVbfz2fI9LErEpl3gtIEXdX30sB9fS5xzZCa
Bg6K569roF4YQsQD2e//Clk+nW3Afq5cx7iqLi9l6wce8OCCtgl6NE299OQtTe+y
lcQ0uxhDiqe85ZgqmjBv1Z0u3SeAz7xFycAgDguuA0TNprTi/AlINbCohbn6+mpx
j8hlsfeE6+ca7f6Lqf0RLmeBsoJ9YyV8Ijk3h7k4XCPEaObLXYx79d3DAO30H/4E
3GW+tMytLf5dvpFN58Ar4+/YJDgbdONb/t3cQoflrrIO90h6djTm/n18Mp/4R/9s
01fFFsRGJWbS2N1vocUV
=2kTC
-----END PGP SIGNATURE-----

--bq5dnamrWct8F2UCdaOAXCcQjv6Q4vGxM--
