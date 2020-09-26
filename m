Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB78C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 13:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E449C207EA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 13:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iPAKQ0T5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E449C207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMA42-000731-PT
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 09:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kMA3E-0006bG-BX; Sat, 26 Sep 2020 09:15:44 -0400
Received: from mail-vi1eur05on2138.outbound.protection.outlook.com
 ([40.107.21.138]:14371 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kMA3B-00008S-36; Sat, 26 Sep 2020 09:15:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bsmo+MLoAxiJshScnWpBtDQad2dR5CmOJBY2cfAd1SI5gdZ4aY08wgxHQ2Cz0hwCTJrdmRlxdRZOoqsL1Iive3ftZFUj/0WMu1Q5d+8aBDhH3rtukL5B9Ow9dKxPZ/IsSo60K2HYox7/xAc6Rgbg7l2PkyDJrXF8qIA/xB3QI992PM/RPPd+gseT4tLYTWk9ekw8k+r+95LvD54ERp1PZtNeDm+7Px+p+e9azHd4M8pylVwBRqUKems+WLeGuWhFCkN+qhrNoNHjWBH7oC6QZbaBDyznFM8dODw8lIN5cub83ZszpMez9ZefFCNDKkzYdJpnCBJ5t2vIWwo4idxaag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YBFVIsXh97NBEo6LHkqp90QxJ0TdGRiniWhbutzZCM=;
 b=h7VgiSFm0RH5PxLhYQ8p9Ahx55JhrwlEBYgZQfVLQRP14VEcR7NSvRrKE6vLxkHiji1YAkUYg64X93z3cvpKzfu928N1HJDi3rcD+Ub8GsFGWGf2mTCZcmcbLd9KwalBrBWXaE6TAptxhj1qSiIiPs9qxpGa/yOV86YJzgFBXXEMcO+ZA3RN22UUtYgXGh7yNaIGzcAXSYxtPvg6xZyXAastPclfMee4MINNphdr5E3rGoqmCQNEKZYvOJFcoJ3TtmND5JhFFlvFNbOjaa5MXdt2IuavE+kMMHq4py7ZPn2xTndUoQJffs1o9njPg3mPYN/QALDNTge+djLE9eDQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YBFVIsXh97NBEo6LHkqp90QxJ0TdGRiniWhbutzZCM=;
 b=iPAKQ0T577d+7sNRnmI/0N9RSQoL9SioE7oZhx8GMkqiH1CJY15fRtL525qhfm5JiqA0bSu9bI+KcOfM0bn3PbaUngqiFJGRGGv9feqXEGjkTtk2rjvM+ndCvIl4hhmAYzx6M9GNWvkMQoTpxp72T+1Zf/RqlwP2laCT7N5pk+A=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB2686.eurprd08.prod.outlook.com (2603:10a6:802:18::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Sat, 26 Sep
 2020 13:15:36 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%8]) with mapi id 15.20.3412.025; Sat, 26 Sep 2020
 13:15:36 +0000
Subject: Re: [PATCH 2/3] nbd: Add new qemu:allocation-depth metacontext
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, rjones@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200925203249.155705-1-eblake@redhat.com>
 <20200925203249.155705-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5a8e70b2-523b-b0e7-b6ec-6790ad95c312@virtuozzo.com>
