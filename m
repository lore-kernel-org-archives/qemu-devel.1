Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074F6C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2ED22264
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uTyk0Ey8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2ED22264
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOSZ-0000DB-1L
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXNjl-0005aB-TC; Tue, 27 Oct 2020 08:06:01 -0400
Received: from mail-vi1eur05on2127.outbound.protection.outlook.com
 ([40.107.21.127]:21345 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXNjh-0003eq-JH; Tue, 27 Oct 2020 08:06:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdEakb6wc3g6zeL0LpwLlIc7Oz0xmYxuPsJxNs/3kxVwI7yiCShiSwHosURp2YzLGRE2nHvxUi8RptmvoWm4CnQ0tiJzrRpGgtRvUmMoMzxFNbPlU1PO298zW+/4+iXQeJgCpVWWSYU1+1DW77yWvIL9cn0prtcO3f4fiXfqyEckJxNhShagPHbkGDaeyW7GeqM/wxmusr4YH77kbbOi58K2CxA8DPqw0D/xBAI7ZEyHVgccsylggTsiBi9bV7B9hh/L0j+PNo+Jj774zdNh4TEfV9+/SmIVWLKdKoaS1tzReeCMR9OR7p2OjtHdXpURFHCQJ88D8Cn2/f9NeehHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPiko+NEmW1Tfe/klXqyc8qgm0fW+iedj8naKLB8x7A=;
 b=CzX2SF8qwvCXcAGGbdADCWRlOGm5fiB6wBIcBzBtBP2sNcVfnXu2oA66bPgkGqcyDNL8JOwEZt5aWOvfvz8C0WKtn7x4eD7QY3irietNiQB5hcZGTwSa0eGSD6kuDaSKIm6zrSqjh7DTusMRKVKCfGnOd1VDt0p0iNvoYlb1ipSB8tibZap0+Bv0JdBHBRNGzHhRuuJwXzCbit+45VJjOuYcVTBvngZjr3DFvP/tMD4WThy11gV4ezfxILY4aNmCHY3T/P33xgg3vfvymjNpRpyqRKU7F8EBPMP//TtJTIh6uo/IvzBuwljhYxg9On0sdmbaNq6YQgDBbXiTk69sQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPiko+NEmW1Tfe/klXqyc8qgm0fW+iedj8naKLB8x7A=;
 b=uTyk0Ey8D+nohbHpytEzpzC6iEizKpn+XDrL9khaermrTDKfL8KEUETnJjX/q1FHVbxWaUj4SxA/LoDlEaTIv0q6oFKwszse0WsBq6VNvL/KpzF8GfQyQsLWz/BOkDfhwBuRBV00zU+GSmfHzAn5NDd9bfCKl9R81BW4nb71emc=
Authentication-Results: euphon.net; dkim=none (message not signed)
 header.d=none;euphon.net; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR0801MB1663.eurprd08.prod.outlook.com (2603:10a6:800:4f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 12:05:53 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%9]) with mapi id 15.20.3455.037; Tue, 27 Oct 2020
 12:05:53 +0000
Subject: Re: [PATCH v6 08/11] block: Return depth level during
 bdrv_is_allocated_above
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, armbru@redhat.com,
 rjones@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20201027050556.269064-1-eblake@redhat.com>
 <20201027050556.269064-9-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <548261ea-209e-35c3-70b7-45a56e5e89db@virtuozzo.com>
Date: Tue, 27 Oct 2020 15:05:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201027050556.269064-9-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: AM4P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::18) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 AM4P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 12:05:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3640c8f2-7b36-4b72-631b-08d87a70a6e6
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1663:
X-Microsoft-Antispam-PRVS: <VI1PR0801MB166353CE85939CC85C2679BBC1160@VI1PR0801MB1663.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEVjrzJy6l2Q56ZdNn5/ZrsWT27dTqwuSoIQimt00UwCOeFN+TOLoghhlCQaOTihoQS54dFFHsQWgrysA0HRlBouV+VILnVl42zhhCra1ADNwr0CBT8KShwzUMsUf/HG0wlxAcDDcNpt81v1oEftsRMzxt8hNhjAjSuaBWu6CtNOLg1GSxEsOTFgxFZmFsqRLkHuEwTdwDakPVVulPFlg28DhBhFrY4II0Y9QZChXGDlZtmS/Y8TNjaT58sF7v11feNAD8yxmwdc6pJf32xoG1iC+yRPOoFesX0ik5quXiLoeJU6fXLhPo+x70oe4167vGfsjBVWBO2U5QWGK3KIHg4ZbWfXexiLZJwsIDtGpCqImvXPoJ2Vb8On5sAis3l8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(396003)(376002)(346002)(136003)(52116002)(956004)(66476007)(16576012)(66946007)(66556008)(2906002)(4744005)(31686004)(2616005)(16526019)(7416002)(26005)(316002)(186003)(4326008)(5660300002)(8676002)(54906003)(8936002)(86362001)(478600001)(6486002)(31696002)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: S/gaB6vkmNa77UMmStQtOQcdXmyeR4uNabgb5C9DSi41I9xTQxD5TyZ2+XTE1r/hybtqMX93kYuU8AlG5s3OI4hg4Pz1OZBms/6Ql/VJAPGwPzn/qFWcofe2DrXUPj4GVKIU5bEAml7394Z6Zf0gcXtSdgwXWIvdxnx48MmWaVPgF7OJIYRQygNiygMMEH7og8dE4gBXuS9jG7AFLDMXfjhwhL08DXS6twSkREN98slUZKqVzA87RxXH9OYxHQyRqw0oTFDjpcPZAjqZZjWdxv7EZTHZ7W+vJ2SetSO474m5+CVgAS6IolNousPfH6svNt/c517Yiwc9D0h7syccjruO5gCrUKzShKDsrl03NQpm2ZcFI+6rQc/S6aIHXQoXAtwVWs4D66cI5DsH3B1UmQcfW/Qol7D6DIHoQ3hzs5s0IHfbLHrGR4Y0AbfQdQ8ioXA5JJstY+sKSV+j4sv2k/eGNnrHqWnKTlsxZrsUPUXFDIkOXy8w5e1oGBdYiAaLvhxsGMfjTVcrnA490vhM9A5KTNB3WJMb6wATXjCsR8D0miyYtL+2c5vgVMz34sIQP+GrrAq/GHrVCzm0bLqgMdAX0Zm1XeuZZmgZGC1L8iDhGSkPh9Wnj3Vz1wMooPLavg00eA/GrMjuOseW67LWFA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3640c8f2-7b36-4b72-631b-08d87a70a6e6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 12:05:53.2527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HBWBxF1cBIH6/e9mkAp0CvFzhE9UhxKHHCt0FFVJl9vV+ZkZpEKeIrbbjxOvvr62yOjEvgkoF9WjuTtyEqRD5yQ7NDSQqVNyQUZ6455H90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1663
Received-SPF: pass client-ip=40.107.21.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 08:05:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001,
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

27.10.2020 08:05, Eric Blake wrote:
> When checking for allocation across a chain, it's already easy to
> count the depth within the chain at which the allocation is found.
> Instead of throwing that information away, return it to the caller.
> Existing callers only cared about allocated/non-allocated, but having
> a depth available will be used by NBD in the next patch.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

