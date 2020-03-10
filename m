Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8767C18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:16:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3D020873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J5xBZvMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3D020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBhYV-0005Db-PD
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jBhXM-0004gK-48
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jBhXK-0005rp-9E
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:15:19 -0400
Received: from mail-vi1eur04on070a.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::70a]:3519
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jBhXJ-0005iK-Di; Tue, 10 Mar 2020 12:15:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STHbuOdFPi5dwnfwfGV13QIH27cU8jewXjKUE9TIBv9hphDECvnji3IPG6q7Xu3nUXMgIwsTmN9CCErNnhIoMNa00xzWqfN8K083kM05lElTKLpYTlpOBw6pipsFVJe/I8xgnK23+rf01jZHkq6cOFXVy0SiSzixPb6A01cQ/hhRZBNcnpjeTD8/M14ZbHlQTSkwi37ycV0af+qyMrR+8AXPL17XyVoGcdGbH+PeJ+huI4l2iulummHqqAX352a08C2eMDzyJroBeNCfPUz2df1QGEdKnhrpns0WVE82pp9C2IEQZIqfagQn1rMhdmJdxktrpAdPkf/GRFVtSzItWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lwytjom3BiLibJYxc8bvVqs5pslBvwflha4MZrqDAXc=;
 b=VXEv6z8c/hCBXTWgcHCmzkX48Yn4OAdVLSJfaf1QFSe1HIQT7uH1g+CpC3SekHc3nloYyypSwiykTwVKhcva9Zz0+V4CV7Ni2ZmuxcR30onEMMHZQupXFxheOaM9EeOznctjLjtNjhHoUbW4WtTbgpcsvWkIEqMwTNqynjZ6LaD2iyCf9ckMYDxp7GAfzKH/E6xAiLUAkCVj9dxoosGTAKAdjq2iav4l1wHVh391uEljxjOCWn79IPKiJpQqUWI2kXkU7XBIKYCKeMvUCVjc+uNIELs8ARPtUokt4R6v+X9mJ6RdU7QuiixWqVd8zBzlrtHRiKIYDfpTV38BB/c0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lwytjom3BiLibJYxc8bvVqs5pslBvwflha4MZrqDAXc=;
 b=J5xBZvMra6c17ZTEiAdl9sF0SJ+Ob29yHXYPv9noWzN9xUWHP5+2GK9iFqvNB/Yn+TEW1W/5/knI41ZcaDzS5PFAMumtc+NuGAZUPduID+4dtN627XaFvFb6zepU2laqSvgmVd7UEqZnChAblpEpXEc052BxVuYb5BgzmzfwWFg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4055.eurprd08.prod.outlook.com (20.179.1.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 16:15:13 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5%7]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 16:15:13 +0000
Subject: Re: [PATCH v3 7/9] block/block-copy: rename start to offset in
 interfaces
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200306073831.7737-1-vsementsov@virtuozzo.com>
 <20200306073831.7737-8-vsementsov@virtuozzo.com>
 <826a06c1-49d0-24a0-4098-fc0ec8f9f5a0@redhat.com>
 <5b30a84f-3b03-d894-f908-b0fae89615d5@virtuozzo.com>
 <7d19fbd3-29ee-c414-38ec-1dc67735043c@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <a86a7a27-1cbf-58a2-299b-83c23972340a@virtuozzo.com>
