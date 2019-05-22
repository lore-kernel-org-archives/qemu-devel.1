Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45271C193F2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E3920856
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E3920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38928 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTNIv-0001oE-Aa
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 05:12:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hTNHb-00016Q-Tr
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hTNHa-0003K9-Mo
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:11:35 -0400
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:44466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hTNHa-00035Y-F5
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:11:34 -0400
Received: from player798.ha.ovh.net (unknown [10.109.146.240])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 9F5AE1325B0
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:11:21 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player798.ha.ovh.net (Postfix) with ESMTPSA id 5275A6209A0B;
	Wed, 22 May 2019 09:11:15 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>
References: <20190522074016.10521-1-clg@kaod.org>
	<20190522074016.10521-2-clg@kaod.org>
	<20190522105248.71c5d72a@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9bf3b3fd-efe4-5e15-b205-31d0e4492ad6@kaod.org>
Date: Wed, 22 May 2019 11:11:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522105248.71c5d72a@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1313080768584321875
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudduvddguddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.36.149
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/2] spapr/xive: fix multiple
 resets when using the 'dual' interrupt mode
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
	Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/22/19 10:52 AM, Greg Kurz wrote:
> On Wed, 22 May 2019 09:40:15 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> Today, when a reset occurs on a pseries machine using the 'dual'
>> interrupt mode, the KVM devices are released and recreated depending
>> on the interrupt mode selected by CAS. If XIVE is selected, the SysBus
>> memory regions of the SpaprXive model are initialized by the KVM
>> backend initialization routine each time a reset occurs. This leads to
>> a crash after a couple of resets because the machine reaches the
>> QDEV_MAX_MMIO limit of SysBusDevice :
>>
>> qemu-system-ppc64: hw/core/sysbus.c:193: sysbus_init_mmio: Assertion `=
dev->num_mmio < QDEV_MAX_MMIO' failed.
>>
>> To fix, initialize the SysBus memory regions in spapr_xive_realize()
>> called only once and remove the same inits from the QEMU and KVM
>> backend initialization routines which are called at each reset.
>>
>=20
> Yeah, sysbus_init_mmio() simply records the memory region pointer into =
the
> mmio array of the sysbus device. It doesn't require the memory region t=
o be
> initialized beforehand and it really must be called only once during th=
e
> device life time. Certainly not a reset thing. Doing this at realize lo=
oks
> a lot better.
>=20
>> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/spapr_xive.c     | 11 +++++------
>>  hw/intc/spapr_xive_kvm.c |  4 ----
>>  2 files changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index f6f6c29d6ae4..62e0ef8fa5b4 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -331,12 +331,16 @@ static void spapr_xive_realize(DeviceState *dev,=
 Error **errp)
>>                             xive->tm_base + XIVE_TM_USER_PAGE * (1 << =
TM_SHIFT));
>> =20
>>      qemu_register_reset(spapr_xive_reset, dev);
>> +
>> +    /* Define all XIVE MMIO regions on SysBus */
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
>>  }
>> =20
>>  void spapr_xive_init(SpaprXive *xive, Error **errp)
>>  {
>>      XiveSource *xsrc =3D &xive->source;
>> -    XiveENDSource *end_xsrc =3D &xive->end_source;
>> =20
>>      /*
>>       * The emulated XIVE device can only be initialized once. If the
>> @@ -351,11 +355,6 @@ void spapr_xive_init(SpaprXive *xive, Error **err=
p)
>>      memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops,=
 xive,
>>                            "xive.tima", 4ull << TM_SHIFT);
>> =20
>> -    /* Define all XIVE MMIO regions on SysBus */
>> -    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
>> -    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
>> -    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
>> -
>>      /* Map all regions */
>>      spapr_xive_map_mmio(xive);
>>  }
>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
>> index ec170b304555..b48f135838f2 100644
>> --- a/hw/intc/spapr_xive_kvm.c
>> +++ b/hw/intc/spapr_xive_kvm.c
>> @@ -693,7 +693,6 @@ static void *kvmppc_xive_mmap(SpaprXive *xive, int=
 pgoff, size_t len,
>>  void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
>>  {
>>      XiveSource *xsrc =3D &xive->source;
>> -    XiveENDSource *end_xsrc =3D &xive->end_source;
>>      Error *local_err =3D NULL;
>>      size_t esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
>>      size_t tima_len =3D 4ull << TM_SHIFT;
>> @@ -731,12 +730,10 @@ void kvmppc_xive_connect(SpaprXive *xive, Error =
**errp)
>> =20
>>      memory_region_init_ram_device_ptr(&xsrc->esb_mmio, OBJECT(xsrc),
>>                                        "xive.esb", esb_len, xsrc->esb_=
mmap);
>> -    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
>> =20
>>      /*
>>       * 2. END ESB pages (No KVM support yet)
>>       */
>> -    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
>> =20
>=20
> It looks a bit weird to end up with a comment but no related code...
> maybe simply drop it and s/3/2 in the other comment below ?

I rather keep it that way. It reminds people that there are three
distinct memory regions and one is currently not supported (by KVM=20
and the guest OS)

> Apart from that, LGTM:
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks,

C.=20


>=20
>>      /*
>>       * 3. TIMA pages - KVM mapping
>> @@ -749,7 +746,6 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **=
errp)
>>      }
>>      memory_region_init_ram_device_ptr(&xive->tm_mmio, OBJECT(xive),
>>                                        "xive.tima", tima_len, xive->tm=
_mmap);
>> -    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
>> =20
>>      xive->change =3D qemu_add_vm_change_state_handler(
>>          kvmppc_xive_change_state_handler, xive);
>=20


