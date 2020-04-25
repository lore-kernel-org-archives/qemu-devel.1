Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30B3C55185
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 06:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E8520728
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 06:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FAeKXbqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E8520728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSET1-0006d8-HU
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 02:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSES9-0005yb-An
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 02:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSES8-000341-UG
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 02:38:17 -0400
Received: from mail-db8eur05on2134.outbound.protection.outlook.com
 ([40.107.20.134]:4238 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSES6-0002re-5u; Sat, 25 Apr 2020 02:38:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tc9jJVz+rtVSfodOuUOmgi1qKzlNBAkvkglar7FCtRPt2/G8esNoeq7NoH9IfM8h+B27UI5dKgcSt2LiNJFy2lsRtU1oNhSRu1kNqvodZ8G57dGXQu4Eyzz+DFd+XP8hjVXWgyBUJApKgQK1jzOzMAu1E4MQoLIxBfUxctzeK50myEBiqdh30xCMv4+O8SMSPE0m4Bnr1OU5T874k/+7WEyhuqGxKVGU7xNMFe1Vgyv71FT7jwZYIQxoK3Vp73py8oR9QJslIZ7psoe/olHA2hHpNOiDFBIzw2phP/9lVeH5U1agJEG3WLsO98qxXp+/soq/tiNRRpizZje/5Niawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7DLpa8QqoJ8Wu+VRHkyOPjwYRXKSTKWIqM9Zt9sI30=;
 b=lXcKuLh7+Al0yiFuPZL3feBmLlERDK7K2rcEOiLHcQv+d47l/3PKDyASRYoyknqZ/itsaozL+k4p5wLbXlMX+ducpAwx6OGLJNiBiYX/hUkO4DiAFCp3+F0fBpyo1h5mZ3Zpa9vr7HwlxV9ktkDfxvWLWGM7jDkXMGpkspsQlgNkyNhk0sVkO0cDwkX9WjcKJ8KZ0JnK7sjK87tULjiLS+uhltErhbPKVXI2aQj3kSOH8TRAWDu4wlhsT7Zir1Hw2Ejmc4fx0iVHvI+h7AKN+3W3BNKpXx4KPQhZbHwRPAnRWEg3+DGR96qXvULGYKbH93suSGZyoY7wgznwehrVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7DLpa8QqoJ8Wu+VRHkyOPjwYRXKSTKWIqM9Zt9sI30=;
 b=FAeKXbqTPvBAKbTHyqUHGt3Bv7uEDWp06vtHOiNVV77YmuHWmGEMuQkNiyctK4zMQZcy37fs/m/WKTlGe9LIIWcmjnnnCKfTp+6OHvlxLjqLXIsdykO2edEYB4bv4FvlybRpOVIh2KdAtAFxsUqIapQRtbkT6HGHD2QoPYT8+vA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5398.eurprd08.prod.outlook.com (2603:10a6:20b:103::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sat, 25 Apr
 2020 06:38:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Sat, 25 Apr 2020
 06:38:08 +0000
Subject: Re: [PATCH v4 24/30] qcow2: Clear the L2 bitmap when allocating a
 compressed cluster
To: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <6d596d82ed62615a8565b661691a06bfaf32237e.1584468723.git.berto@igalia.com>
 <w51r1wcn7eu.fsf@maestria.local.igalia.com>
 <1606ecb5-98ea-fefb-bb98-2ecda1d65f5c@redhat.com>
 <w51o8rgn6j6.fsf@maestria.local.igalia.com>
 <57ac1a2f-1632-1a00-b18d-1fc2169175b6@redhat.com>
 <971a6e4b-ba44-4280-89fa-d454cddf12e1@virtuozzo.com>
 <w51ftcsn2uv.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200425093806347
Message-ID: <c6b6cbb2-0061-2f07-369d-2caf552d35ed@virtuozzo.com>
Date: Sat, 25 Apr 2020 09:38:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <w51ftcsn2uv.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0701CA0003.eurprd07.prod.outlook.com
 (2603:10a6:200:42::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.134) by
 AM4PR0701CA0003.eurprd07.prod.outlook.com (2603:10a6:200:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.9 via Frontend
 Transport; Sat, 25 Apr 2020 06:38:07 +0000
X-Tagtoolbar-Keys: D20200425093806347
X-Originating-IP: [185.215.60.134]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c501673-560a-414b-ebc8-08d7e8e3373d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53987958B1FF497149A6AD88C1D10@AM7PR08MB5398.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0384275935
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(136003)(6486002)(36756003)(508600001)(86362001)(8676002)(8936002)(81156014)(16526019)(31696002)(31686004)(16576012)(26005)(956004)(54906003)(110136005)(2616005)(2906002)(186003)(4326008)(66556008)(66946007)(107886003)(52116002)(66476007)(5660300002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wmnn46KSa3p0X8FFa4pPP4Yj6j8gyMppAEJnwaztSb0IAGpuyauCT2pbS9fKQ2V9FfhLAzjMCl8S5iduif2nZVNSxhTKia/qOv+XkG+Tfb5arIaey385uZQj7ckM7ndN6EgKo/qWJmPOs6GyHSg9rLWFNmrqKZ3XsgUVWVcwtGgJ3JpjflNa8wBoumzXlb6AM2OPIFFwR1cOlAeT94k+Vp9R7Gz6mlkYQoQqXxKpxhz06haeU1BRyz12P3Z/u9WgGdXnZUWA/yqSy6v/NvB/3egv6fTpgofyhibC6Dd0lGQxKtDQ/ZnqeGyshUqIvZHBCBo7l7+G1TNy9HTTKpdUBw7kv8ymWS6UnhEmrvnWBj5pk55UekT3cIWZukeM8/Nk5jXNJNEfPJFPAxMLpr4hwTvbgyQYZqT3mVVYgD2shyRwY+Hvdgo8Vd2bWAHmot3u
X-MS-Exchange-AntiSpam-MessageData: MK6lMSdgTWtWWw4ijVossb0o6pjCiKMZw7PxUQq2t7E0Bh1Txf/Ufzy2mOXtQA0izv2wFdH7oYNAcljHDyksD88/bNpAQkgSUqkxSnOcE6EJU3s54Ob5d5xcsv4LiJ2oG/XxG/YteUDKsuvX5KrzWoVoayRt6fYW5Oy0lW0YQO5mGyZ3LORijvnErZ0smTA2IaZOHQ9tlJspmt1r3vvoNP9yNtn7pRV5696T1I8QWICmXTSwKTXvo9TwwHqbqbSAdUiL8uOr7nr26u8QUvuS0z8s63aQ9tfaHgoYiVZPiFvFZXGjmwPhp80HltpTsPg66vBUML/J0t0UOA0kcIBhFwk2dIV2bc8Xf8OzKyWa5DrCiBcrr3B0Ni/33e3T9QuHQ8P1B7wGswJvaNKHK3jn0PSzVqGYBtaDfCtqBaY1siikKOamqJ+BP1RyiAGoglgYMPMI+NVIvlHfWe5umW5DKQHyw/baq5AevgKds0bMHt2xKTqwaflS7VptjIzLYmrTnrCni+iPMDITeU96iyaG641boG5bhZemR4+ITj+CfwjHWjcxAoHgCxEo8Qb+1ReZd1/YUBCaoHiYx9y8My4ztjUn3fHyflkVKScpsM8VZ3+ZwQsBNNMQPbbr++rjIJ53xScYoE//qCA33sR6ETW6RnbEpg730C/mppcu/pmIpK6noIHwV6sqrVd8rhnZVq7HZfYozNzKzpJJ1V8xgg1hfC14L+qfj39ORXRFt7lrpqgygHzAY19CceEuY7aWXnQvfhVeVZfWfVTKfJgeOLVL0fCbXC2Ih9qCUlb08tbjgqQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c501673-560a-414b-ebc8-08d7e8e3373d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2020 06:38:08.0460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfJvPvuqw060b9pixSS4dmKdxaBKLHxKRVyAUwuSeJWTKvRx+ZoMG4xfrT+G1zySYi8MhblrB/ifZ+8dhj4Gob72xC95Xi1YtSXpzgFZx0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5398
Received-SPF: pass client-ip=40.107.20.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 02:38:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.134
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.04.2020 21:41, Alberto Garcia wrote:
> On Fri 24 Apr 2020 08:15:04 PM CEST, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>> AFAIK, now compressed clusters can't be used in scenarios with guest,
>> as qcow2 driver doesn't support rewriting them.
> 
> You can write to those images just fine, it's just not efficient because
> you have to COW the compressed clusters.

No, rewriting doesn't work:

[root@kvm master]# ./qemu-img create -f qcow2 x 10M
Formatting 'x', fmt=qcow2 size=10485760 cluster_size=65536 lazy_refcounts=off refcount_bits=16
[root@kvm master]# ./qemu-io -c 'write -c 0 64K' x
wrote 65536/65536 bytes at offset 0
64 KiB, 1 ops; 00.23 sec (278.708 KiB/sec and 4.3548 ops/sec)
[root@kvm master]# ./qemu-io -c 'write -c 0 64K' x
write failed: Input/output error


> 
>> Or am I wrong? And we normally don't combine normal and compressed
>> clusters together in one image.
> 
> As soon as you start writing to an image with compressed clusters you'll
> have a combination of both.

Ah, you mean, rewriting compressed clusters by normal.. So the use-case is just take compressed backup image and use it for the guest, instead of converting first.. It makes sense.

> 
> But it's true that you don't have an image with compressed clusters if
> what you're looking for is performance. So I wouldn't add support for
> this if it complicates things too much.
> 
> Berto
> 


-- 
Best regards,
Vladimir

