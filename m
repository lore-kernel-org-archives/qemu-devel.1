Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FD2C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B752074F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NxD3m7+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B752074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Peu-00055A-N2
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k0Pdq-0003pJ-4l; Tue, 28 Jul 2020 09:27:38 -0400
Received: from mail-eopbgr70110.outbound.protection.outlook.com
 ([40.107.7.110]:14954 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k0Pdm-0000eM-8k; Tue, 28 Jul 2020 09:27:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpEILGB2nU/frGr+InQau++5Axig/A7QOFNTi/32++gHU34kCh8C+qRrr2KJgOwBI1ML+5k/XRwyKudRHxI2lFKLjOJ42yODB3+eoCSCufEOAwXpQw43zy5P/ePF5wykpUdvaO/4zbJ5pykDA0cWV/RbBCYfX6AknYICVc7qf1RLLQS7MXLUIF5xeowQmq1vZBTnxqu+M46cXolha3NVctRGWrgaEUxFJuIScdNZCmBmKDG5AKJOy8NUk/y/MgvDKUFkqOv5KlXIde9PabeuwdK1tgPWU+M7RXh8aJn5VjB2DKrPvwQKAP+8+g88UEEdB06PxY9M6aqVuY+rQRDACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TPEol2OjoKHUsUn0fUcGCcXbsAKuLXjoawLZrCZXqY=;
 b=IIabt3nj23IzB+FtO7mflj4cYUb61sXSZULxTVetFsFnsolYj2IQuIkNlv++YCmkELXdTkv10clCR/G5VNPJVVw3kvOL61zDSz9j+ofKPfcw4Nlr78qqwxJnLPx5pJtmBS/3HsXREBTI8l6tDqxejF8DqAoDc15bE1/kjbG+QiDQSj5NCfAEGu1ZvBIUNTELkVxqSXwTrOI8IshTCXoiThcoFIKjuK5Ch2UOUeNr2mRGg4Xhim5zB3sjyRatfdO0XvWHdynF6Q6egHTt6s7lmXZm71autd5AykyGX46HeT2UrZorFK6csBwcD5RLo99butfy01BXBzQ7hqxrqt0g4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TPEol2OjoKHUsUn0fUcGCcXbsAKuLXjoawLZrCZXqY=;
 b=NxD3m7+5Gu4IGBGirwK+blQdLHdL1TSvS4lcDZCF0Xtha7JyTW6kMGTgxwIbJb1GfL1+L/R/hbucUMrkLO11wK6VdFGNYw723IfyPimKBuLiA7Sr6qkm9m23p5bUed+3WcaXZJyRsgzDR62d7Tmsbdeuyifi9bsin0ZyQPRZVxQ=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB4079.eurprd08.prod.outlook.com (2603:10a6:803:e4::19)
 by VI1PR08MB3007.eurprd08.prod.outlook.com (2603:10a6:803:4a::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 13:27:26 +0000
Received: from VI1PR08MB4079.eurprd08.prod.outlook.com
 ([fe80::20fe:9b19:3990:3b2f]) by VI1PR08MB4079.eurprd08.prod.outlook.com
 ([fe80::20fe:9b19:3990:3b2f%3]) with mapi id 15.20.3216.034; Tue, 28 Jul 2020
 13:27:25 +0000
Subject: Re: [PATCH v11 10/11] qcow2_format.py: introduce
 Qcow2HeaderExtensionsDoc class
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594973699-781898-11-git-send-email-andrey.shinkevich@virtuozzo.com>
 <db73d013-832d-234c-7828-80d8b1ed962e@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <d2752450-0c26-a40e-3dc8-e095e7009919@virtuozzo.com>
Date: Tue, 28 Jul 2020 16:27:17 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <db73d013-832d-234c-7828-80d8b1ed962e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR04CA0140.eurprd04.prod.outlook.com
 (2603:10a6:208:55::45) To VI1PR08MB4079.eurprd08.prod.outlook.com
 (2603:10a6:803:e4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM0PR04CA0140.eurprd04.prod.outlook.com (2603:10a6:208:55::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Tue, 28 Jul 2020 13:27:21 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 837c708f-24dd-4c25-56f5-08d832f9f7a2
X-MS-TrafficTypeDiagnostic: VI1PR08MB3007:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB30075DC2B6C568350D8B07A9F4730@VI1PR08MB3007.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJWnlzcSRjOKHUpb/nP5/ueD6/eS2bnfkO/f3FAf0at1XmnzlLrq+EBliSYf3mM92ffVCpajRohSJjtexjuPA5XmvvABiCBC2/abL6+Krh8geaHWtFW5ndbARbq7Fswtn6b0YOwFPzWgQKLTCZdfc8V6h41nkjIapOcmYwwRg2m20o/I35OOblzXjV+z+GdfXd5zpxpPcN5MLBNVeo1cEXN9m+BO5uuf1UR76xqv/6HWRFzzlVDrQfif8RqQKK6HcTgP9gnlegCYFIQLD9KyxCvaqznd30ZHz2HZnDS9b+VbUm0LRyZ9Svf314M8jaJFw9yQT7z5I6OTtG2cmMe0R1jd0KbDtvEBsLk506LVGiTQZ5y1E71g2doR107VB+2R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB4079.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39840400004)(396003)(366004)(5660300002)(26005)(53546011)(186003)(8936002)(36756003)(478600001)(6666004)(16526019)(66556008)(19627235002)(66476007)(6506007)(2906002)(44832011)(66946007)(52116002)(2616005)(956004)(31686004)(316002)(31696002)(4326008)(86362001)(8676002)(6486002)(6512007)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 01JUKwytDM/H4edRw+ZW+sO6r3n524R8+MD/1r/tKk40Ywl2oQRzIG8nVMDJinAi2lSHn3PIJ/jKw3sQOfGJxo/HkMa7qPuIc2+p0N+45in7fn/E0zEJ3oac/0UTLqwyyCg4YL+umfsFgA36o59mrL75FMNDReMLOEFiN+SciTAdcwYq0iVtIsuWaR/c6lUT88iGJyEyr38dE9WY/S1VjhagF0FK67uGDIVBH8ULZTXeuBnKehnkuHUbZ/l8z9GM3NlI1Mr+HAUcmhHqqxtJD455+rvjv/P8zDhyNbn5lvhL+u7DJfR0r6xYDhi3WB/JWT0ZLlm5buGO92SnU5B64stDDQFsH/YoDxN9MCaFsx0avb2sxAUVthUS+hTwaAMjBtz/N+5TWq9FHuEf0GxDs01EIDetEKFzt/Mm1HUWyAZ1f8J86C0HNyjLML+Y/1bAcrd8CJ6MzB7trCSJiIjUW/T3jWL1MK92cZX/47e1qfs8O19ABXZBBtlY5CCNnJ0O
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837c708f-24dd-4c25-56f5-08d832f9f7a2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4079.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 13:27:25.7311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeHT+fDzjLMAmsfmgV7n+P43b4xxO/tV0anfmHkStqUNwybqxY83+GiVfIPR8dU+I3V2Atv6NJykC33CRp13kGUEzOGU4cRTk4+KzoCK/4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3007
Received-SPF: pass client-ip=40.107.7.110;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 09:27:28
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

On 28.07.2020 14:36, Vladimir Sementsov-Ogievskiy wrote:
> 17.07.2020 11:14, Andrey Shinkevich wrote:
>> Per original script design, QcowHeader class may dump the QCOW2 header
>> info separately from the QCOW2 extensions info. To implement the
>> to_dict() method for dumping extensions, let us introduce the class
>> Qcow2HeaderExtensionsDoc.
>
> I think, when dumping to qcow2, no needs to omit extensions, let's 
> just always dump them.
>

Do you like to eliminate the command 'dump-header-exts' and the relevant 
handler 'cmd_dump_header_exts' from the script qcow2.py ?

Andrey


>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/qcow2_format.py | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/qcow2_format.py 
>> b/tests/qemu-iotests/qcow2_format.py
>> index 19d29b8..d2a8659 100644
>> --- a/tests/qemu-iotests/qcow2_format.py
>> +++ b/tests/qemu-iotests/qcow2_format.py
>> @@ -248,6 +248,15 @@ class Qcow2BitmapTable:
>>           return dict(entries=self.entries)
>>     +class Qcow2HeaderExtensionsDoc:
>> +
>> +    def __init__(self, extensions):
>> +        self.extensions = extensions
>> +
>> +    def to_dict(self):
>> +        return dict(Header_extensions=self.extensions)
>
> s/H/h/
>
>> +
>> +
>>   QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
>>
>
>
>

