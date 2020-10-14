Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C673DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E682214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RoL72kho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E682214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjH0-00017U-2Z
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSj8V-0003WI-W7; Wed, 14 Oct 2020 11:56:20 -0400
Received: from mail-eopbgr20111.outbound.protection.outlook.com
 ([40.107.2.111]:2279 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSj8S-0000dt-Ff; Wed, 14 Oct 2020 11:56:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJUgMGbmaz0p0M3IzuTbTErmUO0i6HxHESr3jv3j1FWmwTxcnFjsw4hD5pACKzmemthd4Sdh9IiPgT0Rmu5suNS0LVZucPaD6BHTNQhfxhK3fqYztjm334xzUooVYgFh9fMgwVxZviCJKb0bfbbLWmUrceS6BejZcDjaOzbl/gcn7+1a8Wim9rFNENzhaC84bGZDtjBIryf8v9bxTQaFoMLc8jtcbeioniD94rdhEmBbxulhIDl1moK+QdbYB2ZeUhS0a7oZct0RC6XKr6dXSPCtXlAwsm4B/lea0BaTBOVzMF0wTJWsda7WCJSbnM9Ttx35vpXYs3FKaBksnqjQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHMt/6+M9KK7J7qVdX6FouwxjY2E4qVurRQZ0w8uMI8=;
 b=QEeuQ8afIDkegblFnEAajPF91T7YHdCccuGBibNa6nPn2JsK0YqobZDzpFocQBAI/oz1S7YTgHuAxybyyyXynUSjJSePPDfb/RoUF8Pq112NCRGEBd1Y4Nz6SANa5g/6yj42sVSDOIonmzO4HqvpHnInkWliw1drbJDH+2E+uMxgJCavqYwl8AWl63bQ700I9B8dmf8dxFVHuz+d9QSlJh3TBV1CSL8nhhpus67q5mvZkx7o2HO36Sn8VU3eedIY2z8BIbpneSLp+AD5lb4+z5m44keIgX3OWoFv/LJoL8Q5uuldj3cVIIYcsp/m4lt5FKVZmKf5VrviNdpxoYHQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHMt/6+M9KK7J7qVdX6FouwxjY2E4qVurRQZ0w8uMI8=;
 b=RoL72khog/AoaUiQ3JAOpUXs+ErDYJ4acyVb63E99FFEiRcrDyN17LaK36+evnspx9sM4OuR98/usT8nSEm82IFWYV80sBl6ccuARK6ZtKoWInVhldy/aoQ0MsBWxA57eKcC1Pun88szVW14wlfh19uDTex899nZDcqjTq+bSV4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3095.eurprd08.prod.outlook.com (2603:10a6:209:45::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 14 Oct
 2020 15:56:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 15:56:09 +0000
Subject: Re: [PATCH v3] migration/block-dirty-bitmap: fix uninitialized
 variable warning
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: mreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 eblake@redhat.com, jsnow@redhat.com, quintela@redhat.com,
 dgilbert@redhat.com, zhang.zhanghailiang@huawei.com, ganqixin@huawei.com,
 qemu-block@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Li Qiang <liq3ea@gmail.com>
References: <20201014114430.1898684-1-kuhn.chenqun@huawei.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c3a75c21-d9a6-a13b-7076-936867376ac6@virtuozzo.com>
Date: Wed, 14 Oct 2020 18:56:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <20201014114430.1898684-1-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.122]
X-ClientProxiedBy: AM0PR02CA0001.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.122) by
 AM0PR02CA0001.eurprd02.prod.outlook.com (2603:10a6:208:3e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 15:56:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5d60175-7462-466e-725e-08d87059aade
X-MS-TrafficTypeDiagnostic: AM6PR08MB3095:
X-Microsoft-Antispam-PRVS: <AM6PR08MB30950CC65F18577409E7D91BC1050@AM6PR08MB3095.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bd21i33trYfRDb0TC8s5SXXxClYa+Qe0TRhLj8v2OPrBLwH+yenNJb9dL5EjGYsBfPTIrGFSRbewnx/BZl+ycb7Zow0+HXA8kbajmatB8v3a7pEhfwLJJ1XhBO9jty4K3dEY1Dedaug7G4CN/MfGwR7FNq3K2OVLxxCflr2J8RhbP1yCfgMN0tPU414Jq/vjBQwMGr0KESqDyrWPOZCzkekJ0PZ43RMbmtZ1QCzGfvHbawXCpxy8231T/E7ZQt5kIreyAqDHrrRFCzOI7mBgcXleLh9ctuyri3Anbe2SxtPoO3si1eIh/zC+jXbGWR2gnaaUcOWkxxCR+PlzROpmWt5ujLuyZe1f+GWoDfdPIpxBrwru2qoiLqgqeSjeCVbNM7XMNwlZrUHlwNgT94jOdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39830400003)(136003)(346002)(366004)(396003)(4744005)(26005)(186003)(16526019)(31696002)(36756003)(5660300002)(86362001)(8676002)(31686004)(52116002)(7416002)(16576012)(66946007)(956004)(2616005)(66556008)(66476007)(6486002)(8936002)(2906002)(478600001)(54906003)(316002)(83380400001)(4326008)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sw2cIvtspV/cpy4Rh5KwY32Gp0PcyGnMPXGTJnrHcvXb/87FO5vm22dC/kTOHG0pKr3tXPpqhDMnCljTgJQWUnEEQ6XSdBl6HlAUU46O4qHqoJzEAIA1oju26+f6PewBwKeRVbz7Lc8YnUkAokzVH8gnhXdNpUwDwhiLKdKk175umnE3h72fGfOCZNMUwU1D8Nfn67kEscPfVW5jqsMgudvPsoPiJT1t+J5u6I+LEf55BGPzGJFwJz+qgWIG8vEohIL3xqrn05qzEZAHf7ov+aaOexwabYCU62j3lgQ/8pBflNTlsNCQtBRHuKmVPE1F5TaZlmvgK+Hynm2ETaX0cKP/aa2VmD1KN5AvuGYsLZarXdatuphKer3EeumqmaxCSGjIP7wOJm7Kb06fQOMjzBBBBy9SADejI0I9Mqv9WH3vnji3eEZJ+nidpvIFgnXKkwaCVLfe6aW0QeoMd4Kc756C2guae88L+VRIV/oVqsmTtfBFfbe+KmcqD2P9o6OYQzutoFw5K2HKqk00aaPQgDtngbt+XTplfxeaSPGYcg+jRrOmHW/DDIGDuaUe60UILHcf0KvDXwEvO15nhfoSRySLcKHa/Shx4CQrmKbJeldt1eEgPXQ16NwncLIqDFvpZAvQ2N4Of762EeuTTLw+OA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d60175-7462-466e-725e-08d87059aade
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 15:56:09.6400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Opt9BSXDZMLwOXV8Xl7xwaH8xmR8nz/STeDpHetf0Uolkjoy4PatCGuGgok7VzC0fPfBAiyy+zyGf6jdykkj+4NburdFJBOoi5YfC7JXyLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3095
Received-SPF: pass client-ip=40.107.2.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 11:56:11
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.10.2020 14:44, Chen Qun wrote:
> A default value is provided for the variable 'bitmap_name' to avoid compiler warning.
> 
> The compiler show warning:
> migration/block-dirty-bitmap.c:1090:13: warning: ‘bitmap_name’
> may be used uninitialized in this function [-Wmaybe-uninitialized]
>         g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name));
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Reported-by: Euler Robot<euler.robot@huawei.com>
> Signed-off-by: Chen Qun<kuhn.chenqun@huawei.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

