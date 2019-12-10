Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9085C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 03:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F388206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 03:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="F3O7hnkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F388206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieWDh-0005AT-Hp
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 22:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ieWCw-0004Ke-0h
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 22:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ieWCu-00046I-HL
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 22:29:05 -0500
Received: from ozlabs.org ([203.11.71.1]:57885)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ieWCt-00042i-Ki; Mon, 09 Dec 2019 22:29:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47X5Bd0C3Zz9sR8; Tue, 10 Dec 2019 14:28:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575948537;
 bh=YsXuBeVVSYHyJPXgAlYRW41YMXffKCz9pRlSMuG1nVk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F3O7hnkJGFjR7nQJT/bkp8QMEokDX+1JYuV99S56U4DH1XDNlN8Pj4cV+Pjfna09l
 0LoP78KWYtsYb9NOAAa2XjTdznbq008RntiQ2i0D3s2L6smRQabDaHGWPfh00q0ni3
 ON9uMKK50H/6NWhLW51xFEvcV0poQxWH2hcibCuY=
Date: Tue, 10 Dec 2019 11:36:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 PATCH] ppc: Make PPCVirtualHypervisor an incomplete type
Message-ID: <20191210003613.GA207300@umbus.fritz.box>
References: <157589808041.21182.18121655959115011353.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <157589808041.21182.18121655959115011353.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2019 at 02:28:00PM +0100, Greg Kurz wrote:
> PPCVirtualHypervisor is an interface instance. It should never be
> dereferenced. Drop the dummy type definition for extra safety, which
> is the common practice with QOM interfaces.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.0.

> ---
>  target/ppc/cpu.h |    4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index e3e82327b723..ab7d07d66047 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1220,10 +1220,6 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr=
);
>  PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr);
>  PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc);
> =20
> -struct PPCVirtualHypervisor {
> -    Object parent;
> -};
> -
>  struct PPCVirtualHypervisorClass {
>      InterfaceClass parent;
>      void (*hypercall)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3u6HoACgkQbDjKyiDZ
s5IkkRAA5UBPCELfI25Um0hsuV1cMCn1FwumlBjnXStW7is9aAUmeUuTJw1yKwxY
K2uWL5yClEMD77x705fbIhcV02f+tMT/iyqm61nSqc7QN8zzd4AcUd8zfBfHpyXy
Sc3DMGy4f22KcobEad97YQhGCOa8PqQF9n1WcioI9oe/JFFaJHVyu/tvbq7YEbmf
dIzIDRIi2GakBLy72oCiSVSXTguvdINvUNIfBopyJxHCgh+r8dBGMb7/8wBgIdwC
/wbNDQv78qo71HeB9m3futiyYTLZpPan3reHNsJqWHYh+tX84YI0DiE5iXjQaTZw
lsryyTN3Z+E9UXch4aNjbuWoTy9QJqKwhBtXaqxvI9qSkageA1PovhnkQugi/YZ0
ykOFjINGXTA7hi/HjBlHsQweONpfk0+kuyoIULJFglUGgjq0nmHAD/m07Ufh0huH
xf48DbXw0H91ByqTPsTHbc1kOKqhLSbZBXAwrHaA8augQ23rzlGeOInBXAQzC4bR
KKDjLgvj10Yqj1H3ia3RuwCfwig6iSoqWbos2yMN/prrkA7OSsCRPUditbOOCs0s
ZY7ETJVdb2X/k+4+T7OPTJsH7qF6+HmOExLfRKitv1oA5ZhybxJJ1HmEDB2GpP7K
pEnUCwljJ4Od+KeM/te8WidsUuMuNwFJANzeif66suWHkwv1b7E=
=0dUk
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

