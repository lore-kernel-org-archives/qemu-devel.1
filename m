Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE0AC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F7C21926
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F7C21926
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqDdJ-00044o-Gv
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 05:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47119)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hqDd3-0003am-S6
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hqDd1-0007xG-7n
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:32:08 -0400
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:40683)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hqDd0-0007wh-Du
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:32:06 -0400
Received: from player787.ha.ovh.net (unknown [10.109.146.76])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id BE021105C14
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 11:32:04 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id 9B01185B317E;
 Wed, 24 Jul 2019 09:32:00 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190722182347.25075-1-clg@kaod.org>
 <20190723013808.GJ25073@umbus.fritz.box>
 <177076c3-b418-fb52-74c9-ee98f5fe4694@kaod.org>
 <20190723063730.GT25073@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9dcb77c1-ff45-921a-6b98-6f1c3b67b89a@kaod.org>
Date: Wed, 24 Jul 2019 11:32:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723063730.GT25073@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 2707789276217051987
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkedtgddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.72.238
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Introduce PowerNV machines with
 fixed CPU models
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

On 23/07/2019 08:37, David Gibson wrote:
> On Tue, Jul 23, 2019 at 08:00:27AM +0200, C=E9dric Le Goater wrote:
>> On 23/07/2019 03:38, David Gibson wrote:
>>> On Mon, Jul 22, 2019 at 08:23:47PM +0200, C=E9dric Le Goater wrote:
>>>> Make the current "powernv" machine an abstract type and derive from =
it
>>>> new machines with specific CPU models: power8, power8e, power8nvl,
>>>> power9.
>>>>
>>>> The "powernv" machine is now an alias on the "powernv9" machine.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>
>>> Ah, sorry, I wasn't clear here.  I don't think we need a different
>>> machine type for every cpu model, I just think we should have powernv=
8
>>> and powernv9.  POWER8E and POWER8NVL don't significantly change the
>>> system design (IIUC) so they can still be done with "-machine powernv=
8
>>> -cpu POWER8E" or whatever.  I expect the same will be true for POWER9=
'
>>> when that comes along
>>
>> I understand but I am afraid we will to have one machine per CPU famil=
y=20
>> because POWER8E and POWER8NVL already have their own PnvChip :=20
>>
>>     DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class_=
init),
>>     DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_clas=
s_init),
>>     DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
>>                           pnv_chip_power8nvl_class_init),
>=20
> Hrm.  Is there an actual reason we need different chip classes for
> these? =20
The POWER8 (8E, 8, 8NVL) chips differ by the core :=20

    target/ppc/cpu-models.h:    CPU_POWERPC_POWER8E_BASE       =3D 0x004B=
0000,
    target/ppc/cpu-models.h:    CPU_POWERPC_POWER8_BASE        =3D 0x004D=
0000,
    target/ppc/cpu-models.h:    CPU_POWERPC_POWER8NVL_BASE     =3D 0x004C=
0000,

The chip model is different :

    k->chip_cfam_id =3D 0x221ef04980000000ull; /* P8 Murano DD2.1 */
    k->chip_cfam_id =3D 0x220ea04980000000ull; /* P8 Venice DD2.0 */
    k->chip_cfam_id =3D 0x120d304980000000ull; /* P8 Naples DD1.0 */
=20
The chiplets are different also. NVL has a NPU and a different LPC bus wh=
ich
is modeled. There are different number of PHBs.

> Even if there is, I don't see an inherent reason that implies separate
> machine classes as well.=20

I will see if we can have a single powernv8 machine.

C.

