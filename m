Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E8FC433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E6B20748
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TR3Vufps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E6B20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ62W-0004Sv-2S
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ61L-0003EV-2s; Thu, 14 May 2020 01:02:59 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com
 ([40.107.7.118]:49285 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ61I-0006y9-N2; Thu, 14 May 2020 01:02:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2hZebz96CvYFOe/g21B9vwvfCV8Ny2oejuAwgcSGx5cYWdV7nrGvA5FlfFySQMLvIOlObQ7bK381vZtdjgYZBGfSPKYIGAZmdwBSXWKX0Yj0So4Ac1se71OiHSZZJiB1EjTpQNrXcJLONiLjCv/xkshZSlZibqHGl2wDreuwB/YmPqtc4l02J0KXlzlQYUaDIc8zD6OaxvLqS+t9PgkmqRH1kohB/kfycKmrMbQBly6AXJigK477uSP4CLd0ZvGutJc48Qv1fy+85AE7rI8AaBuepcZJOvfgB3oW8p41dQvI2Iro5OC7X4/zidOBCTty7WT8R/pUipfDchOZzaDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//6S+naezzxAV09bOKHbZTi2ld38jXUI/zCnixysX9A=;
 b=eTklvIZzRpCeLuGE/yPKGXViW2pap1bjQO8BBqqkPlSpoH/YSbhzGv2U600yi2QYqLnEhDINdkKLnGZJ3NoDFPFmHVcTVtL1KnpmFAEnW8bFB7Gst/5EdN2zHf7S0JehQEtqHuAlGYnrOT08GjYp7zcscnf0ABaavyHDaYFYqrqi2EQtImdt1mXw6INmuvEaxZnpyomXAtiPuoTIjSHMx4ASgPIq83q36+odHez6NHUQLewJoMHYZyXECQR2BTDS5MEs82edOWUiFKaMShm6KJFIy0+S3sp5BICna5kt7DYpTDzO9fosfu4jpeWZt+AlWnfMFuIr649SE/HvtxSMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//6S+naezzxAV09bOKHbZTi2ld38jXUI/zCnixysX9A=;
 b=TR3VufpsTnBSeJ+GXETCnjWm+2AVnBicrr1f+2I1EyNgTrajGmQ3dHXhaExwsApGbtNp7MYZZWGQd+iuZebctfg/oRphZ2ych06jfkcm/XEMKD5HLy8Xg3m4XB2xZVHlPkPIJ1YKN23ktgPu1K30ynQ02Q5wjhuDh4YYkA6MNas=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5368.eurprd08.prod.outlook.com (2603:10a6:20b:103::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Thu, 14 May
 2020 05:02:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 05:02:50 +0000
Subject: Re: [PATCH v4 1/9] docs: Sort sections on qemu-img subcommand
 parameters
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4bb6ef4c-9a29-42ec-15ea-36bd1f6d2e03@virtuozzo.com>
Date: Thu, 14 May 2020 08:02:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200513011648.166876-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0154.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM0PR01CA0154.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Thu, 14 May 2020 05:02:49 +0000
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f9c6b96-4ef2-48bf-642e-08d7f7c40cee
X-MS-TrafficTypeDiagnostic: AM7PR08MB5368:
X-Microsoft-Antispam-PRVS: <AM7PR08MB536896DD38E32BBEB1EABF78C1BC0@AM7PR08MB5368.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WnOnYz9jvSZSSOkJwNok+7yFbl1QKY/Orp1rjl1aZsUGUCwDPaF5RopW6AG0yVgISYPUT+QDPagdrzMZRmpV6hZkHoKrDXikTk2EMNvA0dE/kU0W5n0dCS0QwwNkKBqYKfBS9GpLfLddJcNj1XQdnG45TnEkXJKH1GtIJwSQEUwcfUfZIOSFRAhbpeLyAEB7nSyzGIlHTtb90LAzSwxgMXud0nlAX0PbA7ijrwVJAge7zfo7m3PcM1Gl18NFYUMtx1n9Z/uEMKhadGMR6tCGOIACfWlu1wCHPe9oiDv2gOex1w6ppXSs5fhjEoH5C4RGVM7/IgZLbMLHdDemNz/wjWgjFukKD6EMk8kPwy3eRsvwOo3V/ol5ObSq/+HFTJoeJwHhj+VeedqSC6DR2UboV/4jQhLoBUsDHIvaEeei7uRZ5vMMCHCSZplQATiGLOFN2DUg8n+47IDs1OMI15htNCJYqDWMu0yaBrntTAkfAeQ7eW6BZXAk7c6AwILZ3uv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(366004)(39840400004)(376002)(316002)(956004)(4326008)(26005)(2906002)(2616005)(16576012)(6486002)(66476007)(66556008)(52116002)(66946007)(16526019)(478600001)(186003)(4744005)(31686004)(8676002)(36756003)(5660300002)(31696002)(86362001)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nfVjLHECvGYzlYqZmEKxCVZQMK2e6hLkL6XJGrrt2UYlG1GXxY6JJSE5LsJobnzYvnrj99co/AqKYTafU+25l9QAc3qBf5r5LVfY8uuN/dYX+4l/ycjZEK8VhgMnEZOjI4nClKqoRFLtuujguFjAmiQx+eszYxqRnvXvbR0PMJehAToXCDw62pbklaq2N8rdAsuKbUAXG03s4DtSZP5u6+BiOeATWk0b1r3EyfRAB8xfK2ItwjWuYyI7Wdhqu+iyA9QnTjgXbxE9hDiWsnfNc7hZMTPEx9SNg8cozjYIcxp1m45BgROfKEOxN7pXVIDnfEAzTFWWNUMsZlKHOXnpUCuUwbQ7wHQrDrUZicYvrp03AMMzloswzXYRHLwfpLjfd9O7ZCO/h5pc1d+i6nFk0+hY7dcWmbBldICK3i+TvroS7354yg6MjLfyHrvS4u5Dn5owX8519sk5B9vW/r92qfSUDyG4kHs6iC6+LvWSL8M6UAXrifQsRIl1cwGDgr1a
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9c6b96-4ef2-48bf-642e-08d7f7c40cee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 05:02:50.0418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6/+ylGRoDGdKfbh/fwvWpJDazmhwykX7JqLAUjOaYzUIrgHC7xKm+D4qwQJLCCwnnWJjR4XLaU8y9JJsRxrpe5LQ06D73iCx/gAet8tu7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5368
Received-SPF: pass client-ip=40.107.7.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 01:02:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.05.2020 04:16, Eric Blake wrote:
> We already list the subcommand summaries alphabetically, we should do
> the same for the documentation related to subcommand-specific
> parameters.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>
> Reviewed-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

