Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56CAC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA1521734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qmCccNPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA1521734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2AoS-0003TF-Qh
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j2AnU-0002nT-Le
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j2AnT-0004R8-Au
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:28:36 -0500
Received: from mail-eopbgr30091.outbound.protection.outlook.com
 ([40.107.3.91]:62535 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j2AnP-0004Nq-Fu; Thu, 13 Feb 2020 04:28:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6hEhBd8+Wz7wpPLUfkpFS3ORM8lY3J+hYCyiWLWl4WAhxrjIjTXxjEMNVOA5gH+O2nZa8McWfQi7btxa3TGDJp5KuUVpYNbAyEisuwK0EMS2NXL2N7FixgBDb4F3nkTNCWxaDjPg6CWfTl/DwQ6T1K0iwjiIHtZJkLsR+3TFUJsctTDbvxp9xyYTqTjlv6zOKUIZy2d0nj8cYH4arKy1u51JRpcbj076vJ5apoAPWPvvCYSUJK9gthoP5fRor60Z2SmPCA44fcS8uEK6WtbDyaSs7J9Gtd6LAWmlF0VPW87ao4Y9shWkTLWs0umM3x66gmWwk2zy4iKhLrzSu6cMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3dX9I3sHNX0cVMHjFLQbuJoUsNogf8kK9/lHjhM8rA=;
 b=kO0348mgkiYZ07a26sjmgCD6BK4sDB59AX/XeZbQnH68Bdf30nl7+PzMQfhGqEMl1+0R31bSji2cuBUdDyvrvQQENcX2m3V+eUed+2bw2gGyDRnxio5FKO0xh8jJCbxt2tPs8NyEiPLd9X0NAM8FN6A0dXN7sbM6VEsqimSfNMv6/siP9+6TuVn3mBUixgD+GgPn5hGqqbYHB6Qwte+JOpe8vwyWb+ZY893ESfsSPifmk5lJQeKDWZfh1BgClxeqk8EPxJQH0FH59nBNdXKXkYUpeWW87T3Fn/yOdjCRvxBes3OPJOIc7uuY5R41rv5o+uFf3+f55/KJN0/THZx7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3dX9I3sHNX0cVMHjFLQbuJoUsNogf8kK9/lHjhM8rA=;
 b=qmCccNPO1SP0RpU1H8J9+WwyLrIlGNuB3bZDciPMWvsq6dlY0wdSXN2PByr+J/PIDunFZlmwGBNZTYXI2ribWkNHjNMYATQe7+6DTo6F+D3E/pcyPqxRXscj+5IvyUjoi7t6gS70QFR0MRbua8DG+t9TByy45irogf+mArLA7cE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4468.eurprd08.prod.outlook.com (20.179.35.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 13 Feb 2020 09:28:28 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4%2]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 09:28:28 +0000
Subject: Re: [PATCH v2] virtio: increase virtuqueue size for virtio-scsi and
 virtio-blk
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200211141414.12149-1-dplotnikov@virtuozzo.com>
 <20200212154337.GG432724@stefanha-x1.localdomain>
 <f4e65d26-3dac-fbd5-ad63-2d2955ad8d97@virtuozzo.com>
 <20200213090851.GA542404@stefanha-x1.localdomain>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <859b35f2-b398-f744-36b4-eb604f46c8d9@virtuozzo.com>
Date: Thu, 13 Feb 2020 12:28:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200213090851.GA542404@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0201.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::25) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
Received: from [192.168.1.63] (178.34.162.46) by
 HE1PR05CA0201.eurprd05.prod.outlook.com (2603:10a6:3:f9::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23 via Frontend Transport; Thu, 13 Feb 2020 09:28:27 +0000
X-Originating-IP: [178.34.162.46]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d204167a-4a2e-4acb-ffd6-08d7b0671553
X-MS-TrafficTypeDiagnostic: AM0PR08MB4468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4468E23F0A66AFD91D0E8F39CF1A0@AM0PR08MB4468.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(366004)(136003)(346002)(39850400004)(199004)(189003)(81156014)(8676002)(52116002)(26005)(186003)(16526019)(36756003)(31696002)(81166006)(8936002)(53546011)(86362001)(16576012)(2906002)(316002)(956004)(2616005)(7416002)(966005)(5660300002)(6916009)(478600001)(66946007)(66476007)(6486002)(66556008)(107886003)(4326008)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4468;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgseVSO5JWC5ohlaFyeGTFAi8B5Vk3OEZKrk7PbqnBOWqkFftB+AKUAauOVDr2Btp45q6z3KJEdF2pyiDRYjHYIm+Xw3bx7VWK0lQd42pcu/QBpZ62ouNrBu9B7J5lw7czNQtU/deF+8OWw8LyXQpc3gLqoJCWWVZMuEqT5ehsHMeDHZoDYTCQNVHegp5noZigvgxCDiWTC0s0sMzfmKnO0HHG5nJubZYyeoqkkq38QrXGWPgfvFrmazfDdz/rxjEOlkEqMnMz2eyiEbhBO5e1620diZgeiCEybVPsHvSPsrOc1Wvq68+NTgHD9I38XRmgkAmorKVu6IL/XIpTaY0WS0RjZYMDoB67xnOFngXbJ7RfKXdn7ufPGtYYsqdPQ68SnDMokEUpJneljn+OtcMamj4/5k1sgX6x6kY8m9u/IlWbBY2ZUWlRzCYu7Uno/IGvMtzlXtFm0pmqWGkKRqVY9ifpuwspf4o8AS0UQlnz8SaKa4xoS4G/Qc6SbfBMNfLs3qV5aI2NaiyJ4TsvSQYQ==
X-MS-Exchange-AntiSpam-MessageData: D2fWOv1hrhNpC49+14O5GYELztiVNqWuURpAuWTEbKHMd0/iJ1cjUsCbY/M/y11Nv4swPoAKW/BsdL4PF4k89NR1KTXh49oPzRiluXCByylwdjU6BIksfOaaoh7nIwJM/UGhFao6u3lYRvzvvmXZfg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d204167a-4a2e-4acb-ffd6-08d7b0671553
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 09:28:28.3570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWJeEeOZexI6b1H19PALEbwd8fX2YHDoQvuKCH6Uig4UGHcmM0JaRcHcOEqGg8wXTUQbzwBTmgjNc79y8seHSjKN3WqwIfZTRsAqWo62XVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4468
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.91
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, mreitz@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 13.02.2020 12:08, Stefan Hajnoczi wrote:
> On Thu, Feb 13, 2020 at 11:08:35AM +0300, Denis Plotnikov wrote:
>> On 12.02.2020 18:43, Stefan Hajnoczi wrote:
>>> On Tue, Feb 11, 2020 at 05:14:14PM +0300, Denis Plotnikov wrote:
>>>> The goal is to reduce the amount of requests issued by a guest on
>>>> 1M reads/writes. This rises the performance up to 4% on that kind of
>>>> disk access pattern.
>>>>
>>>> The maximum chunk size to be used for the guest disk accessing is
>>>> limited with seg_max parameter, which represents the max amount of
>>>> pices in the scatter-geather list in one guest disk request.
>>>>
>>>> Since seg_max is virqueue_size dependent, increasing the virtqueue
>>>> size increases seg_max, which, in turn, increases the maximum size
>>>> of data to be read/write from a guest disk.
>>>>
>>>> More details in the original problem statment:
>>>> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
>>>>
>>>> Suggested-by: Denis V. Lunev <den@openvz.org>
>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>> ---
>>>>    hw/block/virtio-blk.c | 4 ++--
>>>>    hw/core/machine.c     | 2 ++
>>>>    hw/scsi/virtio-scsi.c | 4 ++--
>>>>    3 files changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>>>> index 09f46ed85f..6df3a7a6df 100644
>>>> --- a/hw/block/virtio-blk.c
>>>> +++ b/hw/block/virtio-blk.c
>>>> @@ -914,7 +914,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>>>>        memset(&blkcfg, 0, sizeof(blkcfg));
>>>>        virtio_stq_p(vdev, &blkcfg.capacity, capacity);
>>>>        virtio_stl_p(vdev, &blkcfg.seg_max,
>>>> -                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 - 2);
>>>> +                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 256 - 2);
>>> This value must not change on older machine types.
>> Yes, that's true, but ..
>>> So does this patch
>>> need to turn seg-max-adjust *on* in hw_compat_4_2 so that old machine
>>> types get 126 instead of 254?
>> If we set seg-max-adjust "on" in older machine types, the setups using them
>> and having queue_sizes set , for example, 1024 will also set seg_max to 1024
>> - 2 which isn't the expected behavior: older mt didn't change seg_max in
>> that case and stuck with 128 - 2.
>> So, should we, instead, leave the default 128 - 2, for seg_max?
> Argh!  Good point :-).
>
> How about a seg_max_default property that is initialized to 254 for
> modern machines and 126 to old machines?
Hmm, but we'll achieve the same but with more code changes, don't we?
254 is because the queue-size is 256. We gonna leave 128-2 for older 
machine types
just for not breaking anything. All other seg_max adjustment is provided 
by seg_max_adjust which is "on" by default in modern machine types.

to summarize:

modern mt defaults:
seg_max_adjust = on
queue_size = 256

=> default seg_max = 254
=> changing queue-size will change seg_max = queue_size - 2

old mt defaults:
seg_max_adjust = off
queue_size = 128

=> default seg_max = 126
=> changing queue-size won't change seg_max, it's always = 126 like it 
was before

Denis
>
> Stefan


