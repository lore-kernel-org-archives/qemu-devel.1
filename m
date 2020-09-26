Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A4EC2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 13:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0C8207D8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 13:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kEsuRFLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0C8207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMAKp-0003XX-Ku
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 09:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kMAK1-00033U-7O; Sat, 26 Sep 2020 09:33:05 -0400
Received: from mail-am6eur05on2107.outbound.protection.outlook.com
 ([40.107.22.107]:56032 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kMAJx-0001na-5m; Sat, 26 Sep 2020 09:33:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPtbtFKdkO0Wqm6TR2c5ys6ry4IKbmjEAErFXQWd65E8iYGS9G+6hZHZcmVdwcwDm4bJRZBlFzuaYmAUoTkmDQnuqk3AB3aGkbSgVU4YW8pu+8872Ipd9XFJPbS3+sTgthFKc+4o7Qna8fPSwIpX9YPQkSbZtTYCS1zhIfHoCED+6FtM91vc9k4kYnUWHv9Yx5hmDwrfNbvMyn1tr2dxmK1jDGsWm88hBjsRyft9hgQBDlOoW4B2COmhoDKyyW/+h+k4Y7tQnmWGV4NrIb5eoA+1P1X4bj+MaWgw+8CiS2f7h/yUjcpq0lPJoFJeL+ECVQnwmrAVAPiPYxi+9szZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6xPa7mqo5Q2Mm1RuXHTa6rM3tnYfFENlcRh8+JsUDo=;
 b=i3BToi+NQWDheGcNBbeMCraDt/wdnpi5x3ZLyXun/1u2kfD04LxxSgS5WE+TXSxDjFL8VD3wXQLCVMqN4bi2+8EV8YLbzYZKP+R8cxerkvkvpvqQ6lhQTUE2WGM9dy61keGkygNn7ANJxxm+C6TPQHGQHL0keSF2n8Pl/mXCvuB5gfRgtT79Jn1HUmNDpEoBgtYa2ufrqffqiVa44SEyrsEYUOkaqDXMYKUJzSbyCTGV0HV/rTF6STpz6SJidckyKwfe+kXfqcwPx1YAmvHUB42qREBwQX+51WHFHZOqqw0job6C53sLcSwYN2UlkQeJyS0CVeP8dWijZ+gUDS4Bzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6xPa7mqo5Q2Mm1RuXHTa6rM3tnYfFENlcRh8+JsUDo=;
 b=kEsuRFLWl/bapHkXjY7HzRgioyrI4YLzt7SoFET8EeU1BVPuzsVHGzk5z2X6l1OnQLVdoZopvxymvtNu2IHlc+VLOaWrbphHYCyr3+ZR3ZjAZCHI88Voo9Q426k5L0UhzAx/cFAccfBn2HL28ugKdXKpPtWnHPfOu26mAgLbS9o=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR0801MB1661.eurprd08.prod.outlook.com (2603:10a6:800:56::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Sat, 26 Sep
 2020 13:32:53 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%8]) with mapi id 15.20.3412.025; Sat, 26 Sep 2020
 13:32:53 +0000
Subject: Re: [PATCH 3/3] nbd: Add 'qemu-nbd -A' to expose allocation depth
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, rjones@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200925203249.155705-1-eblake@redhat.com>
 <20200925203249.155705-4-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ee868912-173e-328d-5138-b1e19a0ca2b1@virtuozzo.com>
