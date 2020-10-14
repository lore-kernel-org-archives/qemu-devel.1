Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFFDC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C46B20878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PZ3Fj+Ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C46B20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfw2-0004CD-Vq
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSftA-00038A-Os; Wed, 14 Oct 2020 08:28:16 -0400
Received: from mail-eopbgr40104.outbound.protection.outlook.com
 ([40.107.4.104]:14766 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSft1-0005eI-8v; Wed, 14 Oct 2020 08:28:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUxVLpiAnNK7WNy4mtr2AIIzxir1//83VBTN0zmK7LIEiuxj/xdYYepLscHJ3NmlVrYQvdm4adaXWPSjfakdIQqxoDmCUGjhmjU2YTYfcUMqOGTYprTmfCICFLoAiokHdjiu8Y0mgbDasEo4kH1QwzPQeUqHGtY1QgDoryrTbHHrXD3rvS6j/Vf0VdwP+4WhYYiShiOrtTizjVNq+k9kgipFnIYptvW2gfhFEMWAdc/JzVWtvR90g5NTGp7mGvebDNHLUSA+rzhWk5h45nKRgi+BPomxHNrO1OuUZObVgwGSR9M09dpnDeDXhJhsaB3g4yvqdLGvi8MQYIxbZwBcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VLyKwlPOVvMw5mWVflTtWgo2CfpTWb+w7WcASFpz0k=;
 b=bb/UXEJGWROg+y8ruaF0bcTUEchPtD3C8oOf/M1O6uCZ2KdIKdGYqHss/rTpx3w3ImK0OFDXoCibM+Pwh64I0pjnpYD9jkFJEx7oriHkuEeu0JXhaRuSC7RQJhny+igMM4Vrw6589eMXu5fpjxhTOZmwQrWGnu/5yiIuaapEhj2O12DU3oLze5WH8zP3A1Dfr7eetmsKxH7aMGXPDJBGi48vM4nL64nQ9D9qU/bO0gFPmCkqG1iMpkOduLktmD+BP2JWevGHFTB6mghrBhQ768KgPE0js/3itL9ShjRIFwdFha3O93SOt7zcW0/QugfQpqYtuMRiCi/OjESsy1M/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VLyKwlPOVvMw5mWVflTtWgo2CfpTWb+w7WcASFpz0k=;
 b=PZ3Fj+EpEhBgZeUhPa/efee3maBUgO4Ge6bfw5h0gTGVQqPoRPGrpYyp2T6xIJmP/cpXCo0iD91brPd5x4pA3X2R7PDjHewvCb+Vl7/YfVo6GUMrRtxFjQox9ETxddxkBxAjkgp5C/bJjjFsLJA1YKzcHTC2fI/CiTYoYuL4Rv8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2529.eurprd08.prod.outlook.com (2603:10a6:203:9e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Wed, 14 Oct
 2020 12:27:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 12:27:57 +0000
Subject: Re: [PATCH v4 6/7] nbd: Refactor counting of metadata contexts
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, rjones@redhat.com,
 qemu-block@nongnu.org
References: <20201009215533.1194742-1-eblake@redhat.com>
 <20201009215533.1194742-7-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <60986167-a395-0418-3163-7f0dfd996532@virtuozzo.com>
Date: Wed, 14 Oct 2020 15:27:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <20201009215533.1194742-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.122]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.122) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 12:27:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6a6ce2f-9a80-45a2-1c07-08d8703c9546
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2529:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB25295C57CE74F353276B74D0C1050@AM5PR0802MB2529.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVcGfNYC5wUgKcYtW56zIh3wBEj+ybMAk69KlY5tzItTKXULKPXnTqIRODqXcNd6Z2PxPSjfoopfNXtwcZBGIl7shReJBCFRz3nBDU49yw8U1eqA0bZEWjmmipo4wRY8i0y+3sSmMjVveKfIiltSWBSDZJvgHz2ASFEn8Styv8hujSgHsjlfPWNhbb0JKn3Xw3W8QsiJpe4cpDl1poA/3lZPewgiBqs7100zcxEBxj7xQIsOPy0eQ0QtXwtGeac72mTGXjah4vU07wojHVrrMdi2X6IqbI1RSpzMBY2wOSAx3N98LPOOBPz6+k77cv7R/9mQHlKE39ujHiHb62OzfTI8EZArn+dFnKCfrMT0OY+szoFpNgRCChCSbi4SxSTf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39840400004)(36756003)(316002)(2906002)(16576012)(6486002)(956004)(2616005)(31696002)(8676002)(86362001)(16526019)(66476007)(478600001)(8936002)(4326008)(52116002)(26005)(66556008)(5660300002)(66946007)(31686004)(558084003)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sYFZxISWvonUYaXNWDwBi6wa6mDN3f9LznqvxWZmo9Bbwq+D89gLlwY1WH4/tDy71HBCJNUuHUUNTaj4KsKSJzDKGM6Xo/LxXZJ25IplC/uhMSY933mkjk3uqzL6x6r6FcnrHue1pQpm+KrkuPVZnIuAeWUoY1kSx2wg+p2jLMO8rXuykmO1wLQyBRkLVoomgytiAkQLuYy8KW/2S/mPImvV7n0/qpkRa3mwaUJ2ka3WabyNhb3M45LA2C3ik1m2h+aRMbGKk5m1AEiBlWoXB/V2QQOpG/15+OjM6HQ5XHpuHT5SRK3CtwPYYZjLGduggkQgBg7ptmUbi6M4PHgMWYNeCg/TU41AXDmvGQbgkbkCGuuTZdFPfOvJq2DM443w+hjB5oOW9VkWHy5ZZP9xN3h7wJbXPlmKj+8z+ZPR7fQvBL82pMZOXh21ovKu/u26L+w8r0QjZ3AHg1CW6Agz7Qoh1OnXQ4p2mtGDHDtb33rxx8yLk/8zblJwItOMVbubS+qbQXfDgVfnV5nw4F0eGJ6jL2qNxVNv3VpR1o90aHKtio4w+N2P55drQmuzKDyP3ZQ1VnwHPzP0wekXLSZfqgsWuTbXGgZ0NADl6uspRcBHBH5ojoovK0ddDhud8n8uu+UwaB73cFAC4HHXp14JxQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a6ce2f-9a80-45a2-1c07-08d8703c9546
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 12:27:57.9067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTNfoOcQ77z/buxMRHsY1UnBoieiQ5rk/OODQHCVTLsUJreU37UkJfUO54aLA5MKx5oLYIKA4F/cBzwW6e1btzNz2gpEkaGePhCVaHhZ5yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2529
Received-SPF: pass client-ip=40.107.4.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 08:27:58
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.10.2020 00:55, Eric Blake wrote:
> Rather than open-code the count of negotiated contexts at several
> sites, embed it directly into the struct.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

