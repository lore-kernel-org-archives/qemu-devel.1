Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDCBC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329412071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dsQOdIsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329412071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjBE-0000N0-EL
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 02:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDjAW-0007PM-5c; Thu, 03 Sep 2020 02:56:24 -0400
Received: from mail-eopbgr00133.outbound.protection.outlook.com
 ([40.107.0.133]:35040 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDjAU-0006h7-8u; Thu, 03 Sep 2020 02:56:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdTAKnDjBrAKxbzZIyKGZsLTIN6TQHc+tpGvI0YeridpSRPLoSL0G3Yjmvi7d7V0NmFLs7mkB8Lm877oZjk0vOtwJUOzdKFd46d+moEqy5uzxk4KMv9IiHDceUFi/NO+ifyoSt/uXTCrOljWdN3s26UTAh5cxgIfFVJqbmUl0imEM5eMLD0YYWacLNKviCyG9R1xl3biEryHzyoH7Ch4C2w5JRiBTnQHWWkOCJXzXs80z73Jc0nvXx+JjXveRQm9SEdvJ9kx+zmvO97n5BfBxqix6r50Z3VecyYWPUS9yoDQWb6Vo1/ptzaU8X9KWbAOYq869rFycZNJrFeKH6gYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slHmAUOS85hEr1YiKgRpSaTyem8FrK+1FO60tj6gi4Y=;
 b=OYGv/t/sLkht+g/pe8oAoA61QD/hMXAPidh13Au1WKM21Sh1IgpjHk1qr93e5haVbPvGlM0RMloRgo4u0VD3HhPYRoKkmrWOFn6DQXhqMnbTKQpfoHs39rU2w8SNnYW9WAzplRDtsNkJvwQSEKrguk55E5sc/e+TgKKGDnyKY5MVhHzJ9nCRPS/k7u/RqGMVKsGdfTnBNzFBd5RGk7BoNHXcQFfjIR8gx1/CZVqRRghnwo6WQypmZYdqzQ6Vk6vek+OFkBMiNRNNtWWBy1DKo88mv7STEzcpMSu9YF4Dyh5n0VtyV1iTMvswSnAFoPXus/ZWzS4P4PaKp+eDDhYDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slHmAUOS85hEr1YiKgRpSaTyem8FrK+1FO60tj6gi4Y=;
 b=dsQOdIsmIUffZTa8Y7Ioyft16NUnRI08r4xOMcyG+tK2HOmGespH7YOvDTQO6ttnF6rXFURGHZKr8wtC4XGm3R8WTmgKJM9pj6CIAI8ivmpd0JPuu+3qeMzyz18wp9vK1w6ftPy9tprYrxftCVElyK1hI/MQ0IZ0LYRPDHUkukM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3286.eurprd08.prod.outlook.com (2603:10a6:209:40::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Thu, 3 Sep
 2020 06:56:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 06:56:19 +0000
Subject: Re: [PATCH v4 4/5] iotests: move bitmap helpers into their own file
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com,
 pkrempa@redhat.com, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>
References: <20200902181831.2570048-1-eblake@redhat.com>
 <20200902181831.2570048-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <35ef13fc-2d6b-da0f-3bd8-1cb6609a536e@virtuozzo.com>
Date: Thu, 3 Sep 2020 09:56:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200902181831.2570048-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0066.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM0PR10CA0066.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 06:56:18 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06b973e3-6cb3-43eb-8e77-08d84fd675be
X-MS-TrafficTypeDiagnostic: AM6PR08MB3286:
X-Microsoft-Antispam-PRVS: <AM6PR08MB32862E469A5EA4B77250D223C12C0@AM6PR08MB3286.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:277;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQWLb1qpyTjCH+STYlT5r9MW4kLNKg6PGStPQTZg+uPO07xoY8oWyMfrp27C0mSj3UPFu9cIwrflOeAmmHLVZPYMvo3BN0pZQ6I6qr2yYGbZyyRIy2Mc4i5iBV7zRLnPmqji7GhOv6XTbyLBXL86+ZlRuYKghwzzarRepGgvVCcU/5gopH/sINtruKH0tFkhkjQcB2RvicnQVUOcb2uthY4lvK3pbyaFWDGyR3oj3w6mMfLaup8QTV1AKxdatOwgl4DWeEHe6ngxMCf346buh7Jik6HBcSQZmiMkB5rYvDrai2GqQ1ryH5IBHXK951Xvp49mp+kd57FRlcWyLzkygxyhFUCkMwuJMAEq1suhyNsgQXydk9t8amYvGHDDLorL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39840400004)(376002)(136003)(346002)(366004)(8676002)(26005)(956004)(478600001)(2616005)(66476007)(66946007)(186003)(16576012)(83380400001)(31686004)(66556008)(8936002)(31696002)(316002)(5660300002)(6486002)(86362001)(4744005)(2906002)(36756003)(52116002)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: phP3ICK8DlF/4vIPdewgrDONQHAuFu9peu/wZlSXUKu+8M+xvq1amdIZ+OuAHlM5GRJjd+6BrdFjuSJ/LvROqS88tRfu+dwqgm6qOjJwPU/T6GBAHgMDcSYoHIlUvds4PTnxK8I4Zf8WlJsa0gc67Xkea3rRTgO/cpH423EdyqcZn0K4D+nvfhfqVYqNrY7A79ms9QFYH0/WaOp4ZCdpeFNXhVlCjItPTdNwng2+OKTa46U6sl/IK2izODHHdi0O1hQBdUTdmeV0gn1olPv17K5UyOuiF1y2bUs1E/fiD0T76IgpQYDUvgzYgs3bbvmLCg/1M/8gCbFfOZAWfa4AGUs3IqUZnEwMwlzB7l0UX77dlA6I9Z1wAnBeXgIj8yvrAckJOfmbn8sjb/RNIwaC+RLhK4EbG9JfGj+d0wraKvq5tfR0/OGwfhPEVAzzr9nJB46nKUsiMLUjPrH73HtDos/ql09xbNeULlf11k1we755LX4V7nEW/X65Vn+wMoFuUqI1fZClXMYHSjQvHM86Cd5t5JqvA95KCh+w8iEMkUP4grRCJKkUICly71j49gKjp+f/QIUUAKafEIKycJcOErb+P5DmTK5AEBHuA5cOKARLphY8P+Svo5Bur8o7gQzqE/XIM2o947X2FdqRbgyFpA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b973e3-6cb3-43eb-8e77-08d84fd675be
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 06:56:19.0968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMyYWrksSF4vV9XmCS4J2/+GYjXmw4dznvXAqFzY2oNr7cACupEc4W6RRG1PcACh+81aEdh8xlDVII7+DdgirHjDJjn3vmuVbE2hCTPTvWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3286
Received-SPF: pass client-ip=40.107.0.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 02:56:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.324, RCVD_ILLEGAL_IP=1.3,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

02.09.2020 21:18, Eric Blake wrote:
> From: John Snow<jsnow@redhat.com>
> 
> Signed-off-by: John Snow<jsnow@redhat.com>
> Message-Id:<20200514034922.24834-5-jsnow@redhat.com>
> Signed-off-by: Eric Blake<eblake@redhat.com>

You forget my:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

