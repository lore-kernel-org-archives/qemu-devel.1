Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E68C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 00:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B387820702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 00:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oIgf9Gwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B387820702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8uZT-0000h2-0j
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 20:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8uXH-0007eo-Io; Thu, 20 Aug 2020 20:03:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60603 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8uXC-0008I8-Si; Thu, 20 Aug 2020 20:03:58 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BXhZD5jHPz9sTT; Fri, 21 Aug 2020 10:03:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597968228;
 bh=ZN8bDjEHPlM8t7mgEir4g+XQJZoPqTYloojVESGaSi8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oIgf9GwotQqIhNF93dfWT9eP/Nl0KsfJgIF4qDxrqlcRI6/eUcg3xF1PVrS720lUL
 3ZxhjdsN/TRF6Nn+D1fHrC5VNcO3ZnuaIBgQyhrPLdqVKq+XuyPHH8oNQ0fjOOL1IS
 5t+evBS2qglsLJDnuhIqIqyMd03gUG2PpK/0vQGk=
Date: Fri, 21 Aug 2020 08:54:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2] ppc/pnv: Add a HIOMAP erase command
Message-ID: <20200820225429.GS271315@yekko.fritz.box>
References: <20200820164638.2515681-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yLfVvEQOBD/VeTNx"
Content-Disposition: inline
In-Reply-To: <20200820164638.2515681-1-clg@kaod.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 20:03:50
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
Cc: Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, Klaus Heinrich Kiwi <klaus@linux.vnet.ibm.com>,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--yLfVvEQOBD/VeTNx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2020 at 06:46:38PM +0200, C=E9dric Le Goater wrote:
> The OPAL test suite runs a read-erase-write test on the PNOR :
>=20
>   https://github.com/open-power/op-test/blob/master/testcases/OpTestPNOR.=
py
>=20
> which revealed that the IPMI HIOMAP handlers didn't support
> HIOMAP_C_ERASE. Implement the sector erase command by writing 0xFF in
> the PNOR memory region.
>=20
> Cc: Corey Minyard <cminyard@mvista.com>
> Reported-by: Klaus Heinrich Kiwi <klaus@linux.vnet.ibm.com>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>=20
>  Changes in v2:
>=20
>  - Introduced IPMI_CC_UNSPECIFIED as suggested by Corey.

Applied to ppc-for-5.2 (replacing v1).

> =20
>  include/hw/ipmi/ipmi.h |  1 +
>  hw/ppc/pnv_bmc.c       | 29 ++++++++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
> index 8a99d958bbc3..c1efdaa4cb42 100644
> --- a/include/hw/ipmi/ipmi.h
> +++ b/include/hw/ipmi/ipmi.h
> @@ -53,6 +53,7 @@ enum ipmi_op {
>  #define IPMI_CC_INVALID_DATA_FIELD                       0xcc
>  #define IPMI_CC_BMC_INIT_IN_PROGRESS                     0xd2
>  #define IPMI_CC_COMMAND_NOT_SUPPORTED                    0xd5
> +#define IPMI_CC_UNSPECIFIED                              0xff
> =20
>  #define IPMI_NETFN_APP                0x06
>  #define IPMI_NETFN_OEM                0x3a
> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
> index 2e1a03daa45a..67ebb16c4d5f 100644
> --- a/hw/ppc/pnv_bmc.c
> +++ b/hw/ppc/pnv_bmc.c
> @@ -140,6 +140,27 @@ static uint16_t bytes_to_blocks(uint32_t bytes)
>      return bytes >> BLOCK_SHIFT;
>  }
> =20
> +static uint32_t blocks_to_bytes(uint16_t blocks)
> +{
> +    return blocks << BLOCK_SHIFT;
> +}
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
> @@ -155,10 +176,16 @@ static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cm=
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
> +            rsp_buffer_set_error(rsp, IPMI_CC_UNSPECIFIED);
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

--yLfVvEQOBD/VeTNx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8+/yMACgkQbDjKyiDZ
s5I45RAAl6hzLKWjEHCtTpuIYGwryV4KB1QnfofkUG8GFNXjbibnrcKuOj+D+pJX
JCmiNex0UxLBknWZ/6Mxt80pHNwEQYWPEdgEnNZ8Mw1DU7gOuIJ0f93ZyXKfPyNn
FvwLtCWzC80MsEqbRWJwLNwFNKrvMcXUGX/Iyi7IDhxZb9RTHvetZSO9ktzVUzOW
V9SGHOdeHHsqyinoIGagYnMSv46AgZUWpxrasXWoezylhupKzNBSmNvdqvtuCPFm
80AP2O5SHGmRbfKuCRtJ6+HBEM5qts7w4/4IZ6sCVz2xT62+84xU9sGsSecc5+y0
GJk4mnq9TXAXLIMCNpkoLbhRZUU7AYZEhlQYtFNs/+hPY7Du9cYPC7PgwFV07JJp
AMdpMcvctdCZQvDY5QULsEuhp+2HZTqu5yV9HNOBC/TeTHxNeGViS7t1euN4uEF4
WedjLr2S8MbHJ5p48nP7rehXw/EHMUvfqkBnbgV9zAXdrviZUavf/HjcjvsvfFwH
bhqm57bczhjpMWas7+P3JQSM7GIa2expzySDxcsJ34PFTJtbnX7P6wI5Yw7oYa2M
5JyjU3gcd/WfMLCxZnlJQ8pAJl1QhKcXMYb7xu4/gWNYUuKv3fvXVFIGwXv64cO+
8PH+fKdoggIeFMCmWQEMc0mxgDGp7Wxu8gYLGvqR9FRkUMYLivM=
=YMCW
-----END PGP SIGNATURE-----

--yLfVvEQOBD/VeTNx--

