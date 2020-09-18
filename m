Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337BAC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9008720874
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uK3yfNWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9008720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJFVp-0007GM-K8
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 08:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJFTw-0006ee-CE; Fri, 18 Sep 2020 08:27:18 -0400
Received: from mail-eopbgr80108.outbound.protection.outlook.com
 ([40.107.8.108]:52462 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJFTs-0002jI-45; Fri, 18 Sep 2020 08:27:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAiAv6SsVLG+bAo17WbG2lkVIewHsPr870ajjmCVDPmJXmZBll2oKukQpTgcoYekdokC6witoS61gqEckQnc3FqLOgRLShV8CRMOrj91UAdJmnJuHx46Yo9GXIlOjaE3e8mvmi9cl0LJS5X4vqLXRNXrksE5q8YxgJyxR9PMxpMeR+u4uRibE1kIYfnuYOC4k2JLX0dZurlLc1ScBWX/xtLfcr5gMUNHbf20RAsbMtfAAKP+LlJa1t8VxSU3v980Fnb65M0ZikgssG837kSyo8wmwS0K8ADtXh4F+tSHtsGPbAf42s2To0BwI2lb/PS/7F475HAPFV/85xJNuJuh+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g00FOPaOYvhFDEGmsx4ickSFGxdEvJ9xZIvMnUi7xqY=;
 b=DznwXUKgsmUrNDjNIDHk8ksCaQUf+vmcyu1885OW5gYOMDPqA8Vj2vF+JFk1xqL0Wm72cczoeTjhwd8x3luowrTa0wQ24nq5jmQCBXrWWAYolwAO+FM2a+o1RKdVHMHQVMzhA8Iukpa53JEMjPsD9tI4XP6ENzHng2/Fnx9horz3LE9mUe3nj+95UaU9h6oAEGU7xT/TawmhpW3kXJsY6uOjvrQlNzzUzv/aA/25ozU9hYl+iehpZNax+WD753Rl7yn5hfcm1VFGpPGvnph0be054xQcH/dk8AkyDqjUwA+4Tl8xzKX6Nt69KbPbqFMmswfhfwFgvVePuUII5ooAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g00FOPaOYvhFDEGmsx4ickSFGxdEvJ9xZIvMnUi7xqY=;
 b=uK3yfNWOX99QGxMtoYC4cH3nlOGX6nHmQyS7XJVRV5x4ylwrvqAucQhm3CNEx/HzOf1iiMVkDo/+wOdSXrCM6CMgTyqJf4UesAaPX/qC6UVwMx3u2HRO9357Nm22VHgTf/fHDa4SeUbbwzXQOlkEhMYL1jtSxM/vZJQvxbMkSsM=
Authentication-Results: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4024.eurprd08.prod.outlook.com (2603:10a6:20b:a5::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Fri, 18 Sep
 2020 12:27:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 12:27:03 +0000
Subject: Re: [PATCH v2 00/13] block: deal with errp: part I
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berto@igalia.com,
 eblake@redhat.com, jsnow@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, pavel.dovgaluk@ispras.ru, ari@tuxera.com,
 mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
References: <160037373907.8478.1501364519385043356@66eaa9a8a123>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9681521f-a28a-aee0-668c-0033eb0b10bb@virtuozzo.com>
Date: Fri, 18 Sep 2020 15:27:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <160037373907.8478.1501364519385043356@66eaa9a8a123>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0108.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::49) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.106) by
 AM0PR01CA0108.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Fri, 18 Sep 2020 12:27:02 +0000
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f98a0d47-5e8c-4f6e-717d-08d85bce262a
X-MS-TrafficTypeDiagnostic: AM6PR08MB4024:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4024EF4CE452C8AC240B5864C13F0@AM6PR08MB4024.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFwRH+mifB9qs0uHtvjvUWzbGEIFpQk+jTLy3aV6+VuJYcy/RVrjcrKXZfdB4FVVcRgQWpF5VjJzu1JUwpIB67JrD8EzzW3JAgAxjidR/o3ynm4p96rGWm64/xYUUZhqAn+Z2AT2NblsQbJvQ7BeL9bmIFpeAaIN7oZULUDhxsa+UyN28Spq0DUSIXZ9xTGXGpDVJsk7hP4DhzvQ0yzs2MNLnE+dSn5jG1X8zEHGgc+skjG+suKAOZlRBXNOSJY2RZZIa3iNc4U9yaP35wEB8yO1R0pQp6KFD5v7XWxreoAslCoOssFox0dilKVDN0Y1wa+zsoqGaDbfFU924jcd6UpEIZhd1DGKl6nFfzdXAHadzG5TA3NB8OKZUysj1MMXbtWUyMu5vfSnaKXdBOOcaoiH6A9i1r7APVChE6Qj4apads/tTVBEeuiyDSRaQ1B0XhlgYJ3YSBpypcOaEEZcsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(39840400004)(136003)(6916009)(6486002)(86362001)(966005)(66556008)(66476007)(66946007)(4744005)(5660300002)(8936002)(316002)(52116002)(16576012)(31696002)(2906002)(8676002)(36756003)(7416002)(83380400001)(4326008)(26005)(16526019)(186003)(31686004)(956004)(2616005)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: r5t+OmrZF+xzm+J+2UMy+mNA6fUM1U+AxMFL58fKf/InXx1TX/fKOZN0P1jS0QjXBHsOR9byqpZTkz1x80cMHEhn63O9Da04GtMQ6Oo92CO0bi8VUzPXx+U3jzbtuVyjcmAMtt47j67o4b35tmIZbXY1S5FpWJxJB18Jk6E7rNBfjfmyG3iUFhHmF2g72f/U1GmaHI9nBehzN+GiJmurKI3CWYzIZad+CTGSjFRxpRYrvWGswUO9t+qLglByDi6dVhDzTFjq/f787cql4MaYMtg6Ri6Y+EBa5QMIuiV5LZ8YM+B4Q3lKYiLUIzDVWT719OkbU7wn8Rl1hXiLodI423zo4OkUUXzLkHolPTO77LO1CMzfjJyXu0WsF9CThQYITuKXIDPVQGAHuJPnhlKlZUkwm8yvwtcVCTS94z+YXPwr3TuhJcB2FnfvgSX4QSh4gbfu4wBdecYC09Zd8EqvUkU0GjtooA2yzjRHZHZNuRNUHZfuFz3M6/XTi+/tB4bJzgUtd3V0weAsOMeoJIIVHtri4enzy41umBRdhCqOE8FX+i0m5YA/TiEfcKAuqE04PFtS7OsIfEkM9mPiFiN8tUpXy/vAZjHTa/YYSHb0iFAh/T3kaFDX5Mzkj++JS8qMEBqVCMGtiC/7StmeODjwmA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98a0d47-5e8c-4f6e-717d-08d85bce262a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 12:27:03.6692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bv+CI1Qt4bejJexo1eOQcNrU5lgaoL0wQoe0h/X27zbnB82K6KIAvOkGA1q0XIGBzIxMYF0JRewR2Jx+2cL2sg9O6yAHuFFKTp7mY11gQD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4024
Received-SPF: pass client-ip=40.107.8.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 08:27:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001,
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

17.09.2020 23:15, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200917195519.19589-1-vsementsov@virtuozzo.com/
> 
> 
> 
> Hi,
> 
> This series failed build test on FreeBSD host. Please find the details below.
> 
> 
> 
> 
> 
> 
> The full log is available at
> http://patchew.org/logs/20200917195519.19589-1-vsementsov@virtuozzo.com/testing.FreeBSD/?type=message.

Link is broken, it shows: "N/A. Internal error while reading log file"


-- 
Best regards,
Vladimir

