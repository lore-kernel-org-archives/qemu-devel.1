Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA718C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A188A20674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A188A20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFGT-0000nB-Nq
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jBFEv-0007yI-NL
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jBFEu-00071v-If
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:02:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3191 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jBFEu-000709-68
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:02:24 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id EE6491921CE1FC3999D5;
 Mon,  9 Mar 2020 18:02:18 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 9 Mar 2020
 18:02:09 +0800
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
Date: Mon, 9 Mar 2020 18:02:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
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
Cc: Laurent Vivier <laurent@vivier.eu>, Euler Robot <euler.robot@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/9/2020 5:21 PM, Peter Maydell wrote:
> On Mon, 9 Mar 2020 at 00:56, Pan Nengyuan <pannengyuan@huawei.com> wrote:
>>
>>
>>
>> On 3/8/2020 9:29 PM, Peter Maydell wrote:
>>> On Thu, 5 Mar 2020 at 06:39, Pan Nengyuan <pannengyuan@huawei.com> wrote:
>>>> -    /* Init VIAs 1 and 2 */
>>>> -    sysbus_init_child_obj(OBJECT(dev), "via1", &m->mos6522_via1,
>>>> -                          sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VIA1);
>>>> +    qdev_set_parent_bus(DEVICE(&m->mos6522_via1), sysbus_get_default());
>>>> +    qdev_set_parent_bus(DEVICE(&m->mos6522_via2), sysbus_get_default());
>>>
>>> Rather than manually setting the parent bus, you can use
>>> sysbus_init_child_obj() instead of object_initialize_child() --
>>> it is a convenience function that does both object_initialize_child()
>>> and qdev_set_parent_bus() for you.
>>
>> Actually I used sysbus_init_child_obj() first, but it will fail to run device-introspect-test.
>> Because qdev_set_parent_bus() will change 'info qtree' after we call 'device-list-properties'.
>> Thus, I do it in the realize.
> 
> Could you explain more? My thought is that we should be using
> sysbus_init_child_obj() and we should be doing it in the init method.
> Why does that break the tests ? It's the same thing various other
> devices do.

device-introspect-test do the follow check for each device type:

    qtree_start = qtest_hmp(qts, "info qtree");
    ...
    qtest_qmp(qts, "{'execute': 'device-list-properties','arguments': {'typename': %s}}", type);
    ...
    qtree_end = qtest_hmp(qts, "info qtree");
    g_assert_cmpstr(qtree_start, ==, qtree_end);

If we do qdev_set_parent_bus in init, it will check fail when type = 'mac_via'.
mac_via_init() is called by q800_init(). But it will not be called in qtest(-machine none) in the step qtree_start.
And after we call 'device-list-properties', mac_via_init() was called and set dev parent bus. We can find these
devices in the qtree_end. So it break the test on the assert.

Here is the output:

# Testing device 'mac_via'
  adb.0=<child<apple-desktop-bus>>
  drive=<str>            - Node name or ID of a block device to use as a backend
  irq[0]=<link<irq>>
  irq[1]=<link<irq>>
  mac-via[0]=<child<qemu:memory-region>>
  via1=<child<mos6522-q800-via1>>
  via1[0]=<child<qemu:memory-region>>
  via2=<child<mos6522-q800-via2>>
  via2[0]=<child<qemu:memory-region>>
qtree_start: bus: main-system-bus
  type System

qtree_end: bus: main-system-bus
  type System
  dev: mos6522-q800-via2, id ""
    gpio-in "via2-irq" 8
    gpio-out "sysbus-irq" 1
    frequency = 0 (0x0)
    mmio ffffffffffffffff/0000000000000010
  dev: mos6522-q800-via1, id ""
    gpio-in "via1-irq" 8
    gpio-out "sysbus-irq" 1
    frequency = 0 (0x0)
    mmio ffffffffffffffff/0000000000000010

> 
> thanks
> -- PMM
> .
> 

