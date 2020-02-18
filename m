Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B84C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1071E20801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WDsyecS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1071E20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43R4-0003Ta-9E
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j43Q5-0002lO-Qm
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:00:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j43Q0-0006UN-OC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:00:13 -0500
Received: from mail-eopbgr130105.outbound.protection.outlook.com
 ([40.107.13.105]:30340 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j43Pw-0006OS-Vp; Tue, 18 Feb 2020 09:00:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSzPWitX1S5KtcLVNiAb6jl/2E+RvA9Qxbe1qO0SqrT+etO+tRnDMg4E1Wr9bYsQ4zl3Fc1aWjgvginFSwBp+tvxqrByKrjC0HCB84L6KuG33awr/Mve6GP4tFT0FfrhNQ3aAlyy1EVYgNsjoBbadb9nq+5lWIu8Oymn9KimvvtkRX/6e/PgE9xUgLw3TUNveoj8tE3Ef80Lm+NqgZchTlEJyBJYjwlL16QikeeTpw597hXJB7YpTGoB3NxJzvJ71aElsfmzIkePP3kXP53QtkcshjvOnUcoxUGSpjdxovmAnwQ8yYsSYoOTDFj0k4KHPO5403Yy9g27FbVz4sJoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3M9MUBBBi3o5UbHmL11QiAyTwqp61TSKUFVhO7nOFo=;
 b=WZBxrgANTdkGk9dqpecpvHCKcY+Y3AcTmmMXw55YEUNq50DOjXpWHcu46SyfbtzHYhs9rROrZVscyD5E6v1nSjBthfJ2i2fOdnbyvSKauCGzeASp0OTF42WKgqqShdYZCuZCPTIZhJNKx2NNsRxUK3mUMUWVHObSeqPgFZjUDd826ho/n4YITIZdjR6ZMVvblfdtFZ8BD4t3kh76StTXtJ8m1WSxMNYHIgKZnAORw9WfbGWnYyROQ2wog7WS6REXpBvUY+JZ+rfqbAyYa8SWzYp0/5TTC91aY3w69AHgEGepkeG5f5LtFsNt1sMKjl7YB/ys3XVbY3k4Vvc7aTpyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3M9MUBBBi3o5UbHmL11QiAyTwqp61TSKUFVhO7nOFo=;
 b=WDsyecS+VrBzaxiSv7vYGSwVavsPiCJjb76G88GMABwMDbwhjZSEMhnmSX2ON0xI/AVEgM5OCnWiX8DfLh1Gh16UokBm8UdLJ5VDjz/ULp4Ke+Z4MwolYUuFABnUY0gnN+jKMwk4ZvNGX/CEoicStxpdbs4aozi5NNn3c9wYXqk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3427.eurprd08.prod.outlook.com (20.177.43.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 14:00:01 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4%2]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 14:00:01 +0000
Subject: Re: [PATCH v2] virtio: increase virtuqueue size for virtio-scsi and
 virtio-blk
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200213145927.7539-1-dplotnikov@virtuozzo.com>
 <20200218135340.GG786556@stefanha-x1.localdomain>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <490fc138-f0c8-8daa-96a0-eb3f6067fef7@virtuozzo.com>
Date: Tue, 18 Feb 2020 16:59:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200218135340.GG786556@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1P192CA0014.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::24)
 To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
Received: from [192.168.1.64] (5.138.123.75) by
 HE1P192CA0014.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24 via Frontend Transport; Tue, 18 Feb 2020 13:59:59 +0000
