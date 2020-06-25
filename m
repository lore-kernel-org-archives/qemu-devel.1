Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE9CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F15206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TA4ln7eI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F15206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joT6f-00068K-QJ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joT63-0005Ya-PE; Thu, 25 Jun 2020 10:43:23 -0400
Received: from mail-eopbgr40139.outbound.protection.outlook.com
 ([40.107.4.139]:10138 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joT5z-0004h0-Jo; Thu, 25 Jun 2020 10:43:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvG1APk1pU0JJGSlsHZLWpX/ehBf5DMKtvRvPZJYWIOgkBYzNw8trFaXdXbVf+ddPiBVvcJb/yQDXwwwg6sExLAPlavfG1kwizkIv7SGBKByPNMEB4yl7Kj9FbuO+xmfxARTGZVat2lKwJKsI8ZxLJ6PWuCLM8UY7qSfv8DG/03PcM4qQ2oGh0dkWDkpQVrSPf12vyL+2suQARpOpCvyTpvHlAbRKtP17+bmw59gxVFYX5UlWQ6c/Qxh5vR+jjVEmoLX9nbXY6deMYHZmzHadVztedbopEIpWZBVgdLvTBp9m3/6GbZTal4+DGtXilbXsTZHflRvqlxJnFaxTOpKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtCqeSNYejp64HGw0Wwd/QBBH6y8yV+UXajruXOMRis=;
 b=Hc10qK/gBR7a/G7CUHNN9bHguBi+9iSwJfW3X8E+OSgwXbTzY5PVzmE0aCo/mQpdlUS0xO9G3MV5OXeCCA/IihMHUyY3iwY/73rtG30ccOaLpwShGfeiIqvLIcqSA6OU87W0NGscZmD5/yarROhxF5M6Pz79595D1rq50keU2WnYZ0JQ3odPh0zW1MOrW/Iu/+AoxBCPtktKLT7d8FCRoyz8earm129Nir4JeIRaicxTsBo198k9YD2NZqsHGYWkUq4k6pPBnGqvF/RcbbTBfcluP73MRW7JFd8SJPFVET2doDaeSuVH8HqF7OIfwRgbZDh4CQTXZR9CSrAJ0ahgsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtCqeSNYejp64HGw0Wwd/QBBH6y8yV+UXajruXOMRis=;
 b=TA4ln7eIeYhyC5e4ee4K+QDBMzEhqa3Of7sbEPOfXwloFUbvMl8gKRsqFsY9ZTasfXFjgy3KmOgYKZw2nKfDSey6ZV38hNMxhzOgQ30hdhrc3VVm9I3P8MlkpLwgw46NkXd1YgeVFG9PpN/O3Umgz7Qx581MAvCzcEVQMnZ18uo=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5080.eurprd08.prod.outlook.com (2603:10a6:20b:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Thu, 25 Jun
 2020 14:43:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 14:43:16 +0000
Subject: Re: [PATCH 01/46] error: Improve examples in error.h's big comment
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-2-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a15bdf92-220c-6f5f-0540-3967f84e2d9c@virtuozzo.com>
Date: Thu, 25 Jun 2020 17:43:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0101.eurprd02.prod.outlook.com
 (2603:10a6:208:154::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.69) by
 AM0PR02CA0101.eurprd02.prod.outlook.com (2603:10a6:208:154::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Thu, 25 Jun 2020 14:43:15 +0000
X-Originating-IP: [185.215.60.69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: def92bf0-3952-4ea2-d1be-08d81916184a
X-MS-TrafficTypeDiagnostic: AM6PR08MB5080:
X-Microsoft-Antispam-PRVS: <AM6PR08MB5080D5B05B4D789ECD993D5BC1920@AM6PR08MB5080.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vy/UtN7N/libHbMjxhIPl5XUhbVRp1+epdFAU1LPIRA/6XOr1hMEOUlQbCyxEmq8ftzBhxHvjJvEQgFxW5UQ7p8jqodFVn4XJLYfWB5MaK5cvOo4I+9I5pHM5E0HSrhFpXPh/pGUK/jkN7P2+2CiAMlh8jq7v3B7sQEo2V2jN74xAIciaVSYWeZwR4XjeMUyZOCU/HSD61lEg+u47pbpSh/gHez/B8B+LbNC5zkvR23+ClqoJ+gp4XsEE6hWtEcmrj/ywa845v8yoTGcd4HR6BvRM9m9T99yOTaN/LDo7MSIwKja4UFZgVOTnfuhIHPjVMIvEJzWP3sP8TnDSvfISw9UFEnTYD/HMkhP87twhUP2DV0ClIN7YwMLpBDAyhoG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39840400004)(396003)(136003)(346002)(5660300002)(6486002)(956004)(2616005)(31686004)(66946007)(66476007)(66556008)(4326008)(36756003)(26005)(186003)(16526019)(83380400001)(4744005)(52116002)(16576012)(8936002)(478600001)(8676002)(2906002)(316002)(86362001)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bAnf+CizRhXwd0iQWgNGhbTpcRDq9ZzV1zpn2/YMcHQsMkyEnM2zpPySvv+cLcsSGxoLYi7SKxB0zkCPwLvn+1GVeCRCKPkVsOsP9QtpXsc7BYXn3gpj9g+7duOIHLAxAPEf1dm/UgnP6yrHoseMNlvwjlUEcJrU6sjZ1m/CpONI4Nx2QLUz19Gsh9rWkgg/OSbvpSouUmM3f5v8m8CXMZRXBdK0RiPCo/MjLN3htv+yZXpYePcgVMrgiQPwJN9K5Ynl8OeT+Pd6nRSMqNyEFRtHmgFzP40muQh8srfj8uyqpjOFbBYNLxr/LbKX5TUteLKDsjIth4saRflJ64o8ryAKbCJweAgONCioUgKz3Ldyaqc5U2q8Gg1br0H2kc6cathib6KNE5VrpR+P/X+suyBBAJFJkUqVCUuGTCUBawOQgOFBhNqJ263/SYlfIJKbvxRlhbQerX8Umgyt/gmGgBmdZfShJBSuDzY/fin5BI4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def92bf0-3952-4ea2-d1be-08d81916184a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 14:43:16.1213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnjQqlZnMk3CAwI2DCZmDMHF2Fw/TnLGPHNRlbZjOjz6T9rkLIYjyYwjN4vPZ98fK9TEOwVivgK6K7aTz9Tca70gC/JJMXgxTLvaZDsta2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5080
Received-SPF: pass client-ip=40.107.4.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 10:43:17
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.06.2020 19:42, Markus Armbruster wrote:
> Show errp instead of &err where &err is actually unusual.  Add a
> missing declaration.  Add a second error pileup example.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

