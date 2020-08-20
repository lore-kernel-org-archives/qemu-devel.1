Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10279C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F522075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PynEWDeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F522075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8i9H-00052F-2l
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 06:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8i8e-0004XR-MI; Thu, 20 Aug 2020 06:49:44 -0400
Received: from mail-eopbgr70139.outbound.protection.outlook.com
 ([40.107.7.139]:48925 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8i8c-0005xJ-0c; Thu, 20 Aug 2020 06:49:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjPoHNUrYYUdX3a490PYK04DDVMR9VvntWHaijxqP8EVCl1D3QfgnqzoCGwNngrxvPMf9Sgi0fqJBRRtcf3nZ3+aLAd8fWv7hy6JHWoIFmK5CCJbbbqyOngBe04wB595ZOD5EZBSwTy7rfjl0zv+Zo4iCykZZhOnWVSTRkyORQp6175z7AYl6H9agDD+deKu9OKb5RJRVxm3GcgVsnY1XceqoV5IlW7BaFmWgLPaq6a5rKmTRVMd/G6dI3AkB/MIw1Mw4zSLZSKzQYgJgtJUSZIgTECdM9KfeDwBeZuWslZhCv+WXwKi7lxEW6LJOyAtgZeOZjeLQBHu2cr9l+C6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9TGKSGSVi4T10ujtTkn0tDfr8ilA4hViIP91KhIwHc=;
 b=mI6ZIexg5SMQLMkpqZyZhbJjDK4+3mNFy8YZIJaeSsd2i2Wrya9T4mdgXYhE3h2FeR/6g4qdfUutCzjXjphkFrWxG/y02zQS1KssoZyqcWE4cUSN7gitznyCvRh2BlUqFaP6n/+uaBRG6Vgo3PkHe0Yyf3fTel4zbpsXQMkCZJlfPPf2DHLWpK0QvgIbVj1FNEPq8WLCFKKm9fkllg5GnvmeZ4z5jUgR1TVB2rxkFJBS+Kr46lzwDMArAt1uVd6CknLIZGwR9hl/NgyUPT3ItN8d/l2K55j0m+unO0l2DrmXY/k4WxywgTnlWGOcAwCm6Nuh7uQ1P8vqgzn/3SnMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9TGKSGSVi4T10ujtTkn0tDfr8ilA4hViIP91KhIwHc=;
 b=PynEWDePbpiBM+iLbQKg9NdzzTZBOFI6AAMmn+8pe1008l8tRWwnKj+xX4TSv+OVGO9mx+Dgqfh9Sqmh/6FmBPT81Ab52vbsif4F/ZPZcgzmfmmTQpO0qcBsfod3OrF9Q7kza1LQrPlcwEoH4RoiB6GKUqUjp4QkQoY0rxH4Px4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 10:49:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 10:49:32 +0000
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
 <20200818142851.GD6865@linux.fritz.box>
 <59fe8d64-b073-aeff-1afb-b526e9a085f1@redhat.com>
 <20200819151625.GF10272@linux.fritz.box>
 <d3ba4a10-9abb-742b-9a5f-33282f9f9fc2@redhat.com>
 <e424496d-cf18-c19b-3418-7c50bd58c8df@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e543223d-0110-a846-db45-d0a5982a3699@virtuozzo.com>
Date: Thu, 20 Aug 2020 13:49:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <e424496d-cf18-c19b-3418-7c50bd58c8df@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:205:1::48) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM4PR07CA0035.eurprd07.prod.outlook.com (2603:10a6:205:1::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.16 via Frontend Transport; Thu, 20 Aug 2020 10:49:32 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c55eb956-d487-4c6f-47ae-08d844f6b8e0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54957631A67DA8819E20E589C15A0@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qyGDk6DfoIBjkB5oHI1EmUE9PoqIIJNT8sPcx5pERml4nnUjEShLK3jZx/23qCtmIczGhXxHmxK6pr+6MHR1syZxjC6EZdYtQPtJxZpRuRqCt+sVs0/E6BYSl8vDrfyZkK6QVwaxej7Ys4LDt9krvwP7YkKWA9EB+xwC9a5dwROiIdTIXw07iiN8SmXQDvuZC0PtRB3U0sJXF4er/OgjBZDhTkelidsPkxEHH4YVwkTECIbPfXiJFICXJedBdKJBl1VZBuDDXPOK4T4mBB6Y4h9LasJ088IXKqVumMWcTmdwdJ8X55bhi5oOlyDIs6m4unbg2s+yW18iuuAXj3XftqOaBIyIYkgc+i7ZXTId++50L7QJT80hsEdzv/XWs3o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39840400004)(478600001)(83380400001)(36756003)(4326008)(4744005)(110136005)(8676002)(66476007)(8936002)(26005)(16526019)(186003)(16576012)(66946007)(66556008)(956004)(2906002)(52116002)(31686004)(5660300002)(31696002)(6486002)(53546011)(86362001)(316002)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qTNDK57iA0qafYI7PD+oeQ+AD7arPQpTY7Ka4NGDlhEowwk4nU1SZCxuS0jqcG0fyFeuINYgOgOQrISsGNvTc0pOZDWA4xcVCNe3uS6J6UCSOGnRySt+YyqFTHQ5O3zoRaWm4GwQGW6tc10Ruw/j1Itoq7XixfPIi6knZqI1ddJFd/S4ChWpww+UFNf2Z1bCz9JhVbg1ROJyMbPU9z3jXUrZ08Yp6Cjf/raYbPnntClYQK2JU+7kzwfaOI6/sWjwbqdyQUFIFY3hWKb8H+wBCc2iWoiKqzXIKHCB0WaaTpBnAIewYmxtF+o9dllh0r/KPJBOGx65W1lbpk53g4rjKKqn65L3EyeKiBYHh4EughPZRyWm5MAAAXop86AQEiPKtZgXH6euv99vql7THjdqFb1uY6xH0Gbm21TM15H2IHR0cvwjqD/AaK3dmoE+d409WIMFqIk2Usv2EATQ5lmOHNZVeoZNSymW8eH4+GqJnfHiELanBDSyLB8ga+Bb8II/HTpOh4LXGyWm+p2F1oj61ULrNuTHTtFma76MdE+QLWyrfT2c0z2xidX0ka9wm2gfbqms886LTqkBkrKkfN0Z9X4O+ltZ6vS8nW+iw7cHT/3bv64kKSvmzB+3sSw2Nrr2IK/qeXoDncF/ZoByxiqhCQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55eb956-d487-4c6f-47ae-08d844f6b8e0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 10:49:32.8230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OL9QzYc8qUZiFepK8UVu7RAjEEw6cxcA4f05/PCdKx/gNoMYnbOMZYzgn3Pj9jo7kHpAMRAGOGtrRDN0sfqHe/oX3ZkXDK/C8y2PL+w5yCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.7.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 06:49:38
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.08.2020 12:22, Max Reitz wrote:
> On 20.08.20 10:31, Max Reitz wrote:
> 
> [...]
> 
>> So all in all, I believe the biggest surprise about what’s written into
>> the top layer isn’t that it may be a json:{} filename, but the filename
>> of a node that maybe doesn’t even exist anymore?  (Oh, no, please don’t
>> tell me you can delete it and get an invalid pointer read...)
> 
> (I tried triggering that, but, oh, it’s strdup’ed() in stream_start().
> I’m a bit daft.)
> 


If it's broken anyway, probably we can just revert c624b015bf and start to freeze base again?


-- 
Best regards,
Vladimir

