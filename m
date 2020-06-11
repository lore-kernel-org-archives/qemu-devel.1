Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C5CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D466420656
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DpA0H67P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D466420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjIps-0000Ej-0B
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 04:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjIp8-0008F6-MM; Thu, 11 Jun 2020 04:44:34 -0400
Received: from mail-eopbgr150130.outbound.protection.outlook.com
 ([40.107.15.130]:26958 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjIp6-0002zm-1t; Thu, 11 Jun 2020 04:44:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffpH+ZSXokOC0oxtp9J/x9icyyDUs6PXtWISVMEAxBZEgI4LAbvyqh43zmY8oYf45bdUZXns/5eR6HxkZJAN+XZJqpo5QNzwaW4EPVimXQCcXHv2iIPzEE4BOmRvG/GDRTIp+Dz/kA+ILcYX++053QLW2T9GJjlFFrshBumZV/BiFKA2TXyn4/qm2brgbNyl26On6Bw50JDzwxXvqyi6Hk0K9CRGmc5RToVkzPEHDS3Rc596ZYNBwVt5Q9yXbH5YPXVbjD4ZAkr6bsSgIEVx4nqLvzSo30PrN+iFiomtUE5M916/0Yje8FJ82L535lqbep/VyN3idGfW4Tog2LtPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLfkrk5oHVMVSe9JTVc7Q0cRnNSdjZxbDuc4Q9tZKig=;
 b=SVSkl0SF/gdaXRHi26NMQaPBBQljTgc5mhtiOligQPgmHwjFtSR+dC91AdB09XxNWuXgUVaRYtAFzgKkdp/7lCW0YqQ3pIP+mduaT05UWA/5sj3u8gk9BB1MSX8PmqjJvgoGGfbM9sbgOUOaBsDybUfjtTGrp3ZGjRnlD7OCITDyBs58XC+uKWx56bY8kCdbftNd2dNxO5CrDffIWCgZGxM7vzfSYzmifZ6evUab68r7Jj9Qa7xpuBF0hczTArsrT9TdS+1gEZCRvAFz64ma1YUyBTkneaa+y2T8MPpGxFDnvT8ALBW4RdBJBua3St6/Pyj2aU1VFCM2/HdCtUJLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLfkrk5oHVMVSe9JTVc7Q0cRnNSdjZxbDuc4Q9tZKig=;
 b=DpA0H67PVaeyQaqT2oBBmSj+5YCoj2nNAespIUqnsjvewL3xCymBlZpxnQ4ANvMDQV488IFr2w4pXElKIAmBB3jodlTTJHRhGDlyINdzFPCjQ3TRAG4OVJm7Egz1zeZwDFEONgpyhZiAkBGXosW79MAK40NP6yqFMtvNT5k3Uq8=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5509.eurprd08.prod.outlook.com (2603:10a6:20b:10c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 11 Jun
 2020 08:44:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 08:44:29 +0000
Subject: Re: [PATCH 2/2] qcow2: improve savevm performance
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200610190058.10781-1-den@openvz.org>
 <20200610190058.10781-3-den@openvz.org>
 <b9f05b2f-f82c-95c6-aaea-27950169fcf3@virtuozzo.com>
 <bda806a8-7363-d41c-e86b-c2f8736d5a1d@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <56f40339-033e-7b71-ee29-ce803b422f84@virtuozzo.com>
Date: Thu, 11 Jun 2020 11:44:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <bda806a8-7363-d41c-e86b-c2f8736d5a1d@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.159) by
 FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.19 via Frontend Transport; Thu, 11 Jun 2020 08:44:28 +0000
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9e0c3a8-4257-4a57-1b68-08d80de3a739
X-MS-TrafficTypeDiagnostic: AM7PR08MB5509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5509C0E6A0E149823AD7E521C1800@AM7PR08MB5509.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5owbJ43i3q20ODkUq2aPo7td9vuk7zYBitLYnKYqu9iX6x2d6wd0BLS6UgovMKH6OiW1fbcItod8/ZcxxGn/Rw+FrpHHPlVJJGm84toLqKU033aXNE0/DobbR77wwvISJRmk3Yoxdco5eIlfnOoju26v1hofW9IRgv62p5PnysuRiP9YAGB3a//Emcno/RWjoYn3pBMo2R+rdJ2+BKPDVnl+Nr5sWsFH4FssCR3HbUEh4D7pn6CkQ48ovjLY/w3SIdOIuFWjVjCS4r8kAYuPTmaundbIbf5XlvwEX/+KzWADhG1EhULxfxygrSrNhozT/rD6LGs2IHFvfjfNlO/2TzDHUwNyC8NYGkLZ9AV9p7N2FvS2YjTtBCctSnLe1Qo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(16576012)(478600001)(2906002)(86362001)(31686004)(52116002)(5660300002)(6486002)(36756003)(4326008)(83380400001)(31696002)(66946007)(316002)(956004)(66556008)(8676002)(54906003)(186003)(8936002)(53546011)(66476007)(16526019)(2616005)(26005)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 2Hy3dR6qVadp9FgJ5N68iZ57l4PFu8os2HnZUIHCZOIRQ0gYyuoNbpVYof3rGnkThD952BY6aSyDXXQjqJZn5dkHLSZAxX92YSS/DVjbEtU6f5q+xMd8AustawJOmXW69LCYb+VXDv4DpsuAhAfcBAgIKmN8zbdFTPvJP3Fic0XfIhCi3qXWW9+iRLktUyinvQJr8AAfAZDt5Yj3gi2K+xbvhKqIl5tCMnQSSFIoB8ZMd7BXwt0RBlcbu4Lhe8mgGiX9ThW87JJNTG4Ec8PE7a32dUqWKMET1QtTtBcOcjxpa3629bugMOKfaKPg/PDONyJdDlbXVA0z3ugQf9jVJVY1Xy8B46htIc3vK8b/gW18GKDfIo84L1WWT2thxFLxDX38SZ9ypD+B0esoQNfjLxAJuyMTqMiMrsrl2j2LDWPts72AE/VEwmD2WFGAJGdHEfh26blGiukShJBaEX7N63NRmioog3ZIpcLnXnY78KJrchQZI535/QOiiRk4VAVQ
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e0c3a8-4257-4a57-1b68-08d80de3a739
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 08:44:28.9121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQcfisCZDUFNpemAWEZvhSWJI/QLYtaElrvZFfLM8J2p8/8qG6HOmDIRTlS95ErFrENNVBrbt9T9WtzysOZ5JMTkGfWh0e5xzuf51qmWxKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5509
Received-SPF: pass client-ip=40.107.15.130;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 04:44:29
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
Cc: Kevin Wolf <kwolf@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.06.2020 11:25, Denis V. Lunev wrote:
> On 6/11/20 11:04 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 10.06.2020 22:00, Denis V. Lunev wrote:
>>> This patch does 2 standard basic things:
>>> - it creates intermediate buffer for all writes from QEMU migration code
>>>     to QCOW2 image,
>>> - this buffer is sent to disk asynchronously, allowing several writes to
>>>     run in parallel.
>>>
>>> In general, migration code is fantastically inefficent (by observation),
>>> buffers are not aligned and sent with arbitrary pieces, a lot of time
>>> less than 100 bytes at a chunk, which results in read-modify-write
>>> operations with non-cached operations. It should also be noted that all
>>> operations are performed into unallocated image blocks, which also
>>> suffer
>>> due to partial writes to such new clusters.
>>>
>>> Snapshot creation time (2 GB Fedora-31 VM running over NVME storage):
>>>                   original     fixed
>>> cached:          1.79s       1.27s
>>> non-cached:      3.29s       0.81s
>>>
>>> The difference over HDD would be more significant :)
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>
>> If I follow correctly, you make qcow2_save_vmstate implicitly
>> asynchronous:
>> it may return immediately after creating a task, and task is executing in
>> parallel.
>>
>> I think, block-layer is unprepared for such behavior, it rely on the
>> fact that
>> .bdrv_save_vmstate is synchronous.
>>
>> For example, look at bdrv_co_rw_vmstate(). It calls
>> drv->bdrv_save_vmstate
>> inside pair of bdrv_inc_in_flight()/bdrv_dec_in_flight(). It means
>> that with
>> this patch, we may break drained section.
>>
> Drained sections are not involved into the equation - the guest
> is stopped at the moment.
> 
> If we are talking about in_flight count, it should not be a problem
> even if the guest is running. We could just put inc/dec into
> qcow2_co_vmstate_task_entry().

No, we at least should do "inc" in qcow2_save_vmstate, when we are inside
original generic inc/dec. Not a big deal still.

> 
>> Next, it's a kind of cache for vmstate-write operation. It seems for
>> me that
>> it's not directly related to qcow2. So, we can implement it in generic
>> block
>> layer, where we can handle in_fligth requests. Can we keep
>> .bdrv_save_vmstate
>> handlers of format drivers as is, keep them synchronous, but instead
>> change
>> generic interface to be (optionally?) cached?
> 
> This has been discussed already in the previous thread. .bdrv_save_vmstate
> is implemented in QCOW2 and sheepdog only. Thus other formats are
> mostly non-interested.

Hmm, yes, sorry, I forget. It seems that sheepdoc project is dead. Who knows,
is it correct?

OK, it's probably OK to make the interface optianally-async, if we add in-flight
request correctly but at least we should document it around .bdrv_save_vmstate
handler declaration.



-- 
Best regards,
Vladimir

