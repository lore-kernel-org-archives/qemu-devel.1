Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C792C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2C22063A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UUv91cUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2C22063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvzzL-0000bR-63
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvzyQ-0007jS-MZ; Thu, 16 Jul 2020 05:14:38 -0400
Received: from mail-eopbgr70120.outbound.protection.outlook.com
 ([40.107.7.120]:6087 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvzyO-0005ct-R9; Thu, 16 Jul 2020 05:14:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qv0Nyxu6SscBMocRmGA/EB6luNPPkj8fMiJL78Fqv+XUSSfKYqHCV5cK0m5R1gXNVeznxaOgQg1HWjECbG93uRGqiLRu903LmRoXnlD+OhsAcvURoqY3Qr6NgLCEFuiD8yAKeQboM+0QNAfHtthBQRC2DDGY8kl5scEBstfLu/x+BMouLa723If869DoMuDFphEZ2vg3k2awAnqiWyoM8LfkuzeEHRcJ56Slcj7dB8uOZV0cKvk8yXgZgtnWcUtZy/ij9VKTSIWQyRnp3Ym2m77k7fkMewm09EHb7phuZny373c4foWnwOo62Y7fBkeBS77HhyIAJBj+IsQHFC8jaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFt9fEqNIchcI6VazHePCp4RQN6mo4A1UyCIhwrpyQY=;
 b=ML/BtTyAXYZ/XGuz539olF6r3Xv/uRPV/4gJtbttXv2pzaSQHlJancFxSvzmSgPlkMW9dGQZ80+9Mh90ZbGUS68rR286x+Y18MqWe+Zok+T6w2LL7fX8nt6RvqmhRg/ClqKnzDnB2eIpDboN6r0qzE836tVcD2WHpAhDyuE28Ff7+KTGDpmYpN7TBmvn7FLTgO6UCutIFlpGo8VX7GEb/qhPvraD7FwttIOInbddSvLqZqjlalRed9CI1m7DaAGGIMC8Zr7OUtRVbqtFqq25ofKVpRv15RdV2OLRkcN1UTcwDPKukkuBO/Cj4hN9yz92xtZXAHi3EPyTmgxYAec1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFt9fEqNIchcI6VazHePCp4RQN6mo4A1UyCIhwrpyQY=;
 b=UUv91cUhkxueqZ+TKgk4aUBFrYeqmSStalOOFY3B8GzP8jGbOi/gXEJ5VWN0IOwOwfUhBn7wBqn0a0Lg/dO1nQ7id6wf1Jy/WU20mS/ml5aFji8oLY7nUXyZZV1gXsKABLY2vfu4ctJY+6MEEa797ZZx6yxh0fvlgjHwxR0sCeg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4915.eurprd08.prod.outlook.com (2603:10a6:20b:d1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 16 Jul
 2020 09:14:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 09:14:34 +0000
Subject: Re: [PATCH v8 05/10] qcow2_format.py: Dump bitmap directory
 information
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1593782030-521984-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1593782030-521984-6-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a1972f8d-3ecb-1053-e6d8-bf80b0a3a583@virtuozzo.com>
Message-ID: <9fe2be66-c917-3f36-d8c3-7bded44574f0@virtuozzo.com>
Date: Thu, 16 Jul 2020 12:14:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <a1972f8d-3ecb-1053-e6d8-bf80b0a3a583@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0140.eurprd04.prod.outlook.com (2603:10a6:207::24)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM3PR04CA0140.eurprd04.prod.outlook.com (2603:10a6:207::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 09:14:33 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55d7c668-e1bc-424c-e8cd-08d82968a7ab
X-MS-TrafficTypeDiagnostic: AM6PR08MB4915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4915F3D1060FABB5DCEEBA37C17F0@AM6PR08MB4915.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DPttLemU0fS6a1CDPuMFxlurrDCZLMaLOEaEnVJCjo+Xy17w/NglA2waL1q3U1GJus2xsPyeHF3g4yvSRFFKkeaxO0Cd2np+zEZYyTfyYwargAU/2Nv14775FA+TYxl5pbAj2EOTB/6npQhsqonYHp67fMRVvQKda1wQhigpEFaSIb65XqXWVXWIH5hmtCLGa0kniEfI9Qe8pRDQe8+wTz/l22+yAXo3+sAHMJ8fsLDmTZZ3GZQNmMuw8QYFZ3OqJNvrjYg07RkU3bsg7ppaEzBrvZt5aJtqBXR1CNNi2kgj+n1W9OTzv0to0kemfKl9CubYGNfCh+xxWyw5ovmFjvvJ91XcxP0y75yI6H0NKpVt4NVxQM71U4DyctirtVXr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(31686004)(8676002)(478600001)(4326008)(16526019)(26005)(186003)(31696002)(2616005)(6486002)(316002)(558084003)(956004)(2906002)(16576012)(66476007)(66556008)(36756003)(8936002)(66946007)(52116002)(5660300002)(107886003)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zxZNm5yPZOyjyy6a6ePpU/i/zdXSGvrIMXqwgsXDW2N1OGgYwUkicgGJkBtnCx7uEBzQTru/igtCch/r4dYZY7lzSf59IvlIrbkHXhXMFHGHkBDL4YcKGGIbaSB0ZD8GkhDtRHqv+HOTBranvufqquJhLtBgdr8Xz+WECR2lkPpYHStXpLZ20k/pcyK9vXKZ8bfqUmPatWFQ8H9dsyGZKTt9qOZ/gxMrZH5VvrBce7JF/CaNuaxlPJMZji58kjq/H9KSIRRcJ/6IdJZOTPE8Sud9qulvEs8zoH3v8/y/eURgfacVNDJqe0286yC6p2Nh74Y+WkrkRPOr6Z/QzF84TZ4WxsA1sobJnWNwRDxMu54DGjdYyTfkRL8FkFyqhzrdN55Dt1lVZPJ6xADVe0aW6OIBNLatgz83bT558IU3EgHV27hPySrGulPjVpWCK0hkz//3IzAxSOLQhFbjEBnN730gk+RY1Cd4ONYuXrXos5Y=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d7c668-e1bc-424c-e8cd-08d82968a7ab
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 09:14:34.0299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeUB6Y4Tfob93pQXLUNc/fULkRXAyz9/iUehCovGEfOIpagc7Ls3lvUMdpibcX8hmex4QLf92h55EtAkcci8we/YzQe6bRN4VC+W9dfDqrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4915
Received-SPF: pass client-ip=40.107.7.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 05:14:34
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

16.07.2020 12:13, Vladimir Sementsov-Ogievskiy wrote:
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Oops, sorry, I wanted to answer v10 patch. Ignore this.


-- 
Best regards,
Vladimir

