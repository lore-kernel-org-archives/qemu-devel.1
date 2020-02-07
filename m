Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CDFC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F37F22314
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ehnMpAG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F37F22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05Xm-0003xr-PP
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j05Wl-0002Vs-4J
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j05Wj-0000Gz-I2
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:26:42 -0500
Received: from mail-eopbgr50137.outbound.protection.outlook.com
 ([40.107.5.137]:10157 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j05Wd-0008Oe-Vg; Fri, 07 Feb 2020 10:26:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMcil7M2tItdlbsznX2lDNthlXkPJvW6x+JVDAyP6nWnDl6o8J9rgH7x/JQ4VDzwa01BYIxXhFayLYumEeTcbPSCh/ybACjGamB6lhx7A41ZBck8mCiuKSZFdMr8SDqRk3NRUVGojXCfeylFRY3JVygzZBoqQp8Tb3nVlXo69C7ATou/wwMBDM7TXkFsO5bQELJu7mhs2OkztJt2Sz/ni4u/WDRIyKvvj8TKKMuIg10IaiqU7pG8fbAuKa3jsFGXiWxzc9PH+xFhHOqmXwzIfahJ0Zoy4HBntQtO7BzJQlvJZS/xdsMKRjBB2pNKzOC1rBTyN0bxNCf7al30MekvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+wyiCe6eqlvVLbAf6F4evDcnXq80b4t3MY+hxmV7EE=;
 b=kxFU++feVEFjtEeTYG/nehUOiwuMnH0n2IBZtTiu0Xhvh0w0C+5NigOlZ9ZhQuSBMaojAjDnqW+CMYcRZvOmqhQ2W9xUkEmv01gXnjY5VgbioIzF3speLtOsoAY038UeZbjOx8K9HbLnR85j2BQO3t8sfCR01DxN+Yz86teg34Qbt5130VzGw7/WjlgKRVKqp98QWSCajFHy/AANyQ5GMj3qE7jWSkUNUu10cvEg9eQurOaJ4NtYChdk9anHRDAxFHizqn/1SFfu9IPsCsHdslNaodYSifmU5vmWHs2mdYZS/LF635tvd0HjwoNVmWl/pE0Bu5GMokSCE1oz0pGjEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+wyiCe6eqlvVLbAf6F4evDcnXq80b4t3MY+hxmV7EE=;
 b=ehnMpAG+O0fqMzmgvOoC82Qg2ahj8B6Rd2RJAQVTWn872UWFD9Ez6F2vVeZ58Lg/XRkm+fJFD/1Dr6a7xGZ3JBg/cAKH0sPM/PFrif1qjEcp50rWkwq+cj++a1k5yPGVp2qWM1tTXsKAfJT70XhhcpEL9Z//nzpsvfpqForfao4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4802.eurprd08.prod.outlook.com (10.255.98.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Fri, 7 Feb 2020 15:26:29 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.023; Fri, 7 Feb 2020
 15:26:28 +0000
Subject: Re: [PATCH v3 1/1] qemu-img: Add --target-is-zero to convert
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
References: <20200204095246.1974117-1-david.edmondson@oracle.com>
 <20200204095246.1974117-2-david.edmondson@oracle.com>
 <90f3f74b-6154-d7ce-4e0e-ba4422f7da11@redhat.com>
 <91c3d45b-4c27-d366-6dd9-5c27164cce35@virtuozzo.com>
 <92ca6082-a3a6-c116-d1cc-e9810280c0c6@redhat.com>
 <38ac63ec-af49-d9d5-c1d4-e45614b71d4c@redhat.com>
 <f110458f-b3e7-6301-64bf-2b4957f3601e@virtuozzo.com>
 <570489b5-8d1b-27c4-01d3-0e63130d2c57@redhat.com>
 <bc572c68-4a4a-9734-39bb-07d78322de1b@redhat.com>
 <56483c0b-7ebc-193b-72d7-d0331eb84b09@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200207182627107
Message-ID: <fe4c87f1-cb40-0230-2194-3ad1c5dc6cfa@virtuozzo.com>
Date: Fri, 7 Feb 2020 18:26:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <56483c0b-7ebc-193b-72d7-d0331eb84b09@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR09CA0090.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::34) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR09CA0090.eurprd09.prod.outlook.com (2603:10a6:7:3d::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Fri, 7 Feb 2020 15:26:28 +0000
X-Tagtoolbar-Keys: D20200207182627107
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f18e3cf1-f038-483b-e7ed-08d7abe21a41
X-MS-TrafficTypeDiagnostic: AM6PR08MB4802:
X-Microsoft-Antispam-PRVS: <AM6PR08MB48028408FC67AB47B0826586C11C0@AM6PR08MB4802.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(396003)(376002)(366004)(39850400004)(189003)(199004)(4326008)(2906002)(16576012)(478600001)(8936002)(6486002)(81166006)(31686004)(110136005)(52116002)(316002)(66946007)(2616005)(53546011)(36756003)(16526019)(66476007)(66556008)(5660300002)(956004)(8676002)(31696002)(81156014)(186003)(86362001)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4802;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PpK9yYtJ9C5uWOe5up3IKbd2SCkeVv9n2YSYZ5ERYHsQfSsHRiL/XVwkshmanCNMr2T/Q7fRXrPPPypUC7VWU+DtI1Q1UCok3WK39iTW+OwVq6yIDhC7vpO2Lv547XwePw8pHQFONaUZ4PZ9Uvhfi0+xW9FOy5NzfvhBjjtVqrcIiGajqLTEWt0zmRroKdmet1OMbIkH4WSAxxkUsT+3ch51zLA1PYbYBIeNxztKKj+fArpb3a3KGs62keueVQ8BLwY2/M0kObPDZiDo4xlrUKTIzZhsV+vPh6zkz1C7Q1GJI3G4pBTG3liWKg4rTLq2WFAzdAihfag+6qxeRmD9uuXsWBtokr1cKWpxJhTWZ3DpuN0JgXwzouiipHaeYC274T3Axv+PL3PDI/4sfTwo6Qezv9xPmEQE6cQhVu0KBQK653M8kFtnTwQZd9ePMrzp
X-MS-Exchange-AntiSpam-MessageData: asZvL5FNaOJsY9IYN+KfZI/AKEl2GCzYLmKYWNxFvGoGyqWuqQxTZk+ANXtJ48AXbhl+px7GJLCDu5yyelAAsCNrRy29aZATMOzIvu3VsQ3nKwERedVlMs0oark4X2YmNe/N/dL5LwdUmU+elzhj9w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18e3cf1-f038-483b-e7ed-08d7abe21a41
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:26:28.8829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CG0o0/gkH8foStznHcP2bU1Ybye+ABLM7m2vpE78bVIl4vQ7r/HQBus78k8WLDTQwkbw0ELRZIrVLC97+WD1o6QKltz7dPSz74H9pXwB1vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4802
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.137
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.02.2020 18:12, Max Reitz wrote:
> On 07.02.20 15:57, Eric Blake wrote:
>> On 2/7/20 8:41 AM, Max Reitz wrote:
>>
>>>>> I could imagine a user creating a qcow2 image on some block device wi=
th
>>>>> preallocation where we cannot verify that the result will be zero.=C2=
=A0 But
>>>>> they want qemu not to zero the device, so they would specify
>>>>> --target-is-zero.
>>>>
>>>> If user create image, setting --target-is-zero is always valid. But if
>>>> we in
>>>> same operation create the image automatically, having --target-is-zero=
,
>>>> when
>>>> we know that what we are creating is not zero is misleading and should
>>>> fail..
>>>
>>> bdrv_has_zero_init() doesn=E2=80=99t return false only for images that =
we know
>>> are not zero.=C2=A0 It returns true for images where we know they are.=
=C2=A0 But
>>> if we don=E2=80=99t know, then it returns false also.
>>
>> Huh?
>>
>> bdrv_has_zero_init() currently returns 1 if a driver knows that creating
>> an image results in that image reading as 0.=C2=A0 That means it can ret=
urn 1
>> even for non-zero images that were not just created.=C2=A0 Thus, that
>> interface has both false positives (returning 1 for a non-zero image if
>> the driver hard-codes it to 1) and false negatives (returning 0 for an
>> image that happens to read as zero).=C2=A0 The false negatives are less
>> important (if we don't know if the image is already zero, then zeroing
>> it again is a waste of time but not semantically wrong) than the false
>> positives (but as long as you don't rely on bdrv_has_zero_init() unless
>> you also know the image was just created, you are safely avoiding the
>> false positives).
>>
>> And that's the whole point of my series to add a qcow2 persistent bit to
>> track whether an image has known-zero contents: qemu-img should not be
>> calling bdrv_has_zero_init(), since it is so finicky on what it means.
>=20
> Sorry, I was unclear.  I meant =E2=80=9Cthat we know are not zero immedia=
tely
> after creation=E2=80=9D.
>=20
> My point that it may return false even for (newly created) images that
> are zero stands.  One could also say it returns only =E2=80=9Cyes=E2=80=
=9D (is zero) or
> =E2=80=9Cmaybe=E2=80=9D, and not =E2=80=9Cyes=E2=80=9D or =E2=80=9Cno=E2=
=80=9D.
>=20
>>>> If we want to add a behavior to skip zeros unconditionally, we should
>>>> call new
>>>> option --skip-zeroes, to clearly specify what we want.
>>>
>>> It was my impression that this was exactly what --target-is-zero means
>>> and implies.
>>
>> --target-is-zero turns into the behavior of 'skip a pre-zeroing pass'.
>> If the destination is already zero, then copying zeroes from the source
>> is a waste of time. If the destination is not already zero, then zeroes
>> from the source are not copied, and the destination will not be
>> identical to the source.=C2=A0 We then have a choice of whether
>> --target-is-zero is merely a way to tell qemu something that it couldn't
>> learn otherwise but still be as safe as possible (if we can quickly
>> prove the target has non-zero data, the user lied about it being already
>> zero, so fail the command, so add yet another option to bypass the
>> safety check), or whether it really is synonymous with 'only copy the
>> non-zero portions of the source, and if the destination was not all zero
>> the copy is not faithful but I meant for it to be that way'.
>=20
> If you claim that it isn=E2=80=99t supposed to be an unsafe override, and=
 if we
> plan to take your series in some form or another, it follows that we
> will have to drop this patch here.
>=20
> Because after your series, qemu can have some insight into existing
> images (either in the driver=E2=80=99s implementation of make_zero, or in
> qemu-img itself by virtue of some is_zero function).  Therefore, we
> could do the same =E2=80=9Csafety check=E2=80=9D and see whether our insi=
ght agrees on
> what the user told us.
>=20
> This would make the flag completely superfluous, though, because when
> qemu knows the image to be zero, it does the right thing anyway.
>=20
> Therefore, I see this flag to be for cases where qemu doesn=E2=80=99t kno=
w.  And
> that makes it an unsafe override.
>=20


IMHO, the flag just sounds wrong for images created by Qemu, and sounds OK
for images provided by user (still, it can never be safe, as user may mista=
ke).

Still, as I understand, in most of real cases, Qemu actually can determine
is-zero by itself, we just didn't have this coded (Eric's series does). And
may be we really don't need this arguable flag..

So, really, may be rename it to --skip-zeroes, to make obvious that it is u=
nsafe
and user is responsible for the result? Or even to --x-skip-zeroes, and dro=
p it
when all needed cases are covered by auto detection?

--=20
Best regards,
Vladimir

