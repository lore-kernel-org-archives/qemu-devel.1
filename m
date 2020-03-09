Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6308CC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39074205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39074205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHuV-0003c1-DB
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jBHtF-0002E7-HH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jBHtD-0008LO-RN
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:52:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3193 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jBHtD-00087A-DM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:52:11 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id D3F546724EAA299FA468;
 Mon,  9 Mar 2020 20:52:04 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 9 Mar 2020
 20:51:56 +0800
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
To: Markus Armbruster <armbru@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
 <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
 <87a74pso48.fsf@dusky.pond.sub.org>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <2ff8e8e8-a281-1d50-417d-96383240c2df@huawei.com>
Date: Mon, 9 Mar 2020 20:51:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87a74pso48.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: QEMU
 Developers <qemu-devel@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/9/2020 8:34 PM, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Mon, 9 Mar 2020 at 10:02, Pan Nengyuan <pannengyuan@huawei.com> wrote:
>>> On 3/9/2020 5:21 PM, Peter Maydell wrote:
>>>> Could you explain more? My thought is that we should be using
>>>> sysbus_init_child_obj() and we should be doing it in the init method.
>>>> Why does that break the tests ? It's the same thing various other
>>>> devices do.
>>>
>>> device-introspect-test do the follow check for each device type:
>>>
>>>     qtree_start = qtest_hmp(qts, "info qtree");
>>>     ...
>>>     qtest_qmp(qts, "{'execute': 'device-list-properties','arguments': {'typename': %s}}", type);
>>>     ...
>>>     qtree_end = qtest_hmp(qts, "info qtree");
>>>     g_assert_cmpstr(qtree_start, ==, qtree_end);
>>>
>>> If we do qdev_set_parent_bus in init, it will check fail when type = 'mac_via'.
>>> mac_via_init() is called by q800_init(). But it will not be called in qtest(-machine none) in the step qtree_start.
>>> And after we call 'device-list-properties', mac_via_init() was called and set dev parent bus. We can find these
>>> devices in the qtree_end. So it break the test on the assert.
>>
>> Markus, do you know what's happening here? Why is
>> trying to use sysbus_init_child_obj() breaking the
>> device-introspect-test for this particular device,
>> but fine for the other places where we use it?
>> (Maybe we're accidentally leaking a reference to
>> something so the sub-device stays on the sysbus
>> when it should have removed itself when the
>> device was deinited ?)
> 
> Pan Nengyuan, please provide the exact patch that fails for you.

As the follow patch:

From 9b4f35e294597410cc03b967c127242ce099692e Mon Sep 17 00:00:00 2001
From: Pan Nengyuan <pannengyuan@huawei.com>
Date: Wed, 4 Mar 2020 11:29:28 +0800
Subject: [PATCH] mac_via: fix incorrect creation of mos6522 device in mac_via

This patch fix a bug in mac_via where it failed to actually realize devices it was using.
And move the init codes which inits the mos6522 objects and properties on them from realize()
into init(). However, we keep qdev_set_parent_bus in realize(), otherwise it will cause
device-introspect-test test fail. Then do the realize mos6522 device in the mac_vir_realize.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 hw/misc/mac_via.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index b7d0012794..4c5c432140 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -868,24 +868,21 @@ static void mac_via_reset(DeviceState *dev)
 static void mac_via_realize(DeviceState *dev, Error **errp)
 {
     MacVIAState *m = MAC_VIA(dev);
-    MOS6522State *ms;
     struct tm tm;
     int ret;
+    Error *err = NULL;

-    /* Init VIAs 1 and 2 */
-    sysbus_init_child_obj(OBJECT(dev), "via1", &m->mos6522_via1,
-                          sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VIA1);
-
-    sysbus_init_child_obj(OBJECT(dev), "via2", &m->mos6522_via2,
-                          sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA2);
+    object_property_set_bool(OBJECT(&m->mos6522_via1), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }

-    /* Pass through mos6522 output IRQs */
-    ms = MOS6522(&m->mos6522_via1);
-    object_property_add_alias(OBJECT(dev), "irq[0]", OBJECT(ms),
-                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
-    ms = MOS6522(&m->mos6522_via2);
-    object_property_add_alias(OBJECT(dev), "irq[1]", OBJECT(ms),
-                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
+    object_property_set_bool(OBJECT(&m->mos6522_via2), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }

     /* Pass through mos6522 input IRQs */
     qdev_pass_gpios(DEVICE(&m->mos6522_via1), dev, "via1-irq");
@@ -932,6 +929,7 @@ static void mac_via_init(Object *obj)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     MacVIAState *m = MAC_VIA(obj);
+    MOS6522State *ms;

     /* MMIO */
     memory_region_init(&m->mmio, obj, "mac-via", 2 * VIA_SIZE);
@@ -948,6 +946,20 @@ static void mac_via_init(Object *obj)
     /* ADB */
     qbus_create_inplace((BusState *)&m->adb_bus, sizeof(m->adb_bus),
                         TYPE_ADB_BUS, DEVICE(obj), "adb.0");
+
+    /* Init VIAs 1 and 2 */
+    sysbus_init_child_obj(OBJECT(m), "via1", &m->mos6522_via1,
+                          sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VIA1);
+    sysbus_init_child_obj(OBJECT(dev), "via2", &m->mos6522_via2,
+                          sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA2);
+
+    /* Pass through mos6522 output IRQs */
+    ms = MOS6522(&m->mos6522_via1);
+    object_property_add_alias(OBJECT(m), "irq[0]", OBJECT(ms),
+                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
+    ms = MOS6522(&m->mos6522_via2);
+    object_property_add_alias(OBJECT(m), "irq[1]", OBJECT(ms),
+                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
 }

 static void postload_update_cb(void *opaque, int running, RunState state)
--
2.18.2


> 
> .
> 

