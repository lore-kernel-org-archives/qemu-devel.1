Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC14CC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A417A20801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nhd9d44e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A417A20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43Uk-0005j7-Ss
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:05:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j43U0-0004xM-G9
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j43Tv-0008G3-Fs
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:04:16 -0500
Received: from mail-eopbgr80095.outbound.protection.outlook.com
 ([40.107.8.95]:65274 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j43Ts-0008Co-Ux; Tue, 18 Feb 2020 09:04:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsjbrzzST/6LmXLl0LAxjhFhVQyr6xgXslovEVmC15rwt1DR5W9EkZsJ2QLLCTYK/JFUFTfQzYlXHCfSw4weL1ISbOADcihJXYV+HvE3rDUS45K+gnkm9bQVnlU1QfWisks2Rq/OpkWi1toVOBLqNG+l3KY28Kri7P4TIapW28lSdYlcxCNzeiu7I25oaLBKZm7Qd+j0nlsJ2L5EfON9GfMWiv3fW6Dbsi4cACL+6pQGGVdDI1GwFmKECeJm1R+0mS2wS1E3mR4gaDjuoKhbYuMkv6r9Ug3SvAGGIuKw0A9VUw/SuEEPnIP+ETG3q3BcO4+Sc6d5OBij0uEXpawQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4W5fe/E2C/XCYpJUoCdZ+P/75ta+vJ4WOLtwQxLFOI=;
 b=f3LwfJxmLeo6c6ctqCFYTRDkd+nF6uPi4zPHiTyj/WAqtETRzwsA9CBZTKRwO6LqN6vmh7r69yo5r5Qeo1bJlT/XxOgR7gaf/nNfdCrOLWYyrJRbdky//Kp9III44km2GbFPB+evXR19FLbJImP6w0qVy7e0X7fFZyDCHa3arslGnOhWIwbsHdb5HhN2t+P14XOK0751QSDTHCKdCCUIUm8lWlGfuzd+sgmYX4N1520rEq1d3mPGpSkCty0YRXWi5Ms1MFvcQiUsMPCp7LyfAChjQXbdfoAPhoyQDliPqTKXpSNkudh7YMTU/bS/Sl1r4ltGX+F5Cx4L7sgW2NSsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4W5fe/E2C/XCYpJUoCdZ+P/75ta+vJ4WOLtwQxLFOI=;
 b=nhd9d44eFIorTrwyjJapgThwRDRzWApphOwhLZrtIEwRcaXsrH/ibFFJLvIGIGFW5ZiV2iS5MDPmAiKNrbHI/9Td07WOvy4tN1zs+sZPG91iboL1e2lZb2GVcoq2+fBQjRocD7hVqKWEUlZKmofPOw/T1iN50+V9PSFy8Rx2yo0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3812.eurprd08.prod.outlook.com (20.178.21.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 14:04:06 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4%2]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 14:04:06 +0000
Subject: Re: [PATCH v2] virtio: increase virtuqueue size for virtio-scsi and
 virtio-blk
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200213145927.7539-1-dplotnikov@virtuozzo.com>
 <20200218135340.GG786556@stefanha-x1.localdomain>
 <490fc138-f0c8-8daa-96a0-eb3f6067fef7@virtuozzo.com>
Message-ID: <79647178-9fc5-6e78-b67f-cf00e399cd43@virtuozzo.com>
Date: Tue, 18 Feb 2020 17:03:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <490fc138-f0c8-8daa-96a0-eb3f6067fef7@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR0102CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::34) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
Received: from [192.168.1.64] (5.138.123.75) by
 HE1PR0102CA0021.eurprd01.prod.exchangelabs.com (2603:10a6:7:14::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend
 Transport; Tue, 18 Feb 2020 14:04:03 +0000
X-Originating-IP: [5.138.123.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7257c251-5945-4604-daef-08d7b47b6ae6
X-MS-TrafficTypeDiagnostic: AM0PR08MB3812:
X-Microsoft-Antispam-PRVS: <AM0PR08MB3812CE37DF143162697CFA51CF110@AM0PR08MB3812.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(396003)(366004)(346002)(376002)(189003)(199004)(186003)(316002)(16526019)(16576012)(2906002)(8676002)(36756003)(8936002)(53546011)(86362001)(6916009)(52116002)(31696002)(26005)(31686004)(66556008)(66946007)(478600001)(966005)(956004)(2616005)(6486002)(4326008)(81166006)(7416002)(81156014)(6666004)(5660300002)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3812;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lofBF1ARWePuW0TTsyA2gDw0aREN9xarpGHkEHz78ZBueFlN9SOHMWPhc8nfl/KiMDVlVWkNY4LUwuxRrrZGgBpKQWrPeVlXzmy8woiarYM9FTDk2RKsueIIz8e4dz0Byt8JExteBLrU4XJzP0gwSVbrctID4LW9l3KwNZtGagzw0RW0up0FTQxpRYEVzHVCxpycK//dkEPryghMUAsUVGqpSxgn1CEYIuRA3zQc1FJ1qX37GU1HBrY2U82FQciqTPx+iYwU7AlFSQkcmmF8Ex5mvY0ZGfkl7ONJzAhEQtueTB64OpE0+CEDPjQjFHRShkCFxaGefqL5dl6bBZO4bGZtn7Bk19ClW71uueZPEZad/kmjiuQU5WmM4LQWX0sCD7Kn3EnS1aRlY47YwZZx5tzhWKzlpXxKHpIGl6mPtEoJpJyf42/96L9wRuaGHvelo0rRsqiZ1ahVK38vpTVKq1mnG1/UBRZyvyqvSxzCRqkvRItf02RdrCdRUiy6KZk4Z+QmrSm1Ea1zpP7/QLpW0Q==
X-MS-Exchange-AntiSpam-MessageData: MrmV7Ac+Vkp6TfORolHdfedN3DCmt5qQXlAdzGMkJgYlI6YOlyGSNGS93fDzfbapaX02n7FovU0BYK2mlevxY2+hjcELxIFKYHCB8tbPjaItQq0adP7N5zbn4TkQxdYddTlCMAgqnb9LxP5qveGjzw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7257c251-5945-4604-daef-08d7b47b6ae6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 14:04:06.4545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cMAlMPTHUOIU7PWyo/JoFVVF2DXMFCf3pyHC+M6VJ/6ndl11Ym9Ib+EiNyF4h8sPE92rDGejXQ38MruTwbh3mH04Tk2mwfBuWFNAFLK0kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3812
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.95
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



On 18.02.2020 16:59, Denis Plotnikov wrote:
>
>
> On 18.02.2020 16:53, Stefan Hajnoczi wrote:
>> On Thu, Feb 13, 2020 at 05:59:27PM +0300, Denis Plotnikov wrote:
>>> v1:
>>> =A0=A0 * seg_max default value changing removed
>>>
>>> ---
>>> The goal is to reduce the amount of requests issued by a guest on
>>> 1M reads/writes. This rises the performance up to 4% on that kind of
>>> disk access pattern.
>>>
>>> The maximum chunk size to be used for the guest disk accessing is
>>> limited with seg_max parameter, which represents the max amount of
>>> pices in the scatter-geather list in one guest disk request.
>>>
>>> Since seg_max is virqueue_size dependent, increasing the virtqueue
>>> size increases seg_max, which, in turn, increases the maximum size
>>> of data to be read/write from a guest disk.
>>>
>>> More details in the original problem statment:
>>> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
>>>
>>> Suggested-by: Denis V. Lunev <den@openvz.org>
>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>> ---
>>> =A0 hw/block/virtio-blk.c | 2 +-
>>> =A0 hw/core/machine.c=A0=A0=A0=A0 | 2 ++
>>> =A0 hw/scsi/virtio-scsi.c | 2 +-
>>> =A0 3 files changed, 4 insertions(+), 2 deletions(-)
>> I fixed up the "virtuqueue" typo in the commit message and the
>> mis-formatted commit description (git-am(1) stops including lines after
>> the first "---").
> Actually, I sent the corrected version v3 of the patch last week. But=20
> it seems it got lost among that gigantic patch flow in the mailing=20
> list :)
> Thanks for applying!
>
> Denis
>>
>> Thanks, applied to my block tree:
>> https://github.com/stefanha/qemu/commits/block
>>
>> Stefan
I'm going to send the test checking the virtqueue-sizes for machine=20
types a little bit later.

Denis


