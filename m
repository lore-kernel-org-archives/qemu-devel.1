Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6E0C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A512071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fwYWMAdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A512071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRzeo-0002vC-5L
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 10:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRze4-000268-5i
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRze1-0003XJ-Q6
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:49:34 -0400
Received: from mail-vi1eur05on2092.outbound.protection.outlook.com
 ([40.107.21.92]:59521 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRze0-0003I6-Kp; Fri, 24 Apr 2020 10:49:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOk4ZJ4Hx33ruPnnXNV1S5RPyQYJBJfquL6ZqZD3vYb4KLc0r6jrYTr5XEo/act4icU98e38muoPjYVxFNeGipPeEM3R83aea6w/nYwXUccgMMofya27iXjCsm/6QgPfoAXsp4kxUrwN8PGMUNkke8XzjaXoU0Xh2LYJfkDhFhCSpqVUTAdlz58uMNIgqlSe92oqtEwG8dd09EeZUaNCya1DSNCD2jidRrn11YuNKd74hgdATYQqrD88JFHaR8LGf+/BEKjig62a/8QMF4jwsrni+a8BTkw1JEBrUzZa44+CkRf9/+NSTDGr9nGWeDwd2kxSdygaUa/lr04NsmQK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnXUzkdMhQ4LcvnpMnNoi7gPAW64Ppgm2GIujCNyW8s=;
 b=lc+0SHZSU+CBlakWjBJGxkucPrHVvscba48P88VxuYPsx8a9LY09eJZ5waw0cWwatMzpPMKbHNTqO6r1TdytTPBfNxqdGUm+Kwc1X8/UpGPbnT4/fXb+cLIB6TzdmxjbrpLRmqXJcp+LGOPWDG3qMSrXZ3BILqw6p4C4c+X3cISZ/Em5Bhn0j8HrcbwD5mSWrKEfBcUaV6hhsIBHis2N87GHQBf6bwt5o6EQIy7VgqVb+AqqX6x2+vgADPjoLDT8ZNZmdVgcXxbQzgpfsJUZit6vc6/CPchQEBr0QUU+O3EN5PFEAIbNZnnvPw/YYs1rwiz/TgYjo9qHwL44rT3pCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnXUzkdMhQ4LcvnpMnNoi7gPAW64Ppgm2GIujCNyW8s=;
 b=fwYWMAdLXBJaEzX/MnvK1zX5H40GN/R+LoBQ8zBP0R80y5r3+LZwcz5+rGKDHSk+wpn/EQfkPZKbI29RWRL1R7W0GXDeKNW408thHFYtndnAjtjk2Fr5ha7N339ia2XATGpMzCcI7sFDFmKadVWZjFIKXZb1Ke1Xc4SAyV2u3FQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5462.eurprd08.prod.outlook.com (2603:10a6:20b:10b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 14:49:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 14:49:28 +0000
Subject: Re: [PATCH v7 09/10] iotests: Test committing to short backing file
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200424125448.63318-1-kwolf@redhat.com>
 <20200424125448.63318-10-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200424174926185
Message-ID: <28a0576d-35c0-5071-662f-52f9d1715427@virtuozzo.com>
Date: Fri, 24 Apr 2020 17:49:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200424125448.63318-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::40) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.181) by
 AM0PR01CA0099.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 14:49:27 +0000
X-Tagtoolbar-Keys: D20200424174926185
X-Originating-IP: [185.215.60.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53688f03-cd0d-4733-f3a1-08d7e85eb03e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5462:
X-Microsoft-Antispam-PRVS: <AM7PR08MB546236257D3DCB2B9CC87755C1D00@AM7PR08MB5462.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(136003)(366004)(346002)(376002)(31686004)(66556008)(6486002)(2616005)(66946007)(66476007)(956004)(52116002)(16526019)(31696002)(4326008)(26005)(36756003)(8936002)(2906002)(5660300002)(186003)(86362001)(8676002)(4744005)(81156014)(316002)(16576012)(478600001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8paQOAaVIxw3/T4sGSYWHhaStuwJ/bCy6KRD+IMqv4IE/hirQBBLulwCYsSMkLiix8vENyPDABExvMvW2FG9Hqek130dijcdGkPcYoS8L9ruKpeXcPBEQbxb7Xi/LEhAnKC7GshB+Dkq8LGjL/5BfZqkTz8Odijcq3FdO/ZQ4A2A8P59MGpZosjPzE9ygiHYC8M0PQfFc3Yk6DHQkaDEJnUz7w/wbzxYDVGTpZWLHxJbe5aCSbYQh0SEcyr0bVd+KLEpKo3BND+LaPmaaM/AqLuu5+e9BYC0/7C3+0IMLg10XPSUULWWZ366XX2zMdPdPXgC1aKXbyVkfPL6xFSr8Mrd0obOm5kpOr9maRHhiR7rNWIxT37kkXg7p2L7Gy+NDb6z94DuW2SinhW5/3wg4/Im4RltbR76XB/IHh1gEkgNEoVNWioPnWZTL6xBxePE
X-MS-Exchange-AntiSpam-MessageData: DkHG1musQi1/FnIBqqCmd5yaaa32mb8x1Icb2XRqgI7wBYPaJ9F+U3CowXdSbck3GI8fZcXgiTYYDLdO2sZOeLxlv742rTfKAoX8/DJVbAV8J3wikJubSiwIryRsoOx5DrOn84RJVpohHTyQxqWGuw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53688f03-cd0d-4733-f3a1-08d7e85eb03e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 14:49:27.8805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1H1IWuEWc+uSB/7aW2Xw5Epd/ntkbo9aEdeLB3pNFNz4sX4sSz8WmLJyvCg8zInJhLk+wElRjq1A7r5DsrYIeJu/Pm0EywhlaS0UDcdOeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5462
Received-SPF: pass client-ip=40.107.21.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 10:49:29
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.92
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
Cc: berto@igalia.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.04.2020 15:54, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---

[..]

> +
> +        # After this, 0 to base_size should be allocated/zeroed.

Actually, top_size_old to base_size, yes? (sorry, nitpicking, missed on previous review).

> +        #
> +        # In theory, leaving base_size to top_size_new unallocated would be
> +        # correct, but in practice, if we zero out anything, we zero out
> +        # everything up to top_size_new.
> +        iotests.qemu_img_log('resize', '-f', iotests.imgfmt,
> +                             '--preallocation', prealloc, top, top_size_new)
> +        iotests.qemu_io_log('-c', 'read -P 0 %s 64k' % off, top)
> +        iotests.qemu_io_log('-c', 'map', top)
> +        iotests.qemu_img_log('map', '--output=json', top)



-- 
Best regards,
Vladimir

