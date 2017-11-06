Received: from eggs.gnu.org ([2001:4830:134:3::10]:40896)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1eBl3X-0007h7-8E
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:19:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1eBl3T-0004qN-Tb
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:19:27 -0500
Received: from mout.gmx.net ([212.227.17.21]:58687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1eBl3T-0004pn-JA
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:19:23 -0500
References: <20171106005656.GC84093@humpty.home.comstyle.com>
	<CAFEAcA_2i0p9C3amtoB0o9Y4K83aCP7Gkw1cDqmLjrkLwJTZxg@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <5ed0a508-e22a-5d59-c826-54fa17afcf20@gmx.com>
Date: Mon, 6 Nov 2017 18:21:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_2i0p9C3amtoB0o9Y4K83aCP7Gkw1cDqmLjrkLwJTZxg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f66bIae8xG55N6311ACtsgXxwNVE5sqrV"
Subject: Re: [Qemu-devel] [PATCH] osdep: Deal with TIME_MAX and OpenBSD
 64-bit time_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f66bIae8xG55N6311ACtsgXxwNVE5sqrV
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <5ed0a508-e22a-5d59-c826-54fa17afcf20@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] osdep: Deal with TIME_MAX and OpenBSD 64-bit
 time_t
References: <20171106005656.GC84093@humpty.home.comstyle.com>
 <CAFEAcA_2i0p9C3amtoB0o9Y4K83aCP7Gkw1cDqmLjrkLwJTZxg@mail.gmail.com>
In-Reply-To: <CAFEAcA_2i0p9C3amtoB0o9Y4K83aCP7Gkw1cDqmLjrkLwJTZxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.11.2017 11:51, Peter Maydell wrote:
> On 6 November 2017 at 00:56, Brad Smith <brad@comstyle.com> wrote:
>> Define TIME_MAX to LLONG_MAX for OpenBSD since OpenBSD uses 64-bit tim=
e_t.
>>
>> Signed-off-by: Brad Smith <brad@comstyle.com>
>>
>>
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index 6855b94bbf..824714049b 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -132,8 +132,12 @@ extern int daemon(int, int);
>>  #define ESHUTDOWN 4099
>>  #endif
>>  #ifndef TIME_MAX
>> +#ifdef __OpenBSD__
>> +#define TIME_MAX LLONG_MAX
>> +#else
>>  #define TIME_MAX LONG_MAX
>>  #endif
>> +#endif
>=20
> I'm not really a fan of adding new OS-specific #ifdefs --
> what if one of the other BSDs uses or switches to 64-bit
> time_t for 32-bit platforms? Is there some way we can detect
> this generically at compile time (possibly in configure) ?
>=20

NetBSD 32-bit ports switched to 64-bit in 2009. There are no longer
supported releases with 32-bit time_t.

> thanks
> -- PMM
>=20



--f66bIae8xG55N6311ACtsgXxwNVE5sqrV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaAJovAAoJEEuzCOmwLnZsxQYQAKaQNqy1t6O0hRYrdpYV4xKl
I65Ko4dYtUae5upUdVM62O7r1WNf/3s6+vPjpw0CVB5HYARizgYrh9SJX9p+mKxF
P2+IFtGQSTJ1CbwCWp5Drjm+nnKF2sRjKoU0laAJuRslYpsWpaCjwgC4KLv+H7vj
HYvYag5ZcaqhYicavKvYfBiJPqYYSJtiMDT+6r+G3hU0GI9SqYaOoxaly2GQ452h
oDx31BQdmRXhIcPXytSz7wguIKOEbYguHwTgysvkabiBg8BN7ZIZz5oub4R7RxET
1Fdl4+T8HZM0F0ApgTBRY4cVMfS1HeucZZNIy9d7EkrbAYHNCFWPPZzwBaJSZacT
NpeVcY0yPD9VLXUfZZFzn376DvU57q/Ak6zs2Jkd0rr3ef9w/+enp4nv7oR/S7sT
AqCHevOub3Q4DsfAgwvfp9HPNrri+8arcowUgF1jhH20lCebqFIR85zrwr/3wCnx
yF7GtHOB9Qc7EHKgKbMZIF84spfuIo4B1MTR3vxZDzYL7A7XCV+r6s1XDPw1fn9S
6IxvkWO41XWJ9fW2fdvMT5AVapnjlCPupkaRAL1zVvRKLTSBt4/22/ipYtQilC/0
qznV85VKDAkyAbcaH3LeDT4nbK/AIsjSRfJVkYPKkwyS8JJ4iOlLizb5A8mzWDAH
b7b+5lUDMPE9z8+A72EF
=JIID
-----END PGP SIGNATURE-----

--f66bIae8xG55N6311ACtsgXxwNVE5sqrV--
