Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB558C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E76E21926
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hK10rada"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E76E21926
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpW0h-0003Qg-Qu
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 06:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40820)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpW0A-0001XI-6Y
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpW08-0007UC-NU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:57:06 -0400
Received: from ozlabs.org ([203.11.71.1]:55627)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpW06-0007Mq-Ai; Mon, 22 Jul 2019 06:57:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45sdpg0mBnz9sDQ; Mon, 22 Jul 2019 20:56:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563793019;
 bh=RxvRnDstaFgz5WELluwRQvpPMCDIp+Tsw2zH5hmOlNU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hK10radaWnN4c4iGAVuXX8bC29P1h98UqyAnUxjhx4JjbBNEiq65EBMyRe436jTJN
 5s8rBZGaDvBIE+1Eb0cVbMgq8BRLQ1PxVs3VW5J2tAOhtkm6TxIzcJmLuDDHPl5i7r
 FwgOJuNXt+J76yP/FZX1NPQ2SLjYxWf2efcza2Jo=
Date: Mon, 22 Jul 2019 18:29:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190722082911.GB25073@umbus.fritz.box>
References: <20190718115420.19919-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20190718115420.19919-1-clg@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2 00/17] ppc/pnv: add XIVE support for KVM
 guests
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2019 at 01:54:03PM +0200, C=E9dric Le Goater wrote:
> Hello,
>=20
> The QEMU PowerNV machine emulates a baremetal OpenPOWER system and
> acts as an hypervisor (L0). Supporting emulation of KVM to run guests
> (L1) requires a few more extensions, among which guest support for the
> XIVE interrupt controller on POWER9 processor.
>=20
> The following changes include some fixes for the PowerNV machine and
> provide support for XIVE escalations and interrupt resend. This
> mechanism is used by XIVE to notify the hypervisor that a vCPU is not
> dispatched on a HW thread. Tested on a QEMU PowerNV machine and a
> simple QEMU pseries guest doing network on a local bridge.
>=20
> The XIVE interrupt controller offers a way to increase the XIVE
> resources per chip by configuring multiple XIVE blocks on a chip. This
> is not currently supported by the model. However, some configurations,
> such as OPAL/skiboot, use one block-per-chip configuration with some
> optimizations. One of them is to override the hardwired chip ID by the
> block id in the PowerBUS operations and for CAM compares. This
> patchset improves the support for this setup. Tested with 4 chips.
>=20
> A series from Suraj adding guest support in the Radix MMU model of the
> QEMU PowerNV machine is still required and will be send later. The
> whole patchset can be found under :
>=20
>   https://github.com/legoater/qemu/tree/powernv-4.1

I've applied 1-8 to ppc-for-4.2, still looking at the rest.

>=20
> Thanks,
>=20
> C.
>=20
> Changes since v1:
>=20
>  - minor extra fixes=20
>  - split the escalation support in different patches
>  - kept the XiveRouter type for XiveTCTX back pointer (will address
>    this in P10)
>  - removed pnv_xive_vst_size(). Really broken on indirect tables.
>  - improved the dump of the NVT table
>  - introduce pnv_xive_get_block_id()
>=20
>=20
> C=E9dric Le Goater (17):
>   ppc/xive: use an abstract type for XiveNotifier
>   ppc/pnv: add more dummy XSCOM addresses for the P9 CAPP
>   ppc/xive: Implement TM_PULL_OS_CTX special command
>   ppc/xive: Provide backlog support
>   ppc/xive: Provide escalation support
>   ppc/xive: Provide unconditional escalation support
>   ppc/xive: Provide silent escalation support
>   ppc/xive: Improve 'info pic' support
>   ppc/xive: Extend XiveTCTX with a XiveRouter pointer
>   ppc/xive: Introduce xive_tctx_ipb_update()
>   ppc/xive: Synthesize interrupt from the saved IPB in the NVT
>   ppc/pnv: Remove pnv_xive_vst_size() routine
>   ppc/pnv: Dump the XIVE NVT table
>   ppc/pnv: Skip empty slots of the XIVE NVT table
>   ppc/pnv: Grab the XiveRouter object from XiveTCTX in
>     pnv_xive_get_tctx()
>   ppc/pnv: Introduce a pnv_xive_get_block_id() interface to XiveRouter
>   ppc/pnv: quiesce some XIVE errors
>=20
>  include/hw/ppc/pnv_xive.h  |   3 -
>  include/hw/ppc/xive.h      |  21 +--
>  include/hw/ppc/xive_regs.h |  34 +++++
>  hw/intc/pnv_xive.c         | 210 +++++++++++++------------
>  hw/intc/spapr_xive.c       |   7 +-
>  hw/intc/xive.c             | 304 ++++++++++++++++++++++++++++++-------
>  hw/ppc/pnv_xscom.c         |  20 +++
>  7 files changed, 428 insertions(+), 171 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl01c9cACgkQbDjKyiDZ
s5J0fhAAwZiFuJrhf4BK9cifeoQrFCO8DjVOb+nr0heFJnkHPoUeIQVhaZZcWfak
5FqFrYhYj4zxerGqURfcN9cvVD0Ll06VqINaAAxt6UdkZmuTgv+gRJQiMLO1cWa0
mRQlvGueGIbPFwHhxn9nFqbAR56oxONUiZwJQq1XE+Mm1/OIw1sEaVGoXMcxh1WK
ut473dip8oDWIeWjRtv/eeyn8RvbKYbqY7OY36wgMEbMbYUGrSHob5U7+x11RSat
CN6FldtszLriq4Gkco/iHzzmq5UxEEfEVfLLGdRxwSfE26nG0C2mtVmiONEKet59
Bdal50Y8tmok/qscOrO3WtBatzRappTlrIiMzNcd9tLwGwSzp5wmHP3N/xGnL/4b
TaoGOXaWGD+XvWQBjNputAaqxv5d2TdgqLEhnIXwf6MSTXs9lDnlc6X2rtANAB6K
qdOxiStRTBdPgGAXWknJ6WsXk7ABwpbP6J9Lrt9/pjEffEjjOUGgHVc1uk06jj4J
XEF8ciM4QFeNEwOsaMwiMuYcuAa/3QIu5W5zAWRJ6T149taNDnrFwvwytEYMAQvm
T/x7/uZbW3ZA91g0PzexdR5gPDXv/eiGIIqZNYGv62/Kq4Id8sX7UTyN2303UKtW
xjf/a6QdfxY7ip7OsdkbbEZWeo2yHl2cjewom902RTmY0NtRbws=
=TJX2
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

