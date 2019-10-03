Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB11C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A40217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A40217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFxjo-0007No-6J
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 05:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFxhs-0006RN-Nx
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFxhr-0001Fn-EK
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:47:32 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:33649)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFxhr-0001BN-8z
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:47:31 -0400
Received: from player738.ha.ovh.net (unknown [10.108.42.82])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 73D061AEBF2
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 11:47:29 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 760AFAA50264;
 Thu,  3 Oct 2019 09:47:25 +0000 (UTC)
Subject: Re: [PATCH v4 06/25] ppc/pnv: Implement the XiveFabric interface
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-7-clg@kaod.org>
 <20191003015555.GH11105@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2a6f6ad7-5967-e2da-c7f2-487cfc2c74cd@kaod.org>
Date: Thu, 3 Oct 2019 11:47:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003015555.GH11105@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 14101051910241291161
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.48.182
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

On 03/10/2019 03:55, David Gibson wrote:
> On Wed, Sep 18, 2019 at 06:06:26PM +0200, C=E9dric Le Goater wrote:
>> The CAM line matching on the PowerNV machine now scans all chips of
>> the system and all CPUs of a chip to find a dispatched NVT in the
>> thread contexts.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/pnv.c | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 77a86c6a2301..ca24dd62df23 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -1378,6 +1378,35 @@ static void pnv_pic_print_info(InterruptStatsPr=
ovider *obj,
>>      }
>>  }
>> =20
>> +static int pnv_xive_match_nvt(XiveFabric *xfb, uint8_t format,
>> +                               uint8_t nvt_blk, uint32_t nvt_idx,
>> +                               bool cam_ignore, uint8_t priority,
>> +                               uint32_t logic_serv,
>> +                               XiveTCTXMatch *match)
>> +{
>> +    PnvMachineState *pnv =3D PNV_MACHINE(xfb);
>> +    int total_count =3D 0;
>> +    int i;
>> +
>> +    for (i =3D 0; i < pnv->num_chips; i++) {
>> +        Pnv9Chip *chip9 =3D PNV9_CHIP(pnv->chips[i]);
>> +        XivePresenter *xptr =3D XIVE_PRESENTER(&chip9->xive);
>> +        XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
>> +        int count;
>> +
>> +        count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_=
ignore,
>> +                               priority, logic_serv, match);
>> +
>> +        if (count < 0) {
>> +            return count;
>> +        }
>> +
>> +        total_count +=3D count;
>> +    }
>> +
>> +    return total_count;
>> +}
>> +
>>  static void pnv_get_num_chips(Object *obj, Visitor *v, const char *na=
me,
>>                                void *opaque, Error **errp)
>>  {
>> @@ -1441,9 +1470,11 @@ static void pnv_machine_power8_class_init(Objec=
tClass *oc, void *data)
>>  static void pnv_machine_power9_class_init(ObjectClass *oc, void *data=
)
>>  {
>>      MachineClass *mc =3D MACHINE_CLASS(oc);
>> +    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(oc);
>> =20
>>      mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER9";
>>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
>> +    xfc->match_nvt =3D pnv_xive_match_nvt;
>> =20
>>      mc->alias =3D "powernv";
>>  }
>> @@ -1495,6 +1526,7 @@ static void pnv_machine_class_init(ObjectClass *=
oc, void *data)
>>          .interfaces =3D (InterfaceInfo[]) {               \
>>              { TYPE_XICS_FABRIC },                       \
>>              { TYPE_INTERRUPT_STATS_PROVIDER },          \
>> +            { TYPE_XIVE_FABRIC },                       \
>=20
> Hmm.. this should probably be on the powernv9 machine only, not
> powernv8 as well, yes?

you are right.=20

Thanks,

C.=20


>=20
>>              { },                                        \
>>          },                                              \
>>      }
>=20


