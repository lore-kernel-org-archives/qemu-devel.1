Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B49C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502F220899
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wM5d6Re5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502F220899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNk7-0001FJ-JI
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrNjA-0000EJ-Jz; Fri, 03 Jul 2020 11:35:49 -0400
Received: from mail-vi1eur05on2110.outbound.protection.outlook.com
 ([40.107.21.110]:36449 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrNj9-00017C-2g; Fri, 03 Jul 2020 11:35:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGZHpiCVQMI2PokIbJyvy+T/4CIeTJpBdDBWzWB0vk6J0ex2fg9aIzwp9ZqcsKMp7ZFdUQoz2Yl1Kv3vHavZWqNbSoogohoob0fwf33Mzt00qeCgQ+Hh/m8fDnEHEWOY7cuT4DTti5I5A0H9fsljBGynwQLziFKB21oLSXd7LezmQAJdSO14ZZd+oTlGFsNi9qMtTTwOs6/Sj5AJT0IAkIJ72bFFLx/W5M6HR6WOW9+CQnea1JMvDQa2xwjWb/ZIT9u4020773Fy752jQmLPnLmc6MRiAS0pgA9EEuWUOSJ6Av4KGlkwJ2zjMe/a+5710dMCiwdDnk2MGLa4k4PH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPNpM/kF6RT6ySnPkgW21VnxipNuo4EQO6ew3WxqG9M=;
 b=Z0QrQRN/hJ/BnAiFbvr2/lZ0lawHsBmE7MoCimqN2NkGXL3R6S6Vp2YejOF8mP7+9t7KCC06BdvDZinHd2E7VO5wAX2HAUsNwbsNkP6aMQUfoz3ESgo1J7ux1PBbzPUq+L7SvKAzlYNt5hjg0cTzq8HhhRYEIVgTI/MMTyrezqYvMl4zU4c4BSaOpzv/3c72R+/Qizk13NF28IxXBUvwOF2/3X/bGsLgeGPw/rurnMkcluYBmBesKSAU5lRTRfW8N/PLBsYQ8uv2H4H14LerZjd3hmbPnKXiVAgo5UfjFxSygGbkFHQUz8B14CIAEu2Z1lV6Danfbg+SSUjEbDWXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPNpM/kF6RT6ySnPkgW21VnxipNuo4EQO6ew3WxqG9M=;
 b=wM5d6Re5JF8/gvm63e8wH1zl00DoaPfFWnnGYbJvGwp/CPE/EbCu5KNBDtwCCWYaVJHRM3OxQySZbYyDxMD34olvJ16RS+LlQWu+pylOLhpeO0Ms53lVFgQcpAmHSlbc0woGhYsU06vnViHCYUc57oVEt5q4faAM1VhO5SsoYSg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4788.eurprd08.prod.outlook.com (2603:10a6:20b:c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Fri, 3 Jul
 2020 15:35:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 15:35:44 +0000
Subject: Re: [PATCH v2 22/44] qom: Rename qdev_get_type() to object_get_type()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-23-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c5a73837-4dd5-e502-c58d-64a59ab65b16@virtuozzo.com>
Date: Fri, 3 Jul 2020 18:35:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200702155000.3455325-23-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0113.eurprd04.prod.outlook.com
 (2603:10a6:208:55::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 AM0PR04CA0113.eurprd04.prod.outlook.com (2603:10a6:208:55::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23 via Frontend Transport; Fri, 3 Jul 2020 15:35:43 +0000
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41cdd629-3988-4b24-8ad1-08d81f66bfd3
X-MS-TrafficTypeDiagnostic: AM6PR08MB4788:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4788D68474B4D064A5C30D7CC16A0@AM6PR08MB4788.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lsXNN/GRLCCxj5pK3tH36ZmR1dqU7VySlblverLelUhWa2jxHG9FWfuHhfgZzOYiogEIvYFMsA4+jDGrgpM8n+O0A0mZMK6+bdZBrmG7/oh2wjfBWrqIPBgVGW8JRo/wG8MbpTw2G+9nkrNocDoDcNEziIvIHxo4pmCwV3eQUwQ6vIEZDyxznFv47DZdGQvULNxZ10TOcQxbGhimKKg6iPuTbdcB2mP0ObJxuunJsdS1/CmX059R60XPyL3/m73v9XLxw3eDn6gj1qI5ZQigawsoCD1uguYFvySIjsKOD5HKBDZj3WAMRRa++zhmXQawl86bI35o7t20NMXMhkfjpQjzgZWB+EB53pqCYb3OSZGNaqvAu8RkgCSG5bl99RMY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39840400004)(396003)(346002)(136003)(316002)(5660300002)(478600001)(2906002)(16526019)(4744005)(186003)(66946007)(26005)(6486002)(31696002)(36756003)(956004)(66476007)(16576012)(66556008)(2616005)(4326008)(8936002)(8676002)(86362001)(31686004)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aWTQg6PNE18sIpNcjB36wAc5BzdyBDcONnreQchfJSu+Xe5mjgIo70j0ybcrtaC7kKG27qIgOU+31/E0B+FYEZloshpXn/iJ9NEA7n6Su/bRR8iZHChYQ2Am5b8QybrRQvH2DgL+77HzHKcwYXLXzIifiVgkSPtOlxWWkdbKLrF5Vcy2+m3oSbwItVJiKJ6oLBtC6DS31c/njfC/3/iKMg41UHwv4UdDjFYpoRavpblYWd+VqWZe64MSoalJJY6Q2bwzqNNgCOm0Davmlslc632rED1HclbTItECooJ0fVKZKUmQ1LcCUGYbes4oxloz2bVBkZMgpIhk6v9jU7IMWSetiLTTb91MUWN0nlwK1YXov2vxGKH7QlBV4raTp1sdhEeeajAgz5Li4R2zAeNVfl+i5AX84gbvCliTj0B35l39ASNe1rbtfj3nyOrbk/VllZP7iE55vlNq3wS7JzKdC8f5N4ck1gFTgbGYJLuVtcuENqNS8OxT+VVnDEeDIKfh
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cdd629-3988-4b24-8ad1-08d81f66bfd3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 15:35:43.9636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +m/OwHeVREsSpyDv2o75327YhSUg63e98UaaaOYxx52yDdtVEj4qWSZ4V8NJV7yCt/GUuMDbBAhQDp0Jz0MCaYX0tGzlHd20nfUuNucaNOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4788
Received-SPF: pass client-ip=40.107.21.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 11:35:44
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
 qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.07.2020 18:49, Markus Armbruster wrote:
> Commit 2f262e06f0 lifted qdev_get_type() from qdev to object without
> renaming it accordingly.  Do that now.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

