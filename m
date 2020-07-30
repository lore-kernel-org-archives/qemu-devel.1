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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2272C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CD520578
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dcB8LLjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CD520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19Uz-0006nd-Ls
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k19Tp-0005CC-Pj; Thu, 30 Jul 2020 10:24:22 -0400
Received: from mail-am6eur05on2095.outbound.protection.outlook.com
 ([40.107.22.95]:62432 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k19Tm-0006QM-D2; Thu, 30 Jul 2020 10:24:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gc4VHgtKUYCrsF+CpUv95jsK6+BgdXhL+49SSXtzYGQH/+3XHRG1T5J7yARJhhZ6FIRSLjVMVXaux5dHcZfT2piyn3bY/0vfA4czkieOCs7LxgIzVcOw3QAaQSlbDzt4hc1Wkd+XwpchNKZUg/nc6LDpQ+bUgi+KT/9wSTzHPARSuRwmBxjSMQLBgyCIFvkibiyuzb1fi6UQQhoUvvnM63/XgOauh13AgIgZrj1mc1I8w+i7W6Fe4z8xB1YFXHNMp1fmcA1FZvZnN/lcTDAKBEB277nAY44kqGgkuBcYOOOVCp/pRQ9XwewY0B1m4OyaeulcHCo9MMAdnikxo2Wl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+KUcbE38a6+D1QqwecnTB1EAA0/UcInUKotrTr1z9E=;
 b=NS9HlA6SkAsn9OwtKNj5BBYg1LIC3mvPj7Yw5/x135uRKJyAsG+w4My+SNrAT7ensnvSoDi4QhPy/teswglSqvbSvoD4ByCUKaSLen8BKjrx9MxzQotDMpmSVCjwai8fnDVpn5YFzUY+jJ6WjIObRl316TnhjMI1OANY2cCfEpEPUBMMCCIyts18iXx70G40rZxbZNmOlMRW3rca/IQeuLYU1tPz0dAzwbapDXyDxw1t9JMO1zVJOmyFpbA/9432L5EoEzZ6wWaoVO0lN9HFCJrUvQbmZI9/RNs94dp0xYWdr2l4Dc/1BCQpL1BJU77wk0IJTy+LgAenOxO+zgSlzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+KUcbE38a6+D1QqwecnTB1EAA0/UcInUKotrTr1z9E=;
 b=dcB8LLjl3W9xc9VTIy1Ax9rLer5KJzLFZoUwBPw6s5eNeQHwO44RiWOulINeXZao7hS8gpgtRFuIqFzf6PcD2g7WryM7iSpU/lIwr71rNo194re9T4+CX08qkHauGJ7lb7DRSL4NRw0a3udctQqMD8hq3oK/gWaQhchU0FNeLKg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Thu, 30 Jul
 2020 14:24:12 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3239.019; Thu, 30 Jul 2020
 14:24:12 +0000
Subject: Re: [PATCH v11 10/11] qcow2_format.py: introduce
 Qcow2HeaderExtensionsDoc class
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594973699-781898-11-git-send-email-andrey.shinkevich@virtuozzo.com>
 <db73d013-832d-234c-7828-80d8b1ed962e@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <e0263bec-405e-feca-4f38-1ce811a4c25e@virtuozzo.com>
Date: Thu, 30 Jul 2020 17:24:08 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <db73d013-832d-234c-7828-80d8b1ed962e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::17) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM0P190CA0007.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Thu, 30 Jul 2020 14:24:10 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f36eeaad-b606-4e87-b377-08d834943b48
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53821749A1ADB8EEF245F061F4710@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+s39MY0L6SKXRm+hzvmHJkgtI3gXSO1pzKpwaX8b55YpG3/0QTCqrFuPZPxKHB/zPuVA90P45DruUrprI7XN8Wy4heDvxeIt9LU741QifjgVzg9Gojt6VquMgqwieeaJSmsEuuFtiY4yD+64AqGgJrKMuR81Z1j8O3h8VOFerLWsFoXDAQ8t3d/etzv84ISl4HRqbIS6x8RPWxxN2rOeeWjbrOoVcTo3lq0QTLSJCHUtmAuyPkuwLNolYC3FKReGzmYSyZd0AbyGRCpL4TmdvDa7aPEFpW8tnYDUo2PYQfrIe6ozoHaugdRO6yLbce8KmUODCKw9hEfWJqoGMDaagrsVdZFEEXzjkD89wKNEQVdUO2GCwQROKZFV/mYErm7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39840400004)(6512007)(31696002)(36756003)(66946007)(186003)(16526019)(86362001)(478600001)(19627235002)(31686004)(316002)(8676002)(66556008)(8936002)(956004)(2616005)(44832011)(4326008)(2906002)(5660300002)(6506007)(53546011)(107886003)(52116002)(6486002)(66476007)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3nal0b0kJhdFHxCqX6yqhDTHG5LUul5m1ZQeHRBEIaan2vmnirn/4dknpfNKZaPpbaSl45ylHNy5sFZ41MBvn8QnS4nCdcyvLGsMyCL4ngUnqY2/lyg45PlHa6MqxcBcKl6GxzHS6TTdE+tp68Nw5vvKx1YRzkR2UUGu5DmTixbwHbN5bhXQGP44viSvauzuuSboiaxPwFcZdUjeiu+1PYn6pdqel8EVwXw2fFs0FDPVYdB5wykq+sRCqh759A83sBAvijge8Ki1ccp97Zq35xYREvHvRkqfrycya4u3BNorghtnw+kJEStVb9TszwlKknYiZM9G7xNQGufSrnbuHJEGzKYFKoEA2bCx2bLWU9CMW9NKcwa/XOss4mf+8q2MsbFWQ4qtQi6wo861j2dyHefnHhPs2yyXAr31Iw7p60zqOwopWqzBICCnxuc1abi9Ft5fgL+UNcHHGc8/2yscOmSd143q5Ix2Ah9SrThEKbSvdYh94QnQMOpre2cTzF0Uq+/Gq9t2TlN8BUg5swlPs2QL+WemlPfEBf8dQGuq0r2PAOefA4VzNTJjYEEM4pFYviRTwN4Il+18uEWq4Yg5FTrV3OCNXP2g5Vr4oNlglFuS/IfsXy/fnwEsV6yxUtiWsqXyVd/2P7rr25ylWCpNpw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36eeaad-b606-4e87-b377-08d834943b48
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 14:24:12.8149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zd5a0Muslqk6CPvYnH1qafkirT0BjcIUIVGqq6pXS+63bihw50t1OcDqIeZWxlhVYgR9CnPYZJ15ZzXdZb3zPZ/VvOtaqwq9cNiMMC1W+YM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
Received-SPF: pass client-ip=40.107.22.95;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 10:24:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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

Sorry. I ment the non-JSON format dump as the original capitalized 'H'. 
The class Qcow2HeaderExtensionsDoc has been removed in the next v12.

Andrey


>> +
>> +
>>   QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
>>
>
>
>

