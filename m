Received: from eggs.gnu.org ([2001:4830:134:3::10]:44221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cTdIE-0007Zw-5H
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 18:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cTdID-0002WO-7l
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 18:35:58 -0500
Date: Wed, 18 Jan 2017 09:09:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170117220940.GI15853@umbus>
References: <1484660269-14363-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2nTeH+t2PBomgucg"
Content-Disposition: inline
In-Reply-To: <1484660269-14363-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ppc: Remove unused function
 cpu_ppc601_rtc_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--2nTeH+t2PBomgucg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2017 at 02:37:49PM +0100, Thomas Huth wrote:
> It is completely unused, thus it can be removed without problems.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.9, thanks.

> ---
>  hw/ppc/ppc.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 8945869..f9a4b51 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -950,13 +950,6 @@ clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint=
32_t freq)
>  }
> =20
>  /* Specific helpers for POWER & PowerPC 601 RTC */
> -#if 0
> -static clk_setup_cb cpu_ppc601_rtc_init (CPUPPCState *env)
> -{
> -    return cpu_ppc_tb_init(env, 7812500);
> -}
> -#endif
> -
>  void cpu_ppc601_store_rtcu (CPUPPCState *env, uint32_t value)
>  {
>      _cpu_ppc_store_tbu(env, value);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2nTeH+t2PBomgucg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYfpYiAAoJEGw4ysog2bOS50IP/3aH2uO5VPY84a6EmwYXjsAA
7wTQ6M4TzsH44b1TOcUX+Z1W6SAWW8tLD0xwVywMR9gNGtlxdS4RMvJpfPKhayA1
eNcrKtF5iyIBG9RbGUMrjLbbIlmn7bm8bkAUvgExGidvNB5f71CcsxituAHmFMNz
8chIeyaiLOqcs5v27d7Q5dN9egUkcHYBL7TcxFuO3fIv5W7FurTHksJXgDwBjaQh
5jQFOp3NcA0EWDUM4FaBSPRtThc3NU4xglDPO9lxWTj9HqOG1q04wCNKAN0JJ8Mg
QzNZ4NjJ57qkd3vNMuinzv71eD3NFJ8Oz1YHGGDTApidp3xKm16u1jQYcs6zx+0X
Rs9iMnX6gM2WHPwLNLcmnvYfsjNskpyy+uG70UgO2qUBwCkXTcwC35i5s8lLGLqD
EeIIJizJBYh0fBFYtnM4kAgmtzAhaekW/2rwy8AF/S53ShChyJL3nuXCvo+UkfPX
F/SfmUYLWZW7KZopuGK2mNSBkDxFCUDh143UX9M1AyPB+Z62Wk3j9LkzN6/p/njR
qhyI2UujpHG+trqV7D1PQ3mGRzdE5ajEmgNAc78dkHysph4fGo5CiABBodqy7ltk
Nx5TcSC3v0gfZ+lozwvq0MknSgVjhcbWQTOSuSVk1riDfgnRzIvKHYN0J7swE4il
dBeirC23NYjTsUACD94d
=YZ0R
-----END PGP SIGNATURE-----

--2nTeH+t2PBomgucg--
