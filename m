Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97D3C433E3
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7409020786
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ovdr95Nl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7409020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juIc4-0005Gf-OL
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 12:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juIbP-0004Rl-6N; Sat, 11 Jul 2020 12:43:51 -0400
Received: from mail-eopbgr60093.outbound.protection.outlook.com
 ([40.107.6.93]:14539 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juIbN-00040a-Ik; Sat, 11 Jul 2020 12:43:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQcSOiBa39dQuAiUc+P0lT41VOODxuUfVtLHpTlkJ11s84IXL16tzF6XBVnb5/PYnlQJVN4a2b+V8CMRsw99m1xDcJHQTVyaIbb6hIwxnOBlY7S6/Q1ET6E4GayQxGVaFd+jfnAKqd+iz5EVEa5LyH37o2j9vKd34Fa5JLgUQ0O53GRQzfHwmNe5+zOt4yvUkLXnkG8kLIWz0DGVIKSqfzBrImbggbEE5+1JAmlGGlNRLx3RT7cwCxvM4BIK+dc5qQdHcGDhJAYCHox0qHpWeCIckVs+YR9J/j77BNQISXXpd3r6sJBaRdVA8GE9/jjWT3czDaNwFTvZrHLe3rKESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TVe/QQORO/K97pq0dy36YIeDse+LM2RJoo5jrh/xyU=;
 b=BRw+eQsf9NO5I6mGWAosI/BTqWqpatriiDDDcbUJTPSsM2od8X0pMVgGrvTieguDFS5SWXYnovBm0YYoPNlXupIkcIv938mwcGO+60MtfKPf5ai8WirofShs59bGhxljjhCbDYggG1oq3zGbqrpLvzorHxotOkIVSy2kCMOn8n0/9axsr8R4VNUPsIGvJWv9xO8QMM7Oo4a5ddmnj344sEZsyKgy+Zh6LxJAcSo+3EK88YaeAIg+xPm3/ZzJAyxFl6sgYK0xS2nuqCyu8yRidRtNNHttgN5rTrtWA19uOPH8HOZAH5KLQk6yrpb7EKzW6/YdVMbEIT1y345SaFbL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TVe/QQORO/K97pq0dy36YIeDse+LM2RJoo5jrh/xyU=;
 b=ovdr95NlE5S7OHJAzazXOAOMrzMb9AGrdd9boOlcsePl+57vjYcnKmK+SP2QTfjQkqWvNl2tb8heaAeuX0KlMdnrmvW5qes4PJBzygjnHqE+/1+NBUZQ/UcxOe+jXLwvuKakygFJeK0qCD3G7I9U9Zes638sjswYRvWbqlj0GOg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3542.eurprd08.prod.outlook.com (2603:10a6:20b:4b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Sat, 11 Jul
 2020 16:43:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.024; Sat, 11 Jul 2020
 16:43:44 +0000
Subject: Re: [PATCH v8 04/10] qcow2_format.py: dump bitmap flags in human
 readable way.
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1593782030-521984-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1593782030-521984-5-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <073ea1aa-766e-8dec-0b8f-9a001a218623@virtuozzo.com>
Date: Sat, 11 Jul 2020 19:43:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1593782030-521984-5-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0131.eurprd07.prod.outlook.com
 (2603:10a6:207:8::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM3PR07CA0131.eurprd07.prod.outlook.com (2603:10a6:207:8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.13 via Frontend Transport; Sat, 11 Jul 2020 16:43:43 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6333871d-9940-4715-f1e0-08d825b99316
X-MS-TrafficTypeDiagnostic: AM6PR08MB3542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB35420A6E1A4BD02748291CDAC1620@AM6PR08MB3542.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UbgYO8Ib/sJfr1OykGQzRiMs2/vOg7/5Ul5r6GxfAKCujxaU3wIbnYmmPfCfLo64Qp+L5BNDVGjAZfy3Uo5OVpQ13tKQ7xGQjpFJ40DxrdIj/ZWSb7wil7aU+zeRbeFNiDmt9Ilm2kIDLju21vqFHUu1RUxa2R9zrSQt/eo7Hp+hyd9NHx19tv/+p2aORbj+cQtd7/DM66NxSKoyd6uEiWOt+fPbBidxxWEezUXUDTo82b68YhHTdagTDz+/1mjl4TJ3lNsn8CdiFhHLkX76tl92HouxeUi6ZGq5wRkg/CiVoLTtNdL4wvbONrJavhmuRJzVJC9YFW183h7S7O73CRK0FyYzCPMyGvptP8KlfQs82OOFs/c8R++zoUkLkWQU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39840400004)(396003)(136003)(956004)(16526019)(66476007)(66556008)(2616005)(186003)(5660300002)(4326008)(52116002)(2906002)(66946007)(6486002)(26005)(8936002)(8676002)(107886003)(16576012)(316002)(31686004)(86362001)(31696002)(478600001)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3Zm9GQcmfPfd3gsfLYLnZrYdINAijf7rmypohjFui2QgujAB5lADwgzBqxcpcm3ZJUt6Ax/HuOzZQF0X5ilHtD1gIJZYFPZ48Tj4Dp3W7NFZ3U5+Q/PZ/ug5gRbRiljpKs/bFSw3DbjAsJD+DwnaPjzrUgt0249qwCE0nhzuK56pKS3DeL0O2kW3YXFhCRDrvnSwQa6A47Yysa3upA5ggyqakhE+DMeA+qT1t+U7E1ZddoeB8ks2tfaqCIjkBXyw0gENNmuQa9L/FSmzCEberLWsvKAEsfHriuYuZ4nT7Rqhy+uzYvnXzE3nv5VABuHaaRmFmfLzrDTIw0OaXDk3XOwBWdsOYH9H5k/fTifGrt3xzRsb7M5hKfTykRbT1ku+n4qJ6G2ru9wdUkPx/vs1PLJ82bXLs5SzMdZL8c3jVbKkcxM+P4aVMlfwRibm4nknCAfLRr+wVTPIObDaJ0+K1rjRWFHKxXbwV2fzeu5hSeBQrb5Y/YEXMSfDhD8zWgMP
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6333871d-9940-4715-f1e0-08d825b99316
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2020 16:43:44.1211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPiEYa08jQ+k6bKvGdyixN0ByrQeFNiLpOvYko9DPAmnrlT7Itp6gW6mk6B7yfhjzzOqgSSc3USbIueK2i6PS7A4/dqL/NtrjnHKUnDxI6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3542
Received-SPF: pass client-ip=40.107.6.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 12:43:46
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

03.07.2020 16:13, Andrey Shinkevich wrote:
> Introduce the class BitmapFlags that parses a bitmap flags mask.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2_format.py | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index 1435e34..d8c058d 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -40,6 +40,22 @@ class Flags64(Qcow2Field):
>           return str(bits)
>   
>   
> +class BitmapFlags(Qcow2Field):
> +
> +    flags = {
> +        0x1: 'in-use',
> +        0x2: 'auto'
> +    }
> +
> +    def __str__(self):
> +        bits = []
> +        for bit in range(64):
> +            flag = self.value & (1 << bit)
> +            if flag:
> +                bits.append(self.flags.get(flag, '{:#x}'.format(flag)))

please use f-strings where possible, for consistency.

Also, more obvious notation for unknown bits would be f'bit-{bit}' I think, so you see number of bit, not big hex number.

> +        return f'{self.value:#x} ({bits})'
> +
> +
>   class Enum(Qcow2Field):
>   
>       def __str__(self):
> 


-- 
Best regards,
Vladimir

