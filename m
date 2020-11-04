Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19D0C4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 19:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C8A2065D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 19:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C8A2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaOV4-0003SL-Nf
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 14:31:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kaOTU-0002mp-OZ; Wed, 04 Nov 2020 14:29:40 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:35428
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kaOTS-00089b-Pn; Wed, 04 Nov 2020 14:29:40 -0500
Received: from host81-158-111-11.range81-158.btcentralplus.com
 ([81.158.111.11] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kaOTW-0005Bo-UZ; Wed, 04 Nov 2020 19:29:47 +0000
To: Thomas Huth <thuth@redhat.com>, armbru@redhat.com,
 david@gibson.dropbear.id.au, atar4qemu@gmail.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20200926140216.7368-1-mark.cave-ayland@ilande.co.uk>
 <20200926140216.7368-6-mark.cave-ayland@ilande.co.uk>
 <16f13e17-37cb-a238-4e2a-9a945649cafd@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <24aca485-fe87-8aab-7554-ba8dc1a3bbb3@ilande.co.uk>
Date: Wed, 4 Nov 2020 19:29:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <16f13e17-37cb-a238-4e2a-9a945649cafd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.158.111.11
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 5/6] macio: don't reference serial_hd() directly within
 the device
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/11/2020 12:47, Thomas Huth wrote:

> On 26/09/2020 16.02, Mark Cave-Ayland wrote:
>> Instead use qdev_prop_set_chr() to configure the ESCC serial chardevs at the
>> Mac Old World and New World machine level.
>>
>> Also remove the now obsolete comment referring to the use of serial_hd() and
>> the setting of user_creatable to false accordingly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/misc/macio/macio.c | 4 ----
>>   hw/ppc/mac_newworld.c | 6 ++++++
>>   hw/ppc/mac_oldworld.c | 6 ++++++
>>   3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
>> index 679722628e..51368884d0 100644
>> --- a/hw/misc/macio/macio.c
>> +++ b/hw/misc/macio/macio.c
>> @@ -109,8 +109,6 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
>>       qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
>>       qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
>>       qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
>> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hd(0));
>> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hd(1));
>>       qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
>>       qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
>>       if (!qdev_realize(DEVICE(&s->escc), BUS(&s->macio_bus), errp)) {
>> @@ -458,8 +456,6 @@ static void macio_class_init(ObjectClass *klass, void *data)
>>       k->class_id = PCI_CLASS_OTHERS << 8;
>>       device_class_set_props(dc, macio_properties);
>>       set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>> -    /* Reason: Uses serial_hds in macio_instance_init */
>> -    dc->user_creatable = false;
>>   }
> 
>   Hi Mark,
> 
> the macio device can now be used to crash QEMU:
> 
>   $ ./qemu-system-ppc -M sam460ex -device macio-newworld
>   Segmentation fault (core dumped)
> 
> I guess we should either restore the user_creatable flag or add some sanity
> checks elsewhere?

(goes and looks)

Ah okay it appears to be because the object property link to the PIC is missing, 
which is to be expected as it is only present on the Mac machines.

With the latest round of QOM updates I can see the solution but it's probably a bit 
much now that we've reached rc-0. The easiest thing for the moment is to switch 
user_creatable back to false if this is causing an issue.

Just out of interest how did you find this? My new workflow involves a local "make 
check" with all ppc targets and a pass through Travis-CI and it didn't show up there 
for me (or indeed Peter's pre-merge tests).


ATB,

Mark.

