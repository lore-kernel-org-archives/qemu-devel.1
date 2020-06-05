Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C00C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A7C207ED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A0lFIwrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A7C207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFC3-0001QB-E0
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhFBF-0000gN-VN; Fri, 05 Jun 2020 12:26:53 -0400
Received: from mail-eopbgr130105.outbound.protection.outlook.com
 ([40.107.13.105]:41618 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhFBE-0004fm-5b; Fri, 05 Jun 2020 12:26:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyGxqRSGXN8uIj02WFpCD4xp29e3oRno1Wr2f0NTgsa0UA1ni9Knc/EyUmIbe3fFT7v6alSa1m7d/eWdfPk4L2d3ruypkdIhE7svyHCfZgaErcvICWwgFSIcG29JogYX/if5IvUYpcGYqeJ3RtbLErGDR618LAp6oWHdg4JCZVDEGGUBIvNUqBg6ozl07r+0HGBSamCu1Fe0ohVWk35vqiSDvBdLBpBOLed740ay8ZPFO1TFdtYtWpbt9CYs7TIkMBd0eTFxSuKeFUfkqoJ/qjAgrR/RgcdEhJW5OGAUTnGZANbIqpz7nlq6QVrm7VjRZ3KDACooIRAYCn5sdX0Pjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xzesil7rexaK2XXriXTiO9hEvzCs1fKWR8qsuk4aZN8=;
 b=afRaDf0mxj4V2Gg/UX3Xe79WnW2/nFjmztuKpTdR3h5Eah4G0pffXVbvx6597K0/uSPFRtiyxXR0T5nnyUwiGt3Q3zFUrP26OmIPtp+kKS5JqVTfY6fcKRRMwmTyQ88treHj8TD2bsbO2tmX7BkT+/m6G4yhAnU3Yw4OGQ113fPzlI0oCe3V7wNydU1bWALp6g8tEOq/SBsDfRLCPx9SbhpZeKS5QNRz2QGkNKj4w1ELje9KRcqD9trsOH1iWiz6dy5mN5k/i3hUByK+4fVHC6alDrPRJVQ4WdDyRi6ntk26alnQGG1zbTvnXm5PORl9Z1v0KblbX/wdKWiyWf4+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xzesil7rexaK2XXriXTiO9hEvzCs1fKWR8qsuk4aZN8=;
 b=A0lFIwrOiLA3557tvhnZvxR8Na0jOrhZc1+hNiO6SIHcmbqEOSvMSW0P5l0A9krK3nrP8yqGFBNM8f3R1AbIrh9f0T8rB+lUgaHmPLCPT5FhRRqGqt0GbHm0Z3IO+gJZ5ysh5FBt0fmUg45IUVCBlHtELWCrq+Kqh2RR5052GkM=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5415.eurprd08.prod.outlook.com (2603:10a6:20b:10d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 16:26:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 16:26:47 +0000
Subject: Re: [PATCH v4 11/12] qcow2: QcowHeaderExtension print names for
 extension magics
To: qemu-block@nongnu.org
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>
 <20200604174135.11042-12-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4e04eb8f-c599-b7e6-4879-860a7ad8d7ec@virtuozzo.com>
Date: Fri, 5 Jun 2020 19:26:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200604174135.11042-12-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0010.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM0PR02CA0010.eurprd02.prod.outlook.com (2603:10a6:208:3e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 16:26:46 +0000
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0960a03a-4a22-47e0-1b0a-08d8096d3e24
X-MS-TrafficTypeDiagnostic: AM7PR08MB5415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5415B021BDABC8EBBB2E11B9C1860@AM7PR08MB5415.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:136;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFQv06RtA6be1SuSik0kZGUpdw/UK4KU6s4um4rL1qsB+Kn3xgHXHyGFfX/XfYkHP7CZs5dKJGIQ/3mHUAFk3PwrOWqWaqhX6ymMtpIAVdsTPPceHgrYWdAdkK15gtsRrkr39/aL9OimdNbjKiyFMHq0qAzvF4PndtV2a5A66zsgILPQjxAuvpjxK9jFUiHAsslfk8e0Hqcc6PLBw5vy8LA62oW5S2pRsO60Aqo1kitAgizuhMz1+J61+XyZxJXLRtSiFQWmPd80lELgvFOrPu+UXK/EuOa2hwA1OFz8zFDtFc1DQFxlQNT3gm2Wke1AQqc+SkTqNebdCAfTL2/Gs5J5OistxIAaLs6nVNrs9NLe1Uit9MAgmfQa2YNcwnBI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(376002)(346002)(396003)(136003)(36756003)(66476007)(66556008)(6916009)(4326008)(86362001)(107886003)(31686004)(8676002)(8936002)(2906002)(316002)(26005)(6486002)(16576012)(83380400001)(478600001)(52116002)(956004)(16526019)(186003)(5660300002)(2616005)(66946007)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: W+5vMpFyrQjh2BQjFtsM7hBWecqWJkfWSn23OQ8Sg51HWMKnk3Bd9QQiDUoNMeILrMJeOiHJkMl9C94Sh4Xqh4DAGonWSLyxIaddPySH3qw77w95PNNkVikuJzkOzyRJ3ewRS7wpKEG/mn+BH5PIWyhosMVEFphd8tkDL9AhqkaDVLg/KNb3UobSH3FBDZpAqv/ZGu2cZN1m/KCOPXQaMtTfkcBAjPgWOIJ/is0urRVIvVqfd+cpvBw0X7PE2dcoQye0LGqCT1VL0zULKJHvYI9bKOkqbjRfbdIhSNNcMqOwyqRqTh9VuxEjDR5jzhsuAIy9QhK2Wb7H7zASX1DQFaSAFfJKuBUfS0yvJdZnOwgE5igNosBjEZUd02pt40/8KInXAyRlQ4w4QOd2D6lhskLDFNk5WkdZcZyMO+SK4wd4SFoUhOQKRpCCzgencLhsiWxN0zwl2gZm3vn1j1iwQ1PszF7unUvovLu5ZnpX3uZPYIn2huW3iM2RQZJVM67X
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0960a03a-4a22-47e0-1b0a-08d8096d3e24
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 16:26:47.2300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZzv8l3iDc/oZYM2BG+wWI/aWfe6h/EcXEDT7cNYLV53vFfy+R4WOn5+hB0vNqRoUHy6b6BR+uEVSZiy9dgYzuRHNIA3ZBRpVbXWJ2LbBgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5415
Received-SPF: pass client-ip=40.107.13.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 12:26:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

04.06.2020 20:41, Vladimir Sementsov-Ogievskiy wrote:
> Suggested-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/031.out         | 22 +++++++++++-----------
>   tests/qemu-iotests/036.out         |  4 ++--
>   tests/qemu-iotests/061.out         | 14 +++++++-------
>   tests/qemu-iotests/qcow2_format.py | 17 ++++++++++++++++-
>   4 files changed, 36 insertions(+), 21 deletions(-)
> 
> diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
> index 5a4beda6a2..e0225f4247 100644
> --- a/tests/qemu-iotests/031.out
> +++ b/tests/qemu-iotests/031.out
> @@ -25,7 +25,7 @@ refcount_order            4
>   header_length             72
>   
>   Header extension:
> -magic                     0x12345678
> +magic                     305419896 (<unknown>)

Oops, I've broken hex number. I think it should be kept hex, even with name.

>   length                    31
>   data                      'This is a test header extension'
>   
> @@ -53,7 +53,7 @@ refcount_order            4
>   header_length             72
>   
>   Header extension:
> -magic                     0x12345678
> +magic                     305419896 (<unknown>)
>   length                    31
>   data                      'This is a test header extension'
>   
> @@ -81,12 +81,12 @@ refcount_order            4
>   header_length             72
>   
>   Header extension:
> -magic                     0xe2792aca
> +magic                     3799591626 (Backing format)
>   length                    11
>   data                      'host_device'
>   
>   Header extension:
> -magic                     0x12345678
> +magic                     305419896 (<unknown>)
>   length                    31
>   data                      'This is a test header extension'
>   
> @@ -116,12 +116,12 @@ refcount_order            4
>   header_length             112
>   
>   Header extension:
> -magic                     0x6803f857
> +magic                     1745090647 (Feature table)
>   length                    336
>   data                      <binary>
>   
>   Header extension:
> -magic                     0x12345678
> +magic                     305419896 (<unknown>)
>   length                    31
>   data                      'This is a test header extension'
>   
> @@ -149,12 +149,12 @@ refcount_order            4
>   header_length             112
>   
>   Header extension:
> -magic                     0x6803f857
> +magic                     1745090647 (Feature table)
>   length                    336
>   data                      <binary>
>   
>   Header extension:
> -magic                     0x12345678
> +magic                     305419896 (<unknown>)
>   length                    31
>   data                      'This is a test header extension'
>   
> @@ -182,17 +182,17 @@ refcount_order            4
>   header_length             112
>   
>   Header extension:
> -magic                     0xe2792aca
> +magic                     3799591626 (Backing format)
>   length                    11
>   data                      'host_device'
>   
>   Header extension:
> -magic                     0x6803f857
> +magic                     1745090647 (Feature table)
>   length                    336
>   data                      <binary>
>   
>   Header extension:
> -magic                     0x12345678
> +magic                     305419896 (<unknown>)
>   length                    31
>   data                      'This is a test header extension'
>   
> diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
> index e409acf60e..6cf892123a 100644
> --- a/tests/qemu-iotests/036.out
> +++ b/tests/qemu-iotests/036.out
> @@ -25,7 +25,7 @@ incompatible_features     []
>   compatible_features       []
>   autoclear_features        [63]
>   Header extension:
> -magic                     0x6803f857
> +magic                     1745090647 (Feature table)
>   length                    336
>   data                      <binary>
>   
> @@ -37,7 +37,7 @@ incompatible_features     []
>   compatible_features       []
>   autoclear_features        []
>   Header extension:
> -magic                     0x6803f857
> +magic                     1745090647 (Feature table)
>   length                    336
>   data                      <binary>
>   
> diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
> index a51ad1b5ba..7afd2be9d9 100644
> --- a/tests/qemu-iotests/061.out
> +++ b/tests/qemu-iotests/061.out
> @@ -25,7 +25,7 @@ refcount_order            4
>   header_length             112
>   
>   Header extension:
> -magic                     0x6803f857
> +magic                     1745090647 (Feature table)
>   length                    336
>   data                      <binary>
>   
> @@ -83,7 +83,7 @@ refcount_order            4
>   header_length             112
>   
>   Header extension:
> -magic                     0x6803f857
> +magic                     1745090647 (Feature table)
>   length                    336
>   data                      <binary>
>   
> @@ -139,7 +139,7 @@ refcount_order            4
>   header_length             112
>   
>   Header extension:
> -magic                     0x6803f857
> +magic                     1745090647 (Feature table)
>   length                    336
>   data                      <binary>
>   
> @@ -194,7 +194,7 @@ refcount_order            4
>   header_length             112
>   
>   Header extension:
> -magic                     0x6803f857
> +magic                     1745090647 (Feature table)
>   length                    336
>   data                      <binary>
>   
> @@ -263,7 +263,7 @@ refcount_order            4
>   header_length             112
>   
>   Header extension:
> -magic                     0x6803f857
> +magic                     1745090647 (Feature table)
>   length                    336
>   data                      <binary>
>   
> @@ -325,7 +325,7 @@ refcount_order            4
>   header_length             112
>   
>   Header extension:
> -magic                     0x6803f857
> +magic                     1745090647 (Feature table)
>   length                    336
>   data                      <binary>
>   
> @@ -354,7 +354,7 @@ refcount_order            4
>   header_length             112
>   
>   Header extension:
> -magic                     0x6803f857
> +magic                     1745090647 (Feature table)
>   length                    336
>   data                      <binary>
>   
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index 4683b1e436..caa190f7b1 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -21,6 +21,12 @@ class Flags64(Qcow2Field):
>           return str(bits)
>   
>   
> +class Enum(Qcow2Field):
> +
> +    def __str__(self):
> +        return f'{self.value} ({self.mapping.get(self.value, "<unknown>")})'
> +
> +
>   class Qcow2StructMeta(type):
>   
>       # Mapping from c types to python struct format
> @@ -75,8 +81,17 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>   
>   class QcowHeaderExtension(Qcow2Struct):
>   
> +    class Magic(Enum):
> +        mapping = {
> +            0xE2792ACA: 'Backing format',
> +            0x6803f857: 'Feature table',
> +            0x0537be77: 'Crypto header',
> +            0x23852875: 'Bitmaps',
> +            0x44415441: 'Data file'
> +        }
> +
>       fields = (
> -        ('u32', '{:#x}', 'magic'),
> +        ('u32', Magic, 'magic'),
>           ('u32', '{}', 'length')
>           # length bytes of data follows
>           # then padding to next multiply of 8
> 


-- 
Best regards,
Vladimir

