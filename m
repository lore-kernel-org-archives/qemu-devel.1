Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD003C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61672070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nhLjksQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61672070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19Ii-0000ik-VP
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k19HM-0007yl-5T; Thu, 30 Jul 2020 10:11:28 -0400
Received: from mail-eopbgr80097.outbound.protection.outlook.com
 ([40.107.8.97]:51431 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k19HJ-00045v-Gz; Thu, 30 Jul 2020 10:11:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLYuHm0Q8miJ0MewhyXIZGlnYgIQdPwGzguUo9Tv28Jw7PIb4FIaC5WGsXj0zytt1H/R+o+D/hZnMHiHEKiwsjbRmMwg805qzYZ8cI/D8LR9NR1neGpjwuu5t8SHcgaRoctxIyt6rZ4nV54kuK8BMoq438JeIetfOxsX2C7tv8/0foDktUkQa8aQKu4HaVWl5hAUYMp9lYJ8LHGea7zjJ3UiCdYIsC/9S5wQviyvP/NvO4O4OJYNf1NvuRotfAzWyhhKCWE35sdyS7ZKDirn1erCqU8VP9HnhUMDTvwrfGnqnPM64V6nGxQ9YYg02723qN8vsZEmlJmFxhsLh32tww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KGCetPX/fcXuniLpk6vqkk9LWl4NgH30YNk2JKU7BU=;
 b=jysRQYrAQkGilD8sNABEIxmF9B5aoA49RyQRUqToL1QlFKhdTNTJVbv6+MjMt+YENrqG57akvu78YuuM2yTIsHFCLt32Np6xw14jRaFOE//HFa1ZuTBJdpDvqsS+aSJE6mrzmIDAo3J347raGKwm5nCnzrsIZwJR4njKK5megbzpXaiio2Y/5R9WJDi5Z3HM+ahv+EtMpz6Gev45zswbnswxm/LvZMduHYVIFy/O2aTNoku2GXEXQhWqd/hpxhIh2GF2Q71lxhn8GU8pbtc2QnERdW//37K8gB1m7iaeRAvxHUKLKcJO99HtT8hUGtE5Rz7iAhW8ZeWCDQ9SyYIwag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KGCetPX/fcXuniLpk6vqkk9LWl4NgH30YNk2JKU7BU=;
 b=nhLjksQXCd39DqOIwv+ccdNwqAXPojM+OPfWlbo3+qHpCLluDcM1cvxFmvKMuTcOVxbfSwUKdswTmWJ71z6S3oMej8MV9X0QKoAXSt2oejlSP2fWFVrWfq0SpQGrw93At4UiSqkLrSMRfBD6iRepxlWZobTQZrcrUy38srbmboY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4407.eurprd08.prod.outlook.com (2603:10a6:20b:bd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 30 Jul
 2020 14:11:20 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3239.019; Thu, 30 Jul 2020
 14:11:19 +0000
Subject: Re: [PATCH v11 10/11] qcow2_format.py: introduce
 Qcow2HeaderExtensionsDoc class
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594973699-781898-11-git-send-email-andrey.shinkevich@virtuozzo.com>
 <db73d013-832d-234c-7828-80d8b1ed962e@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <0128ad51-aa3c-3b7e-6d94-ea907add7cba@virtuozzo.com>
Date: Thu, 30 Jul 2020 17:11:16 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <db73d013-832d-234c-7828-80d8b1ed962e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR02CA0094.eurprd02.prod.outlook.com
 (2603:10a6:208:154::35) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM0PR02CA0094.eurprd02.prod.outlook.com (2603:10a6:208:154::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Thu, 30 Jul 2020 14:11:17 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3192e4a-a8e2-46ee-501e-08d834926e4d
X-MS-TrafficTypeDiagnostic: AM6PR08MB4407:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB440764789CFC00EE65ED4CCFF4710@AM6PR08MB4407.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktfg9eGfu9Y6ppWwsoqcYfKyS8bAyl0fy/sLwgM9HlawVacd7TWgareLOWgvezHo0/8zRxu1ledB9wO7P3lI/lfXt/J4MeZq157HERCQ48HO3uzX50sFpSH7timJK++wuBte5/8/LwPViqqm3+UaAaFfKSQHbTyz66f+cHg0sIYzWqMss5zncH4kZqjGnf25QNRIUZCFssnw/EU2dHGCvL5EdQERPykOIRYxS5LCwiQJqv+kNAmUELCoePDjIFteH3lxUz2Ie2My3RXf1rP//AXUO36IxRaYPzUQlVH+SU5TTQYFm0W/aCFtdpyNY/VM0+XSnuw7bUV/oI4aIhVKC1ateCpZB2YqITw0jektfCgkSbROoGpI2QnGX9Augjji
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39840400004)(26005)(2906002)(16526019)(186003)(8936002)(8676002)(66946007)(31686004)(6506007)(52116002)(66556008)(66476007)(53546011)(44832011)(19627235002)(956004)(2616005)(478600001)(4326008)(6486002)(107886003)(5660300002)(316002)(36756003)(6512007)(86362001)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: blgGFvrWyhm8prWBjGEw9NdpXbmiiSdcYKBYX6cOasUY8Dr7TT3WT189qMBmEtoYmBuLwGIowPfRfR4Oi0McvsC0U307TjOAaP7jE5Z8ow1gDPKiRdjDVosxnppQY19CRkp0pglb/ofQ1F4HiXYrhYEHGAqoLF1+KHQvPrvNjjjEgLsYunMkc7lz11VKsMY5Dg0lVvLeVzK1BgILl8JDuWaiEU0BxCOz6D/5RHb/Gvlx/rjr+1D4K4KP9hsKDtisTcberi193pX2bAgFAZf5O25WAWh/14OyAZwjW3pgMbz4pQypbxNdUrA6Hqu9pkUmVaEf5SzFA1/WXSZgkXGSD5SNHki8M3ZYeXEYUNB+MmhOSsyB8ZMR8O0tlT38/dgt6mueWigOUYJED4vSIzIlSWM23Vy+fkcCDwYSW5Sy0ExqhLqzbwghQIKxa1GH5SaMKve4GEczoaY7nBawKCeZdXLp9CPmbeRMmElBkrb7/ICiyT021g1giKFbdA/55JJ7SFh/Q2OBKVyN1avy7Lys/92T/JoZbB9CZh7/hHSPymk5pag8zushrz2/wLWz9wg0YTe80eM6EHw8iAlWW4av0mp5JU3v+Xb/Xb/0IAZAZ/mJGjgaBT048dapykBC/QTkY15pyJIbhvcuXKQQGQbaOg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3192e4a-a8e2-46ee-501e-08d834926e4d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 14:11:19.4844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgCY8zP7YP/S1EKBVQ3EIZw7N6lUzDvE1WTwC9p9rxkS7qC/tC4u3SlMAt6oKqNukbeKA7c43NAd1FEce/vqbpiH7T1+bOcuMKEwbyNYvvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4407
Received-SPF: pass client-ip=40.107.8.97;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 10:11:21
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

It is the original code and the change would be unralated to my patch.

Should I make a separate patch for this change?

Andrey


>> +
>> +
>>   QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
>>
>
>
>

