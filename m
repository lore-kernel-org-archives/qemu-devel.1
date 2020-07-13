Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABAEC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E69206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AxmMIuOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E69206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuR7-000297-G1
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juuQC-0000pT-69; Mon, 13 Jul 2020 05:06:48 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com
 ([40.107.8.121]:57406 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juuQ9-0003o8-UW; Mon, 13 Jul 2020 05:06:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eageSgv7neelbpt9f+383NxA40ivhmzTGRJRu/6qQkob6+rLcF+zd5FBbDOLttVtMFX2qYdVQsZ/b4ZasYJxvFeAA7W4Epgt3oyIGQg8l0J5lhGnefC0NSpgn9ytzVHJxpC0rfRDsMmlyrNreLtfvJ7YlMemu+DIfI83IOHczjzDD6Q4sbbRcyoQoTFo1SUPObuR2Z6UMqLnZSDLCM/+ux8AV+MqMb2hnDnwkV+unI02bawDT1CQIEJg5YE/u1JP440jaKUzAs/d02XOCOrOWyciDfizmJD0k+fLE3stnqguuBg8GbOgOKO0xEa935xn2UVqHK9oDQlGl1LBE0f0lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ggsjo13BB5PSkM2l0eNll1X69o6RBCEHxSkUXncj5w=;
 b=kLdyrIdFU7ZuyAG/w08OhOh9IO31d2xlLfAyTFeSlB5qTmKNRR/GyxBaZVB/jM8aCfj6Ig6tbq1UJgZRjvl6Lu+B22poLkqFBFfvTY2w2gG+VDmZ313kGfBFY+ns7Jqi5ATmPOxYnHzlg45fVqB7x2ZFfiFEq68bq6/Stc3KV2q5p+UQo0hWRzhwo6jkGi/2aLW21A6um6nfg66cMAwXQSTfmgxx+ItuXKsM3E8Gt0wUU8a4kDBy6iqyW4SuJQ3XAUoBRHTSLEaTDK+w6l2yie646IznDFg6RS+8+kMNr+/W3hvJYGBKtbvqjRzivqewjx4xpt0jLQ7vnTN7pfqZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ggsjo13BB5PSkM2l0eNll1X69o6RBCEHxSkUXncj5w=;
 b=AxmMIuOjtvHCGq97E21/GFnDf9sikIOtIkiJldmiQAtK40R+FLoe0qzqTeZyIuo86WHQgjJ3Pp0HoCXGXDHp1kJJG7yWiXvdYPkCRCY3rjcpqKWdjVBuwYiIcSPP4CuRQPvWNMHMiuHu+4On52fwPXpuq/A2wTuNdfI1kKs2mJo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1780.eurprd08.prod.outlook.com (2603:10a6:203:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 09:06:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 09:06:42 +0000
Subject: Re: [PATCH v7 01/47] block: Add child access functions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-2-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <12e568be-f931-fc16-0ca2-a7ec54e538ea@virtuozzo.com>
Date: Mon, 13 Jul 2020 12:06:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200625152215.941773-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.167) by
 AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20 via Frontend Transport; Mon, 13 Jul 2020 09:06:41 +0000
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dae4acd8-4059-4090-4659-08d8270c0efc
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1780:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1780B3E65823E598CB942DB5C1600@AM5PR0801MB1780.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89ebWM/+0VQs/51tuijzGcjxQJJZeP5K1o+o8PJl8wuZ8vDTVMl0w478NPVR9cXF/br6bySCpdsB8VY5x3BlYbziKUcbu/XANLAVIDk99jLbDJRyhVTtuYK6R8LrwVpEFDEBtRsaEcCcTX3K66jMsMm8P/8Wv85HwaMGDzfuOidY5mkIXPyy/cs0GzPOoltAAq77CxhCe0KAXEaQce/lSpHo3rkLIR61CJW1GSPJWMQ2ftaglHI1jCY2JZOY6Am3GHZPSoT+BTDcCj49cjvkmQ3Trsy4QaQZ97zsGqaCIsfVtI7wWtnzrhSsOKqw6M+iVo1NRMxFKkpH0IJ+1BcTAbzdRrzOEyH+g593HelT+2Cs/Pt5mU59FSjr5jdv5SI6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(376002)(366004)(346002)(396003)(478600001)(956004)(2616005)(31686004)(2906002)(16526019)(186003)(36756003)(4326008)(5660300002)(52116002)(8676002)(83380400001)(26005)(66476007)(8936002)(86362001)(16576012)(66556008)(6486002)(66946007)(31696002)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CxFNv61pVqJ4mbo0ainTKCNGmjmtCtaHrA5dl2C/IqLui55BYcjohPgFt6SrZE8ea+Tw1Wkkf1c+EDxEKnhncW6qPZ1A3zZofrppjUrXWESNFBaTRBh4Sm8WcmcIFddV9l60oHqR9PXAhmyq8UKLE2m1ebJuUMEGdF7FE1EI4bKSq6aCZ69PnqrhhfFYrG/9lV+AU+yRwBIxooKvgq0yih2NoAZmEaSt8mWrXKpif3+5Ts0fXdL4erkiwa78PPoDKSbh8zC2ocPQjj2m9anLk3RhKlj6dRCzzr8kNr0ZTC7egF8BEZk6uMn1Ndr2DRbc60HWW0CNMOUAl05rAEO/frpp9YYk6ciW+VMJ2G8n5n/JIdE+piO7U7TqsDiz8L19XR/4geZ5QPZaDD7nDbXdu7UP555yWFn9SY8GI7xfy1RK7mSY+RhRSxWXZd16oTD+iO+9ZpxfU2BnHrBeHoZsrrYj/Andz5gCbQAy+HGzA4PE+79yCMPE75H1pHDmLHm4
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae4acd8-4059-4090-4659-08d8270c0efc
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 09:06:41.9252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PVpFAO6rd0U4bEPyDKq86uXcIpia7PHaq6sjOSeE67FbXwC95S8sqJ9J+tUbm3Z6hoNRCSd9sO7+HfIz0AgjeSwT/93R6hbCYZhnurzUv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1780
Received-SPF: pass client-ip=40.107.8.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 05:06:43
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.06.2020 18:21, Max Reitz wrote:
> There are BDS children that the general block layer code can access,
> namely bs->file and bs->backing.  Since the introduction of filters and
> external data files, their meaning is not quite clear.  bs->backing can
> be a COW source, or it can be a filtered child; bs->file can be a
> filtered child, it can be data and metadata storage, or it can be just
> metadata storage.
> 
> This overloading really is not helpful.  This patch adds functions that
> retrieve the correct child for each exact purpose.  Later patches in
> this series will make use of them.  Doing so will allow us to handle
> filter nodes in a meaningful way.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

[..]

> +/*
> + * Return the primary child of this node: For filters, that is the
> + * filtered child.  For other nodes, that is usually the child storing
> + * metadata.
> + * (A generally more helpful description is that this is (usually) the
> + * child that has the same filename as @bs.)
> + *
> + * Drivers do not necessarily have a primary child; for example quorum
> + * does not.
> + */
> +BdrvChild *bdrv_primary_child(BlockDriverState *bs)
> +{
> +    BdrvChild *c;
> +
> +    QLIST_FOREACH(c, &bs->children, next) {
> +        if (c->role & BDRV_CHILD_PRIMARY) {
> +            return c;
> +        }
> +    }
> +
> +    return NULL;
> +}
> 

Suggest squash-in to also assert that not more than one primary child:
--- a/block.c
+++ b/block.c
@@ -6998,13 +6998,14 @@ BdrvChild *bdrv_filter_or_cow_child(BlockDriverState *bs)
   */
  BdrvChild *bdrv_primary_child(BlockDriverState *bs)
  {
-    BdrvChild *c;
+    BdrvChild *c, *found = NULL;
  
      QLIST_FOREACH(c, &bs->children, next) {
          if (c->role & BDRV_CHILD_PRIMARY) {
-            return c;
+            assert(!found);
+            found = c;
          }
      }
  
-    return NULL;
+    return c;
  }


with or without:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

