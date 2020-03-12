Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD9EC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D6A206E7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iLMdQ12K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D6A206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMVO-0001mN-43
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCMUb-0000yz-RU
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCMUa-0001jd-7a
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:59:13 -0400
Received: from mail-eopbgr50111.outbound.protection.outlook.com
 ([40.107.5.111]:13563 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jCMUZ-0001eK-L2; Thu, 12 Mar 2020 07:59:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8bXmmtMVf+Jytf7LTIO8R8mp2PoInAL7Hih/q4ytpJa5G9AsuEZohe2dbQi4kMnJyuhTy5UzW14VXOEt7uKUvD6is1mhjQa/xyy0J6PEWALi9l4GeMiii5ptGrgwKdFlzK4VjngIiOK8I8nsPFZN2dR1+6YXaJ5Gk3d/YE6UUbILqo7XCPI3s4IDgHW2UyDXjsaxT5JVq+G0fMFkxlGIrp8yYd7DMAnLBsJC4PnfpPyJ+0HPp+it7dS+9b7D9+PFqU72CKBNiZhbSLxjMZnxkXIDLJuHTCMM4SCB1Knbb5jCQJqCmiZC95J56ilYosyy9DnF9HaTI74Ru1kIj2n0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHwl9SbEi3VLC1HJy8Xr0YN7iyf9MFB4HNbsc9HuHw4=;
 b=G+efiB8/bHc7HNtPZIakT/o2cgGj69kyZUBNE4RD1AS9OUDXzPb6D8Gp7N6k43d2NqoGxPSVwn0Ixqzk9ogqBLKnHt/nuJqQLU8xQiRKAQQbiqPgvdATz9E1mCCuaRxULiCXAoGV4RPKfCtpVyoBjSHjyDRm0BvbnZ2iXUYKcjRgdcBgLr3Ok+c2+KMRlZUm6D12E8sjbuedQ4WqKIgF+xmTZvLxHHtzw3/8mHzu7uQ1xjcjHxF8Rp/by7nksQOzIaovSbLvqyaMSoMa4xbA5c7DkrLl3gD8YFpO1TuPXxFg3Xd1InR3CsxE+51Pwcmq4ZNn/M00ETmpLsLl/xdC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHwl9SbEi3VLC1HJy8Xr0YN7iyf9MFB4HNbsc9HuHw4=;
 b=iLMdQ12KNp6J1Xz0jHULnNRewQHRO6Z6rgABnPsQtAMIWgr0VG1YFAZsT5LDRwjdCJrSDCpThOQJ9Ypl+rrQbQeA4YlzCkQgQ7MODFhuYIWIctNBPnLNdQ2diBzgtsRA7VlmlewmcT4C3xiY2P0G1lm73TdJ5E3wZ18BmlOgHN8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4753.eurprd08.prod.outlook.com (10.255.98.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 11:59:09 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Thu, 12 Mar 2020
 11:59:08 +0000
Subject: Re: [PATCH 3/3] block: fail on open when file size is unaligned to
 request_alignment
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200130152218.7600-1-vsementsov@virtuozzo.com>
 <20200130152218.7600-4-vsementsov@virtuozzo.com>
 <4fb7d692-4009-c6a7-c765-292ac8073ae3@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200312145906444
Message-ID: <a36e50a8-38c5-027d-16b8-1daa10ed378c@virtuozzo.com>
Date: Thu, 12 Mar 2020 14:59:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <4fb7d692-4009-c6a7-c765-292ac8073ae3@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0101CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::30) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0101CA0020.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Thu, 12 Mar 2020 11:59:08 +0000
X-Tagtoolbar-Keys: D20200312145906444
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaec7f3b-273a-4be6-f210-08d7c67cc56b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4753:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4753047B09D1F74B689A49DCC1FD0@AM6PR08MB4753.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(346002)(376002)(396003)(136003)(199004)(2616005)(31686004)(956004)(36756003)(8936002)(81156014)(81166006)(8676002)(6486002)(5660300002)(66476007)(66946007)(107886003)(66556008)(53546011)(52116002)(4326008)(16576012)(2906002)(86362001)(186003)(26005)(31696002)(16526019)(478600001)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4753;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9i3DWywcK0tie5eSwZTGxXpEJbmmvoj196TalaaKlRcIt/A1aVJ3MtfoQ8hkWP0vmKOjRMw+beLqS950WBadAMkZuSt743ASTyNZElkoUFZMchN1QpB1+nj+tMtskSM3xhCRN0ndU6pqZ23zCctH9LzMqLMM8Trzg3oDs9mUZVo+L+EB7CHLP5JmbfRqri802mCcV+qciC0xZn5QfTP3CaMjZmJ0KRPs/ZEVzbCk6eGmgT+7ROB9FnwjOss9oeJcss8jqT9Nl89VD8tYav0lOHvVAGKezveVEMrbNhZktJ11tIqHofcic18Lc1XBfwvsQKDZJZURV3u03K98exSvVsGrO4blzBmD9SbAbQTHOfYDEm6RwzzNcQdJk08CCvDE9KvU36e6qvnaMNK9X+yl8enVOn1neclwZ+AFWfmuXP/zV+SGEN1xaagM4KjQEp7I
X-MS-Exchange-AntiSpam-MessageData: VXnZn1JEM3vpui2sJnv6Vq1uQYZO76W3KS1zxJfXJsbFXJi9pdXoq+57H+hVm+ULm0740LdkufNSbPPUElrf/uMrrTCqDqqimapGIpSF6yw7VTN1gHKvWAkTjZ61rMu6YP0GIlYkJJqiC6K5J3NkDA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaec7f3b-273a-4be6-f210-08d7c67cc56b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 11:59:08.8983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Byv3Z+1Mvy0pX6vdTAN7lT/rKb6+4Bbs+bjkPrE5f22Dtyb+gmv9/R55QHT2V/8ZroTrK/bmdk8fFG5tpcppcJCOJKfmMLQ4m/6z6zzTaHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4753
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.111
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

11.03.2020 14:06, Max Reitz wrote:
> On 30.01.20 16:22, Vladimir Sementsov-Ogievskiy wrote:
>> Prior to the commit the following command lead to crash:
>>
>>    ./qemu-io --image-opts -c 'write 0 512' \
>>    driver=3Dblkdebug,align=3D4096,image.driver=3Dnull-co,image.size=3D51=
2
>>
>> It failes on assertion in bdrv_aligned_pwritev:
>>    "end_sector <=3D bs->total_sectors || child->perm & BLK_PERM_RESIZE"
>>
>> The problem is obvious: 512 is aligned to 4096 and becomes larger than
>> file size. And the core bad thing is that file size is unaligned to
>> request_alignment.
>>
>> Let's catch such case on bdrv_open_driver and fail.
>=20
> I think we had a discussion on this before, but I can=92t find it right
> now.  (Although I think that had more to do with something in the
> file-posix driver, because it wasn=92t limited to alignments above 512.)
>=20
> In any case, the file itself is totally valid.  Most importantly, qcow2
> will regularly create files with unaligned file lengths.
>=20
> So let me create a qcow2 image on a 4k-aligned device:
>=20
> $ truncate 512M fs.img
> $ sudo losetup -f --show -b 4096 fs.img
> /dev/loop0
> $ sudo mkfs.ext4 /dev/loop0
> [...]
> $ sudo mount /dev/loop0 /mnt/tmp
>=20
> $ sudo ./qemu-img create -f qcow2 /mnt/tmp/foo.qcow2 64M
> Formatting '/mnt/tmp/foo.qcow2', fmt=3Dqcow2 size=3D67108864
> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> $ sudo ./qemu-io -t none -c quit /mnt/tmp/foo.qcow2
> qemu-io: can't open device /mnt/tmp/foo.qcow2: File size is unaligned to
> request alignment
>=20
> Which is too bad.

What exactly is bad?

Is it correct that create succeeded? Without new error, how would qcow2 dri=
ver
read from unaligned tail of file-posix? It will crash, isn't it?

>=20
> So the real solution would probably...  Be to align the file size up to
> the alignment?

On creation, you mean?

>=20
> Max
>=20
>> Note, that file size and request_alignment may become out of sync
>> later, so this commit is not full fix of the problem, but it's better
>> than nothing.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/block.c b/block.c
>> index ecd09dbbfd..4cfc6c33a2 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -1324,6 +1324,13 @@ static int bdrv_open_driver(BlockDriverState *bs,=
 BlockDriver *drv,
>>       assert(bdrv_min_mem_align(bs) !=3D 0);
>>       assert(is_power_of_2(bs->bl.request_alignment));
>>  =20
>> +    if (bs->bl.request_alignment > 512 &&
>> +        !QEMU_IS_ALIGNED(bs->total_sectors, bs->bl.request_alignment / =
512))
>> +    {
>> +        error_setg(errp, "File size is unaligned to request alignment")=
;
>> +        return -EINVAL;
>> +    }
>> +
>>       for (i =3D 0; i < bs->quiesce_counter; i++) {
>>           if (drv->bdrv_co_drain_begin) {
>>               drv->bdrv_co_drain_begin(bs);
>>
>=20
>=20


--=20
Best regards,
Vladimir

