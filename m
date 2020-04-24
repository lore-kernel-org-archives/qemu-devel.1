Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E97C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F73220700
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qb/zHTqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F73220700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS0ES-0005JE-P2
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 11:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jS0DT-0004N8-MU
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jS0DS-0007zA-4b
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:26:10 -0400
Received: from mail-eopbgr10115.outbound.protection.outlook.com
 ([40.107.1.115]:17385 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jS0DR-0007r9-5E; Fri, 24 Apr 2020 11:26:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBdLwz/GmFN8oMlJMvY575f67CHUKF7zo0C1hnxUpW0KyaEU/1L/aJJY8zDSSY7tZKHif/fAlKfpm5w+4RWtTiS2hPvbyZ24tWS6z0I03PE/PU2gEnvz3IGi9V9Z1h98drB87RcNqvdX1dBhFZqs4mzL53am9obYzNYy+sWhiueOF0dmE10FEnAxH/hGG2eMAVzmyXfgqQlBV7QMG60VfKZSvjz3Yqc/JzthCfVfStdWA6tL6iYRwpawP1GPw3xN6JCBYM/yRlKf213JEVj9zETPMTXjWPrjYOwzTNaskuwrjZ3CVcDZxQfYAc60VPyUQLkgFNtiNdXDrk9hEyktvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNdOExZAP3j+J6NoJH5yiOac21+wyzRJnfYGq2drYQs=;
 b=OdC/r7Px/KGW3wJYv0x9qw7/sHOlRFo5QfeVJvTcdhPXj5fz8JcEIjRpLIjRUE+buLOJ0znb88GEBWdSKfph+2gF0WFi1hAsVBr6d//2wzWFh0V+wuO/zuixGfDEXW1e2nBYFr72+l2E1B0eXKt3JPTSors00tvPjmf9DKfV3bBb56fe9EUZlg+ZMj6MVKjrUy4yunTuI5rxdwt82Srj6g4+M7qB7sesprc8WBi4kssuYPQrpUYtsZrczKZJUFxbZvEw38KDNU2pTAZ9D5aJWRAA2qScki557kt4/ZGVnrj++/+gFHSoSfbpEWZuciqEuPLd3aN9IPl6c2xKysPu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNdOExZAP3j+J6NoJH5yiOac21+wyzRJnfYGq2drYQs=;
 b=qb/zHTqqe8aqTcVg2EUPVH5a7Ks/n+wzPi74DrcTa9fVsJ1D+eebOco5Ka0yOzcA42Y7TaUsBbFVrfPYfkF6WIPRUUJPAg5JR0AVz1XGYNIEFrzrvMgX/wjMUN9c9QiGUHlDbGMHA/kvzjkc0G+eDu67KNSQ9veuhJ4hZa/RyH0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5528.eurprd08.prod.outlook.com (2603:10a6:20b:dd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 24 Apr
 2020 15:26:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 15:26:05 +0000
Subject: Re: [PATCH v7 10/10] qcow2: Forward ZERO_WRITE flag for full
 preallocation
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200424125448.63318-1-kwolf@redhat.com>
 <20200424142701.67053-1-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200424182603482
Message-ID: <4ea6fa46-3668-4553-5956-ac314631dd63@virtuozzo.com>
Date: Fri, 24 Apr 2020 18:26:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200424142701.67053-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.181) by
 FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 15:26:04 +0000
X-Tagtoolbar-Keys: D20200424182603482
X-Originating-IP: [185.215.60.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 294e50dd-a4c2-4bf9-eb42-08d7e863cdfa
X-MS-TrafficTypeDiagnostic: AM7PR08MB5528:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5528C63EDE1F856E1167FAA3C1D00@AM7PR08MB5528.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(376002)(366004)(136003)(396003)(39840400004)(5660300002)(31686004)(4744005)(8676002)(81156014)(2616005)(8936002)(956004)(2906002)(186003)(31696002)(16526019)(478600001)(6486002)(316002)(4326008)(16576012)(52116002)(66946007)(66476007)(86362001)(36756003)(26005)(66556008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6HLUaOgPv/vMfMf7AO1yXNYXAZ5kwJOZifNiQfm/DXG6J4zLjAqWe3yA7BpcZCMeOgBBJVWgzsqJBBtryw7ap2ymgEIPuzG+Hlsij/rCBcxG5XV3yQq16Tsjm2X7a255M19e8gdCav+U4ELEaybxYCqtTeg/vghSR5k0ccDia8neBgaBbVAsVK/jupfRITGBFWY4eHpA8C0pd9Y3mvMC2VhgrvvS87YQacuIMf8XhgnQt8SSiZ8o+ieSX8WmQMTLCkkh/JJNGxkassvAo5eSkNTXPGVh2gTNcWtfmJkAfk2odGqb3tAtw89mYfGbQg8phBQtYoDgb/g3JkLEHA9Ao+vnTdZRwQKhU4VIToMf9T4TwiPlyBbV4Zht8j/Brg5lc8F5T/flR6+RhkIPMCsJbdyN5zXIfNEPv4NMnQ7Jo2g9Kb7Ca/U4bIAYljvZOih
X-MS-Exchange-AntiSpam-MessageData: GwaNNtmq6Gq2QYHOalHAkkZA7xyc9U5sSss3cYDCsqPoC+hEN2OCTwNL4H4qseLLmedab06HNucvNbLjCi9iH1X7YVCg080hjz+ALAIy1dpjPLLweTH5R//ECDCKr0je3UJlaX+UwNi288Zmc3/fqw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294e50dd-a4c2-4bf9-eb42-08d7e863cdfa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 15:26:05.2200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d71E2tA2Ujsybf3yTekseSi+forAU1onOXrKAd4onYeBmj2S37/VOsOuc8iuOdyGxDmN1I3lJ4C+x9NCLmyKkjLVFHDXOZjuZ+NxHbXnECU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5528
Received-SPF: pass client-ip=40.107.1.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 11:26:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.1.115
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

24.04.2020 17:27, Kevin Wolf wrote:
> The BDRV_REQ_ZERO_WRITE is currently implemented in a way that first the
> image is possibly preallocated and then the zero flag is added to all
> clusters. This means that a copy-on-write operation may be needed when
> writing to these clusters, despite having used preallocation, negating
> one of the major benefits of preallocation.
> 
> Instead, try to forward the BDRV_REQ_ZERO_WRITE to the protocol driver,
> and if the protocol driver can ensure that the new area reads as zeros,
> we can skip setting the zero flag in the qcow2 layer.
> 
> Unfortunately, the same approach doesn't work for metadata
> preallocation, so we'll still set the zero flag there.
> 
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>
> Reviewed-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

