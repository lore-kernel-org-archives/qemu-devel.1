Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA96C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F79207CD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Z+9AZum0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F79207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr4QC-0006Bn-Me
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 14:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jr4PB-0005hN-NN; Thu, 02 Jul 2020 14:57:54 -0400
Received: from mail-vi1eur05on2115.outbound.protection.outlook.com
 ([40.107.21.115]:17513 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jr4P8-0000ls-Gx; Thu, 02 Jul 2020 14:57:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQj3/qvAe/iAGq3bU0v4ghz8lxfdI0eRKI51jBxWiKywCUr5ROM+jOWHmq0XGof6WiGmNodSSXI4h3WKv0erNObCn8chygie+/8e0rJh1AMfeSOBqFpkdrhybT7Z1P/KNJvL7NWkmdD+s4rKlTRFUuE4c0x/kWG7AunhMz37gQZS8n2w+QhWjJsAKH/GyQqamQd/cG53ov5bqwzX7fH070vN2upwhLJBhBwFRXhqeZ3SPGQYU7cErTtbdYm7p+T8ZiJEKe7rvJNRik/98f2ltuWpISu58RlkzOjkh1+bZi4NJ5m1P3LllBII5aaX/KpdI3q4IjExmqxdNY4li1JgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK2TQmU//w4ESOuVPrTrQRWfAM5/ab1XTdFVTwfjF4E=;
 b=n8hKC7fFULorQqTBZ3GobaUkp2e89lhypeCoyWK3fULGyUKWIOnfMC4jSraTYNB/bDj0ZbYxwGlgMNnYm+JAPzjvz/GPOvu3MKwStV6mP1B2tqfA4LAUyA1L/qG9x8oqIsAmToP2ZJ0YVKVw+SKAX6hla5129ll7F6gCETlKj1LLOEu/qKrQDyaGxpDDdnxPmajnswI6oaLBno0TdwJzDXNu/8AelFuAZLmoVNTa0y+MvLzc3UPsX+fnc/Bgxtzk3ZmTyc5WqIaZ2gj6rg6iUYmq0j8pGhj6iU10H37/UMpO25fRVmlY5t9cET7qLYSCEP8PL6Ty4e+kqEH7iwcOug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK2TQmU//w4ESOuVPrTrQRWfAM5/ab1XTdFVTwfjF4E=;
 b=Z+9AZum0+JbvZVVoDU6u6Vo2LcWjrkDBqzKFiCW5y1tktWe4FZeqW0o3B/oL953oDL2FQspbsBPzZnxynlNzVaAyO3dY9xq59YYfUXd/u9Hb4++NxPQ7HOHBOi23vnwxn5c3MJ0QwTzgL5hTqRC1MTpmzt3dlBFP4sVV1pu9SLQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3766.eurprd08.prod.outlook.com (2603:10a6:20b:83::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Thu, 2 Jul
 2020 18:57:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Thu, 2 Jul 2020
 18:57:46 +0000
Subject: Re: [PATCH v2 03/44] qdev: Use returned bool to check for
 qdev_realize() etc. failure
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-4-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4d9bb0b7-5e30-095b-00b1-1fe9315a6db8@virtuozzo.com>
Date: Thu, 2 Jul 2020 21:57:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200702155000.3455325-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0001.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.54) by
 AM0PR02CA0001.eurprd02.prod.outlook.com (2603:10a6:208:3e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Thu, 2 Jul 2020 18:57:45 +0000
X-Originating-IP: [185.215.60.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fafc3eac-02fc-4336-957a-08d81eb9cef6
X-MS-TrafficTypeDiagnostic: AM6PR08MB3766:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3766B127BDDE42FE78845A33C16D0@AM6PR08MB3766.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGk3AaPxSiFY1VTSj+zWasNFxehd2jW4svX9tQ1N9BpqetAI46CAn1h3qnkhezhwkC/brHht74plTpABIUYD8m9NGQ8LTNvl4eygNskjCs70ZbMB0uW1Wx0V2sFJCkazCwrN/zx9jFK2hC/IAGnHzTC3psP7xzF3X57is9+PZJMk57E9iGQKW5xTq48ZeNmAmcsaXGzCp+i9wTcfkILIxt4YvEyfXTzemIAqlRwel9AJfO3S2OAFmEplXCraq47OOIhO9KaO7aTFl4SJiER/8E0qvuIvnzvXcGrzQSwl1VCS30vejVRh+XL3raEF3OsI5ND/6/zJs7rvuiSDkZZDnoAt2xouDdms8sVncajhZXenw81AxLsOdiR0NIM0UGdS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(136003)(346002)(396003)(376002)(478600001)(2906002)(186003)(16526019)(31696002)(5660300002)(86362001)(66946007)(66556008)(66476007)(16576012)(2616005)(31686004)(316002)(36756003)(956004)(4326008)(6486002)(83380400001)(52116002)(26005)(8936002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Nd//koQo/xjOovHBOb+VJj7XqYcuA1Z/0lnY7kV/Vj9DRie3ZZ17ubxRncpYkCA3yRmxFXkxWqWj3VJZT+4OnYWcsQjmFasn+EuhHn3Cq34cSPgM/EIceqaeW5+wd0GX/fC1wwZE7QgU33zGwhif1FdTYevzYuadguwEl2Gpboxo7GjDi4BdIZIMMM0aGfWUunsS9BumnybEfm9dm6he1qHIzSX5h8qn5qzDeeKpIpqliPrp9Kc92TfRLkxlB8D0Ie60lE6VnczS3+k/ZjigUYQBAQeJLo8JKxgzVKDwfNPWFxRCrlzHbLGQTPo+zfruevdVWAasH8ZHtjvvLNqVgKIlfsJoa33RPqOxjOdHf+00dvGFjLXhPfoJa5BHkwvC6OTi8GRJv+WAVuforYZVq6SUs54vX2BEdbbFzl1MHyEGMjp/E5atvuhiyeFYXu2Eg7aEfASX+aCm9q8NuBwpPfZ0GA1Qkcj0yljeT2mRfvQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafc3eac-02fc-4336-957a-08d81eb9cef6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 18:57:46.4707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJF7fbrUQe7MjrM0qByO7i2WXiuG9oHjwi+msVZTBm5F/krJe1s8YMrP2GB0LwenyOXQI95RNh79sXo7MCgkymC5E/XCH+B9+BwC6ZJmDjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3766
Received-SPF: pass client-ip=40.107.21.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 14:57:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.07.2020 18:49, Markus Armbruster wrote:
> Convert
> 
>      foo(..., &err);
>      if (err) {
>          ...
>      }
> 
> to
> 
>      if (!foo(..., &err)) {
>          ...
>      }
> 
> for qdev_realize(), qdev_realize_and_unref(), qbus_realize() and their
> wrappers isa_realize_and_unref(), pci_realize_and_unref(),
> sysbus_realize(), sysbus_realize_and_unref(), usb_realize_and_unref().
> Coccinelle script:
> 
>      @@
>      identifier fun = {isa_realize_and_unref, pci_realize_and_unref, qbus_realize, qdev_realize, qdev_realize_and_unref, sysbus_realize, sysbus_realize_and_unref, usb_realize_and_unref};
>      expression list args, args2;
>      typedef Error;
>      Error *err;
>      @@
>      -    fun(args, &err, args2);
>      -    if (err)
>      +    if (!fun(args, &err, args2))
>           {
>               ...
>           }
> 
> Chokes on hw/arm/musicpal.c's lcd_refresh() with the unhelpful error
> message "no position information".  Nothing to convert there; skipped.
> 
> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
> ARMSSE being used both as typedef and function-like macro there.
> Converted manually.
> 
> A few line breaks tidied up manually.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>


Sorry me, reviewing this patch with help of script:
#!/usr/bin/env python3

import sys
import re

with open(sys.argv[1]) as f:
     patch = f.read()

regex = re.compile(r'^- *(?P<func_call>(?P<func>\w+)\(.*, &(?P<err>\w+)\));\n'
                    r'^- *if \((?P=err)( != NULL)?\) \{\n'
                    r'^\+ *if \(!(?P=func_call)\) \{$', flags=re.MULTILINE)

for chunk in re.split('^@', patch, flags=re.MULTILINE):
     filtered = regex.sub('OK', chunk)

     if re.search('^[+-][^+-]', filtered, flags=re.MULTILINE):
         print(re.sub('^', '   ', '@' + chunk, flags=re.MULTILINE))


funcs = set()

for m in regex.finditer(patch):
     funcs.add(m.group('func'))

print()
for func in funcs:
     print(func)


====
output:

    @@ -34,9 +34,7 @@ static void virtio_gpu_pci_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
         Error *local_error = NULL;
     
         virtio_pci_force_virtio_1(vpci_dev);
    -    qdev_realize(vdev, BUS(&vpci_dev->bus), &local_error);
    -
    -    if (local_error) {
    +    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), &local_error)) {
             error_propagate(errp, local_error);
             return;
         }
    diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
    index 67f409e106..0fc00fee1f 100644
    --- a/hw/display/virtio-vga.c
    +++ b/hw/display/virtio-vga.c
    
    @@ -444,15 +444,13 @@ static void realize_event_facility(DeviceState *dev, Error **errp)
         SCLPEventFacility *event_facility = EVENT_FACILITY(dev);
         Error *local_err = NULL;
     
    -    qdev_realize(DEVICE(&event_facility->quiesce),
    -                 BUS(&event_facility->sbus), &local_err);
    -    if (local_err) {
    +    if (!qdev_realize(DEVICE(&event_facility->quiesce),
    +                      BUS(&event_facility->sbus), &local_err)) {
             error_propagate(errp, local_err);
             return;
         }
    -    qdev_realize(DEVICE(&event_facility->cpu_hotplug),
    -                 BUS(&event_facility->sbus), &local_err);
    -    if (local_err) {
    +    if (!qdev_realize(DEVICE(&event_facility->cpu_hotplug),
    +                      BUS(&event_facility->sbus), &local_err)) {
             error_propagate(errp, local_err);
             qdev_unrealize(DEVICE(&event_facility->quiesce));
             return;
    diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
    index 142e52a8ff..0517901024 100644
    --- a/hw/s390x/s390-pci-bus.c
    +++ b/hw/s390x/s390-pci-bus.c
    

usb_realize_and_unref
sysbus_realize
sysbus_realize_and_unref
qdev_realize
qdev_realize_and_unref

===

So, the remaning non-matching seems correct, and all found functions seems to have corresponding semantics:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

