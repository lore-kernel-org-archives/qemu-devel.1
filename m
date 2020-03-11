Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67820C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3114620726
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pokCTGuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3114620726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC25T-0004Pa-Bi
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jC1sS-0000HA-Ke
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jC1sQ-0004Aw-3r
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:58:28 -0400
Received: from mail-eopbgr130114.outbound.protection.outlook.com
 ([40.107.13.114]:5092 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jC1sP-00049b-EV; Wed, 11 Mar 2020 09:58:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WH2HVCyWmqKZ+PYOPIwmc8GFCJZjdK4/UomDPQPYCq4k10maBMT8HmnL0bP3UqxiAf2m/v2vd0dqpvNmZCoSleksh13ioTksTbBfw825X/1ygr7INnklmWL0IIZCqmYHYPSZxYqO/7l5mqRW3911HkshFkllJ9TZzSBAU0+cMv3PMv5JRCig6TwtEtGTu+fqDrmsaJSGatOlcD+Mpai7yHwy/R1fxvPrI3nvGlNbN9cdXVGrvIYzL2P/AVOgPjVyI5C2ts31vBzT+3Ukfhb5Ea1juDHgtKr/zROXRQoDNAe5BpHwbddY8Pe76yPtluetkpPMxCNKHo6cwuyiuHGDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/vyGycbXYNk6JV2DVwxmIbzfvEdqYK7tt67jMn1GOw=;
 b=dGDDgO05ZRvFxCU+XyqdVMkJ9dYivrK02gYxF1NUkYODF+7WDUWUGkBUhNfHqYEePxluZQqK9nuF9/bI8K6T+YPVuwoC89PrKXsIcruwSXo72nQ8XNhCIDZFxpIXYFnK06IbPJccOShQSg0keo4LI/UH2UjmOek7+yDfJgfD8lc0FUNvBvJ2/w738rt2PSxJsm4cbufuG9gc5hcX7tpzlOBXHcBqHNXkv5d5UiFz/825WzJA3ElCrrpcFBciGHQJI4ty7be9/wwRrmf32AECRgxfQyltUzriUXSpBfiJbxiZiDOBNvX3xaimDyQMQ0XKWXDw5OTePaddRzlMmhdp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/vyGycbXYNk6JV2DVwxmIbzfvEdqYK7tt67jMn1GOw=;
 b=pokCTGuz8h/CvVQPtRXur1OqQUzZkSMP0QnUQ+A3yKAgu7ioeg+RNiPtOAhCfGN4d780ve8PEUhlJUmCZ8eBesXMv5h7ifwSHl+/fRRs/NF1oK2hgCatM5m/TYO/OyLL0/4cP2nPvJw6P22CEOz4n/gVtQyW0IvnnXk4gPTQ08M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3367.eurprd08.prod.outlook.com (20.177.113.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Wed, 11 Mar 2020 13:58:21 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 13:58:21 +0000
Subject: Re: [PATCH v4 00/10] Further bitmaps improvements
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200205112041.6003-1-vsementsov@virtuozzo.com>
 <4cf33f31-cdbb-cee4-a1b4-4053c88a002e@redhat.com>
 <6b570584-100b-248f-5412-98a5d91f62f5@virtuozzo.com>
 <ca6f95ef-d51f-130a-8ad1-4eba5e0a3528@redhat.com>
 <7b655cdf-8c54-b10a-4140-2ad083dec75a@virtuozzo.com>
 <153ff5cc-a929-1aa9-c405-846739b13570@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200311165819579
Message-ID: <f3068c48-4c59-3328-5190-9e47a792ab57@virtuozzo.com>
Date: Wed, 11 Mar 2020 16:58:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <153ff5cc-a929-1aa9-c405-846739b13570@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0102CA0069.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::46) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0102CA0069.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Wed, 11 Mar 2020 13:58:21 +0000
X-Tagtoolbar-Keys: D20200311165819579
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb321078-0875-47be-d321-08d7c5c4428e
X-MS-TrafficTypeDiagnostic: AM6PR08MB3367:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3367CFE8945CBEA7E69D61FDC1FC0@AM6PR08MB3367.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(136003)(366004)(39850400004)(396003)(199004)(81166006)(52116002)(186003)(86362001)(8936002)(6486002)(8676002)(31696002)(81156014)(16576012)(2906002)(316002)(53546011)(956004)(478600001)(2616005)(4326008)(16526019)(66476007)(66946007)(36756003)(5660300002)(26005)(31686004)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3367;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: beWI0zIKVI6YSM6ntQZuxfN2BA3UoXEN8oPfLFDcAs45pv8fezqOtZD7hIOZtih+3mCvQXBsBOXZus254dI8aOXhzd2LQHZBbSmnQqQvRens4wrwk6OtdguP3/y6S9Ly8uA0nz/O/2nAoYfWb2Y4fVEsg2LyigcWSZE+DXYq9ZL97ofGhtu+QXkuWrTCrNiO9IOn4ZFo815Tj8aYCVwH+XM8Y7hyCjYmRyyIytF1FGxJ80djSv/FFcf3dLCkgpsAyet1KNrEl+HUs2G0rtgGxlaqWFEAB2pUUiE9Jbp9JW8FJUe58UGl9lz8oA3xIYnww4/GxSe6ggnXBm1bG3cla6jvhj2rhTn953cM243zEw+cOfOyHp+RlRWjLoI4xPlDtT44ZeKTnmQ2I/klFSMlFGJDG0c9Pr37UqCrHhM1eI3+ySagUsEUBMbbdHT2TvKk
X-MS-Exchange-AntiSpam-MessageData: tGsRXdLQOuMV45avNBi7WeWUrCjp9PstO2Uw+tXIAlX26sMEByn2gzWEXFWIEYFkJcpkfmRh5XCzzqCPnUpBa/YihBvR/KHYj8yoAzZyfjLNcSSxMSugM2C49TdQVhUPwpIBRe6qvKxe64XJ29m/ZQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb321078-0875-47be-d321-08d7c5c4428e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 13:58:21.9081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ffZdAdaiafvmZ92LH4gRfPPwUpGQSxGeJmGE8czDehKUd7v7lZkrCpwnBthGAvt27KZbnZPSN+FeGs3C/xTqef+nG/8Wths1AA81pKDLbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3367
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.13.114
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

11.03.2020 12:55, Max Reitz wrote:
> On 11.03.20 07:17, Vladimir Sementsov-Ogievskiy wrote:
>> 10.03.2020 20:17, Max Reitz wrote:
>>> On 06.03.20 08:45, Vladimir Sementsov-Ogievskiy wrote:
>>>> 26.02.2020 16:13, Max Reitz wrote:
>>>>> On 05.02.20 12:20, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Hi!
>>>>>>
>>>>>> The main feature here is improvement of _next_dirty_area API, which
>>>>>> I'm
>>>>>> going to use then for backup / block-copy.
>>>>>>
>>>>>> Somehow, I thought that it was merged, but seems I even forgot to se=
nd
>>>>>> v4.
>>>>>
>>>>> The changes from v3 look good to me, but I=92d prefer a review from E=
ric
>>>>> on patch 8.
>>>>>
>>>>
>>>> Hi!
>>>>
>>>> Could you take it now, or do you prefer me to resend?jjjjj
>>>
>>> I understand that you agreed to drop the comment above
>>> bd_extent_array_convert_to_be(), then do the
>>> =93s/further call/so further calls/=94 replacement, and finally replace=
 the
>>> whole four lines Eric has quoted by =93(this ensures that after a failu=
re,
>>> no further extents can accidentally change the bounds of the last exten=
t
>>> in the array)=94?
>>>
>>
>> Yes, all true.
>=20
> Hm, I could take it then, but on second thought, John is the maintainer
> for 8/10 patches, and Eric is for the other two...  So I=92m not sure
> whether I=92m even the right person to do so.
>=20

Hmm, true. Let's wait for John?


--=20
Best regards,
Vladimir

