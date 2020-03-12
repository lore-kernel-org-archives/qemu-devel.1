Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8803C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79038206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IWSy95oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79038206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCJo9-0004Bg-JO
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 05:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCJnL-0003F3-5m
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCJnK-0000fD-2V
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:06:23 -0400
Received: from mail-db8eur05on2125.outbound.protection.outlook.com
 ([40.107.20.125]:18176 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jCJnJ-0000e2-Gk; Thu, 12 Mar 2020 05:06:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ti0stRQtXRSQdsh/0V9m45HbXyKv/FCUbwb/R4PMDTooxLFPDNrkHLBXuzHJDYC9l+Mj/GFNZX1xjKiDjoxs0VerQVwfdc5gaSlgZntA+c2FmqcuUAHUq1Iz4K7sx1X1rX8blE568/dOd8bcVnKtYJkzdlxY/5V7ihw0VnwRQ8Rrm3yoARqggfMzhkGhZh7aIr/JbOuGFyZZXT6vjjMU4XXxsM/ZN/paTUl6Ky5BB5K1qIcDZopNOve3Pr6IcjLPw2pcVp4JtkK8U0W5Mhu/NEUMRDRxHzYuoaKf2yY8PKGSDCZbqpea0D5jhQ9g6eVbElholR/jlf1zknRU6PJThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asDK+YUYCocOb13cTaashHlqEH6pB0bbyEZ45GloY2M=;
 b=nmnCtnJGQAUjqkJZKBA8T2wBrYR5lP/+d0gPZakgkJeTn55P2XExNezQbp41siPLJkkHlRociZceWHJeQTtVHl7IQfgMI6Png0QsG4xLA8CPYZFSVqpGkj0UTwr4KnFeXgDUSpxLvp1Jqy3V5AbpGzktA8frGUKGM+WotiTl4It19dQTNttIT3X2umJ84OhwKtLyBnX3kV/p+0xueurUcOgFQeUJam18fVCnJHtYoHS5EWwkUinLWBuBypFhkIcLU2yhmJVEz/W98aSQk2ubirbpOV9OznmNvbGqcbhIJ9n7e5qQoJVKHRgjN9qVkXuWmuRh7wnhgf/exu//b6a1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asDK+YUYCocOb13cTaashHlqEH6pB0bbyEZ45GloY2M=;
 b=IWSy95oo2Wn9JSzCVL68qzwXzDAuHBogQZLbd46ukPkqVx9ssdfYXoVwEqqloj0l1JVdReQpl2eGi2h63c7D2BLuOIRn0EflWBPvqBKJFtSNMJ5DvLEO7lT/4KQWrQxJD+fucxPPG1AwXCG6QqRt9O9IfoRr+wXvyMC7wkGI6J8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4360.eurprd08.prod.outlook.com (20.179.4.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Thu, 12 Mar 2020 09:06:18 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Thu, 12 Mar 2020
 09:06:18 +0000
Subject: Re: [PATCH 3/3] block: fail on open when file size is unaligned to
 request_alignment
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20200130152218.7600-1-vsementsov@virtuozzo.com>
 <20200130152218.7600-4-vsementsov@virtuozzo.com>
 <4fb7d692-4009-c6a7-c765-292ac8073ae3@redhat.com>
 <186c8080-a45b-0756-fa4d-c38af02f3a8b@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200312120616021
Message-ID: <c30d19ae-52c0-455e-8ff1-0af7a853ef0f@virtuozzo.com>
Date: Thu, 12 Mar 2020 12:06:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <186c8080-a45b-0756-fa4d-c38af02f3a8b@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0301CA0011.eurprd03.prod.outlook.com
 (2603:10a6:3:76::21) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0301CA0011.eurprd03.prod.outlook.com (2603:10a6:3:76::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.20 via Frontend Transport; Thu, 12 Mar 2020 09:06:17 +0000
X-Tagtoolbar-Keys: D20200312120616021
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03a7cd6d-46bb-4b44-bc3d-08d7c664a006
X-MS-TrafficTypeDiagnostic: AM6PR08MB4360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB43601E9CB0B668F6D5731D41C1FD0@AM6PR08MB4360.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(396003)(376002)(366004)(136003)(199004)(2906002)(81166006)(316002)(31686004)(956004)(110136005)(52116002)(6486002)(4326008)(81156014)(26005)(36756003)(5660300002)(8936002)(8676002)(2616005)(31696002)(478600001)(16576012)(86362001)(53546011)(66556008)(16526019)(186003)(66946007)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4360;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gg1X8sjgl1XdLgD64hS38dCXtr29cMMj9cFyn/lxnwKd340zaWuORAhmOd+w1TtkFjMxUuKpC51ffUabpX1fv0L8d908BUVuohxBqysKJwotkfq/gxtQO1CfSBBJ0nf8dCfKebnj2SHZFgRdPxUq1538Wp/aExHwmQY0QwdaUGVplvBdXlTYNcpRGKIXgBoIE/RBBN/Yr8zzDLOHM6eNdUzxwjZU73yWke+WFuc/nul1Jd/LKPZT4snMrMZ/p+ycAZ3fkpnlU2aBk6uxWFy8oRCYLGUD7sONhNid0YSxLxaszi4Vd3ZbzJJmyb8BN9owbeXQEw9H+g5oks0cLbjvOiTHged0wiHQja4QDflgfB/01WmN3mZ0FeqYDZuqjh338RAPG7co9mgWX5TJhOTbaPBX3pB55ULwjbNUccUt9cOOJbfjktARYIMsFpkyaJV4
X-MS-Exchange-AntiSpam-MessageData: Ea402QC6zdCRPf52FGTUXXAGQok+2KhQHSoHCqj7cb04JI8NwTM2OOJo7rKBLkZ9fXPE5/uMjwD7Y+24ahGh2pYP6SgZCOYF44wlTSQpK9vgBBCExkz1wD2YJpo2twGJ5z0VqS/3nYSE1XdQ2Cb99A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a7cd6d-46bb-4b44-bc3d-08d7c664a006
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:06:18.1818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXHzEoNQ3zZ/7yvCNZxiAAylK4NBB4gpI+t7GY3omPGdfJh1RAVkNJWf1jOvcwrnQr9r9HvnYLPN9MnSRpjS2+/0LapDvsfD20DSQ3pjblE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4360
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.125
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.03.2020 15:29, Eric Blake wrote:
> On 3/11/20 6:06 AM, Max Reitz wrote:
>> On 30.01.20 16:22, Vladimir Sementsov-Ogievskiy wrote:
>>> Prior to the commit the following command lead to crash:
>>>
>>> =A0=A0 ./qemu-io --image-opts -c 'write 0 512' \
>>> =A0=A0 driver=3Dblkdebug,align=3D4096,image.driver=3Dnull-co,image.size=
=3D512
>>>
>>> It failes on assertion in bdrv_aligned_pwritev:
>>> =A0=A0 "end_sector <=3D bs->total_sectors || child->perm & BLK_PERM_RES=
IZE"
>>>
>>> The problem is obvious: 512 is aligned to 4096 and becomes larger than
>>> file size. And the core bad thing is that file size is unaligned to
>>> request_alignment.
>>>
>>> Let's catch such case on bdrv_open_driver and fail.
>>
>> I think we had a discussion on this before, but I can=92t find it right
>> now.=A0 (Although I think that had more to do with something in the
>> file-posix driver, because it wasn=92t limited to alignments above 512.)
>>
>> In any case, the file itself is totally valid.=A0 Most importantly, qcow=
2
>> will regularly create files with unaligned file lengths.
>>
>> So let me create a qcow2 image on a 4k-aligned device:
>>
>> $ truncate 512M fs.img
>> $ sudo losetup -f --show -b 4096 fs.img
>> /dev/loop0
>> $ sudo mkfs.ext4 /dev/loop0
>> [...]
>> $ sudo mount /dev/loop0 /mnt/tmp
>>
>> $ sudo ./qemu-img create -f qcow2 /mnt/tmp/foo.qcow2 64M
>> Formatting '/mnt/tmp/foo.qcow2', fmt=3Dqcow2 size=3D67108864
>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> $ sudo ./qemu-io -t none -c quit /mnt/tmp/foo.qcow2
>> qemu-io: can't open device /mnt/tmp/foo.qcow2: File size is unaligned to
>> request alignment
>>
>> Which is too bad.
>>
>> So the real solution would probably...=A0 Be to align the file size up t=
o
>> the alignment?
>=20
> Or to bite the bullet and finally implement byte-accurate size everywhere=
 (instead of our current insistence on rounding size up to 512-byte multipl=
es).=A0 If we have to deal with unaligned tails anyways, it's better to mak=
e the code universally applicable whether that unaligned tail is to 512 or =
to 4k, than to have it work for 512 but to fail for 4k.
>=20

But how it helps with the problem of files unaligned to request_alignment d=
efined by driver?

--=20
Best regards,
Vladimir

