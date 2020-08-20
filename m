Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D24C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC68206B5
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SEeO5MlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC68206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8n3E-0005OP-VA
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 12:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8n0p-0001g0-OA; Thu, 20 Aug 2020 12:01:59 -0400
Received: from mail-eopbgr80128.outbound.protection.outlook.com
 ([40.107.8.128]:50182 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8n0m-0005Ay-Rg; Thu, 20 Aug 2020 12:01:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGNH6Yqh15ZAf/ET7uuoC7m4ad/DRfNOJP9sH2WY/IaQCmrBtaaF72hLLmcRE3HtcqoPXH0yPtfWv9Xbi1JhAKt+EahSJqCavhOFrnOW3coH58lnpz5RiI4OAgiIRr2Aevy4hjd/o7rjjEfWQN6KOYgFb5ZTgFYP8hdfdPSCcqBNo+PV8pfeAJhWzFSQFJjW0HcYS/rY5I2gI7xJGChCHvWGCSHiCuvpE661V6aQ5ZqCoHAL/kySyzqbaWkVWgJem8/zYwXwi4GXL6y6tvSa8qcJ90caTI+IVqKoxPOhtapfNVaT89qr9tev9QejptWPGocKhAu8Ga0I4i0MgapLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6yiBmnsI9zSX4Kbv3/TBbzqQ2vZnOATam9MmfLtDP8=;
 b=BJ21cAasMwHiCIBa+ldRVx64xeCaGo+bb4vwW4rCeWIlndGBxkuBYyZ2KI9vbQ5rXrthiVLQdqP/s6weSSoRjvZY09yagaLYpydk4OcVAxeZ+JeAAoVhlnfNFeMShs2dnoO8qzgLFaYG79YcVNMwCD35AUUQ+jQfeYrVX4Ft13o9Njv/PgNEzcMXaYVbk/UcuSrG7uH1X0FWLuLl0itr/hNLKfOBgzO+n16bJ7r0pCUaWc0YQBHfrTyjJzPm4apCIMJwyu1uxJn8RLbejNkBXIpqhOpnjbgxPyce18ziicVb1WBkmFDHHyi2BKC1scSUXuPnp+dQRNHofolK37PxYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6yiBmnsI9zSX4Kbv3/TBbzqQ2vZnOATam9MmfLtDP8=;
 b=SEeO5MlWjm4+39Yb4sAYhojkWJ2kadftTW/kGK2QKqSkOSv5zc1i8qcKqnqwIwPeCzWZo7/H5mY1UzJTQoViveGxLrH7uPZHNErNyE6UZsf2qtcFyheyL0dN8JPZPbSV8MvUF86vxCIKYLKBx7NACpQnc75MeaDBg4eUJ+Cz4is=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2983.eurprd08.prod.outlook.com (2603:10a6:209:4d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 16:01:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 16:01:53 +0000
Subject: Re: [PATCH v5 3/3] iotests: Test node/bitmap aliases during migration
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200820150725.68687-1-mreitz@redhat.com>
 <20200820150725.68687-4-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f360b297-e166-a16a-4f6c-8373b7ad0984@virtuozzo.com>
Date: Thu, 20 Aug 2020 19:01:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200820150725.68687-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0066.eurprd03.prod.outlook.com (2603:10a6:208::43)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR03CA0066.eurprd03.prod.outlook.com (2603:10a6:208::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Thu, 20 Aug 2020 16:01:52 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d88ceb76-b912-4859-b8cd-08d845225afa
X-MS-TrafficTypeDiagnostic: AM6PR08MB2983:
X-Microsoft-Antispam-PRVS: <AM6PR08MB29832822187CCFABE146F264C15A0@AM6PR08MB2983.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s6ToSMY/yhJ/f+CUp57xJcypTRAh7+KbzcbTVgFGEkgE755d/G9FvKr0a3uZIsZG1bZrB6CdldJwsdxvpX0G1v5ZIA3dNCJwL2/IYyWSw8cMrU9gKClsJRDzxSTtCD3Bldo/tP0BFJe83sZXvGTyCHcFRdGBaP0UqQbzuMT9WtoEKEfVzXfycHWXtTEjblAr4BlwYgUj1XUrNPzpt8YZoxHBkFH2u6A7DUaHOumxijvw0omgIPXBEQBX2DS11aAmubocF6UHBofaNqJNVYLkAh/JrP4NLYfvZUnlJsM/IHe6pw+VIJLH3qvwdsHMpvr61ChqRg0OhE848msDjnjq1YagvOhHwpVThMRozxxNcg82zOVEWM/TwBMJkjV503ZS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39840400004)(396003)(366004)(956004)(8936002)(6486002)(186003)(2616005)(558084003)(26005)(4326008)(5660300002)(66476007)(66556008)(66946007)(52116002)(8676002)(16526019)(36756003)(2906002)(31696002)(86362001)(31686004)(16576012)(54906003)(316002)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: iM2uI/EvZQiHOwl3tLJVhtkj1X2dB1AuukI7ShY27N0iOQ+Z8mWZT2cBZCBSTicXAhjxLJ/KJwIiKEQUn2PJ9FxYJNhExY/zWbVC2TWDPTldSzTmRas4ENbaemu/rpJceUfnKNb+UZJ6zzx6gCs+lVG3wACmpASGJRQKufVI9uooxLzIBvmW2rYoNY6vJleIi5Hshg94zNhFeeSXa1TuCZRl7IBuhWXX6GWc4wr8UXAW7QopJ0rDrJK0MxId0pW7eQ++NaCVMNOC1iGIV4V31OIDDlO+d07Xpc4xEyezUcFS2QpeW0RGJLSn5mlhwFrHCZw013L3lVb7idKzapYmD1WsTvMhUnnGlenCouVNMUc/Lrv+wmK1vnFJX/2bOyFcCpavenVPdEJWiDBHk6wTVsLu4YruR1BQxsFTWwCi6lq3pfoowAcEDGua2/iZ7ZCxZM11bkLrPYYMWpvmd7HiGGDMFgNG+IQdlBOaW2tl5AXn+xoevdGZrU+t/+R60AVHPS4OGFbEsYvaF79dxUrOYTs2LO+RQFE9FSFNWiRcUwQ82xOeZRHkLn02sWhHxH2gDJpPDrTF/J01uWC7pHuw8my587IRcCqLEuTWNI84PgFOXaRlNmY7ZzjVRc95ENbI1lTlr4MTmR5LAZRND1+GyQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88ceb76-b912-4859-b8cd-08d845225afa
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 16:01:53.1336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Pc2r10JH11pXjZ0QWyv4VUlIXFSuEEHOGyloBxk2D3CNwfMRqM6128pFnmZB9lvK9A6ZtKzKlf2Ki+wOHGqvnoL/BCilMT2My6VTiFA+AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2983
Received-SPF: pass client-ip=40.107.8.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 12:01:53
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.08.2020 18:07, Max Reitz wrote:
> Signed-off-by: Max Reitz<mreitz@redhat.com>

Sorry, I missed v5 and answered on v4. Still, the only change is s/write/discard/ (good change, I'm for), so please refer to my answer on v4 for other comments.

-- 
Best regards,
Vladimir

