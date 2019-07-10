Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC536C73C68
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 03:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C9B20665
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 03:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C9B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl3kR-0006Ik-9t
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 23:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51287)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hl3jg-0005uF-Em
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 23:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hl3jf-0002GG-64
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 23:57:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47864)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hl3je-0002Fh-Sn
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 23:57:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8BA6308212A;
 Wed, 10 Jul 2019 03:57:37 +0000 (UTC)
Received: from [10.72.12.42] (ovpn-12-42.pek2.redhat.com [10.72.12.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CDF3196FB;
 Wed, 10 Jul 2019 03:57:34 +0000 (UTC)
To: "Longpeng (Mike)" <longpeng2@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <785B5B0623C08241B2D0E6E7D8FA6B181E0A8FFF@DGGEMM506-MBX.china.huawei.com>
 <20190708094750.GE2746@work-vm>
 <fb1d9412-d017-3a74-012b-2bcd88271160@redhat.com>
 <83ba270d-5302-3ffe-2663-8adc36e9f079@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2c37ed34-7cd9-8962-c4bd-d55b91336bd5@redhat.com>
Date: Wed, 10 Jul 2019 11:57:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <83ba270d-5302-3ffe-2663-8adc36e9f079@huawei.com>
Content-Type: multipart/mixed; boundary="------------EDB64A6158FC94DFFB7E147F"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 10 Jul 2019 03:57:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [BUG] VM abort after migration
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
Cc: "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "v.maffione@gmail.com" <v.maffione@gmail.com>,
 "quintela@redhat.com" <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------EDB64A6158FC94DFFB7E147F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 2019/7/10 =E4=B8=8A=E5=8D=8811:36, Longpeng (Mike) wrote:
> =E5=9C=A8 2019/7/10 11:25, Jason Wang =E5=86=99=E9=81=93:
>> On 2019/7/8 =E4=B8=8B=E5=8D=885:47, Dr. David Alan Gilbert wrote:
>>> * longpeng (longpeng2@huawei.com) wrote:
>>>> Hi guys,
>>>>
>>>> We found a qemu core in our testing environment, the assertion
>>>> 'assert(bus->irq_count[i] =3D=3D 0)' in pcibus_reset() was triggered=
 and
>>>> the bus->irq_count[i] is '-1'.
>>>>
>>>> Through analysis, it was happened after VM migration and we think
>>>> it was caused by the following sequence:
>>>>
>>>> *Migration Source*
>>>> 1. save bus pci.0 state, including irq_count[x] ( =3D0 , old )
>>>> 2. save E1000:
>>>>  =C2=A0=C2=A0=C2=A0 e1000_pre_save
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 e1000_mit_timer
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_interrupt_cause
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_irq --> update pci_dev=
->irq_state to 1 and
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update bus->irq_count[x] to 1 ( n=
ew )
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 the irq_state sent to dest.
>>>>
>>>> *Migration Dest*
>>>> 1. Receive the irq_count[x] of pci.0 is 0 , but the irq_state of e10=
00 is 1.
>>>> 2. If the e1000 need change irqline , it would call to pci_irq_handl=
er(),
>>>>  =C2=A0=C2=A0 the irq_state maybe change to 0 and bus->irq_count[x] =
will become
>>>>  =C2=A0=C2=A0 -1 in this situation.
>>>> 3. do VM reboot then the assertion will be triggered.
>>>>
>>>> We also found some guys faced the similar problem:
>>>> [1] https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02525.h=
tml
>>>> [2] https://bugs.launchpad.net/qemu/+bug/1702621
>>>>
>>>> Is there some patches to fix this problem ?
>>> I don't remember any.
>>>
>>>> Can we save pcibus state after all the pci devs are saved ?
>>> Does this problem only happen with e1000? I think so.
>>> If it's only e1000 I think we should fix it - I think once the VM is
>>> stopped for doing the device migration it shouldn't be raising
>>> interrupts.
>>
>> I wonder maybe we can simply fix this by no setting ICS on pre_save() =
but
>> scheduling mit timer unconditionally in post_load().
>>
> I also think this is a bug of e1000 because we find more cores with the=
 same
> frame thease days.
>
> I'm not familiar with e1000 so hope someone could fix it, thanks. :)
>

Draft a path in attachment, please test.

Thanks


>> Thanks
>>
>>
>>> Dave
>>>
>>>> Thanks,
>>>> Longpeng(Mike)
>>> --=20
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>> .
>>

--------------EDB64A6158FC94DFFB7E147F
Content-Type: text/x-patch;
 name="0001-e1000-don-t-raise-interrupt-in-pre_save.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-e1000-don-t-raise-interrupt-in-pre_save.patch"

From afe9258486672d76d7bf133ac9032a0d457bcd0b Mon Sep 17 00:00:00 2001
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2019 11:52:53 +0800
Subject: [PATCH] e1000: don't raise interrupt in pre_save()

We should not raise any interrupt after VM has been stopped but this
is what e1000 currently did when mit timer is active in
pre_save(). Fixing this by scheduling a timer in post_load() which can
make sure the interrupt was raised when VM is running.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 1dc1466332..a023ceb27c 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1381,11 +1381,6 @@ static int e1000_pre_save(void *opaque)
     E1000State *s = opaque;
     NetClientState *nc = qemu_get_queue(s->nic);
 
-    /* If the mitigation timer is active, emulate a timeout now. */
-    if (s->mit_timer_on) {
-        e1000_mit_timer(s);
-    }
-
     /*
      * If link is down and auto-negotiation is supported and ongoing,
      * complete auto-negotiation immediately. This allows us to look
@@ -1423,7 +1418,8 @@ static int e1000_post_load(void *opaque, int version_id)
         s->mit_irq_level = false;
     }
     s->mit_ide = 0;
-    s->mit_timer_on = false;
+    s->mit_timer_on = true;
+    timer_mod(s->mit_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 1);
 
     /* nc.link_down can't be migrated, so infer link_down according
      * to link status bit in mac_reg[STATUS].
-- 
2.19.1


--------------EDB64A6158FC94DFFB7E147F--

