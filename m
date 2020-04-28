Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E03C83001
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37311206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UrPLIhvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37311206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQQg-0002Gw-9W
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 09:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTQO6-0005af-D0
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTQO5-0007Ki-7t
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:35:02 -0400
Received: from mail-eopbgr140123.outbound.protection.outlook.com
 ([40.107.14.123]:55975 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jTQNy-0007Id-Fl; Tue, 28 Apr 2020 09:34:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFNDDb/ybPliNVDjjiixcJigYYkkkwgicDm3g6BR5AufbJ8G0BPKepNmmMhlsLEW6BVQj9g41ZsoL2vQLR2fW3iTs9+ih6wggMwg6YhCvPP5OigArzOAyGb7Jqo/iQ3HBLyxQU3vQJv6nRQSu3lmv5BRZXo+Lxmx8jYbwDqHvFMoPlU06fI3L4nBXalWO/Nwb3nlee0qhF6XDsSS5aPQQs1lXjenorPNh00p9YfA0vYLRXdWQBXZvN6bnapenh8oUzvuXfv2doy/Wq8jUTpvNYo7jTwsEgqfDmyN9UnIgeqeAuM3vgNJwxEl3TOhrBU4Tq25a+pXSOSyw6zUP7aXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7IEGIQMUhEfSfEOitrtYLbFGW7gkyhYrHtBkMl7oU4=;
 b=AUtLlGcHpzq03yyph4BoPi5yu1iV4IYuhFZodaxAMdEgdatupWBRET5Rp1R55OnSMAluroRzDtgvai4D4iAJIuocJbgyOUmBgDyOFa0NICxLSRxG2ryYgNSzEZVZOrd1DEsqjrkMUvhE4kwS57Q0mTVj7VWZbpQUBN9mwlyNz+ob6QzCD4XOfxkLgu2mZzoG4QoDbO7SQ8/LPNqsqpj2i/KlpXbS4XzYJsVjQL9xH1k74WkvsRx+lvbfBF5V8LarCAXGxRWKxcUHMWW0mN1940u90Rq2Tn2phHiNTaLdyFKIoT07/b1o4WpSgKWHyz+R7H7MpkQS2uWctZba8rBa7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7IEGIQMUhEfSfEOitrtYLbFGW7gkyhYrHtBkMl7oU4=;
 b=UrPLIhvVX1RCB0PVC9vkU4HV+R0rUsm+1f7LCKjlf0kWATYcPIQoUoobRSMZ2O8jGc4RQlFtsXtWn1nSolfWBfK85ysQ00y5V3aimBlpT2oXTdpI75cPDo6xly4Arr2D7HhX3Ab+ykDrVjjDwH8HepmZEhj7WmkS1+G3xPrOeoE=
Authentication-Results: igalia.com; dkim=none (message not signed)
 header.d=none;igalia.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB4227.eurprd08.prod.outlook.com (2603:10a6:208:13d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Tue, 28 Apr
 2020 13:34:51 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 13:34:50 +0000
Subject: Re: [PATCH v20 4/4] iotests: 287: add qcow2 compression type test
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org
References: <20200421081117.7595-1-dplotnikov@virtuozzo.com>
 <20200421081117.7595-5-dplotnikov@virtuozzo.com>
 <c0fdc097-dabd-4661-fce9-a63a24a8d792@redhat.com>
 <64471c60-6bdd-fc7a-2dec-ff480137fec8@virtuozzo.com>
 <f96f8020-2c39-3676-3bff-d35038f6e3df@redhat.com>
 <639fc953-3e01-6ff8-460e-5f571ffca48f@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <ddd2c369-af24-e6c4-14a1-4d7beb294c82@virtuozzo.com>
Date: Tue, 28 Apr 2020 16:34:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <639fc953-3e01-6ff8-460e-5f571ffca48f@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0117.eurprd05.prod.outlook.com
 (2603:10a6:207:2::19) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.151.204) by
 AM3PR05CA0117.eurprd05.prod.outlook.com (2603:10a6:207:2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 13:34:49 +0000
X-Originating-IP: [178.34.151.204]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6df4b13-8e77-47b9-90b8-08d7eb78ed46
X-MS-TrafficTypeDiagnostic: AM0PR08MB4227:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4227C47A98D2BB71DA8653DDCFAC0@AM0PR08MB4227.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39840400004)(396003)(136003)(5660300002)(16576012)(110136005)(66946007)(66556008)(4744005)(31686004)(316002)(66476007)(2616005)(956004)(2906002)(31696002)(6486002)(52116002)(26005)(36756003)(8676002)(186003)(8936002)(16526019)(4326008)(81156014)(86362001)(53546011)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47/EDQQqk8BdyHo4ZZIn6Xd9lDtaDg9HRRsKtSZGF1kFBKiwp5Mg2+l1VUN0DrE06+0BxJiiSPFj4JzKlNknV04OWOCD5hlBgi2PP3DW1FQJjxHMXZRnHl0tnG9uBJPQHPNQXKdZAcLhPCsc4RFJ8G1OO2fdc5umiGM7TnLVRxPlYDY34Hw8ilUw8CrFjDk9F5f3Objh8XdZ2J+Pvpe4z7RygmRxekmEPbVjHNhBqnvxD2XGLaRW2evbRM/25TO2WI+R53HgAZa0SFfHwbNb2qK4s3CXbctNrVgzCv0NBTPVb4JXfDc9FgtZLoB6EZYKX6wWD/YEz0iEAqmInThRS4DMkIJILUaNV0xSnR816FtoRVjuxWOiDBpzhDtsiRf/v2ob4vpCmnrJmUxNT6Yq4g+8Q5RU/7pwcabhQVezxEbpdtCCH3CBFGeh2ASdTRev
X-MS-Exchange-AntiSpam-MessageData: 0s4bsxvWVLM5Bdm5LvtqMyu4yWSfo6LslFr28+52SGz6IE3sb82bOkRZQXNVvh9yuRGAGO2Ar4Dwf1nBJ8toWGFtbpzx5BHQeQmFn52uhcbevMvvzC9V57CV41ncLu3Ix/Q1USUrMacoN0aOBtlqkH7fkauYQTo4ueCPEkV3Dmsmn+I0ZXDCESicIKbuWMxo/DHeFxJV//Q/Me/6M2GxSIj7qlbUC9Tn3OHUJiVgS4vcJQFix2MZHdsNv+00Z6ypFImV3lHir8fJoPRixMWtascZhWsDVUl2TeB7W2N15wJIueRiEF5UJ3zT1gAWR/mO6nly0ChRe5b+QLF/doAybsm/1sejdw/s02OWgoLrEkJ4BncFz96cY8OCObCL4ah4ipyCeCcqF+pS7XA+TgjF9wM2X3ePTaWWKyZwVnkDT59/VWFAEVHQ87ZUHVBDPSkwiA0Q8vNITmiUgxEY1/dBBWSGcmQj6N7PzCNhcyCZ3SAZwTAPF+vjMe4TEWBbmUompUxd3cJ56uCyjQRnPAFqQ3n9oZr3dGdRuBj1dyJsVhMyvjwh6UmEORBrXY7aD2uyQ+550y6Qc1REps7Rtxt8o+Ox4rNHDGg4iI1wQ/qEJdC4sdq6V9m6tVzKOkN0UOzKHPWL2kCcb3hGsiZf/gygQ6pPsMsBS3DHlSXkZ4/5UY+vuwVqgPygl+UTbSupfdBKzfn6kn8iCE2dBLyEuXSE+zaU6RbtcHJwaIZNFbSNl4Ff3GmOZ2k1IzQdrac9kxFWku0COgeva6xIZRV9UZbBKljHwcLOrmCOcEHJ9Oo+lUs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6df4b13-8e77-47b9-90b8-08d7eb78ed46
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 13:34:50.7740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5G5DrYBHYgYbK9f9bGZCj3npxr+LibLpqByQOKdUN+LID2UJqPt/4cgyELkjmEUZw2Z/+XRUz/ErtZ+3/fL2MfWpTS5tHkYaTf1+WYZIew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4227
Received-SPF: pass client-ip=40.107.14.123;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 09:34:52
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.14.123
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 28.04.2020 16:01, Eric Blake wrote:
> On 4/28/20 7:55 AM, Max Reitz wrote:
>
>>>>> +# This tests qocw2-specific low-level functionality
>>>>> +_supported_fmt qcow2
>>>>> +_supported_proto file
>>>>> +_supported_os Linux
>>>> This test doesn’t work with compat=0.10 (because we can’t store a
>>>> non-default compression type there) or data_file (because those don’t
>>>> support compression), so those options should be marked as 
>>>> unsupported.
>>>>
>>>> (It does seem to work with any refcount_bits, though.)
>>>
>>> Could I ask how to achieve that?
>>> I can't find any _supported_* related.
>>
>>
>> It’s _unsupported_imgopts.
>
> Test 036 is an example of this.
Max, Eric

Thanks!

Denis
>
>


