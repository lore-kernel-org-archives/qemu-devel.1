Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F27C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B0D2065D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QveZwTmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B0D2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutkO-0001CH-37
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jutjj-0000hS-TS; Mon, 13 Jul 2020 04:22:56 -0400
Received: from mail-eopbgr70139.outbound.protection.outlook.com
 ([40.107.7.139]:11198 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jutjC-0006Ut-7b; Mon, 13 Jul 2020 04:22:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gN3wgIj8DyQAl/YPfI8lY7xDsbb0jF9UxGKYn7KY7SdBo+VPPK5BXhkONZPKGQIkgsH5cP4r33+RqhC2BcVui1b3gyfIAi70foSAUQw3+Ysod399TuOFBjDShvxxNES1qHFG0DsxPk1WKzgFPPemBJYZy6SZYQ/DAJTyyGnMvf2dPHjXVrUrnuCjfWpITKTAZY252ISBrJViBAApJHjbJw7/EzGwGdYK7e0/Y865XB82qwF6r6AF1bbS14QGWPlbSrBUYhaoER202drH1ed2zdC96/pbQDpHQTcKF3NvqYNOupPpEKS95OTwTcKnuf1LwkppR+OVhJ5YLq5radJObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQhMjcn3rbfgANGV2S/PfEVcDqfhrPLg+gFAONVISzA=;
 b=eYx1Nluxo2fRVoltBsCbq8QrUxtHeYd1MZCqfAUIuyjDZoxlC3/R+HPHmc4IyTOpla4RvAGtr2RIRNi4luYAXp5suqeGuFC/sRIyLbedYXWNnhasxoIWbre6aXyaTstYTadERMZVgpGBkrv6ANUYhfR1mnT9muHPOJCmSvRtcJMG9ERIjIklto2n5m2jq4E68zeRahcaypQCw3emqWRfOqRCtPFSi90uAXUir2l1/8BdZ0dufsVHckERZipayvUjhDgrz6xa4rfFfPSIsVjy2C3XrkUaFWjB/nEKRWAQZvwei4iSnZ+Ogf4SwS6IvL+n5obA3VmqYYfcYQBuJeAxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQhMjcn3rbfgANGV2S/PfEVcDqfhrPLg+gFAONVISzA=;
 b=QveZwTmEoRQBy9nE8//wfdorHHxhc4NOJHjSZUGNvborL8ETgAiArtrXNvULoUMPWhOZhfkM6UkcQXslbZSJhfWn/5KHQQPHbnQkkkZIm+7FbHWP5/RUWuYDDUqoVTcIa9y7JALlcd6Zrw+2Cz5EdncsPrDFqMsuSmoIiHB/ms4=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5032.eurprd08.prod.outlook.com (2603:10a6:20b:ea::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 08:22:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 08:22:15 +0000
Subject: Re: [PATCH v8 05/10] qcow2_format.py: Dump bitmap directory
 information
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1593782030-521984-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1593782030-521984-6-git-send-email-andrey.shinkevich@virtuozzo.com>
 <e3b87637-92cd-fc56-9344-c8c9d7329dd3@virtuozzo.com>
 <ca35f69b-3ab4-a0f1-9785-8354fec90d60@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <60114056-74ee-ad86-5f23-cae6a56ebbaf@virtuozzo.com>
Date: Mon, 13 Jul 2020 11:22:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <ca35f69b-3ab4-a0f1-9785-8354fec90d60@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::40) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.167) by
 AM0PR01CA0099.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Mon, 13 Jul 2020 08:22:14 +0000
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85b1930c-2005-420b-27d1-08d82705d9b2
X-MS-TrafficTypeDiagnostic: AM6PR08MB5032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB50325A3D2972845D12D0B550C1600@AM6PR08MB5032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NO5kqn/u4IFeYUbc1VgXBw674SxR/YsxkCZmNPT7pTndlRJaaGmi7bHvLvfB71k8+SnDQitTADcPeIiVNspcgSIZmTP9qcuAyuYN6cqZ1R0A0tCaZVc5uneYCcEiadPQjpreuwoRdz5pK5b3vqWaZeCH0JmmaY7n5g/whW5Nq099bMzY34kDingZ/fpVL9SwDPMFdkbeEPX+VxHzar+r8mKPmo3JcmZBQLb+lavi6VWN6tZLatijbnFi7hLMIvQR8qEkbymQf2Az2Np2SehYVkIiCdAOXf6YI307WvVNsxO5odL4HY7/NS2Y2WFUYqZHKsdL5c4Trl8FUjGKHAHQG6RtKunVMjpovY+X0TrdLtX4MO5LgkBGVl6utHrRH1WK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39840400004)(366004)(396003)(376002)(136003)(66946007)(66556008)(66476007)(316002)(16576012)(2906002)(26005)(6486002)(53546011)(36756003)(16526019)(2616005)(956004)(107886003)(186003)(31696002)(8936002)(5660300002)(86362001)(8676002)(83380400001)(478600001)(31686004)(52116002)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TQkg7Bpg5UIid7BmwBUTvv9njDmeHm+UTLvzzZ5lPvrWu26gdQj57mpHl9SwQ1lJ+fE9O60yl0Qhj0WB16asRmR3XaCylmjNGkZjYDEaOXtHj2nchYe8XR4qZaBKYU1HpXXIzGYCWisl1VIxTsIXbJoeWAYYyD9IFtg3R46cGpAruVyfRE1AsgPn1HV/ophy7H2nI3ui3/DQc7rSzyx+wFeXqc+G3oEkkQdJm3oDVcoRPkocTcc4dU3/WyifZbBoF/KCk82zloSb1WADfxxWtTr9cjl97FDsX35IguVIALjp0H74NhJyPUUVseNhONDjHRoZtSNLDR/QwBsR6qRwifqrdSAF5KyH3Upj8eQI7QbXEh2DebXC4IVMMe3rj2Yb3bSIgImM7baHWNqEx+eN4n1VUpoVV1pbKOGNrADskTHCao9vztmr4Q+my1fTnYa91h/TaWyd8OchatLOsIGOHHstnC4xETqeXn6MIqq3WQU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b1930c-2005-420b-27d1-08d82705d9b2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 08:22:15.6941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVymGvUnR0z7AGgnZuJWNWrJTn4aWmaEbD/29cdhbtZE4XymdT3C2ehLAzBgy7Hi0+0gW0L8oxnDscf0qbB9AZghbsoShBytB4ggmMI2qW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5032
Received-SPF: pass client-ip=40.107.7.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 04:22:17
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.07.2020 10:07, Andrey Shinkevich wrote:
> On 11.07.2020 22:11, Vladimir Sementsov-Ogievskiy wrote:
>> 03.07.2020 16:13, Andrey Shinkevich wrote:
>>> Read and dump entries from the bitmap directory of QCOW2 image.
>>> It extends the output in the test case #291.
>>>
>>>
> ...
>>>   diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
>>> index d8c058d..7c0dc9a 100644
>>> --- a/tests/qemu-iotests/qcow2_format.py
>>> +++ b/tests/qemu-iotests/qcow2_format.py
>>> @@ -132,6 +132,50 @@ class Qcow2BitmapExt(Qcow2Struct):
>>>         def __init__(self, fd):
>>>           super().__init__(fd=fd)
>>> +        self.read_bitmap_directory(fd)
>>> +
>>> +    def read_bitmap_directory(self, fd):
>>> +        fd.seek(self.bitmap_directory_offset)
>>> +        self.bitmap_directory = \
>>> +            [Qcow2BitmapDirEntry(fd) for _ in range(self.nb_bitmaps)]
>>
>> sounds good. I think, we should restore fd position after reading bitmap_directory, to point at the end of extension, to not break further extensions loading
>>
>>
> Yes, it is done in the constructor of QcowHeaderExtension:
> 
> if self.magic == QCOW2_EXT_MAGIC_BITMAPS:
> 
> ...
> 
> position = fd.tell()
> 
> ...
> 
> self.obj = Qcow2BitmapExt(fd=fd)
> 
> fd.seek(position)
> 

I don't like it. If you want caller to care about fd, caller should know size of created child. But passing fd to constructor implies that caller not aware of size of new created structure. So I think good api is: constuctor starts to read the structure and left after this structure on exit from consturctor (so, caller may read following structures). Constructor may read some nested structures, but is responsible for restoring fd after it.


-- 
Best regards,
Vladimir

