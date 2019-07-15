Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E718EC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBDE9206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDE9206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmy53-0005ls-38
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 06:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34019)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hmy4q-0005Hl-73
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hmy4p-0004n3-0d
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:19:24 -0400
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:58903)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hmy4o-0004jr-RM
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:19:22 -0400
Received: from player738.ha.ovh.net (unknown [10.109.159.90])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 293BE1D7127
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 12:19:11 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 452B980D2FD7;
 Mon, 15 Jul 2019 10:19:03 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>,
 Laurent Vivier <lvivier@redhat.com>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
 <20190529065017.15149-42-david@gibson.dropbear.id.au>
 <a5139cdc-7175-1747-f18f-e5fcf6926d44@redhat.com>
 <20190711012613.GA13271@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cd2e72a2-c252-2305-b070-95c6f3d39d5c@kaod.org>
Date: Mon, 15 Jul 2019 12:19:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711012613.GA13271@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 5989506029506890672
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrheekgddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.177.69
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 41/44] spapr: change default
 interrupt mode to 'dual'
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
Cc: peter.maydell@linaro.org, rth@twiddle.net, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/07/2019 03:26, David Gibson wrote:
> On Wed, Jul 10, 2019 at 06:26:09PM +0200, Laurent Vivier wrote:
>> On 29/05/2019 08:50, David Gibson wrote:
>>> From: C=E9dric Le Goater <clg@kaod.org>
>>>
>>> Now that XIVE support is complete (QEMU emulated and KVM devices),
>>> change the pseries machine to advertise both interrupt modes: XICS
>>> (P7/P8) and XIVE (P9).
>>>
>>> The machine default interrupt modes depends on the version. Current
>>> settings are:
>>>
>>>     pseries   default interrupt mode
>>>
>>>     4.1       dual
>>>     4.0       xics
>>>     3.1       xics
>>>     3.0       legacy xics (different IRQ number space layout)
>>>
>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>> Message-Id: <20190522074016.10521-3-clg@kaod.org>
>>> Reviewed-by: Greg Kurz <groug@kaod.org>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
>>>  hw/ppc/spapr.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 39e698e9b0..4fd16b43f0 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -4352,7 +4352,7 @@ static void spapr_machine_class_init(ObjectClas=
s *oc, void *data)
>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CA=
P_ON;
>>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
>>>      spapr_caps_add_properties(smc, &error_abort);
>>> -    smc->irq =3D &spapr_irq_xics;
>>> +    smc->irq =3D &spapr_irq_dual;
>>>      smc->dr_phb_enabled =3D true;
>>>  }
>>> =20
>>> @@ -4430,6 +4430,7 @@ static void spapr_machine_4_0_class_options(Mac=
hineClass *mc)
>>>      spapr_machine_4_1_class_options(mc);
>>>      compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_=
len);
>>>      smc->phb_placement =3D phb_placement_4_0;
>>> +    smc->irq =3D &spapr_irq_xics;
>>>  }
>>> =20
>>>  DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
>>>
>>
>> This patch breaks the '-no-reboot' parameter (I think the "dual" mode
>> breaks the -no-reboot parameter)
>>
>> After grub loads the kernel and starts it, the kernel aborts:
>>
>> OF stdout device is: /vdevice/vty@71000000
>> Preparing to boot Linux version 4.18.0-112.el8.ppc64le
>> (mockbuild@ppc-061.build.eng.bos.redhat.com) (gcc version 8.3.1 201905=
07
>> (Red Hat 8.3.1-4) (GCC)) #1 SMP Fri Jul 5 11:21:28 UTC 2019
>> Detected machine type: 0000000000000101
>> command line: BOOT_IMAGE=3D/vmlinuz-4.18.0-112.el8.ppc64le
>> root=3D/dev/mapper/rhel_ibm--p8--kvm--03--guest--02-root ro
>> crashkernel=3Dauto rd.lvm.lv=3Drhel_ibm-p8-kvm-03-guest-02/root
>> rd.lvm.lv=3Drhel_ibm-p8-kvm-03-guest-02/swap
>> Max number of cores passed to firmware: 256 (NR_CPUS =3D 2048)
>> Calling ibm,client-architecture-support...[lvivier@localhost ~]$
>>
>> I bisected to this patch, and then after I understood the problem is
>> with the -no-reboot parameter as the machine is reset by the CAS
>> negotiation... and the -no-reboot prevents this reset.
>>
>> I don't know if it's a real problem or not.
>=20
> Ah, bother.  I didn't think of the interaction between the CAS reboot
> and -no-reboot.  I guess that's more reason to work out a way to do
> the xics/xive switch without a full reset.  People were already not
> thrilled with the extra reboots here.

QEMU builds a device tree depending on the interrupt mode negotiated=20
at CAS time. Can we dynamically add/remove nodes ?

C.

