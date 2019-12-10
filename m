Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D579C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023BA2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023BA2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iej0f-0001iv-4b
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 12:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ieizl-0000eV-VW
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ieizk-0003u4-SA
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:08:21 -0500
Received: from 19.mo7.mail-out.ovh.net ([178.33.251.118]:55515)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ieizk-0003tF-MN
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:08:20 -0500
Received: from player759.ha.ovh.net (unknown [10.108.42.202])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 48EF81422EC
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 18:08:18 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id E7339D295964;
 Tue, 10 Dec 2019 17:08:12 +0000 (UTC)
Subject: Re: [PATCH 1/2] ppc/pnv: Loop on the whole hierarchy to populate the
 DT with the XSCOM nodes
To: Greg Kurz <groug@kaod.org>
References: <20191210135845.19773-1-clg@kaod.org>
 <20191210135845.19773-2-clg@kaod.org>
 <20191210174901.6215ddd4@bahia.tlslab.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5f5fb7b7-32a1-29d6-d197-9759a27af69f@kaod.org>
Date: Tue, 10 Dec 2019 18:08:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191210174901.6215ddd4@bahia.tlslab.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 15060318629322984256
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelfedgleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.118
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/2019 17:49, Greg Kurz wrote:
> On Tue, 10 Dec 2019 14:58:44 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> Some PnvXScomInterface objects lie a bit deeper (PnvPBCQState) than
>=20
> I didn't find any trace of PnvPBCQState in the code... what is it ?

PHB4, which is not merged yet. =20

C.=20

>=20
>> the first layer, so we need to loop on the whole object hierarchy to
>> catch them.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/pnv_xscom.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
>> index bed41840845e..006d87e970d9 100644
>> --- a/hw/ppc/pnv_xscom.c
>> +++ b/hw/ppc/pnv_xscom.c
>> @@ -326,7 +326,12 @@ int pnv_dt_xscom(PnvChip *chip, void *fdt, int ro=
ot_offset)
>>      args.fdt =3D fdt;
>>      args.xscom_offset =3D xscom_offset;
>> =20
>> -    object_child_foreach(OBJECT(chip), xscom_dt_child, &args);
>> +    /*
>> +     * Loop on the whole object hierarchy to catch all
>> +     * PnvXScomInterface objects which can lie a bit deeper the first
>=20
> s/deeper the first/deeper than the first/
>=20
>> +     * layer.
>> +     */
>> +    object_child_foreach_recursive(OBJECT(chip), xscom_dt_child, &arg=
s);
>>      return 0;
>>  }
>> =20
>=20


