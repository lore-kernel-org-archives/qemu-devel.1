Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9493AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE03220639
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE03220639
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaJk4-0000fH-Qj
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 09:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kaJij-00083H-OP; Wed, 04 Nov 2020 09:25:05 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:46699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kaJig-0008AX-T8; Wed, 04 Nov 2020 09:25:05 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9B6707475FE;
 Wed,  4 Nov 2020 15:24:59 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 793C6746331; Wed,  4 Nov 2020 15:24:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 77EC374594E;
 Wed,  4 Nov 2020 15:24:59 +0100 (CET)
Date: Wed, 4 Nov 2020 15:24:59 +0100 (CET)
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 5/6] macio: don't reference serial_hd() directly within
 the device
In-Reply-To: <1ee5be24-277c-dda1-adc5-beae5177782a@eik.bme.hu>
Message-ID: <bba4f379-c81a-f5a5-bba3-6b7a51bcf1c9@eik.bme.hu>
References: <20200926140216.7368-1-mark.cave-ayland@ilande.co.uk>
 <20200926140216.7368-6-mark.cave-ayland@ilande.co.uk>
 <16f13e17-37cb-a238-4e2a-9a945649cafd@redhat.com>
 <1ee5be24-277c-dda1-adc5-beae5177782a@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 09:24:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 atar4qemu@gmail.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Wed, 4 Nov 2020, BALATON Zoltan via wrote:
> On Wed, 4 Nov 2020, Thomas Huth wrote:
>> On 26/09/2020 16.02, Mark Cave-Ayland wrote:
>>> Instead use qdev_prop_set_chr() to configure the ESCC serial chardevs at the
>>> Mac Old World and New World machine level.
>>>
>>> Also remove the now obsolete comment referring to the use of serial_hd() and
>>> the setting of user_creatable to false accordingly.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>  hw/misc/macio/macio.c | 4 ----
>>>  hw/ppc/mac_newworld.c | 6 ++++++
>>>  hw/ppc/mac_oldworld.c | 6 ++++++
>>>  3 files changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
>>> index 679722628e..51368884d0 100644
>>> --- a/hw/misc/macio/macio.c
>>> +++ b/hw/misc/macio/macio.c
>>> @@ -109,8 +109,6 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
>>>      qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
>>>      qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
>>>      qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
>>> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hd(0));
>>> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hd(1));
>>>      qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
>>>      qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
>>>      if (!qdev_realize(DEVICE(&s->escc), BUS(&s->macio_bus), errp)) {
>>> @@ -458,8 +456,6 @@ static void macio_class_init(ObjectClass *klass, void *data)
>>>      k->class_id = PCI_CLASS_OTHERS << 8;
>>>      device_class_set_props(dc, macio_properties);
>>>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>>> -    /* Reason: Uses serial_hds in macio_instance_init */
>>> -    dc->user_creatable = false;
>>>  }
>>
>> Hi Mark,
>>
>> the macio device can now be used to crash QEMU:
>>
>> $ ./qemu-system-ppc -M sam460ex -device macio-newworld
>> Segmentation fault (core dumped)

Also in macio-oldworld that seems to have the same problem.

Regards,
BALATON Zoltan

