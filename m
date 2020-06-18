Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CBEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 09:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7119821548
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 09:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lxdZy9gF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7119821548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlr3S-0002jh-NP
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 05:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jlr2p-0002CQ-0I; Thu, 18 Jun 2020 05:41:15 -0400
Received: from mail-eopbgr20121.outbound.protection.outlook.com
 ([40.107.2.121]:53664 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jlr2m-0005G3-2b; Thu, 18 Jun 2020 05:41:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETTJ2w06idO2lUQFnMKusIZmiI4yKaDFy66bQo4YmQkByAVU2R6iAJfO3xc0pJ1w4gsgA+GAxMsaH3Bf0GgqMu4Taht5iCEIMxT5OEMSv7Dhfmy0WuO6EILeCnXbfo5NZuqMuUDBVS04JDEPT3TwzPh+qr7vQNfSJWe1SKy8D8/Ju5LIkilTEFA6hnJIsisoI8JdA7yqQCJF7Ootq34TKd7Hxb3x0x6o8VWvJbiuNcZgSgdoFKPE+R92hb30tbCjT7/KpopRrgJF+v5IlIN4gUZV6rh9hFCJcoXmCix4W3aMvu2rdtfQqSwWeofqWeG5nkwzlM5ZzUc3nmLvltIFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF1tZH1m0HSsllS61A02BCuzkDlM2F1ykt0jOg5OM5k=;
 b=irlZATbo+cYVLuL0tOcy1X2P53xq53aDoGyjfOijOoxFGGnVwHjBQB0GnrNSAOiLg7WE7nTyASh/Yf45vv4BoGj88NnUiKlbpMDKwZG0v0GTzHJKrS657h9plnU5Vz3CFnOTkU04pDV/FTakbQ8935Sklvp7BFArs48XJgzrYo3SOcUpjRYhQlEE3lnqhJtCmPdjEDjpehlpA29Zw/JPUn8JX1ez0d/Qw4sCFpPxRp51zb0Wk3xsYT23lrdX8Vorz8A7xoPivt2ogUqiZWkYky5DuchTMhf1C4r4NBn8hvhI7TfauIQpE3KkwhGF4x1CZSDmQYytaSgiUNxfrxqiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF1tZH1m0HSsllS61A02BCuzkDlM2F1ykt0jOg5OM5k=;
 b=lxdZy9gF3RkiES/djzQNwSHc7nDa13E2v+q4nDnRHbIg8so+aRuITR4km+t9lZ4zBRFu9/RAbDtiTLOFY8cNN/mLKaBR5lZ9SKh4LyTsy03GBws3hG9ueGTfWnQs4W3l4Tt1XnIUdUqSYTCvkG47fnjEfNhR1oV9PuJInLeDlys=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5302.eurprd08.prod.outlook.com (2603:10a6:20b:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 09:41:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 09:41:08 +0000
Subject: Re: [PATCH 2/5] block/aio_task: allow start/wait task from any
 coroutine
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616162035.29857-1-den@openvz.org>
 <20200616162035.29857-3-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9cbbd7ab-a2b5-d481-9941-660b2d84f8f1@virtuozzo.com>
Date: Thu, 18 Jun 2020 12:41:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200616162035.29857-3-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.145) by
 FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Thu, 18 Jun 2020 09:41:07 +0000
X-Originating-IP: [185.215.60.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25d85aab-f439-4e2a-6c74-08d8136bba2a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB530247F1DC50CFA1E26BED8EC19B0@AM7PR08MB5302.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNgS8DroDjCI2/Sw2lU2xuu9HRk7G8bRwPo8aDW4tOCHZFbt0+zrIrJyqTtU9AM2lAdyG9EdK5ibDUEaGON0pbjXREUxyMfUUlapneHfGyCT0quA25klzZOdILfu6ld/AxcjHqdXM6/6Y7aq/UlRvnPO+c2M5Qj5aPb63uwAxbZhw+0gpkomn7GxK2J7vvWsEX5fQO44dbxkZ5PP/VZCrqMbSwE5IJyG2JAC1MmtZdCY28aec8AEFU2l/xrsTvL825GVX6368D1MaNEtEVy3y664Uw3rNyeeeDTdeUKP5xHw6U2qHt4plQRI9DQVUG2WT7Lr4xUhNj609sl/vMmVNZv38vhdDnYi/wKiyMFV2wLhyp4kuFXcobYryIqDU0Jx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39840400004)(316002)(16576012)(5660300002)(26005)(8936002)(2906002)(86362001)(478600001)(31696002)(2616005)(6486002)(36756003)(107886003)(8676002)(4744005)(66946007)(52116002)(186003)(31686004)(16526019)(54906003)(66476007)(956004)(66556008)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XuBxtCEm/L/gPEUpjeLGSB0iIw03z+lVmmMx02at65rJexTKLPHEBJXSx7G6NaHKzpERVOTyGuZ67oXSPyL+Lj1DlPNtE/2vvTEaaMOZU9oWNTSOofZRvYriXQLP2fCj8eozscK6Z1Xo4JEe+3EAO8jlqsZl01o/MZqSnacSPXSDmhZloSlJoF7nuE3B49kNNBmW/CRkb9DQBcwt3jnO5laGDOsvIEqj5Hf1q7n/sx2dIlFV7q2TAfBkmY1I9wk9vPNJyHD+/rUgezCPkWDVIfku2XwnVhZ8LojPzJEbXlMSk0D0BwswGf3gb7ooY1PrqaQMFymwuANbqC9xb8GkGlgxP+YOGo8VrRS06iIb1wxeKdKJNUU1oGVsel/LSmRTLcLN4tNr1MVP3zyJNqxBWq8L5bJyvYQ/gu5jxO2oqOf1bjKXuYCq4YFkLwafGovY5jstDwMTm2RSNX8deQDzuMl5of6KO+z4a7HDwe9xwtMM68fi+paznV3ufeB62Nnp
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d85aab-f439-4e2a-6c74-08d8136bba2a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 09:41:07.9920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6H8f1nSRIEl0lLUTegdiF3cxFLJgN9XPUlfgRr2jVOQ4/ZslixhccIH0Ir4ui1+vHRwIJGcVnKhFBY6jaVqmouud9l7YEdLPeUtQTakVkcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5302
Received-SPF: pass client-ip=40.107.2.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 05:41:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

16.06.2020 19:20, Denis V. Lunev wrote:
> From: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
> 
> Currently, aio task pool assumes that there is a main coroutine, which
> creates tasks and wait for them. Let's remove the restriction by using
> CoQueue. Code becomes clearer, interface more obvious.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev<den@openvz.org>

if it applicable:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

