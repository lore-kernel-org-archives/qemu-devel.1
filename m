Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198C6C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34C32073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34C32073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iej1E-0002FG-3M
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 12:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iej06-0001AE-Ug
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iej05-0003zA-U7
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:08:42 -0500
Received: from 13.mo7.mail-out.ovh.net ([87.98.150.175]:60897)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iej05-0003yo-Nf
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:08:41 -0500
Received: from player786.ha.ovh.net (unknown [10.109.146.166])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 1F7981420DC
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 18:08:40 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id A48FED35C620;
 Tue, 10 Dec 2019 17:08:34 +0000 (UTC)
Subject: Re: [PATCH 2/2] ppc/pnv: populate the DT with realized XSCOM devices
To: Greg Kurz <groug@kaod.org>
References: <20191210135845.19773-1-clg@kaod.org>
 <20191210135845.19773-3-clg@kaod.org>
 <20191210175323.76e77bcb@bahia.tlslab.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <377f830f-e667-7447-9e7f-867eef9091b2@kaod.org>
Date: Tue, 10 Dec 2019 18:08:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191210175323.76e77bcb@bahia.tlslab.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 15066511080464943936
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelfedgleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedu
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.150.175
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

On 10/12/2019 17:53, Greg Kurz wrote:
> On Tue, 10 Dec 2019 14:58:45 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> Some devices could be initialized in the instance_init handler but not
>> realized for configuration reasons. Nodes should not be added in the D=
T
>> for such devices.
>>
>=20
> Do you have examples of such devices to share ?

PHB4 again.=20

C.=20


>=20
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/pnv_xscom.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
>> index 006d87e970d9..6d3745a49e50 100644
>> --- a/hw/ppc/pnv_xscom.c
>> +++ b/hw/ppc/pnv_xscom.c
>> @@ -272,7 +272,10 @@ static int xscom_dt_child(Object *child, void *op=
aque)
>>          PnvXScomInterface *xd =3D PNV_XSCOM_INTERFACE(child);
>>          PnvXScomInterfaceClass *xc =3D PNV_XSCOM_INTERFACE_GET_CLASS(=
xd);
>> =20
>> -        if (xc->dt_xscom) {
>> +        /*
>> +         * Only "realized" devices should be configured in the DT
>> +         */
>> +        if (xc->dt_xscom && DEVICE(child)->realized) {
>>              _FDT((xc->dt_xscom(xd, args->fdt, args->xscom_offset)));
>>          }
>>      }
>=20


