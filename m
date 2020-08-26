Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF68EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 06:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93B4206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 06:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KEPj/AWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93B4206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kApGX-0004Oi-VX
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 02:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kApFV-0003MP-8h; Wed, 26 Aug 2020 02:49:33 -0400
Received: from mail-eopbgr20101.outbound.protection.outlook.com
 ([40.107.2.101]:18404 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kApFQ-0003MD-Q2; Wed, 26 Aug 2020 02:49:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU/URaRvZ2TGbrSQG57Yhw0BgO9UihBGd1HsCeiDg1RFHg4TjaUlUE7KD2sm2ckCtvG1864YPCitT3X+ML49z2X9Nl0sa0P+q307oWSym5aHKGWe2UD5FGrOmNOJvXf8av1IGm23o+Jdz059/VjmMv3ViHgPIvxY6DluNxD1Oxt344eBx0hm/O9b55sMgX99fPZ2vy619UDVDglCpJk9a7hH6uhRoLNh3kjvUhiqbglwnKucsKNSyt4tVrRuCqAqkp9N+VR9irsEc9uvO2QT9A27f2qBiG5a2iRjUQXIoxPuqepUGHGuAe5NVaH1AnLIN+DferkeOAgAofdwop2ssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RO7QF3jIWlwvbmJRiFby+R6qaO3AmwtOz0/kwJwAzz0=;
 b=PSELiJEXn3OM5cAE3dqPrVqazLgdp+MY+GBRXfsgu8kjQjz0XeUIK+M1E9gweUmxqGOz1dK/clpdvUQf88tG8k4rt0wibEAl25Cp587JnA3Ef+oYwj9MwQ/b+Q/Z/Cr/e80sdi6w3qIkbuKAnDBeML5j+8QKw/RZ9rMEunYG7WbqhedKK/D6PhX7gP9HqWGlbmrJKC83KlwWtwCjMv8oBGSXDNR+RvA52WTL/j0ZZ/zfHVo08xEH865R1r2ueL5isVyOHbNG3Rv3G1gjzWQqmsLpztMCShRusKFja9IJfGzGBBls3oq7RzUV5RCkPHmbKLFXForEMCAGXlJOceioiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RO7QF3jIWlwvbmJRiFby+R6qaO3AmwtOz0/kwJwAzz0=;
 b=KEPj/AWyxFMzKmd0Vn1MbS8C5jWoXP5RYNoPJH6caTw8/08OsR+II0rDB4SJv2wDA6mtJIPWe3X4sYO9fKEFQ8NoFt/Cvc4BfZL3D7eHlSwE8zQxml0VCV4tMQvyV5hy3J9Je60T4HTwR87UYh4quJUuHbzdCln3t4ONE69HMf8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3543.eurprd08.prod.outlook.com (2603:10a6:20b:48::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 06:49:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%9]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 06:49:24 +0000
Subject: Re: [PATCH v5 07/10] block: introduce preallocate filter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <20200821141123.28538-8-vsementsov@virtuozzo.com>
 <9d22c3be-df5f-0bd1-0634-6217889670ec@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9195846d-13ab-67d6-dae0-f29056577be1@virtuozzo.com>
Date: Wed, 26 Aug 2020 09:49:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <9d22c3be-df5f-0bd1-0634-6217889670ec@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.10 via Frontend Transport; Wed, 26 Aug 2020 06:49:23 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f180e36-f500-4f6f-cef8-08d8498c2b4e
X-MS-TrafficTypeDiagnostic: AM6PR08MB3543:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3543471954C7C5CBC5BA16C8C1540@AM6PR08MB3543.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oe2aPIm5POVICaQPTWAlE+g1WUKVk5Bjdp59APkQIbCot3/vhx/qcA0a2Co0NL18XB9TsUMeEn1Z7KKeKiG5GBa50JX3HbDfQWEeH/RtI7JJj7BashX7qmUBeOVmi9kSmAWhK65CkWwSRXk9KxFHXRjdmNZwHJ4cIknfrIWxQXT5tktUMXb4ozmv/+0TOoiUtdTGsMquN4gQxzAMMCeZjoGjarIkn1EQzQMC9TfCh+8S9U0FJRYFtvS9U+wLjltjSt0M3NBX/td6Sxhj5qjGZ4cOILeIPIsqsuEPX9MMUB8lOqvGFjT1xkkXYiVRZaPFymhEd1IoWBwxmHqsgyo0NN2x0kALIZ5tghgntzl1M537Ry7JGPXXdLyoumet6jE0A7256C3VcgzefwleOM+1TB3TlzM8SOhMIR3tlqixjrL4f5nPxB5KlCqeRml186+gGLADOn4KEaiqC1h1zZyEbRxqdfFgupZGas3ECfSFK7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39840400004)(30864003)(66946007)(956004)(36756003)(86362001)(2616005)(478600001)(2906002)(8676002)(16576012)(4326008)(31686004)(6486002)(31696002)(8936002)(16526019)(66476007)(26005)(316002)(53546011)(52116002)(66556008)(186003)(83380400001)(5660300002)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: RDUatWSx2abt5g9/jcTzqXcd4W2LnJuuegBRxZHXMkzH7Xv2xJwxKep5A8+/Z60XPWMrXJLQnxBw22eV3F6wxM9etHRjYZcj30k7+e4FcFY/8juqhRuagjOm6oguCkuA8S6TXcE4hcBVJH+0Z/BWwQ69YtsmxAsAHVrt2CDC6vJbrL9ui7PMqvXiF7JTQkr4UeK1OhEy8pkGS5/f/g88a0fj/I14cFG2XDrOg0f1acOUsLH+yXFOdSgkwPQ31X81RyrnmV9h+fasbnAn4F92olTNhh8sE0X/LOxPC3+KnMaSfr9IPIsiJvcpjeOvV4K9MYg5ezrtGYdGv3i3gxtWKjf3ZtZiXIKaHLLdgdJ7JlA7oYUVirzuBoa0DO7zSf20Nzb589XAlU7AcGkXtJvmUTC0mC9LNt/LuBmc2fM9jfy+t8pOkqF4nr+BgGINsfziBBVk3CcK6u6g5TtilzXPDl+yNHuyuaSFYylR0Oxjx/Z6iSPuuDVLY9jeUoMCRs6cfzNdSFTP64QdG3tya0+CEyn2hXe+fI3H/rHRRXAySLudEUYvi42wV9hOdPDQvyJQkazUIraL31XeSEA4ZRau3EaihNJ/APWZZbZ/L5eBPijY2y6GTNmvx0uI21IuwiUFWzZkJiSCrbZjQydv+vholA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f180e36-f500-4f6f-cef8-08d8498c2b4e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 06:49:24.5053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2flcOWvTkW8EZe4saDoFlXR6I3k1/9UJcN9DY/yoGfJev7/pmqUEYkbBjZt3GKRsQC/kKgWJZpDzGSWvCW1Q03rbZkCf5Fs2d3zij6CoIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3543
Received-SPF: pass client-ip=40.107.2.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 02:49:25
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.08.2020 18:11, Max Reitz wrote:
> On 21.08.20 16:11, Vladimir Sementsov-Ogievskiy wrote:
>> It's intended to be inserted between format and protocol nodes to
>> preallocate additional space (expanding protocol file) on writes
>> crossing EOF. It improves performance for file-systems with slow
>> allocation.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   docs/system/qemu-block-drivers.rst.inc |  26 +++
>>   qapi/block-core.json                   |  20 +-
>>   block/preallocate.c                    | 291 +++++++++++++++++++++++++
>>   block/Makefile.objs                    |   1 +
>>   4 files changed, 337 insertions(+), 1 deletion(-)
>>   create mode 100644 block/preallocate.c
> 
> Looks good to me in essence.  Besides minor details, I wonder most about
> whether truncating the file on close can be safe, but more about that below.
> 
>> diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
>> index b052a6d14e..5e8a35c571 100644
>> --- a/docs/system/qemu-block-drivers.rst.inc
>> +++ b/docs/system/qemu-block-drivers.rst.inc
>> @@ -952,3 +952,29 @@ on host and see if there are locks held by the QEMU process on the image file.
>>   More than one byte could be locked by the QEMU instance, each byte of which
>>   reflects a particular permission that is acquired or protected by the running
>>   block driver.
>> +
>> +Filter drivers
>> +~~~~~~~~~~~~~~
>> +
>> +QEMU supports several filter drivers, which don't store any data, but do some
> 
> s/do/perform/
> 
>> +additional tasks, hooking io requests.
>> +
>> +.. program:: filter-drivers
>> +.. option:: preallocate
>> +
>> +  Preallocate filter driver is intended to be inserted between format
> 
> *The preallocate filter driver
> 
>> +  and protocol nodes and does preallocation of some additional space
> 
> I’d simplify this as s/does preallocation of/preallocates/
> 
>> +  (expanding the protocol file) on write. It may be used for
> 
> I’d complicate this as s/on write/when writing past the file’s end/, or
> “when data is written to the file after its end”, or at least “on
> post-EOF writes”.
> 
> Maybe also s/It may be used for/This can be useful for/?
> 
>> +  file-systems with slow allocation.
>> +
>> +  Supported options:
>> +
>> +  .. program:: preallocate
>> +  .. option:: prealloc-align
>> +
>> +    On preallocation, align file length to this number, default 1M.
> 
> *the file length
> 
> As for “number”...  Well, it is a number.  But “value” might fit better.
>   Or “length (in bytes)”?
> 
>> +
>> +  .. program:: preallocate
>> +  .. option:: prealloc-size
>> +
>> +    How much to preallocate, default 128M.
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 197bdc1c36..b40448063b 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2805,7 +2805,7 @@
>>               'cloop', 'compress', 'copy-on-read', 'dmg', 'file', 'ftp', 'ftps',
>>               'gluster', 'host_cdrom', 'host_device', 'http', 'https', 'iscsi',
>>               'luks', 'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels',
>> -            'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
>> +            'preallocate', 'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
>>               { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)' },
>>               'sheepdog',
>>               'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat' ] }
>> @@ -3074,6 +3074,23 @@
>>     'data': { 'aes': 'QCryptoBlockOptionsQCow',
>>               'luks': 'QCryptoBlockOptionsLUKS'} }
>>   
>> +##
>> +# @BlockdevOptionsPreallocate:
>> +#
>> +# Filter driver intended to be inserted between format and protocol node
>> +# and do preallocation in protocol node on write.
>> +#
>> +# @prealloc-align: on preallocation, align file length to this number,
>> +#                 default 1048576 (1M)
> 
> Speaking of alignment, this second line isn’t properly aligned.
> 
>> +#
>> +# @prealloc-size: how much to preallocate, default 134217728 (128M)
>> +#
>> +# Since: 5.2
>> +##
>> +{ 'struct': 'BlockdevOptionsPreallocate',
>> +  'base': 'BlockdevOptionsGenericFormat',
>> +  'data': { '*prealloc-align': 'int', '*prealloc-size': 'int' } }
>> +
>>   ##
>>   # @BlockdevOptionsQcow2:
>>   #
>> @@ -3979,6 +3996,7 @@
>>         'null-co':    'BlockdevOptionsNull',
>>         'nvme':       'BlockdevOptionsNVMe',
>>         'parallels':  'BlockdevOptionsGenericFormat',
>> +      'preallocate':'BlockdevOptionsPreallocate',
>>         'qcow2':      'BlockdevOptionsQcow2',
>>         'qcow':       'BlockdevOptionsQcow',
>>         'qed':        'BlockdevOptionsGenericCOWFormat',
>> diff --git a/block/preallocate.c b/block/preallocate.c
>> new file mode 100644
>> index 0000000000..bdf54dbd2f
>> --- /dev/null
>> +++ b/block/preallocate.c
>> @@ -0,0 +1,291 @@
>> +/*
>> + * preallocate filter driver
>> + *
>> + * The driver performs preallocate operation: it is injected above
>> + * some node, and before each write over EOF it does additional preallocating
>> + * write-zeroes request.
>> + *
>> + * Copyright (c) 2020 Virtuozzo International GmbH.
>> + *
>> + * Author:
>> + *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "qapi/error.h"
>> +#include "qemu/module.h"
>> +#include "qemu/option.h"
>> +#include "qemu/units.h"
>> +#include "block/block_int.h"
>> +
>> +
>> +typedef struct BDRVPreallocateState {
>> +    int64_t prealloc_size;
>> +    int64_t prealloc_align;
>> +
>> +    /*
>> +     * Filter is started as not-active, so it doesn't do any preallocations nor
>> +     * requires BLK_PERM_RESIZE on its child. This is needed to create filter
>> +     * above another node-child and then do bdrv_replace_node to insert the
>> +     * filter.
> 
> A bit weird, but seems fair.  It’s basically just a cache for whether
> this node has a writer on it or not.
> 
> Apart from the weirdness, I don’t understand the “another node-child”.
> Say you have “format” -> “proto”, and then you want to insert
> “prealloc”.  Wouldn’t you blockdev-add prealloc,file=proto and then
> blockdev-replace format.file=prealloc?

Yes something like this. Actually, I'm about inserting the filter automatically from block layer code, but your reasoning is about same thing and is better.

> So what is that “other node-child”?

Hmm, just my misleading wording. At least '-' in wrong place. Just "other node child", or "child of another node"..

> 
>> +     *
>> +     * Filter becomes active the first time it detects that its parents have
>> +     * BLK_PERM_RESIZE on it.
>> +     * Filter becomes active forever: it doesn't lose active status if parents
>> +     * lose BLK_PERM_RESIZE, otherwise we'll not be able to shrink the file on
>> +     * filter close.
> 
> Oh, the file is shrunk?  That wasn’t clear from the documentation.
> 
> Hm.  Seems like useful behavior.  I just wonder if keeping the
> permission around indefinitely makes sense.  Why not just truncate it
> when the permission is revoked?

How? Parent is closed earlier, so on close we will not have the permission. So, we force-keep the permission up to our close().

> 
>> +     */
>> +    bool active;
>> +
>> +    /*
>> +     * Track real data end, to crop preallocation on close  data_end may be
> 
> s/on close /when closed./
> 
>> +     * negative, which means that actual status is unknown (nothing cropped in
>> +     * this case)
>> +     */
>> +    int64_t data_end;
>> +} BDRVPreallocateState;
>> +
>> +#define PREALLOCATE_OPT_PREALLOC_ALIGN "prealloc-align"
>> +#define PREALLOCATE_OPT_PREALLOC_SIZE "prealloc-size"
>> +static QemuOptsList runtime_opts = {
>> +    .name = "preallocate",
>> +    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
>> +    .desc = {
>> +        {
>> +            .name = PREALLOCATE_OPT_PREALLOC_ALIGN,
>> +            .type = QEMU_OPT_SIZE,
>> +            .help = "on preallocation, align file length to this number, "
>> +                "default 1M",
>> +        },
>> +        {
>> +            .name = PREALLOCATE_OPT_PREALLOC_SIZE,
>> +            .type = QEMU_OPT_SIZE,
>> +            .help = "how much to preallocate, default 128M",
>> +        },
>> +        { /* end of list */ }
>> +    },
>> +};
>> +
>> +static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
>> +                            Error **errp)
>> +{
>> +    QemuOpts *opts;
>> +    BDRVPreallocateState *s = bs->opaque;
>> +
>> +    /*
>> +     * Parameters are hardcoded now. May need to add corresponding options in
>> +     * future.
>> +     */
>> +    opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
>> +    qemu_opts_absorb_qdict(opts, options, &error_abort);
>> +    s->prealloc_align =
>> +        qemu_opt_get_size(opts, PREALLOCATE_OPT_PREALLOC_ALIGN, 1 * MiB);
>> +    s->prealloc_size =
>> +        qemu_opt_get_size(opts, PREALLOCATE_OPT_PREALLOC_SIZE, 128 * MiB);
>> +    qemu_opts_del(opts);
> 
> Should we have some validation on these parameters?  Like,
> prealloc_align being at least 512, or maybe even file.request_alignment?

why not

> 
> (I suppose anything for prealloc_size is fine, though 0 doesn’t make
> much sense...)
> 
>> +
>> +    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
>> +                               BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
>> +                               false, errp);
>> +    if (!bs->file) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    s->data_end = bdrv_getlength(bs->file->bs);
>> +    if (s->data_end < 0) {
>> +        return s->data_end;
>> +    }
>> +
>> +    bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED |
>> +        (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
>> +
>> +    bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED |
>> +        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>> +            bs->file->bs->supported_zero_flags);
>> +
>> +    return 0;
>> +}
>> +
>> +static void preallocate_close(BlockDriverState *bs)
>> +{
>> +    BDRVPreallocateState *s = bs->opaque;
>> +
>> +    if (s->active && s->data_end >= 0 &&
>> +        bdrv_getlength(bs->file->bs) > s->data_end)
>> +    {
>> +        bdrv_truncate(bs->file, s->data_end, true, PREALLOC_MODE_OFF, 0, NULL);
> 
> Now that I think more about it...  What if there are other writers on
> bs->file?  This may throw data away.

Good point. Actually, if bs->file has other writing parents, the logic of the filter
around "data_end" is broken. So we must unshare WRITE and RESIZE permissions.

>  Maybe BDS.wr_highest_offset can
> help to make a better call?

Anyway, we'll have to use wr_highest_offset of the filter not the child node
(in the child wr_highest_offset will track preallocations as well), so we
want to unshare WRITE/RESIZE permissions.

> 
>> +    }
>> +}
>> +
>> +static void preallocate_child_perm(BlockDriverState *bs, BdrvChild *c,
>> +                                   BdrvChildRole role,
>> +                                   BlockReopenQueue *reopen_queue,
>> +                                   uint64_t perm, uint64_t shared,
>> +                                   uint64_t *nperm, uint64_t *nshared)
>> +{
>> +    BDRVPreallocateState *s = bs->opaque;
>> +
>> +    bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm, nshared);
>> +
>> +    s->active = s->active || (perm & BLK_PERM_RESIZE);
>> +
>> +    if (s->active) {
>> +        /* Force RESIZE permission, to be able to crop file on close() */
>> +        *nperm |= BLK_PERM_RESIZE;
>> +    }
>> +}
>> +
>> +static coroutine_fn int preallocate_co_preadv_part(
>> +        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
>> +        QEMUIOVector *qiov, size_t qiov_offset, int flags)
>> +{
>> +    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
>> +                               flags);
>> +}
>> +
>> +static int coroutine_fn preallocate_co_pdiscard(BlockDriverState *bs,
>> +                                               int64_t offset, int bytes)
>> +{
>> +    return bdrv_co_pdiscard(bs->file, offset, bytes);
>> +}
>> +
>> +static bool coroutine_fn do_preallocate(BlockDriverState *bs, int64_t offset,
>> +                                       int64_t bytes, bool write_zero)
>> +{
>> +    BDRVPreallocateState *s = bs->opaque;
>> +    int64_t len, start, end;
>> +
>> +    if (!s->active) {
>> +        return false;
>> +    }
>> +
>> +    if (s->data_end >= 0) {
>> +        s->data_end = MAX(s->data_end,
>> +                          QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE));
>> +    }
>> +
>> +    len = bdrv_getlength(bs->file->bs);
> 
> I’d rename @len so it’s clear that it has nothing to do with the request
> length.  Like, file_len.
> 
> (Because...

Ok

> 
>> +    if (len < 0) {
>> +        return false;
>> +    }
>> +
>> +    if (s->data_end < 0) {
>> +        s->data_end = MAX(len,
>> +                          QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE));
>> +    }
>> +
>> +    if (offset + bytes <= len) {
>> +        return false;
>> +    }
>> +
>> +    start = write_zero ? MIN(offset, len) : len;
> 
> ...I got confused here for a bit)
> 
>> +    end = QEMU_ALIGN_UP(offset + bytes + s->prealloc_size, s->prealloc_align);
> 
> Ah, I expected offset + s->prealloc_size.  But OK.
> 
>> +    return !bdrv_co_pwrite_zeroes(bs->file, start, end - start,
>> +            BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
>> +}
>> +
>> +static int coroutine_fn preallocate_co_pwrite_zeroes(BlockDriverState *bs,
>> +        int64_t offset, int bytes, BdrvRequestFlags flags)
>> +{
>> +    if (do_preallocate(bs, offset, bytes, true)) {
>> +        return 0;
>> +    }
>> +
>> +    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
>> +}
>> +
>> +static coroutine_fn int preallocate_co_pwritev_part(BlockDriverState *bs,
>> +                                                    uint64_t offset,
>> +                                                    uint64_t bytes,
>> +                                                    QEMUIOVector *qiov,
>> +                                                    size_t qiov_offset,
>> +                                                    int flags)
>> +{
>> +    do_preallocate(bs, offset, bytes, false);
>> +
>> +    return bdrv_co_pwritev_part(bs->file, offset, bytes, qiov, qiov_offset,
>> +                                flags);
>> +}
>> +
>> +static int coroutine_fn
>> +preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
>> +                        bool exact, PreallocMode prealloc,
>> +                        BdrvRequestFlags flags, Error **errp)
>> +{
>> +    BDRVPreallocateState *s = bs->opaque;
>> +    int ret = bdrv_co_truncate(bs->file, offset, exact, prealloc, flags, errp);
>> +
>> +    /* s->data_end may become negative here, which means unknown data end */
>> +    s->data_end = bdrv_getlength(bs->file->bs);
> 
> What would be the problem with just setting data_end = offset?  We only
> use data_end to truncate down on close, so basically repeat the
> bdrv_co_truncate() call here, which seems correct.

We can use offset only if ret >= 0 && exact is true.. But simpler is just call
bdrv_getlength() anyway.

> 
>> +
>> +    return ret;
>> +}
>> +
>> +static int coroutine_fn preallocate_co_flush(BlockDriverState *bs)
>> +{
>> +    return bdrv_co_flush(bs->file->bs);
>> +}
>> +
>> +static int64_t preallocate_getlength(BlockDriverState *bs)
>> +{
>> +    /*
>> +     * We probably can return s->data_end here, but seems safer to return real
>> +     * file length, not trying to hide the preallocation.
> 
> I don’t know.  The auto-truncation on close makes that a bit weird, in
> my opinion.  But since this filter is probably never directly below a
> BlockBackend (i.e., the length is never exposed to anything outside of
> the block layer), but always below a format driver, it should be fine.
> (In fact, those drivers do probably rather care about the true file
> length rather than whatever they may have truncated it to, so you’re
> right, it should be safer.)
> 
> Max
> 


Thanks for reviewing!


-- 
Best regards,
Vladimir

