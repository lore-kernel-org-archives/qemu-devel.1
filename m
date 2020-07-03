Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77512C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C6921531
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IW2/twA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C6921531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNhh-0006Nd-HA
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrNgx-0005RX-EW; Fri, 03 Jul 2020 11:33:31 -0400
Received: from mail-eopbgr40119.outbound.protection.outlook.com
 ([40.107.4.119]:36583 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrNgu-0000cb-M5; Fri, 03 Jul 2020 11:33:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOiu/9nwwa9f1HHvMC4EZMvzchTNafuJILK7RRWyJLXVbkMCk9T/QfzdJcUGnQKe8N7/JUfYYb+b/LL31Bqciq4Y3PxylMiExgUOZh3JcLPmHzbDBg1WuvB0Ygx7q9UyzEVSXeaT4ByOs1d1CGpftYhDmBqKdbBH0+kHh4IPVc1t224E+1QLWn8iLtOv3WGzqCLguEprFUSSaEh/9Cp1wNVTmLOi1OprKTj77U2OY+tXWtLxGFgSr1OYsB78g0eUokMNhfbtSqe6JE4GMVBP+uJGnBhVIQEfvVDWWFi6UFA0vFmq1Ve4M1I9KvSsQB6QtmxTvUrjogaNa+U7Qq/aQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En41VwRSkQTreFwMLWHtB7Gkf8xn8rsAZapHH6qWNjM=;
 b=FSExR4HNUp8GZITuzHuKFoXLaxnWRRIUfe23jJtK2IY6LLxBwm1ICgck0J6yPmAbb+2woppQ283QON1b430nnMyaU/SLbeeFpooFm4YPDqExQUZdJn7h6j3iYEqFofbzs5P7q5Dwy/p/mldNOf2vxAGl7Za4a6HO1N935hZzZB8s2VynLhPkyeXNhjkY4gmNvDpRZ7DJBB6IS+0524RleH2nV6ddZmLBnJB20E7gAJ+A+Qpg4Xae+W7xb8qhXkZ6PXoC+zojddC7h8VP3JUCwuR7zwyEHmaRNKDovK7+d07FfbScz5vsxt93QY1bgEHGEdf1aHIW8uMe4vQNf+zhXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En41VwRSkQTreFwMLWHtB7Gkf8xn8rsAZapHH6qWNjM=;
 b=IW2/twA4vdZ+C8X1+QPPZ1GJzbzRMVJ15sce87vDcfLgQ1nRQYQr4FrIGme7z0W5PpKAyzBshknvzHSaWYQCMhYrV4f0nj0BHtG59mfWlxlk8Bmme01HBmcAd9604OtFldFqQzSpnU4wVpPw3oXTjK7N7VC6JiXdbUDWQmNdE4w=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3287.eurprd08.prod.outlook.com (2603:10a6:209:41::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Fri, 3 Jul
 2020 15:33:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 15:33:25 +0000
Subject: Re: [PATCH v2 21/44] qom: Use error_reportf_err() instead of
 g_printerr() in examples
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-22-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9c03ba1b-a5ce-8ced-306f-f35e6ae70a5f@virtuozzo.com>
Date: Fri, 3 Jul 2020 18:33:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200702155000.3455325-22-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0701CA0022.eurprd07.prod.outlook.com
 (2603:10a6:200:42::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 AM4PR0701CA0022.eurprd07.prod.outlook.com (2603:10a6:200:42::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.14 via Frontend
 Transport; Fri, 3 Jul 2020 15:33:24 +0000
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 193a6415-a2c4-418e-a5b3-08d81f666d26
X-MS-TrafficTypeDiagnostic: AM6PR08MB3287:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3287A480A4F91678FADB9A06C16A0@AM6PR08MB3287.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTX4LQvc+NghSNis8JNcc0MktqKAn+aiO/J5/j03dQzp61BzMyLhrUm4/VGZo6d2baOsDfVEiOIjnOYeg+GHKt7tHS3zjYLp1xemRSUM+u+apzpQtg/Oy32k/bUlvE5b9HFSXcfltIK+bKH1R8zDcV1lHoYN7b/gDp9mPAGDQEAKZIRvuW0VXmq7+Bnbs6niFxd9uZyBEAa5AZ+i5b2BR5K0bkUuo5vlFmgTyUsutHkVMhX6yp/4tyO6Ml1WKZaJL0S+DiQwVStC3bcQ7V1bTXG72eNnGmtbEcCAXjLnBdLxZ6hbwFf70EUHesY8n7kRuRVobQHk+sMn+ScaiupA0+ExAQgOKXWyPxGn+LXLF6fHxCDUOfls4OvLTLyBZHhx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39840400004)(956004)(2616005)(8936002)(316002)(5660300002)(31686004)(4326008)(186003)(26005)(16526019)(36756003)(2906002)(66476007)(66556008)(478600001)(66946007)(6486002)(31696002)(52116002)(558084003)(16576012)(8676002)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /gXcN7nhgs7R2ZftJt7+cnR3YnDxWe10EtDD4cZjFGKns9/KuYrt2ArqWW/mCjw8LZcbXzwl8ljWkzQ1QngWndnnuIGxU1M7JjFd6hbseZ3HBAjHasTAtPc5OdQvnHhXmSElvqQVJXA1GClr+1aAJqzbAmY9cqr48GONIJfllJFnZ2pxQwz0KT7QgiHSXkW+bE9LDyEMad9CSCNl/TQAwLi039iUVMsMDtX2oBuQDpHsnMvK0vsHpCqxtojUCO/7VSFNXcTtEXUXhGhAF1zU1lt65guys0aiOQLw55gdvK/3J93aUH3v4c+mi7quCGnHdiE0oTWxtWv2P1wihD4Sbc5oxwNwuhIlhzIDZ2lQqQEmprtPGX1s9CpzNDFbplNjrK1iUCZqMinz/yk73Uf4otljDf2Kd7YYMCaPukHE1YmmN6vgmrZ2TK7H/JbA4ytj2sxSW4PzAZfkSOJle6YdHxPyp40ktOVaN/RwBLUeFRG3QhvrAgOFJWAv4ye8uHX5
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193a6415-a2c4-418e-a5b3-08d81f666d26
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 15:33:25.2773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLDRFnWnsDNtcEeP5KpIAB8KHtrNAnpuT/FWmMDHO30ctnYZk7xaqi2zUhQPqhj5Ki8/EnrY4ASpZIFdsu/z8qC4AxGRhcFZp0GgfWoImwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3287
Received-SPF: pass client-ip=40.107.4.119;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 11:33:26
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.07.2020 18:49, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

