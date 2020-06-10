Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9ECC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9BB82078C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wWvHYfXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BB82078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0zT-0001fW-2N
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj0uF-000347-K3; Wed, 10 Jun 2020 09:36:40 -0400
Received: from mail-am6eur05on2139.outbound.protection.outlook.com
 ([40.107.22.139]:34400 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj0uD-0002Kp-Kh; Wed, 10 Jun 2020 09:36:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eS9Ql45bVwWKwXsER93FPLKWIZGZ4RjNvdADW2+mf2KhI3Ch41FO+YMC08FEPlz7aC5LCDs1KMjADg59xB6TLEDXl64VESFDoxmK5X+QPG6o5uo9RvOft9V0rVXZgHbsSddOJ8ulVCwqg7wFEUb5kHLYD8XQotK/+13SJtEzlwtmlzp8B95/vAQes9ozf7XC3cBVogmtxZmUqC2R7Sp/0JavHV+rowAr0T/aV+YqenOB/tqvqqDA+o4by3c2HmN6BNF/OiS+XCFR96FGDWBgzRddOzDtLpvTrOwC4lQkZY4WOFVSI+lUKbfd5jAZsVyVsbRhPsnaojfYb6BzAeEiPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRmV5DQIqM2Q6Y38Z+ebQQtWxza4Pwwwb9+OIQRYmgE=;
 b=Sb2uGBUaGh8+DeNe2QyqkZyKktkXtTYLxwoaf2t81cT7uxV78+L6FtFn532/zKJ8MgwpmZWCkhiDYzUEiJVP2Btc/GffSvGx8nkVVdvl8LcMo/lTCMibgYWhZiu/K8omZrq2xfxHTc89sCYXsDliFv0paDOx+o0tuEdIdFeESetCFZYqKa7sL9xmB0eujt/K58x2dtkHJF5lHFp/Lis/hgGnOPoZsxRs9dn++qYlyxnPB+qESf1Z0ff1bxXtKIKXnpT6dw2+FaWgmdS3C9mHi/y0jF/0Acd7cDed/bc0cqRP7xd/8jEJjECveHLrULD84pGkIOPI6xqBuBp1CCnUfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRmV5DQIqM2Q6Y38Z+ebQQtWxza4Pwwwb9+OIQRYmgE=;
 b=wWvHYfXjAmYrDPgqvE6glBGGQ+1jZpDpwIWQZLCAUvVjqNrQf376sBNYVaDOPFUQHO/AwP3Mq+rk5tPbQWttNwGCPCfjA/DeIovE6UFxTMXD32MiluZNuGPpfNasMbT3m1VL6PwVHmXDtbqcnUdHELPTn+yYpxV/D16PbqbRLVo=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 10 Jun
 2020 13:36:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 13:36:34 +0000
Subject: Re: Clarification regarding new qemu-img convert --target-is-zero flag
To: Sam Eiderman <sameid@google.com>, David Edmondson <dme@dme.org>
References: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
 <m2imfz877v.fsf@dme.org>
 <CAFr6bUk5LrEL8BPXYkNOqj_jsbxHBfbj_NYryUjszMtG89L+2w@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2d3e27a0-8f72-b65c-e2c8-c91f305d03ce@virtuozzo.com>
Date: Wed, 10 Jun 2020 16:36:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <CAFr6bUk5LrEL8BPXYkNOqj_jsbxHBfbj_NYryUjszMtG89L+2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0128.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::45) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.166) by
 AM0PR10CA0128.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Wed, 10 Jun 2020 13:36:33 +0000
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c36f9fe5-cf89-4226-a467-08d80d434ab3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5397:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5397F4463DE1F9E88F4309A1C1830@AM7PR08MB5397.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLxtNIHpy1sWYRHK0JRB3gM+csVCERiydOhg1VmhD6ThOoCTCbz2yrXZYz2jc6ye9mZ4OpXEr2F38aNqVOaD/VC2hI/GE1gSDyFORIJS2lEBLacmFGdcS0Kn1BUZZ9d0k9dyv+ciJIDOMAQ75VOCTrXo9no41TYt/P1zwS0nHZRAHT/OQ02uSajis3zgONDKdIe9ctR73dJBdezE7UsRt6GlWHlJfJ3bf/1AS3Iw7REqPToYNov4a28frvMkCZlv2gBNrDLRYxGTkek2Z6lFDKoQ1Ya/CV2l5FRPIC1bBCIo/Gcp9lAK4XYODfCb54gQAyJ2Ciyf8FEIpGklgDtfK/KexSmou4SxeeLR/jYl2Y/cqsF4d4sNRcy3u1YbXsTS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(136003)(39840400004)(376002)(31686004)(6486002)(8676002)(8936002)(36756003)(316002)(54906003)(186003)(110136005)(16576012)(16526019)(2906002)(86362001)(53546011)(83380400001)(2616005)(66946007)(4326008)(52116002)(5660300002)(26005)(66476007)(956004)(66556008)(31696002)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1VzY89qhvhQkIpneqG1DFe3txwi6xXR+H6LWuDbWp8LudMobWtw3SUJTdTX3WOodWa06+EgXjvnQTUKgUaRPvfQGmWwK23dCPYSkEOOPF82DvPH8zyvSTtTo73/C+hBkZXXWnrEEXSt1nz9YnGs1Cd/zZqY6U3mtj08QssYdQC3sThxfgGFZWVZYkeGVX0d8e7+rJkukFOB2gvpXHYVWSuQG3NXGi+UA3YpO7ADUInx6yAgEMpYJs8GDGuIMcaLeW9skYWR0dl4CDKDDxL9TACHgG/BeHpueM5NFuLcbN16qgJ33RE9tZTb3yAKWO44l57SlhuJZk6nI3+fmTZNzuZRk450EEZJ5Sd+OPmkeTtKheKHFXB85izxRqjnRmU2VM08BqhCxJQr1z8BjqVrBZfZ5IIoJDYGgQXfGi4HAKGvGEbfV/vob6QIWhC1KYP7qyTN4JPRWGzu2/pWm0D6tvpVeDinnw4OimGoFZQjVbGFo+58FyTmY2RMxriXNbcCf
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36f9fe5-cf89-4226-a467-08d80d434ab3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 13:36:34.1775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XE5MW9A0Fgvq0D5Xh7s5taCTPp0VPkaWTTn0qKFCZSySZSZBJLeoiidxxky3VgRU8EiXDQ0/SdHj1qtoFvrfgKU4xpvTx6ohfRIXLOIoTik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
Received-SPF: pass client-ip=40.107.22.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:36:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Tony Zhang <tzz@google.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.06.2020 15:19, Sam Eiderman wrote:
> Thanks David,
> 
> Yes, I imaging the following use case:
> 
> disk.vmdk is a 50 GB disk that contains 12 MB binary of zeroes in its beginning.
> /dev/sda is a raw disk containing garbage
> 
> I invoke:
> qemu-img convert disk.vmdk -O raw /dev/sda
> 
> Required output:
> The first 12 MB of /dev/sda contain zeros, the rest garbage, qemu-img
> finishes fast.
> 
> Kevin, from what I understood from you, this is the default behavior.
> 
> So if my VMDK is causing trouble (all virtual size is being written)
> this is probably since all the grains in the VMDK are zero allocated
> right?
> 
> Thanks!

