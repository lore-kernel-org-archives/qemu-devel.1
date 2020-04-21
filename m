Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE022C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79AE206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wpX9hklK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79AE206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrgl-0001Gu-Up
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQrfi-000890-Pq
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQrfi-0005yI-Gj
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:06:38 -0400
Received: from mail-eopbgr00128.outbound.protection.outlook.com
 ([40.107.0.128]:55782 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQrfe-0005t0-RB; Tue, 21 Apr 2020 08:06:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=can6UBoxISwa8U96qRxohneWLe2pKPyuTdsEnMlnpEZQfUB0aEnqC98Prtco4MJh4lTzaTqAuS6HLd7JK7y/Bi5WpXxoMxbszyyuDyxx5JFmMIO+WRC3DHDiI9KkiOsognApSUFhmv4dEW+klG1tYj69cLaWugt6wgrbxRYsJXfv9GwG2M8w4M5ZTDPwrAUY9ExGmigbC9BHynBaozFZgAKkOOHkbX9hOpWMo4B/CtPW1r8ETxKIf/biJfsrdcPfmKOfOem55eQCiHAlbRTIUKojiwlC17gPN6sBnzsRR4XCruCTfe1T42L9tJxlADtqmr0KMTQZLnOY/S8hqli6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4d9zUdjFwjp8y5aAsJNCtZKI9/5JZFlOYAYf46IJRG0=;
 b=crZsNmySHbyQPRulBrsIDv7qQyzUKxOjcJWinh39BiP+Ip2g4qn4s5KdsSeQjfh6uxPTBt5DsK6MDP2sGM+6fg+QaIOWDh8vo4hmG3ulHyQ7hfiitBOey3oR2OULAUWxP0u7vAItT1lOeOV/zPQWG8xXnG6odbB9AHprLHNti/4QV7fLEsRKghU3ErBMTZ5shTHgOWw/6j10qcKefX+ekZ6GpqMFzeCRUw2LRnluxHWs2LC/jsA8nZ3pOMlwsXn+hbR7ymB4lSZA1mx4rkDLiilcVM5DyYr6uoUQ+MbvNFEtkeKUxPwmzPA/LP7AfwLZGjANKuQ5sL854lXU+dD1SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4d9zUdjFwjp8y5aAsJNCtZKI9/5JZFlOYAYf46IJRG0=;
 b=wpX9hklKjapqgIIF5uAlpa0Z1ml9T5e3Xm6gCKYZ4324XWwMqGZC6WmXsmBCQcwVbLQC7PfgPLsnJthTzTaIGCjEOExgAQ+Gp8kCOzoyuhNHjILmL8LNDnr4LADsWZUXGt130+tomA4VMrP8HRWRO/qh4XxHO7SmdSejkj5R55s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5527.eurprd08.prod.outlook.com (2603:10a6:20b:de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 12:06:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 12:06:30 +0000
Subject: Re: [PATCH v20 4/4] iotests: 287: add qcow2 compression type test
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200421081117.7595-1-dplotnikov@virtuozzo.com>
 <20200421081117.7595-5-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421150628031
Message-ID: <7865c072-7d82-1fa4-ece5-5c543a473463@virtuozzo.com>
Date: Tue, 21 Apr 2020 15:06:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200421081117.7595-5-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Tue, 21 Apr 2020 12:06:29 +0000
X-Tagtoolbar-Keys: D20200421150628031
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63a057e2-7415-4400-c8b3-08d7e5ec6cdf
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB55276984194C72598FAE4136C1D50@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(136003)(39840400004)(366004)(346002)(376002)(6486002)(2616005)(31696002)(2906002)(956004)(36756003)(81156014)(8936002)(86362001)(8676002)(31686004)(4744005)(16526019)(5660300002)(186003)(26005)(316002)(16576012)(4326008)(478600001)(66476007)(66556008)(66946007)(52116002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2s0L9uW5m7ZKgx7WxBWqom234yeRHUrN5JOsJSqM3jIlrJ26QY1W0/Apj01yJFzrjtROH+le5aSgA+XtAs2Cz8pJ6IYC1Q9cvDQir5288qSKJ15OxmEyf8j9n9L1ZI+ZX8GW+wGj1X2g7xvi1U1/tjzqUm7SJn8zwTkmBzopPzZoV1Fnuj1QUDa9mcKxrPOUMAyWXmcmdAG6mVt1Wvl/QqTVEf7rkGYEcoN7s0aHg3nb10LVEXUUsbKE4Pt7LzAyMS/NAJUIVVGZraSJBynzb6FekWy2yD/UtQ27SFcR7ZOtLM4n21ZZ6/gT9qGJ6speks5NAf3oul5kB3wFNjywAW5C3nnE3sDJPQJP8bqKoi6A+HGWR9Kn4LNtA0kEPlkhVnW9+rIZjr1tYr9r+6/uEYMbec8Tc6bXoNTZlc+RTgUVzBToKNr3F73cvdfxCdQl
X-MS-Exchange-AntiSpam-MessageData: pzP1IgwoPxu6uoZfoIFozEK8ZLuc0+7KvLlRRyAsyp+yo4CuhACty1fIBOTDzaT2/WXLqaVoZ2C8wHni9zVLwVV+avaFQVazM5hJlPVS3nf8ojY43pkKS2ZRo4Xqx5CeTu4Owp65KZJdSm2krGxwuA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a057e2-7415-4400-c8b3-08d7e5ec6cdf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 12:06:29.9087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9FZKMyz7O2cKc7jGeKqYmfD3YdG2PBtVYHilTT/dIadrFAMJWdBwU5icmcCZhpCIHuQGJB4ipj+a8VhdKttChgmdYDKfUBKzNavp+qQZ5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
Received-SPF: pass client-ip=40.107.0.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 08:06:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.0.128
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.04.2020 11:11, Denis Plotnikov wrote:
> The test checks fulfilling qcow2 requirements for the compression
> type feature and zstd compression type operability.
> 
> Signed-off-by: Denis Plotnikov<dplotnikov@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