Date: Sat, 26 Sep 2020 16:15:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200925203249.155705-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR03CA0065.eurprd03.prod.outlook.com
 (2603:10a6:207:5::23) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.99) by
 AM3PR03CA0065.eurprd03.prod.outlook.com (2603:10a6:207:5::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Sat, 26 Sep 2020 13:15:34 +0000
X-Originating-IP: [185.215.60.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d74ffff-1acd-4ff4-3b71-08d8621e4148
X-MS-TrafficTypeDiagnostic: VI1PR08MB2686:
X-Microsoft-Antispam-PRVS: <VI1PR08MB26862E84D9CFB36AA0D6F92EC1370@VI1PR08MB2686.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrIOsyOufli6yroL+F1BBTs9LAL6hDKogphZ4ea6lHTDI1jABrm2XBIVGd9WpDy4tWHDGnPBdqt+6tDwAG0EbGWxvQuTlfmErgHubyd+I+KYgTBKkdfpmPmBXcstbHI9QKPsE8EWlGs0QNczZfvo38470qKCtlWu2sxywlkUcl5MX+00DEDknAJFRHhLqnMVqcx2vZLRtcypm/QCgx5vf93CzBLw17M2tLJ8Y98w4JqvkFEIHG+KAJm4Z5gnfCqdxzCO0FonFYSLN50MRMXQZrVbJQhajWTosZWUpfhlxnQFMOsoEQtmgUPoROieX03VmieTWpFlT+rGz7oXsYald6WdApFzfmdxJkACB27QHzwPJg+dfZ6RL2DJQpoM3yZizcDm8Kz6bQXegEYc8B1H/5r++fgcJuJRjzqkcmyx//ZiswrRmZFRHWACucCEikcq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(396003)(376002)(39830400003)(186003)(52116002)(16576012)(316002)(31696002)(54906003)(956004)(2616005)(6486002)(86362001)(478600001)(31686004)(26005)(16526019)(4326008)(83380400001)(5660300002)(2906002)(36756003)(66556008)(66476007)(8936002)(8676002)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zUFR3hkzaVcVU1T6KNU+uL01J38fiem346203IHqnSl7i/pRsarBPEl8GzXfb015xiMpS46MFsyXw3/BN8P6rHM++bBBRp5xZX6DWADasDufQQn9Gx7BEAOg7//g+3OwMQHpvjLBFdCG5Ts28BT5Us5CQ4AY0D5AktpCUzbxzyUOquPMWb6Aj9RsfANekroBszWZLrZTj6aMg9RToLS6yO2mgO2uNgWza3EOD7Wu/N3NWH8bPDz6BzwFeTdhDcsuwiy3SIFxLPuxxdHhLdUijKV3ppzetiIHQKQpPXO6ENtWBzToeWfKOd+NHk0wJGLiaanLfv8XCianb17eof/HefKQCiewHVKR0dZA80a84QFawmutar2BKrnZNN9PXgzcw0ze/6V4MMDYBin8OrqX2/C8P1qY6jwkPf8Sd82t7XeTxqz4m4UUjVemFOHJv2qIFhASSmrIHyi3/F2Cu+C1LKYxz7imyCT+w1M9s4kklzKvrkGu/aiXn99ofEDjE2Cl0/tcFzE+dbfeM4Jz2oH40ycMxT/82fNzxptNEjeLNum3uZQ1KYNgknnfgnJnbPJpmlKUJmusGN86utmS0mtgGLFBiY34H+/a5Xkf4CvHEDFGrdFZS5aZq7blEsVQl+T7E0JGykOS0dtiKliuPZPQ7A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d74ffff-1acd-4ff4-3b71-08d8621e4148
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2020 13:15:35.9795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwE8ZCtMKopKrNlT7utUTxbl3A9GGXBL2iY+p59J2BJuIUaD+pptPlhRdDKunbm2nfHtBuawGGp6ykHNmbeE7ZQlwWyGrowAKKvkO6mQSAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2686
Received-SPF: pass client-ip=40.107.21.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 09:15:38
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.213, RCVD_IN_DNSWL_LOW=-0.7,
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

25.09.2020 23:32, Eric Blake wrote:
> 'qemu-img map' provides a way to determine which extents of an image
> come from the top layer vs. inherited from a backing chain.  This is
> useful information worth exposing over NBD.  There is a proposal to
> add a QMP command block-dirty-bitmap-populate which can create a dirty
> bitmap that reflects allocation information, at which point
> qemu:dirty-bitmap:NAME can expose that information via the creation of
> a temporary bitmap, but we can shorten the effort by adding a new
> qemu:allocation-depth context that does the same thing without an
> intermediate bitmap (this patch does not eliminate the need for that
> proposal, as it will have other uses as well).
> 
> For this patch, I just encoded a tri-state value (unallocated, from
> this layer, from any of the backing layers); we could instead or in
> addition report an actual depth count per extent, if that proves more
> useful.
> 
> Note that this patch does not actually enable any way to request a
> server to enable this context; that will come in the next patch.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Looks good to me overall, need to rebase if patch 01 changed (as I propose or in some better way).

-- 
Best regards,
Vladimir

