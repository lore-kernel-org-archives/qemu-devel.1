Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF86C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE0220848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rWPscLsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE0220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfpI-0007tJ-IP
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSfmv-0005vl-Iq; Wed, 14 Oct 2020 08:21:49 -0400
Received: from mail-vi1eur05on2121.outbound.protection.outlook.com
 ([40.107.21.121]:16609 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSfmt-0004fz-HR; Wed, 14 Oct 2020 08:21:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt+6713APtQ1gN3Rkvh+rv8HFvnt+s9l5+JY/ReOmvn4PwamLpcZVEXUAGA6BU20PZEW7fK2ub6LgV5iLKUfl+Rbdtzp2Uq6zcWp1PE7Vek+YD/qyk1CaK/C4CIZqOsGL7lhmW2FKmrNv7LFZCBJI2Xf4AQa0koQKVMLiOPMMkO4v4rr59+m7UE9NxLPO3AktMdPznFEguqg618fSIXsxs1no6OrROIkZG+MnpxIDbb+YAWj7PDp2hiZBPL5eHR90OxwXFGdpRgTWExkGnYkMMzxnR62lDfjh0145G/0eKYOVibxaqmKU8HUEWgg93jwtRQd0Bkcd406+AQQD6m6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqvt7XETGjKgpANIbIgPKm+aBzk3Jc49siPm/EOnai8=;
 b=CFR96+Mzu7xg2nymOpVbeMqeFc1MRc6Nrljdu7qQ0ovVHo6vw9X7bD733DQ9UqAqw+IMuQDBxQoU95c5EiTAvfx0Yb6pZTErhbHfOHyKKOIT9fAdTfIzpNeW0tSfc5GWScGORwBb6YNH+m6GgHUa08hP0BLV/kqf1ydsc9qnP+QTg76Mmaoiyko+sJL+9Rz6H8+5JmAa0P1h259EQnhJfKTM55R1qpPagjlBAIeMEfUfYhv2hGyHO/KNZc6XbtNBVAfWcMUB/28o8vbmXhO3tGMSoizfp+SkN3sIeXtyEqWmQNPd4+NhV3xzIovducRxGj1/Af5bS18jdsYEbPF8zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqvt7XETGjKgpANIbIgPKm+aBzk3Jc49siPm/EOnai8=;
 b=rWPscLswG0c0eYjnmslOBa9IyzkE8LPMuTbYtT6m45oDxFeAYGslwdZOaB6WYPXAbrTkU4wvBGVEOVTbBjoOR8Ez4fls+tgEU6UV19h89LW+Dbrq/071xLxouuCGuIEnfQiI0f2fbIkC5UgDru0d4J9dpiH/ws+HuvvdPQzlLJE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2609.eurprd08.prod.outlook.com (2603:10a6:203:98::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 14 Oct
 2020 12:21:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 12:21:44 +0000
Subject: Re: [PATCH v4 5/7] nbd: Simplify qemu bitmap context name
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, rjones@redhat.com,
 qemu-block@nongnu.org
References: <20201009215533.1194742-1-eblake@redhat.com>
 <20201009215533.1194742-6-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <093f92b8-4e79-474c-1010-be5551ccb7bb@virtuozzo.com>
Date: Wed, 14 Oct 2020 15:21:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <20201009215533.1194742-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.122]
X-ClientProxiedBy: AM4PR0202CA0013.eurprd02.prod.outlook.com
 (2603:10a6:200:89::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.122) by
 AM4PR0202CA0013.eurprd02.prod.outlook.com (2603:10a6:200:89::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Wed, 14 Oct 2020 12:21:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7653b7d4-1b9e-4f5f-3bdc-08d8703bb6c4
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2609:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB26096CAD751AE2E7E2056534C1050@AM5PR0802MB2609.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hdRYlXm9ZLlcrR8AJ4tyOA0nW3K4b0yGBSm1zrIlUBfyjxr49nfRcxUGYc3BzBWaT8v8BdPWyfjChaYH/mRT79wGV/pWlXLBY1TNcq+OeJMrEaRZLDbS1k2RDwDfQmF2qlRdQ1VarO37gWKu/CE4ugYklkiuTolV/BETfM+rhN6We2mSv8EQxX/TZEwJ7lts092IlMF6ihsfykAihvG0kwmYsXd7FUGglfBkmiqiOknUCj/mNQg2/WkfPs+z+emkwTXGwellICs0iGeurCXjlNGsc6ODLtYRPHoKhDI8+lrXrP1+1cxh1WH3ExcG6ibe9GV4NYOUpu88nQoVOYADFxFg7qZ7S68aK3CfKNrV33RjXmAAd1CfiStBDF7upHt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(39840400004)(346002)(956004)(2616005)(86362001)(4744005)(316002)(8676002)(8936002)(31686004)(16526019)(31696002)(52116002)(186003)(26005)(5660300002)(36756003)(66946007)(66476007)(4326008)(66556008)(16576012)(6486002)(478600001)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 51WO0cOUS4KSwo+u0n76nybKWwIOpBebOOvziU8DCbON2vFr5ZAflU9ihp9wJaPGgbxCMtpcIJO+B45Iw9K+OaM9gJKK5h6Dr9JpiKs4prIl5HTkgfBREAiFNS6+nDKFvVqSXb/UhFWOpSoIyOf2gMNr6DyJjn3+WaHv5sF4PC9gxVG3bvF5ir9kbNGbkWpwZ/TG/6Xg99w5NqOHfDvSqZ8gFTCouo4337wNgVl4HFQvSGkv4ZroexIf5/s7r9zJpqycaGPCqpkUUtIQYjRqzwmV/HyHrf7PKTeCnC4Q08KJwYdNHevyW9eLiUU8wXCSi+pBTb5JPQqkxF7alFqoe6XwIFiyNQ8cswDdyOa9XPFo5DbEZrmbaC0dfAGxkYoxNLGcROk3Ntfx7n7zWqZ/sylifIG/oqFDOJVd8fltCIZEd+xbgvZ++kSsdZVJaZ06xrQwGV+0qNWxbj0mzXYiZw4+zoZlEUkRCUyhFizWjGcsqHVrRcJKHW/Qspigc8H4M5BuhMW24OYQ8oodONkblYFiIqCm9pCp70TyJk5F2B+z3KKQ5mJEvxfpZZDvawceR4yuYbpe3VtDddvObIuebC9N6ZWsFeEhQ6K12nLO7CRho0OFgwRde/fP+QEhaSC1vBH2yKuiW4uo5ywtRbYpZw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7653b7d4-1b9e-4f5f-3bdc-08d8703bb6c4
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 12:21:44.5874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zI/Hd9RACJCo+CUcTI576wnr1YJg5fu6ZbFNR2yBvsU5FmvgyEQhN92gItOWolqI67ZbnBWt5nJl/bHy/Cs2fp2RDaspzGLG1fmUl2jAKyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2609
Received-SPF: pass client-ip=40.107.21.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 08:21:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

10.10.2020 00:55, Eric Blake wrote:
> Each dirty bitmap already knows its name; by reducing the scope of the
> places where we construct "qemu:dirty-bitmap:NAME" strings, tracking
> the name is more localized, and there are fewer per-export fields to
> worry about.  This in turn will make it easier for an upcoming patch
> to export more than one bitmap at once.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Thanks for updating this!

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