Date: Tue, 10 Mar 2020 19:15:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <7d19fbd3-29ee-c414-38ec-1dc67735043c@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0170.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::18) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR05CA0170.eurprd05.prod.outlook.com (2603:10a6:3:f8::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Tue, 10 Mar 2020 16:15:13 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e075f613-cf6f-4877-c91c-08d7c50e36e7
X-MS-TrafficTypeDiagnostic: AM6PR08MB4055:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB40559FBC15B02FFF8E7D9027F4FF0@AM6PR08MB4055.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(346002)(39850400004)(396003)(376002)(199004)(189003)(2906002)(5660300002)(44832011)(26005)(186003)(16526019)(956004)(36916002)(53546011)(2616005)(4326008)(52116002)(31696002)(478600001)(66556008)(16576012)(110136005)(8936002)(86362001)(31686004)(81166006)(966005)(316002)(66946007)(81156014)(8676002)(36756003)(6486002)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4055;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anubrn4I4eEWN5Xwx/wtBVdKZwdGoY1ecsoIwMRwYQMfBxQA7xXqv/G5kLb5X3Usw2zMOO+BdH+kPwTCfk0Ns06HJH/qjb//0IgXyUmIalGRNfyHfEJ9M88cPs3VFi/wfBeWEAVbcB2ngcEzqpYtTNrtjytfQb6GYq27+AesFxLyeskAdQZXFE8fy8nwNitsrdbfkNd7vRYomQO4N/1FeaH/ZpyZVQ6gsCaJ7c1/ppFhpb3E8DTqZ3f3xHs6D1MpCcV8zP3MCvzFCVTsUhdLFTLPOTVMGsp3kRmml0U+zkzyg1b7SfHSfqibiMEig9dSFKvH+PRLItE2T3Ik3rp4yfRj7/AiBtCLwtlOYqSD1XZEsV6mEkpIisWJ/w5MoniA1vKB1Egx5sx+EKISZLUoXCcFumP6AtEKxSv77gG0t4BegP+jSp2iaVYdbS1e+f9HODiT0oAiPhkBa8/Q/5e66ZomJtWl4ne760zeshNVUi2riocmr9vya6yY72+2cVZSJQWCkgV/MTWhxZHl7P0LjA==
X-MS-Exchange-AntiSpam-MessageData: j0u+BBBuT1JHD5zlaq4SVzQ3D+vTuhwP1QdoykdbgUJlOqnH5dCfmqEuVBr26lGNRSbQnq2hqruWplvEeXVYObZLd4CpLV7lGNeAuKlBBn27B++5X++teNnGDBzfyL7OkVwEaifR7rHByxLXEUv2YA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e075f613-cf6f-4877-c91c-08d7c50e36e7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 16:15:13.8657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h19+6zzhaXp28/Tzocw3DTswROpQruAn5C5V3sr/i/U/JMcUyCcKWP5I/p1kuJnukF1BmAO2xYcF1DSuGJhPmnmRqG5oQYWRgeC2/5/Eyyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4055
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::70a
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/03/2020 18:14, Max Reitz wrote:
> On 10.03.20 15:55, Andrey Shinkevich wrote:
>>
>>
>> On 10/03/2020 17:50, Max Reitz wrote:
>>> On 06.03.20 08:38, Vladimir Sementsov-Ogievskiy wrote:
>>>> offset/bytes pair is more usual naming in block layer, let's use it.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  =A0 include/block/block-copy.h |=A0 4 +-
>>>>  =A0 block/block-copy.c=A0=A0=A0=A0=A0=A0=A0=A0 | 84 +++++++++++++++++=
++-------------------
>>>>  =A0 2 files changed, 44 insertions(+), 44 deletions(-)
>>>
>>> [...]
>>>
>>>> diff --git a/block/block-copy.c b/block/block-copy.c
>>>> index 4c947e548b..2b29131653 100644
>>>> --- a/block/block-copy.c
>>>> +++ b/block/block-copy.c
>>>> @@ -25,13 +25,13 @@
>>>>  =A0 #define BLOCK_COPY_MAX_MEM (128 * MiB)
>>>>  =A0 =A0 static BlockCopyInFlightReq
>>>> *find_conflicting_inflight_req(BlockCopyState *s,
>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int64_t
>>>> start,
>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int64_t
>>>> bytes)
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 int64_t
>>>> offset,
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 int64_t
>>>> bytes)
>>>
>>> The alignment=92s off now.
>>>
>>> Max
>>>
>>
>> After applying the patch, it looks aligned in my vim editor.
>=20
> I did apply it and it wasn=92t aligned for me.
>=20
> Now we (Red Hat) have some mailing agent for a couple of months now that
> for some reason likes to change incoming mails=92 encodings (in this case
> from, I presume, 8bit to quoted-printable), so I have to use a script to
> translate it back.  But judging from what I can see in the archive:
>=20
> https://lists.nongnu.org/archive/html/qemu-block/2020-03/msg00196.html
>=20
> the alignment is indeed off.  Otherwise, the second line (with the
> @bytes parameter) would not be changed.
>=20
> Max
>=20

Thank you Max for noticing that.

Andrey
--=20
With the best regards,
Andrey Shinkevich