X-Originating-IP: [5.138.123.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81a8ca6d-4fb0-4c21-8f86-08d7b47ad8dc
X-MS-TrafficTypeDiagnostic: AM0PR08MB3427:
X-Microsoft-Antispam-PRVS: <AM0PR08MB3427313A6F025A8009CD4633CF110@AM0PR08MB3427.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(136003)(39850400004)(366004)(199004)(189003)(66556008)(66476007)(66946007)(4326008)(31696002)(16576012)(2616005)(186003)(53546011)(956004)(26005)(16526019)(2906002)(86362001)(36756003)(6916009)(478600001)(6666004)(8936002)(31686004)(316002)(5660300002)(81156014)(52116002)(966005)(81166006)(7416002)(8676002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3427;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9nvpyIuXSer3fgsk4ypTu63Za1PpvfIYQqyrWEpU2wQd3ZiHYJ00LW8lkWJYlrgoyPTc65McGUri3Nzu4Z4BzZ8GtN5WGeQWOrHPA0NlWNw9i2ep+4DHOP16V/SxpgBZRKpRP2RBdRgmjBgbpWL49HpULWHeVKi/oaTApb5nuvzkVFGJYNdmLHsQIpm6lfP/9739j3P8SJqkPqfPe9ZZfW8goiv3qsB2B8jbwdNyX/sETVS912qWxl/f0Oc9iczj4FJACA3rRG3OrV14vJA/t/1ShA0T1NlcGbmf8AVODh22xaBgGI0fvaDuoMeMYbQnqcEJkjnpsaElfgHwLlbUuOX47KlWDLOa0bE3twM5fgbk9vb6JRthYhc8Y1EJyN1xfGYDQRRu+MJvKSnue8201eorN/kxxjcp2ig/4K4uz8dVJLAAyRIQIyLYgqm6u1uado/aZeHnQFwRsbQNygjHn7X1lJLqXvhis35wnIwidVeEdiUclyRQxa3MJqEGDhOttWX1+yUHnqnR2ampi1Vs5Q==
X-MS-Exchange-AntiSpam-MessageData: 3a9dlJJiV8WoFpltDmlFb0i3yCAUCNS4jfnjlkntEdLNjKCqBIdik2QVFSsD82rlIAjdVyuMHrvaefNVUAR1brJ7qk0tOylnaNoQ8wtKosPhXhKKvpBueZzhjQbMq1HyKxKamnTBrU91vLGXpOxrWQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a8ca6d-4fb0-4c21-8f86-08d7b47ad8dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 14:00:01.5416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fZj515TOejrMQvKBvdl8YuJdVwx+uKddSPJSl3be5DqZIThFWi5+0qRAAcYlfNc6mUFOkp3zZHDz/EWZSpVuLqvPSHoNRYfga3ijdbRgB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3427
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.13.105
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 18.02.2020 16:53, Stefan Hajnoczi wrote:
> On Thu, Feb 13, 2020 at 05:59:27PM +0300, Denis Plotnikov wrote:
>> v1:
>>    * seg_max default value changing removed
>>
>> ---
>> The goal is to reduce the amount of requests issued by a guest on
>> 1M reads/writes. This rises the performance up to 4% on that kind of
>> disk access pattern.
>>
>> The maximum chunk size to be used for the guest disk accessing is
>> limited with seg_max parameter, which represents the max amount of
>> pices in the scatter-geather list in one guest disk request.
>>
>> Since seg_max is virqueue_size dependent, increasing the virtqueue
>> size increases seg_max, which, in turn, increases the maximum size
>> of data to be read/write from a guest disk.
>>
>> More details in the original problem statment:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
>>
>> Suggested-by: Denis V. Lunev <den@openvz.org>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>>   hw/block/virtio-blk.c | 2 +-
>>   hw/core/machine.c     | 2 ++
>>   hw/scsi/virtio-scsi.c | 2 +-
>>   3 files changed, 4 insertions(+), 2 deletions(-)
> I fixed up the "virtuqueue" typo in the commit message and the
> mis-formatted commit description (git-am(1) stops including lines after
> the first "---").
Actually, I sent the corrected version v3 of the patch last week. But it 
seems it got lost among that gigantic patch flow in the mailing list :)
Thanks for applying!

Denis
>
> Thanks, applied to my block tree:
> https://github.com/stefanha/qemu/commits/block
>
> Stefan


