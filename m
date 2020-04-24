Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D260C55186
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 06:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80C820700
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 06:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="o/QvP3qY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80C820700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRrjc-0005k9-Pn
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 02:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRriY-00053N-N2
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 02:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRriY-0003hy-6e
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 02:21:42 -0400
Received: from mail-eopbgr40119.outbound.protection.outlook.com
 ([40.107.4.119]:21457 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRriX-0003aA-Ph; Fri, 24 Apr 2020 02:21:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3cNGFikJttcIfD7Whb/7zcE76QnLMvrCXTnqwIiscUoZLEq/FF8875wXj/bYrQsDqsXZCpHBunEAb/G1l131jz741PjMZ4YvxLpAZNAuUXITCvgNuvjfMiXn5CAA6cGzWenDP/vtbCMV3GMR1OZEadbAqvdnVJJKglwRClneECdXesPorwZiBatojA6kXcUdAP1X/ZqLS93/00CmUuuqvOznHoYebcqOBENjpL4ME50YtjRkQg9DJZ+SeJ37lb2lvNfTsc8u/sMqEw7Pd5wY8BCd1FuqG1uvPnxWkKq9qOnwGQPnhB7cKLObyodMX3MKPRYtXsrTOAtrg0vTsovdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7QRxp0uUlWR46IZa0y4VyS7CVJJGb/mwzBFOxQpF64=;
 b=FyXtNYERY9MFvIR+O1Vs1VtrA5Pekhpc5czZYgKb32jg6x7vtwHgIsk/MuhScpSJkP0uWfGqwm9P6fW7fxuAf1C4gtm81gaFkk+8xPmOKy3ZueKCFuF8aU08LsgksFASXkH/HZhf7Qu7UWcTHQdVqerAAgmgMm49xaluM/Ca6yPzll8OX4DN8+98T5cNMDpPsRGqV+cfPjsly1BjpB4Q1nOBBxr1nSvKjhSDUaJwf4xNm3n1WFhSOYhRL024kFZF2b5M+AwQduN40vXboEr535njejTJ8nqpeyfPCEkntaWkfa956YZWljXmCFYt7CZrrZpC0u6TtpIgkzjEuj0b+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7QRxp0uUlWR46IZa0y4VyS7CVJJGb/mwzBFOxQpF64=;
 b=o/QvP3qYID3xglsmSQgO2MZ1YV3r0FMZIl3n2Xw7N9o781H6Sylilc23DHLj6ISBEVWdSsl0Tv52JRrky2oHaf0o8vAPvv6f0L9mPKhjkJSYwGyszKpAd8gumUc3UPdovEXAP6Dlk6Fvg5vajSo1JC2P5qTHMKEFT2omtG5leC8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5365.eurprd08.prod.outlook.com (2603:10a6:20b:109::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 06:21:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 06:21:39 +0000
Subject: Re: [PATCH v6 05/10] raw-format: Support BDRV_REQ_ZERO_WRITE for
 truncate
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200423150127.142609-1-kwolf@redhat.com>
 <20200423150127.142609-6-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200424092137522
Message-ID: <f503d79f-2940-a8c5-0ad2-78ce3e402edf@virtuozzo.com>
Date: Fri, 24 Apr 2020 09:21:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200423150127.142609-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0092.eurprd02.prod.outlook.com
 (2603:10a6:208:154::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.145) by
 AM0PR02CA0092.eurprd02.prod.outlook.com (2603:10a6:208:154::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 06:21:38 +0000
X-Tagtoolbar-Keys: D20200424092137522
X-Originating-IP: [185.215.60.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a3980f5-fbf4-42dc-3eb9-08d7e817bf91
X-MS-TrafficTypeDiagnostic: AM7PR08MB5365:
X-Microsoft-Antispam-PRVS: <AM7PR08MB536536E1A3C2462DA9623923C1D00@AM7PR08MB5365.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39840400004)(396003)(366004)(4326008)(66556008)(6486002)(316002)(16576012)(4744005)(66946007)(478600001)(5660300002)(66476007)(36756003)(52116002)(26005)(16526019)(2616005)(8676002)(81156014)(956004)(31696002)(186003)(8936002)(31686004)(2906002)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6V+x8nLew/8Sl93dRUsj10S/EP+CDXmDx3LTiE5kEDQ56Dg+nWhwhIonwvRVYfoSnNi0j2Qviuo/JFfWbuNVJemvN5/I51icEo/8uB05R8Mu9iTn03yQZ8mQ0e+Scvx1GjiHqlPWNZ36qzYoBgLQlXX4zaQ5ROIEWrK/aPvmvCgblQTE7bt1SJxla7Q3OPcqvRH6tYFZOPDMPSnMi6PaXCrJ7jYdMvuJXU8CYDXbKI0LyZ7hFsvd8RVlhLdSLXN3lKbu+0cVxEVS/ENjGpEhT2L1ds+PNbXM2gYm6Tmo37TIykKMNlLhwFtB59u7MaDWKhVcC/926cFzQIc1c0ISEKzt4R+pjwN0dYZ4T4uLIgwUIxGWuT4naxh0gdLVdP+IBJA7fjRCdqsVK1ZxaA2CAEcaiSrHA9UMlPTdxW0EePfem8/3Y+szyqwH7e3DZUW2
X-MS-Exchange-AntiSpam-MessageData: kpS9GffrWwzVkzn1STVkc1ZtlEmEtbibPrUoJzF04lpwy/4MQcHoWTUPNfmBLzL7y3ke/gyNhetrpwf/QHISc8hFond1lXrUQjUObBDJRr4sY3NAT6dcEXOplW5mbKtqPKUgE5IQ/nBmYponhW7A9A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3980f5-fbf4-42dc-3eb9-08d7e817bf91
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 06:21:39.2899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYHrFD3kc57QYrZ4mDhcE1xk/5ziqkLCX5Ue3LO7YVUJs+SdP/nvxmnU4y3u3T/tyxPUGkaVJbSPZm0RI9s4qJwa1Er4+M0plSmrbsKly+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5365
Received-SPF: pass client-ip=40.107.4.119;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:21:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.4.119
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

23.04.2020 18:01, Kevin Wolf wrote:
> The raw format driver can simply forward the flag and let its bs->file
> child take care of actually providing the zeros.
> 
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>
> Reviewed-by: Max Reitz<mreitz@redhat.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

