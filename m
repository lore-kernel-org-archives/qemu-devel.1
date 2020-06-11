Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AD3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067D220656
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J1VNV5ft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067D220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjJom-0006Q5-5s
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 05:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjJny-0005q4-Q0; Thu, 11 Jun 2020 05:47:26 -0400
Received: from mail-am6eur05on2105.outbound.protection.outlook.com
 ([40.107.22.105]:9525 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjJnv-0000rd-U4; Thu, 11 Jun 2020 05:47:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjVTveC7kULm7ot5eMko4OpvkbnzHEyp1uGfLzDePWDCovN2mjORTlo/S/6V/LYdc2OsIFLXSLkWdxLkpMBx8MCAglmZDrNmGhm8JumUZwf/6x6TdZBVyZSaA9vxE4WuRAjSnZ8LvVQIkXFHwRLXkzORUilbChv5DyNxogqPI+1BkwtQb/pHZ0b8oj/D5qWaR4qdYmPiPFAJlQvNwR03P1OuXDFpVNymXNJbeymLpZYtxjdbVETxQVgW/DC2PgbggAcai5kaMIHyFscDzOk2yzL6JcKOh/KcnUhQcLOZaW6qvZJG+cOkcx6u3BVguOe4ktThTTh79VJifJ9v73eJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4YrjCXR2i1FOnHY0YN/90WD0QAoQU87ae/m8FgWfo8=;
 b=NKR5WYLrAJpC+SCeltl5T0dhNTvKKISRDLFOyBrCZHMtNzwNKv81Q3hA/GU2OIKZykm/QEOmT9WxpcSmSt3JUMqq7LrRjSh+MPh0GBzRaFAiMKnCANH0G5xiDyA+vWrxOSK7kk1vl0t07KWW83mazlSR3pCAXfKQZUUA4tvIZTwl3bfRIT596gay6hpL/SanWnGyD/7u7KvV/hy2wfP0oDAPmuwzAKsofj1hKrn5+dX+21uD3IP8fEDNQLpuWnsEwH0knLJy9TwYQcCDpwzq4JEjZN6GY1IWFIpJGSkBgz+OTbGGgxsT7yv7/TR/I3JcgmCzWRymwnRWV9GLzjGKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4YrjCXR2i1FOnHY0YN/90WD0QAoQU87ae/m8FgWfo8=;
 b=J1VNV5ft/1yGR3/52KO+lnlr+S7n3Pg71UjzArGIbDmLMr4cvppMMhQB1c97UwhUSNNKQXKwo/BL8U/pjw+uIEA2skse3hL09W2qv0pCzG5XatJC1F0IVNi3rqXCKMx6V863noaE06OaTEhxGjd1hea3YUmJ4aXS72Wpd5wmMho=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Thu, 11 Jun
 2020 09:47:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 09:47:20 +0000
Subject: Re: [PATCH v2 2/3] spapr: Use error_append_hint() in spapr_caps.c
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <159186635896.48605.3457464705220760573.stgit@bahia.lan>
 <159186660024.48605.6756496231687601694.stgit@bahia.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b26f1d9f-8bee-7458-fb50-fe9414a4c1eb@virtuozzo.com>
Date: Thu, 11 Jun 2020 12:47:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <159186660024.48605.6756496231687601694.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.159) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Thu, 11 Jun 2020 09:47:19 +0000
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca36522b-3214-40b9-cfba-08d80dec6f25
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5382EBDE4FB3954C5BCAF132C1800@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfTe0YaxtB/BglzztMhbT17Apaf3yFD8Zrs+auPjeK/EnsetzEqT/f7JICmz9HEnhQ2EeC5u78506dQ4uDBALW69S8L7v30R44xEVQzHMMltW94mwdIfSon8iflbxoB4UB9GSXGstxlFR0cF23WqaSoyU4HbKYmMOHv1tVFgwcp3hHW2wh/2UrRZt8zKcF31c9ptOT/FPNR6Gxob5fBHCvLWGe4lkpkFrZLQlboMigfx/CHtLPLowjlmm8s29Z/SddK/kuHDecLRjMpbdP+pt768RrT9XcEpppYAotU2oy7ehsAZWGnKrakN8gxRGr5+Fsp5z7XvIJp/8KX7S8AaIeDMKxMvY56aFg7IPCqKL76hLa8WyxaAeHC59eqRJrYM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(396003)(39850400004)(136003)(52116002)(478600001)(16576012)(83380400001)(8676002)(8936002)(54906003)(2616005)(316002)(956004)(110136005)(4326008)(6486002)(2906002)(36756003)(5660300002)(31686004)(186003)(16526019)(86362001)(31696002)(66946007)(66556008)(66476007)(4744005)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UaMVaXZtuniz8Z4kms9JfjZdhJh9YYRPfX6Ze6TclQSaH+CkpUtIswO0dAjpKPqhS4H/tOc25qbcMR5jd+0nDF/cZMJr9SLk1Qbvs/aev2fxJtJSjpcSV3GaUf9gf+Mninb1aKXXSuW+ZFclVUPsp9QLKrqp9Y9tOYasYBxomNFlTeLmKxN2G8axheCPgdxbwSgpmrozgyLmtaenZmjcwbTiAq2LzH/NgpCEgZVjU0buKgqRlWL5xd18HcpNa1at0SnrCwoyEAKbdigdzBZRXXfHtIRFYPZqR4dp0LkEiiKbk8/7moMBDecwqDIK/R9YzKQiEc6LX1UWOxvX0AUkRTNlWMGNzakggFmpIHk3EJ8qgSirSu80yrpNBnxMWFtSMQecj0J+J2xSamjwvbvUQX4n7/c39SceurjlSLQenPCGFS2JJGjKH+xA74yR0oujleSR/Ghm+FvkOnkaWAz0l9Ixcih+ZPNM196XKIof4/XL9XXsh6+R4ieEkYqFodIL
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca36522b-3214-40b9-cfba-08d80dec6f25
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 09:47:20.2217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNbfTF4p4cegaOcZe1QKWZdZn4cDcoWqo5ZpgDsEQZi+YbK6S+Yf20KeK2qgB6gDg4/BekBZ8jOHcjdc652Oo/CvMMIVdbT32vwp82MIUSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
Received-SPF: pass client-ip=40.107.22.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 05:47:21
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.06.2020 12:10, Greg Kurz wrote:
> We have a dedicated error API for hints. Use it instead of embedding
> the hint in the error message, as recommanded in the "qapi/error.h"
> header file.
> 
> Since spapr_caps_apply() passes &error_fatal, all functions must
> also call the ERRP_AUTO_PROPAGATE() macro for error_append_hint()
> to be functional.
> 
> While here, add some missing braces around one line statements that
> are part of the patch context. Also have cap_fwnmi_apply(), which
> already uses error_append_hint() to call ERRP_AUTO_PROPAGATE() as
> well.
> 
> Signed-off-by: Greg Kurz<groug@kaod.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

