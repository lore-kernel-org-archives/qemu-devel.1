Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499E5C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D1A2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D1A2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40875 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1eM-0002lg-CR
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41994)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hr1e8-0001wS-CJ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hr1e7-0007Fu-Ew
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:56:36 -0400
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:60695)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hr1e7-0007EE-9G
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:56:35 -0400
Received: from player159.ha.ovh.net (unknown [10.109.143.208])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id A459B13CD08
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 16:56:33 +0200 (CEST)
Received: from kaod.org (bad36-1-78-202-132-1.fbx.proxad.net [78.202.132.1])
 (Authenticated sender: clg@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id 3EFB9841A6FC;
 Fri, 26 Jul 2019 14:56:29 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
 <156415228410.1064338.4486161194061636096.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cea0e74f-3795-d43f-2d59-b841bbf28ba3@kaod.org>
Date: Fri, 26 Jul 2019 16:56:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156415228410.1064338.4486161194061636096.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1486469354537061203
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkeeggdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.36.149
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr/pci: Free MSIs during reset
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

On 26/07/2019 16:44, Greg Kurz wrote:
> When the machine is reset, the MSI bitmap is cleared but the allocated
> MSIs are not freed. Some operating systems, such as AIX, can detect the
> previous configuration and assert.
>=20
> Empty the MSI cache, this performs the needed cleanup.

This is fixing the reset bug.



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_pci.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index bc22568bfa71..e45507bf2b53 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2078,6 +2078,8 @@ static void spapr_phb_reset(DeviceState *qdev)
>      if (spapr_phb_eeh_available(SPAPR_PCI_HOST_BRIDGE(qdev))) {
>          spapr_phb_vfio_reset(qdev);
>      }
> +
> +    g_hash_table_remove_all(sphb->msi);
>  }
> =20
>  static Property spapr_phb_properties[] =3D {
>=20


