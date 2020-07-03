Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7542C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B1820772
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W7Xo30Xy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B1820772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrKlN-00048S-W6
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 08:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrKkY-0003XD-3N; Fri, 03 Jul 2020 08:25:02 -0400
Received: from mail-eopbgr150132.outbound.protection.outlook.com
 ([40.107.15.132]:46374 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrKkU-0005Ax-Rw; Fri, 03 Jul 2020 08:25:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAxMXBVzmr+98vX1KpOVVqG5E4PPjq09MymQoZF7Vj72r1U2MRHtRozyw2u84furcjy2QPk3cmQanCIBH7LzpCbwZdXARWdno5mZQHQgmZ9beKUIGwhtkMtwVvTG0yzaAlolJAa03hKWgWcvKr4Nh1sHIZwQpfvQtg8/89/EvBrf1GYkiw/Io5zHjo9IkidAIVRySp/d9McVZpvCpBqnT7fjIjSJFd0AFnv2PC7a1zbjpgccCtoqMYWz/Qu3Ve62ZjJzWdE9DanFd7YSJQ987jdkLXwMu+NVXgzkpRXMLywrZKfAXFCDcAFRGQC4vgAL2lmlAo4vKGiWWFn6fSkfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/aAz1CE4CqHd0Mvi1SA6nXS3Wm1MOw637cfFQFWVJ8=;
 b=UufIAgdRu82OT5Dv6DSooSnwAPS5yjFXL/ZH5uAD8FhCOGhljEJ0g5fNvkO0+FAlXMqwAUTYRVDPb9mqCYo922tMxbuXXzgx5777WuoU0ckqGu3ZFjsaSrJEhYGxuMjOS8rBuZz6TEjR9onWUWOvgus9IUFUt3tD51il3myD8z5+z5GbZm1DVhP4oZxTr3eLaWHmeY/UrJXZ/LA1ueeOfoQ81mSIgLe1jzvKOIdIJQTUDpEVROTqdgQcDBnGBJu043f43IRok6P2a5MagqwRQUhvzld3oPm3AmFLorn+cvHI1UvxA2kzOh7tgE8E5gfpZNt23++CGDTW2gkxXCO04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/aAz1CE4CqHd0Mvi1SA6nXS3Wm1MOw637cfFQFWVJ8=;
 b=W7Xo30Xy0EukFkULwyV/gEGqmDWLvt9WNpDWlCATh33/+loBmeVXMAMCvkMOgHShHon445wkLl41LtUsMZqEhZsWZ0CnfTlRja6bncPNAKaMApy+HCDUdjqLHK6RNTLRuRIu2DGT5YoKw5x4IPRMjiLGMR/uxVzd1P1kpI50GAY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3544.eurprd08.prod.outlook.com (2603:10a6:20b:4e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Fri, 3 Jul
 2020 12:24:55 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 12:24:55 +0000
Subject: Re: [PATCH v2 14/44] block: Avoid error accumulation in
 bdrv_img_create()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-15-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <db5330ab-8ecc-8922-f41a-b87c94620424@virtuozzo.com>
Date: Fri, 3 Jul 2020 15:24:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200702155000.3455325-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0009.eurprd03.prod.outlook.com
 (2603:10a6:205:2::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 AM4PR0302CA0009.eurprd03.prod.outlook.com (2603:10a6:205:2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Fri, 3 Jul 2020 12:24:54 +0000
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5af62f3b-3ab5-4247-51c9-08d81f4c17e8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3544:
X-Microsoft-Antispam-PRVS: <AM6PR08MB354459D349B4F42F9255E7E7C16A0@AM6PR08MB3544.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ml7K1bzqobs8SG481F+Kkj7zhzbP4XKukr49EOhqvWID0wJeU508lJ2B8XURY0KWRANDFuAYwQaJoK8Zs1QeevAt+nbuZBPkRiqZTfwCPWuWGJHC9cuONsBPC0fRrsYEFU04fbnsKLOymcJWVoylUQB2RqVCUK8PqRde+wOKDO5kOFsGn9Q0RxJyioXuVSVaOwkpA3Tkm+PcViA3DtBhqPm4nQEVYKA/ASpOsx5HMoowQr6tX2BO4AZcbpuP/jhe3OtA8U/Hw1wPNsS1EA0swqmNe3qulsfUXO5IEo32xQ/23jXyMo/KWD3+fPOl14V3qawpcaM/9bzafODVRC1bVrD1xbs77mythXNz6X7mqFdETfukQFUXETFVSvnmb6QL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(39840400004)(376002)(136003)(5660300002)(66476007)(8936002)(4744005)(8676002)(6486002)(478600001)(66946007)(52116002)(86362001)(31686004)(956004)(186003)(26005)(16526019)(66556008)(4326008)(31696002)(2616005)(16576012)(316002)(2906002)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: O4k+JKui53bJCyasJcVQWfF4QNYfjBIscFjTJwoJvQUhwXXT6HmUTAs/G2tOIyn5pE/Hiy70TIe1yEtG3axIpRdrvY1RI9nJRCCO654FYQr984nY3iW7qUm2GaAq20D/Mo60pW2s/A9ThcpbMV0jH9unDdoZIS0XDie3YP0ppK0PQwhqatLlxN9Gr8YQd4qYWY2lH8bo/rq9xHg/gDdHEvzPMtYqNqaj3YfPz55Hcl90gbHd4zFU9JGN/gwEye22LdSF9PRHDIQc8UUX60Uyj+y2TgVv1ZkpqBADfxLBuirVjFFYy4rdp4vtY45y6NDZzH9T8nm9DqDA7pz2oYd/xx7XgmwkMs+O9FUiqIWDu1Zp7bMv58mBGUmUS3sx/gD2QSTdqvEM5qmZpAPkCwoOK9pUVTQtsTym9SsiAECWlsXreZw6yHLZdSHQOSXUTDyZzeFF6ikmaB0kw3D4Vbr5wkgQlOqVc1xaNHI786MkrdT7OGKxb6iIqdeV+rkhw3Rs
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af62f3b-3ab5-4247-51c9-08d81f4c17e8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 12:24:55.3824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17lr0fPBl5TMMnOox57SgtRFul6wTV1vLMH0pgHH+L3wafWcKul9IjNjJLSQzm8AAbNTnUjreHVpmzjGL34Ltj/VJflAIRQoFZbRf7AzUFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3544
Received-SPF: pass client-ip=40.107.15.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 08:24:56
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
> When creating an image fails because the format doesn't support option
> "backing_file" or "backing_fmt", bdrv_img_create() first has
> qemu_opt_set() put a generic error into @local_err, then puts the real
> error into @errp with error_setg(), and then propagates the former to
> the latter, which throws away the generic error.  A bit complicated,
> but works.
> 
> Not that qemu_opt_set() returns a useful value, we can simply ignore
> the generic error instead.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

