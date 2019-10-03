Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946ECC32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACB6217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACB6217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFxir-0006P1-VH
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 05:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFxh5-0005rx-Qp
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFxh4-0000Dm-H3
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:46:43 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:52913)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFxh4-0000BS-9p
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:46:42 -0400
Received: from player795.ha.ovh.net (unknown [10.108.57.95])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id D343E11B890
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 11:46:39 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 69175A72BB47;
 Thu,  3 Oct 2019 09:46:34 +0000 (UTC)
Subject: Re: [PATCH v4 05/25] ppc/xive: Introduce a XiveFabric interface
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-6-clg@kaod.org>
 <20191003015409.GG11105@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <954e59f3-4e82-68e9-7f5b-092909dceb38@kaod.org>
Date: Thu, 3 Oct 2019 11:46:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003015409.GG11105@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 14086978161446849433
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.111.180
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/2019 03:54, David Gibson wrote:
> On Wed, Sep 18, 2019 at 06:06:25PM +0200, C=E9dric Le Goater wrote:
>> The XiveFabric QOM interface should be implemented by the machine. It
>> acts as the PowerBUS interface between the interrupt controller and
>> the system. On HW, the XIVE sub-engine is responsible for the
>> communication with the other chip is the Common Queue (CQ) bridge
>> unit.
>>
>> This interface offers a 'match_nvt' handler to perform the CAM line
>> matching when looking for a XIVE Presenter with a dispatched NVT.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Um.. this has basically the same single method as the XivePresented
> interface you just introduced.  What's the distinction between them?

XivePresenter is the subengine of the controller, XiveFabric is the
bus linking the chips on the machine. PowerNV being multichip, when
looking for a target, we need to scan all presenters in the machine.

C.=20

>=20
>> ---
>>  include/hw/ppc/xive.h | 22 ++++++++++++++++++++++
>>  hw/intc/xive.c        | 10 ++++++++++
>>  2 files changed, 32 insertions(+)
>>
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 39de45b87cb9..3c2910e10e25 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -399,6 +399,28 @@ int xive_presenter_tctx_match(XivePresenter *xptr=
, XiveTCTX *tctx,
>>                                uint8_t nvt_blk, uint32_t nvt_idx,
>>                                bool cam_ignore, uint32_t logic_serv);
>> =20
>> +/*
>> + * XIVE Fabric (Interface between Interrupt Controller and Machine)
>> + */
>> +
>> +typedef struct XiveFabric XiveFabric;
>> +
>> +#define TYPE_XIVE_FABRIC "xive-fabric"
>> +#define XIVE_FABRIC(obj)                                     \
>> +    INTERFACE_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
>> +#define XIVE_FABRIC_CLASS(klass)                                     =
\
>> +    OBJECT_CLASS_CHECK(XiveFabricClass, (klass), TYPE_XIVE_FABRIC)
>> +#define XIVE_FABRIC_GET_CLASS(obj)                                   =
\
>> +    OBJECT_GET_CLASS(XiveFabricClass, (obj), TYPE_XIVE_FABRIC)
>> +
>> +typedef struct XiveFabricClass {
>> +    InterfaceClass parent;
>> +    int (*match_nvt)(XiveFabric *xfb, uint8_t format,
>> +                     uint8_t nvt_blk, uint32_t nvt_idx,
>> +                     bool cam_ignore, uint8_t priority,
>> +                     uint32_t logic_serv, XiveTCTXMatch *match);
>> +} XiveFabricClass;
>> +
>>  /*
>>   * XIVE END ESBs
>>   */
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index fff50429f8ac..7a15a64ed7fe 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -1841,8 +1841,18 @@ static const TypeInfo xive_presenter_info =3D {
>>      .class_size =3D sizeof(XivePresenterClass),
>>  };
>> =20
>> +/*
>> + * XIVE Fabric
>> + */
>> +static const TypeInfo xive_fabric_info =3D {
>> +    .name =3D TYPE_XIVE_FABRIC,
>> +    .parent =3D TYPE_INTERFACE,
>> +    .class_size =3D sizeof(XiveFabricClass),
>> +};
>> +
>>  static void xive_register_types(void)
>>  {
>> +    type_register_static(&xive_fabric_info);
>>      type_register_static(&xive_source_info);
>>      type_register_static(&xive_notifier_info);
>>      type_register_static(&xive_presenter_info);
>=20