Date: Sat, 26 Sep 2020 16:32:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200925203249.155705-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0095.eurprd07.prod.outlook.com
 (2603:10a6:207:6::29) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.99) by
 AM3PR07CA0095.eurprd07.prod.outlook.com (2603:10a6:207:6::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.16 via Frontend Transport; Sat, 26 Sep 2020 13:32:52 +0000
X-Originating-IP: [185.215.60.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: facd3408-7451-423f-007e-08d86220abac
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1661:
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1661DE7288061007338A85A1C1370@VI1PR0801MB1661.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBo1SIUcmLOHwlOwIaVxiIZSWcM7w9QdZNsSGDkCifjTI3hzJNPfdZG1YkfFmF+eGQrUuvBbEyokfuuR0Olsb95s7RJJ373rW1KRkkzi/E21xTFwxx4g8gsHPfeWEhoKgf7I4xipoQ0osS/uXiDvK6xBGpF0L5SBgI5kCp933VnSTa5od1Tn7mZZq5/9/rn6JtUmvW/6pFIEos+TOK7SiJLHy6TrZHGgvjn67JAeXIb3iyzJ4iXlgKvbs0lI9ri2WfEYUqqxUgRAdLgSYQi5q54qxSPuY4JQS9L7DdX26xCIkPX+rVfa93EuZgnYOd+6NG+RgzwDo//pKCmNqILQsZXdleg2Mnhs8uBumoC00tb5ZB/J0cqSs/cFgWs43zKM7fGfSJdSvhXfaeChDP5MZuSMsfzOZOmE7jtM/cPXZUhyEnbJYTz+g8mu0SPA+WNN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(396003)(376002)(346002)(366004)(136003)(66556008)(16576012)(316002)(66946007)(54906003)(66476007)(31686004)(5660300002)(186003)(36756003)(16526019)(6486002)(26005)(4326008)(31696002)(83380400001)(4744005)(2616005)(52116002)(956004)(2906002)(86362001)(8676002)(8936002)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1o4GXMODBHJFijRvwQj8xbF2C5q66Esl0MZqGVE6LEYlnVPUPuLS3g8iQIuSs4Iz+uthEJuDU9yZD+9dt0+ILbv0iG4nRgzOdwJFeh+IMRChhl8Rnqu7/BEXDhDhtebBWBTEaQORag79Tkp5ejxRdMgWm1ANXjsgQfEMZFcjTeXQknKSZVOvpoYoJMNWHi41U+ut4Ov3jBIn2EjEUK+4VFa79W13g7jJXslVWN0W7gbEuXB4OG0Sf/wt0MwcpjbVEhp0eUkoGy/wpgaGEaRYMj2tp2T/UDtPjh8XFYZH7Re//aQZ1YqOdhqgFoRJC9qewrz9JYUIR/CA50HmEGwn+UQUlNDClC1CfhMR+bNILGvM4SX66vfwc0/5YDxXyeOuRAA8VcdMfAuMtdxSbjTjN8xtkrvA7XLvQHwoStE2S5csQDrcxeHMQf/pAzPFVor2678G7Ou+Y/ShLkemAOl8RcXfL02eu2pSOPVrjsYKL8laSOl318dJOM412QVEFSN1CgWne4OkXQzV+D4Tu21qrO8Q8o0BCtJCzs6Euor5HvJMEBlYb0zZiqAFfL2n/pa3swPPKhHHocoBklXDlzr2tr0HCA1r5e4deQhWRcmErWay7VcgYQHB2iLySosOmTB3eKXldGnu1yWrUOr0JMjV/w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facd3408-7451-423f-007e-08d86220abac
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2020 13:32:53.3010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abpvK6+4soMN5aX/ksOGnGpeGdu9BUahxJbzqhMUTumLlk/X8vtkop2w7MymEZX4C/1p4MQ43OnnV/exE2s1+5G6wOqtN+oqL+dCJP6V1dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1661
Received-SPF: pass client-ip=40.107.22.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 09:32:57
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.213, RCVD_IN_DNSWL_NONE=-0.0001,
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

25.09.2020 23:32, Eric Blake wrote:
> Allow the server to expose an additional metacontext to be requested
> by savvy clients.  qemu-nbd adds a new option -A to expose the
> qemu:allocation-depth metacontext through NBD_CMD_BLOCK_STATUS; this
> can also be set via QMP when using nbd-server-add.
> 
> qemu as client can be hacked into viewing this new context by using
> the now-misnamed x-dirty-bitmap option when creating an NBD blockdev;

may be rename it to x-block-status ?

> although it is worth noting the decoding of how such context
> information will appear in 'qemu-img map --output=json':
> 
> NBD_STATE_DEPTH_UNALLOC => "zero":false, "data":true
> NBD_STATE_DEPTH_LOCAL => "zero":false, "data":false
> NBD_STATE_DEPTH_BACKING => "zero":true, "data":true

It wouldn't be so simple if we decide to export exact depth number..


-- 
Best regards,
Vladimir

