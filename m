Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5F0CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8123521872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8123521872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNa7v-0005Pj-60
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iNZro-0005DG-Rw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iNZrn-0008OI-Ba
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:57:16 -0400
Received: from 4.mo3.mail-out.ovh.net ([178.33.46.10]:43305)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iNZrn-0008Mq-4o
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:57:15 -0400
Received: from player756.ha.ovh.net (unknown [10.108.57.139])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id AB2CE228723
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 11:57:12 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id 24D7EA878D7F;
 Thu, 24 Oct 2019 09:57:07 +0000 (UTC)
Subject: Re: [PATCH v5 4/7] ppc/pnv: Add a PnvChip pointer to PnvCore
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191022163812.330-1-clg@kaod.org>
 <20191022163812.330-5-clg@kaod.org> <20191024023812.GO6439@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ed3b2931-7836-058d-6b93-d35eed3ff859@kaod.org>
Date: Thu, 24 Oct 2019 11:57:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024023812.GO6439@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 8464515503485520675
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrledugddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.46.10
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/10/2019 04:38, David Gibson wrote:
> On Tue, Oct 22, 2019 at 06:38:09PM +0200, C=E9dric Le Goater wrote:
>> We will use it to reset the interrupt presenter from the CPU reset
>> handler.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> Reviewed-by: Greg Kurz <groug@kaod.org>
>> ---
>>  include/hw/ppc/pnv_core.h | 3 +++
>>  hw/ppc/pnv_core.c         | 3 ++-
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
>> index bfbd2ec42aa6..55eee95104da 100644
>> --- a/include/hw/ppc/pnv_core.h
>> +++ b/include/hw/ppc/pnv_core.h
>> @@ -31,6 +31,8 @@
>>  #define PNV_CORE_GET_CLASS(obj) \
>>       OBJECT_GET_CLASS(PnvCoreClass, (obj), TYPE_PNV_CORE)
>> =20
>> +typedef struct PnvChip PnvChip;
>> +
>>  typedef struct PnvCore {
>>      /*< private >*/
>>      CPUCore parent_obj;
>> @@ -38,6 +40,7 @@ typedef struct PnvCore {
>>      /*< public >*/
>>      PowerPCCPU **threads;
>>      uint32_t pir;
>> +    PnvChip *chip;
>=20
> I don't love having this as a redundant encoding of the information
> already in the property, since it raises the possibility of confusing
> bugs if they ever got out of sync.

Indeed.

> It's not a huge deal, but it would be nice to at least to at least
> consider either a) grabbing the property everywhere you need it (if
> there aren't too many places)=20

We need the chip at core creation and core reset to call the=20
interrupt chip handlers. These are not hot path but the pointer
seemed practical.

> or b) customizing the property
> definition so it's written directly into that field.

OK. That is better than just a link.

C.=20

>=20
>> =20
>>      MemoryRegion xscom_regs;
>>  } PnvCore;
>> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
>> index 9f981a4940e6..cc17bbfed829 100644
>> --- a/hw/ppc/pnv_core.c
>> +++ b/hw/ppc/pnv_core.c
>> @@ -222,6 +222,7 @@ static void pnv_core_realize(DeviceState *dev, Err=
or **errp)
>>                                  "required link 'chip' not found: ");
>>          return;
>>      }
>> +    pc->chip =3D PNV_CHIP(chip);
>> =20
>>      pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
>>      for (i =3D 0; i < cc->nr_threads; i++) {
>> @@ -243,7 +244,7 @@ static void pnv_core_realize(DeviceState *dev, Err=
or **errp)
>>      }
>> =20
>>      for (j =3D 0; j < cc->nr_threads; j++) {
>> -        pnv_realize_vcpu(pc->threads[j], PNV_CHIP(chip), &local_err);
>> +        pnv_realize_vcpu(pc->threads[j], pc->chip, &local_err);
>>          if (local_err) {
>>              goto err;
>>          }
>=20


