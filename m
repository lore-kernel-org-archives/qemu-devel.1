Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A8FC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C19217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qQm1Oq1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C19217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrpV-0005xJ-Ls
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kHroA-00053i-0p; Mon, 14 Sep 2020 12:58:26 -0400
Received: from mail-vi1eur05on2118.outbound.protection.outlook.com
 ([40.107.21.118]:19649 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kHro6-0002cl-GL; Mon, 14 Sep 2020 12:58:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXlDd3fUIVDxPzXRAaxUm+BDYIQ2AVSzXRdZWBanIVM9Srml9wakPFgPUAoQztLldC2OTLWUgNfL/bPTR21L+LePAbhAspM/6LmCpDEeU604MbQ4smGVbV++PABoJIA46cCygQolbk7jag9kU/LxywKC6Xq4WkYaLBF3iq5ONN23ulLz++oa3nOSlPsFsAeGymCgv7ntRcqCtSxyrFi3vznILnXN9OSF7egpbifobtUhyZ6Y/DZsR3tKhTdbGedFg7SIa9pRMBqyC8vH6E4Fdbmvdruw/NHa1E7tTkGPNyfVmu81Bpn23tulE3bsilGALh4hK1z6VDfXP7Rr03neQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFn8tv02pTirQPtG2mY8StRpHViGSYxEGhymdnBmjq8=;
 b=UwhQTM2kuHtBFYS90xcMilWuM3+suSCn+8y03Eqs7fFB6wvsss260slMlS0eADKd9S7n0YzfjMF8ybwXWJ+XdKlL1NalhSMKrOw8PUwwX7gumG1Wrwf82q2ODEWlTXrjxQZzVqbZrC/A7SwmZpiSW/DpljND6fKh0771rHGV/hWMz/2Z7iY2Oj/ARiQRFSmtpcdua9o4yjHYmfE0HRkcCV3Unt6IbKx2khoDwff7w394TSohtQr1GGU2R7GnQcG93xKxI54KEYA2pYfz1KvCw2cI+vhzkXkP5R/BhVypmWbUYV3bNmdxOHif2t0ysvLr05baqlymhTR+U2w+TYoMRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFn8tv02pTirQPtG2mY8StRpHViGSYxEGhymdnBmjq8=;
 b=qQm1Oq1Lo3xUIRo9M46JK+Gx64cayjX2D00dHdBuHhSmtl5wfqgWZKxQNk+JI0QnKyqFrrpkJ9DVfAa6KXwgz3HlrfHN5U+Xagc5xdVvOkrgbeBaixDQLgUikws7JDrD+BYuZU4AX7N86WyzdN9Nez7C/lCjFrN33EZbdOfMQb8=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2612.eurprd08.prod.outlook.com (2603:10a6:203:99::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 16:58:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 16:58:17 +0000
Subject: Re: [PATCH v5 0/5] fix & merge block_status_above and
 is_allocated_above
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, fam@euphon.net,
 mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, den@openvz.org
References: <20200610120426.12826-1-vsementsov@virtuozzo.com>
 <20200914130643.GI579094@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ff809605-edae-adce-63be-aa9942033f50@virtuozzo.com>
Date: Mon, 14 Sep 2020 19:58:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200914130643.GI579094@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0101CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::11) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM4PR0101CA0043.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Mon, 14 Sep 2020 16:58:16 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9c9c26e-e1e0-4f66-0fc0-08d858cf604c
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB26127F4295ACD6DA1BF67E73C1230@AM5PR0802MB2612.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVb1jbJnDznEcPgUKNrLTICqwy57W58L6URXNX/IHeavjGumB82uBzAGOoXU5xu1VmHWQpY8BqrVYH0PRN2K6bhLCIxGEyO74WqkMvAPRDjHUu1WNKbjqbRpR/zAEovfThD/4yXKaJtDCW1hyRdNGMfqedqhPo4t6ULZCYaQj+FxI2a+mMMqVu8Yfpx4f9nv+McrxtUG09s8DJUGLkNMl4E9jol1YN3YDJSRJNnS2T8iUL3IuLlTEhTjzAj45b+hiQBdRbWiFG22k2PwtCJWf4oXvPWDg9CONy095O6z9+VwSFJ+b6aYJku7MBgkvbwI41ghG2A542wapzCfaURjsn6Rzvtj1W2bXJtdlGBMLOlTJeczbeBgrhS9QBdJ1TCE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39840400004)(346002)(396003)(366004)(2616005)(4744005)(6486002)(5660300002)(66946007)(66556008)(66476007)(26005)(16526019)(6916009)(31686004)(86362001)(2906002)(186003)(478600001)(956004)(31696002)(52116002)(316002)(16576012)(36756003)(107886003)(8936002)(4326008)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: BQYv3G5acgGmFUfM1MhvUykORcbz5MGk63RbE89dqm/GwjB2qgM2Csys2LZkW4A9+O6DE3IYQEdZGj1+I8Qga0ZXgjpF8VI5+t/ox0Kd3uXIG86VyHNHLdovTC+42CDYdOwPRbCddDNzDvjek6IZpHJ8GGrcSqYJjM/6KAfhUbpH5gI/ZkX/uYOxO6OXihbQI7+0Vi8JKnmvr/IQnMvscirGtIsbPJQrhK/enGlADbWHGmKr6KZsjg9WVCSL+LdC6MH89LAiQeBOxNpjmEtG7AARvOr2teaM3ifNJKjOi2xbADGPerZK1/HMyEM2HVeB5Si9wN5AEH/I+UQHb87jZk/tEeKTKBIDZEIcG42bWlVJv9spYYxSU8j5CsSqbbY/HYLbySU9qkRa6/dZsLylNKYUVHtBTl3l13Bs+nMHf34f6VpIq0o0EoIbJkTsgubFWLH68I2J8gweh9lA0Z1409E53rAfuazY7w08tNBLP4hXraCzSyX+3eLHWIb98kMvkAoHU+fWiruddEDM9XcWkHK/ZD4k308omZPYAwGQyTJz6AeQqguAUCQIPCCtQK2EU+Y40ZylBcob+jv6FvikXgMcRIeP/x7kwcUWYAO1wbW4JSwbJ06AW9etrGxzqEbzCMnGhrkbg9IPCWu1SiS/SA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c9c26e-e1e0-4f66-0fc0-08d858cf604c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 16:58:17.1620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZulibIuwQ2E8fvvDQP/BJzc06WdVnJcJTOIiqAbiiHpYigsL1b2+KF9AhZHvWMrYSV4K06Srxi8tB6yoYgOccQ+k/BsJD8zvztKbnydYD3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2612
Received-SPF: pass client-ip=40.107.21.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 12:58:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

14.09.2020 16:06, Stefan Hajnoczi wrote:
> On Wed, Jun 10, 2020 at 03:04:21PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> v5: rebase on coroutine-wrappers series, 02 changed correspondingly
>>
>> Based on series "[PATCH v7 0/7] coroutines: generate wrapper code", or
>> in other words:
>> Based-on: <20200610100336.23451-1-vsementsov@virtuozzo.com>
> 
> Hi Vladimir,
> Please rebase this series and the coroutine wrapper series onto
> qemu.git/master so the meson build system change is resolved.
> 

Will do this week.

-- 
Best regards,
Vladimir

