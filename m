Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADFDC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 11:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180AB20855
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 11:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VjwyxcoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180AB20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8ifL-0007Nb-AZ
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 07:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8iem-0006qG-VR; Thu, 20 Aug 2020 07:22:56 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49039 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8iej-0001gd-N1; Thu, 20 Aug 2020 07:22:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BXMh73zlrz9sTQ; Thu, 20 Aug 2020 21:22:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597922567;
 bh=4uOtPe8jWbeg17tzHO+6PKeOLv3FEQhRphdU/UTXyHE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VjwyxcoVuzf7djCSeiZuUU5ftU3tzS/pEq3z9addF9+vIbg/95BCUkSX9rxmGckZU
 xoFnFP15PkfzjVyZJ9SXnSTzTw7Jqjd7UmpvsL2NZQ6QyGPB5KLSZRoSAAZyPihbCI
 wXYaY4xi8E1uzhNJ+nXmxck+V8FayS2RwmqG7Hrk=
Date: Thu, 20 Aug 2020 20:12:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Add a HIOMAP erase command
Message-ID: <20200820101244.GP271315@yekko.fritz.box>
References: <20200820073650.2315095-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wg9FEZT+WCTrEXgJ"
Content-Disposition: inline
In-Reply-To: <20200820073650.2315095-1-clg@kaod.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 07:22:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 Klaus Heinrich Kiwi <klaus@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wg9FEZT+WCTrEXgJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2020 at 09:36:50AM +0200, C=E9dric Le Goater wrote:
> The OPAL test suite runs a read-erase-write test on the PNOR :
>=20
>   https://github.com/open-power/op-test/blob/master/testcases/OpTestPNOR.=
py
>=20
> which revealed that the IPMI HIOMAP handlers didn't support
> HIOMAP_C_ERASE. Implement the sector erase command by writing 0xFF in
> the PNOR memory region.
>=20
> Reported-by: Klaus Heinrich Kiwi <klaus@linux.vnet.ibm.com>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.2.

> ---
>  hw/ppc/pnv_bmc.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
> index 2e1a03daa45a..0fb082fcb8ee 100644
> --- a/hw/ppc/pnv_bmc.c
> +++ b/hw/ppc/pnv_bmc.c
> @@ -140,6 +140,29 @@ static uint16_t bytes_to_blocks(uint32_t bytes)
>      return bytes >> BLOCK_SHIFT;
>  }
> =20
> +static uint32_t blocks_to_bytes(uint16_t blocks)
> +{
> +    return blocks << BLOCK_SHIFT;
> +}
> +
> +#define IPMI_ERR_UNSPECIFIED            0xff
> +
> +static int hiomap_erase(PnvPnor *pnor, uint32_t offset, uint32_t size)
> +{
> +    MemTxResult result;
> +    int i;
> +
> +    for (i =3D 0; i < size / 4; i++) {
> +        result =3D memory_region_dispatch_write(&pnor->mmio, offset + i =
* 4,
> +                                              0xFFFFFFFF, MO_32,
> +                                              MEMTXATTRS_UNSPECIFIED);
> +        if (result !=3D MEMTX_OK) {
> +            return -1;
> +        }
> +    }
> +    return 0;
> +}
> +
>  static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_l=
en,
>                         RspBuffer *rsp)
>  {
> @@ -155,10 +178,16 @@ static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cm=
d, unsigned int cmd_len,
>      switch (cmd[2]) {
>      case HIOMAP_C_MARK_DIRTY:
>      case HIOMAP_C_FLUSH:
> -    case HIOMAP_C_ERASE:
>      case HIOMAP_C_ACK:
>          break;
> =20
> +    case HIOMAP_C_ERASE:
> +        if (hiomap_erase(pnor, blocks_to_bytes(cmd[5] << 8 | cmd[4]),
> +                        blocks_to_bytes(cmd[7] << 8 | cmd[6]))) {
> +            rsp_buffer_set_error(rsp, IPMI_ERR_UNSPECIFIED);
> +        }
> +        break;
> +
>      case HIOMAP_C_GET_INFO:
>          rsp_buffer_push(rsp, 2);  /* Version 2 */
>          rsp_buffer_push(rsp, BLOCK_SHIFT); /* block size */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wg9FEZT+WCTrEXgJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8+TJoACgkQbDjKyiDZ
s5LJlA/+KZUye56HpfUQr155c+vfeg/F+WvWQ8aILjUAfzSnbIG3OHIonSm7Oj77
kf02ieEhB2jPYFLADpf+P5Ippqz6N/Ty4/kntsrnR8B3iMIQEGqDByG1qb7GG84T
MxA+XiRukots2IbL0Hr33eThZaFcqobKJQQkx2MedK0LVRSybBLgl10du7VNb04d
aRmWpMexaOUBFalGBP67LaBBymtQHRYdmpS4vrKGcUBuRxqsSIdc63YNM2uU48m1
Vld5b73R4nXFURzUtR6C66cYD8cW5aoY9Nt3HK+rVUBtEFmPl16Vgkv74Dat0G3Z
PK/YfW/m11pFsMgXM1CrkmdEit3ZXFSJeAX4MTVeAwVuXR/qEfNnRAS/ain2Cpsn
kVGxT1jdunBqFaFr6StGZNF3Qd6jldtqgxn38mpAPlfCsyBKYOiatB3sI9P0i7xD
FqexXsWUW5WA7Sqf2AeH21HsTR0oYK4PM7EuBi85SYfU2Cw3PIp3tOwuy2wXOa8h
UZS9NQvK9EgvF4EmjESKisM+ZSr2UABEUTt8hrPtuV1D/8UZg4sE3hgTQlnKvVbk
akuMplcRTP1H1KwX3vSNtp8W317oMIps2hCJIyKnVI8jdW1G1uS7KevNTLxtjxn6
V1s++Tm+N4Hq/+6ztt2+894lID8HDTSkQCWedX24qRcZ8lpskD8=
=/O7O
-----END PGP SIGNATURE-----

--wg9FEZT+WCTrEXgJ--

