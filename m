Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4CEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1D7223C6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DjgVRjTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1D7223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmyZ-0004oL-8Y
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nshirokovskiy@virtuozzo.com>)
 id 1kUmtw-0007TJ-Ie; Tue, 20 Oct 2020 04:21:49 -0400
Received: from mail-am6eur05on2122.outbound.protection.outlook.com
 ([40.107.22.122]:39360 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nshirokovskiy@virtuozzo.com>)
 id 1kUmts-0004Tm-Go; Tue, 20 Oct 2020 04:21:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZSBSKFFQ+QT8b9F2LDYmLoKsuRkbkm4tXPlzGc6xOPq6Ml8t2IgBMO2fs/BcE/ssBELYB/Pv7OKTWn7ByG61kEhx5YOB9jjCUdUJbn9V9fl4gxB6cQMhglgghVGRD7oz2gDVduBK9g3JVJ2OKqo8whGAL0s1lasdEo8+cO0gwdEn64gyc/ND7VcdUNrx/mTe/K1jPOLh+eSgr0fcMv+HB8kfSPEsUU6wzBZGZCki39on01NgpLMkaqU1VhgOErlheCBaTrIDFyYbQIW2XkvkGEq8I1LQQvgf07AwXqwb8mPOBHcHgCEWVVchzXGmq5XkE2H8to5k8eZ848X1cEF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7INr/+evg0Eu0Jyr2qmMFnARtU5LTuIc6mt3Hqm9g8=;
 b=nYHOKzXiLrAEJEdT2ugsR+gvJ8vwq/RrtbmqYFEVDYKka1UuZoLWDLmk+qeZr/Oi0hIT7Klw67AUYWhVM7/gapySe219R80oz3pdLtXTMld2elhVAVw95ZLHMPmBphwKF6DfsIon2ZoUHMArhgN1r3CqrlCOXeJG0Y0MKfditoMD8s8gn54M/4Mq3mINK9Lvc2XOntwEj9svgyTi0MjJkg1NXl7FEcYewRfZjDe5W+TLItweqPhQHhfewZeREA2WqCOam0oAM+0JbTYWD98iTcoqH5Id6l5PJ0GFGh9Y0T73AScx5zf9vbqX/uKcStWY12tUU8a9Sxtbz3Xs4glEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7INr/+evg0Eu0Jyr2qmMFnARtU5LTuIc6mt3Hqm9g8=;
 b=DjgVRjTZ00D/TAZKTsuDQAs1ihAhfHXy/9Ul2OR91Hiz4aSkwuhRgRKOuv6537dcielyi4UD/2UaVUdliMb2ARtpgMyQA60nZH+RTmDKBowMyLP/+7Uskqo3ivPbgcc5VS3LPzxuRXEWAre19pj4I8+2dLYxMcm9a9ilQBlDH9A=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0802MB2298.eurprd08.prod.outlook.com (2603:10a6:3:c4::16)
 by HE1PR0802MB2601.eurprd08.prod.outlook.com (2603:10a6:3:d8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Tue, 20 Oct
 2020 08:21:37 +0000
Received: from HE1PR0802MB2298.eurprd08.prod.outlook.com
 ([fe80::d12a:7bcb:c813:55c1]) by HE1PR0802MB2298.eurprd08.prod.outlook.com
 ([fe80::d12a:7bcb:c813:55c1%10]) with mapi id 15.20.3477.028; Tue, 20 Oct
 2020 08:21:37 +0000
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
From: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Subject: RFC: tracking valid backing chain issue
Message-ID: <3b99657c-2016-78cb-4314-27aacb30ca3c@virtuozzo.com>
Date: Tue, 20 Oct 2020 11:21:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.252.131.121]
X-ClientProxiedBy: AM0PR01CA0171.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::40) To HE1PR0802MB2298.eurprd08.prod.outlook.com
 (2603:10a6:3:c4::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.38] (109.252.131.121) by
 AM0PR01CA0171.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Tue, 20 Oct 2020 08:21:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 668c8b86-d4b5-4012-b4df-08d874d12984
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2601:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2601DC4F59EED6089604138DA21F0@HE1PR0802MB2601.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQNc5U+ER/SFxnhVFovYL8oIww08d7pckM5blb6NTYOswZMAGBaywRGu3+fehvisQBfEU/XhXPbcETjWdjgfKghq07y92CRn9nbV+JYkKSi/nmkKQRlMWXFULZVTA/KkBv3SGHHLMWEIbENghVizwYAkVXoee/A1Pib1DSlfuwXlkzDcJJaWMs8DeaHnWRS6mGWJcWvntIUwxteYYSr6ch9FBAh6zSbS/tSl92UjKHgvpdt1qK9qu0GO1ZQwFXhIzNNmQLPLFcDGUCD3R01fQhEIgjYUgPilNWKs8LAEVsyGo2r2QKHlTczGeVMZJj3xRPOYC5E0GQkNbg7zTx4jyKbOp7Yxo6qoQcYweQxArznWzI/VFtux5REXahGpP6Ey
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0802MB2298.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39840400004)(366004)(136003)(31686004)(450100002)(107886003)(4326008)(66556008)(66476007)(36756003)(66946007)(2906002)(6916009)(4744005)(5660300002)(478600001)(16576012)(8676002)(2616005)(956004)(83380400001)(16526019)(86362001)(31696002)(6486002)(186003)(26005)(8936002)(52116002)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XpALd6yk1lM/zrpIAAtsj2QqEP14XsgTYpmMfET9RKXIgC6VRnYf2ZeeAWNOQ6Pzdh99aiSGQ5OXYyBLaLKkBRc0lT8+1eqiyZvOZpaqjqWVJ1fqjvkW3Ik/8mqtJ3sz/ttWX4/gg0LBGgVhCvZIFY/Pv+7/W8j+VB8wPnGYzy+FTT8nrjBYBesV8e84DMswRJEPXubeiRqeTac8LkQQfVWTpuMtkOVhFIIgiIdjuxprC+c+tTbCo0cFpqD3hSy1DE7c/6y0zzXk08rXLbiomVZv4dx0gJLgeE8u/DpKrzA//3GQk4MHi21LF4nBfXXDvZngwHBGSIgaXcZSaZxhirSATWzQsBfs3Fyz+leLM9VVgGBbuAL4ceuxILxIKqJ4xCB770kbNqEDSKj8CZiuK7gtxc7mmFL4N0pI3IqIzxGoFhBN/9BPiGbrT34hORD44dS+GNWLp15AbrQbHu/83THEE8IIei1Kze2q7mdXKQv34VceEzXYy1j/NTWYangu/CY3sjH/xrZchsvB0qowqWwnAfTOpinoTmKJ254jnjH5Xkj8WVgmHFVrssxIACZPV+XVO+uRl1HTW9hGK6MFaOu9Z9I62ActGVb+Aj4kdSzB4/GGbMIkgZEK6pzFla5sGBFFFIeQbcXQ5d9vmQ8XBQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668c8b86-d4b5-4012-b4df-08d874d12984
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2298.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 08:21:36.8693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMkBeX29avhF2YYgE90IG0Odnt3BVmjlSufd/HqKuQsXgxejWe79203sdNcyY6xnhk1A6fMYHRELEHfIWZrFUnKywiSb/KpLmYXAczPkD80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2601
Received-SPF: pass client-ip=40.107.22.122;
 envelope-from=nshirokovskiy@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 04:21:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

Hi, all.

I recently found a corner case when it is impossible AFAIK to find out valid
backing chain after block commit operation. Imagine committing top image. After
commit ready state pivot is sent and then mgmt crashed. So far so good. Upon
next start mgmt can either check block job status for non-autodissmised job or
inspect backing chain to infer was pivot was successful or not in case of older
qemu.

But imagine after mgmt crash qemu process was destroyed too. In this case there
is no option to know now what is valid backing chain. Yeah libvirt starts qemu
process with -no-shutdown flags so process is not destroyed in case of shutdown
but still process can crash.

So corner case is very rare. Mgmt crash in a specific short moment and then
qemu crash before mgmt is up again.

I guess some 'invalidated' flag for image would help. And also qemu itself
could check that mgmt is not trying to run on invalid backing chain based
on this flag.

Nikolay

