Received: from eggs.gnu.org ([2001:4830:134:3::10]:53538)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gPjKa-0004qd-2T
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:23:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gPjKV-0004mX-MF
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:23:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:44119)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gPjKV-0004gy-7j
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:23:15 -0500
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
	<1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <adc671f3-808a-59ef-2650-2b558958a00f@gmx.com>
Date: Thu, 22 Nov 2018 08:24:02 +0100
MIME-Version: 1.0
In-Reply-To: <1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OT3Wfv3LobKQRwJ1cctmgq3lD7Ao8uZSF"
Subject: Re: [Qemu-devel] [PATCH] hax: Support for Linux hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alexandro Sanchez Bach <asanchez@kryptoslogic.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, yu.ning@intel.com, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OT3Wfv3LobKQRwJ1cctmgq3lD7Ao8uZSF
From: Kamil Rytarowski <n54@gmx.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Alexandro Sanchez Bach <asanchez@kryptoslogic.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, yu.ning@intel.com,
 Richard Henderson <rth@twiddle.net>
Message-ID: <adc671f3-808a-59ef-2650-2b558958a00f@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] hax: Support for Linux hosts
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
 <1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
In-Reply-To: <1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.11.2018 13:52, Paolo Bonzini wrote:
> On 14/11/18 14:04, Alexandro Sanchez Bach wrote:
>> Intel HAXM supports now 32-bit and 64-bit Linux hosts. This patch incl=
udes
>> the corresponding userland changes.
>>
>> Since the Darwin userland backend is POSIX-compliant, the hax-darwin.{=
c,h}
>> files have been renamed to hax-posix.{c,h}. This prefix is consistent =
with
>> the naming used in the rest of QEMU.
>=20
> What's the advantage of HAXM when Linux hosts can just run KVM?  I gues=
s
> avoiding bitrot?
>=20
> Paolo
>=20

This patch is also useful for NetBSD, even if it's not a Linux host.
There is a driver in progress again (thanks to the newly added Linux
port, it's now much easier to get done).

I recommend to merge this patch.


--OT3Wfv3LobKQRwJ1cctmgq3lD7Ao8uZSF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlv2WZIMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsdnwP/RvHPK/RTdd7izfDKx016HqEdvNnyIhkekKKtRMj
43VCR5lRhNndM5yFCQB+0c3bXcBJ+vqA3yuePI0CufQPfWWNCbuB8cp2cZ/+AGyH
SEGjAKsp/wP9DkExAdQFJszmG4FZDMSPJIIjdtQ8/uR/P6ZvcVS9eVxPoTjJIY+p
NsJ/+2xsf4ArTtCfYcxSLJufi5sAH9Rj9w5VHhtv4dHvOqJ2LmQb1b+bZMBGm3Ca
Z956BVfFXeEqIWdBd8LQqYQVPJT4COut39XVW99fNH5ouL/L1+1jWq7PyUZ0D2ZG
zNAFDafl6CsXfoWrpqUMTQHBJu/zyjxpBac/Sup8gI5ximAVgT2npSV6n3UdP7hv
5SRnL3ft+j24tPYCcg97zVcgJ/NcJx2JvzmgvXBzldPua3ePC6I0oVkdvd8Xe5a9
EemJeRHq2xD+/VIe/O6bMvGjM27tr6clm0EDc2BKSy+SnwpNh6u8zaViH5qiHO2s
0MEA6VFQ42EHYG+9W7p9fMmIyDPP0HzZGcA4s5vV1Mi5E0lcz7XBEm3vCoM2wVqU
QPJHOFACdyUl21cVqVPcE6XL+Jba6AkkE0HdWDWxH6hPsfP6pIqdwC8wzv5ehIOe
PvaMd508QARYnEtolF+jkywc0P+pYsAWg5C9sizS/FwlIuO+vwPfdK/9akGRqKc3
rruy
=4QTt
-----END PGP SIGNATURE-----

--OT3Wfv3LobKQRwJ1cctmgq3lD7Ao8uZSF--