I'm not sure that skipping unallocated clusters in qcow2/vmdk is default. As I see,
briefly looking at the code, unallocated clusters are skipped with -B option. But
it assuming using some backing file, which is not your case.

Let's check:
]# ./qemu-img create -f raw b 1M
Formatting 'b', fmt=raw size=1048576
]# ./qemu-img create -f qcow2 a 1M
Formatting 'a', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
]# ./qemu-io -c 'write -P 0xff 0 1M' -f raw b
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 00.05 sec (21.646 MiB/sec and 21.6457 ops/sec)
]# xxd b | head
00000000: ffff ffff ffff ffff ffff ffff ffff ffff  ................
00000010: ffff ffff ffff ffff ffff ffff ffff ffff  ................
00000020: ffff ffff ffff ffff ffff ffff ffff ffff  ................
00000030: ffff ffff ffff ffff ffff ffff ffff ffff  ................
00000040: ffff ffff ffff ffff ffff ffff ffff ffff  ................
00000050: ffff ffff ffff ffff ffff ffff ffff ffff  ................
00000060: ffff ffff ffff ffff ffff ffff ffff ffff  ................
00000070: ffff ffff ffff ffff ffff ffff ffff ffff  ................
00000080: ffff ffff ffff ffff ffff ffff ffff ffff  ................
00000090: ffff ffff ffff ffff ffff ffff ffff ffff  ................
]# ./qemu-img convert -f qcow2 -O raw a b
]# xxd b | head
00000000: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000020: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000030: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000040: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000050: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000060: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000070: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000080: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000090: 0000 0000 0000 0000 0000 0000 0000 0000  ................
]# ./qemu-io -c 'write -P 0xff 0 1M' -f raw b
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 00.05 sec (20.648 MiB/sec and 20.6478 ops/sec)
]# ./qemu-img create -f qcow2 base 1M
Formatting 'base', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
]# ./qemu-img convert -f qcow2 -O raw -B base a b
qemu-img: Backing file not supported for file format 'raw'


So you see, in a newly created qcow2 file all cllusters are unallocated. Still by default qemu-img convert writes all zeroes. And we can't use -B with raw tartget.

> 
> On Wed, Jun 10, 2020 at 2:56 PM David Edmondson <dme@dme.org> wrote:
>>
>> On Wednesday, 2020-06-10 at 08:28:29 +03, Sam Eiderman wrote:
>>
>>> Hi,
>>>
>>> 168468fe19c8 ("qemu-img: Add --target-is-zero to convert") has added a
>>> nice functionality for cloud scenarios:
>>>
>>> * Create a virtual disk
>>> * Convert a sparse image (qcow2, vmdk) to the virtual disk using
>>> --target-is-zero
>>> * Use the virtual disk
>>>
>>> This saves many unnecessary writes - a qcow2 with 1MB of allocated
>>> data but with 100GB virtual size will be converted efficiently.
>>>
>>> However, does this pose a problem if the virtual disk is not zero initialized?
>>
>> As Vladimir indicated, the intent of the flag is supposed to be clear
>> from the name :-) If your storage doesn't read zeroes absent any earlier
>> writes, you probably don't want to be using it.
>>
>>> Theoretically - if all unallocated blocks contain garbage - this
>>> shouldn't matter, however what about allocated blocks of zero? Will
>>> convert skip copying allocated zero blocks in the source image to the
>>> target since it assumes that the target is zeroed out first thing?
>>
>> So something like a "--no-need-to-zero" flag would do what you want,
>> presuming that it would write known zeroes but no longer clean the
>> device before use?
>>
>> dme.
>> --
>> You can't hide from the flipside.


-- 
Best regards,
Vladimir

