Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFBDC2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 06:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB6A20644
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 06:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="s0oyhG+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB6A20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLhwJ-00061w-Qn
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 02:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLhve-0005Vc-R3
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLhvc-0002ZA-W3
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:41:46 -0400
Received: from mail-eopbgr30092.outbound.protection.outlook.com
 ([40.107.3.92]:11649 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLhvc-0002WT-9y; Tue, 07 Apr 2020 02:41:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVEVx5UNP1kWTv0nRQATylkqVEvRaampqNsxsyaksK0MIIT1sUstFLMSkbOYA/ZEprMwCFqLJEAJWYWalDlGAJ0gstADorHO9KcEFAV1r3AEJsiBUclgqevgEHpHbf3EqMLBPceOEUuzfTrg/8LMCYCxBWKdqkaelPh0q1hmIpNa3Xk7g4Lg4xSrrhE5v7QMRHB9yjAd13HmxBj4UtSTCyvxg82t9y2WfpE7lu/3EYZAcQgdjnSq0Q1QcTbwFz4hZ9lYlxy09ehLD1wI/USuXSVavX+I6leCFIO0adBlQyum3AXULD0c1ekwMemYFUUBlB2hf4gpEMD1/K4BZCu/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDHm3ZCI+3IKn1PE64GtDL5DTWvmqbON2qqgsiUQF/E=;
 b=Uoz8CafXGwk5ZnapYGTn/SVE9pTb+In5l/84ffYiInNJ37O2ALxgKlO6bAMHyGpDDn2QsWAt6/PXq0uz3YIO2uOcbUB/6M6KrVJvA2tlAe82QU0w9aZR97wpgv7VVyzga8c9wuet/TqgA1G2SiSqKAyuW395PY+MXyUhwE7orT+8SSSGpUGb3Nh+raZJv2Uhk1zaXLIO652EcoaFQ1HcW7d1ZeQfT95HqT+YgUlnS3vHj+G4Bq1O3tnDrei72tRmJBoLEMXILPEwBlEmxafGEPGZCcLucwjUl1Kff3kCUcEpXcSx86KK7X4vx0PhOrMlo5r01dGtoXZ5FxQbOgcZ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDHm3ZCI+3IKn1PE64GtDL5DTWvmqbON2qqgsiUQF/E=;
 b=s0oyhG+YzEpYy45H/FhVdT7pgNVTi/nMfEp74wMZPIbmBsOPAySJSom3UKEVl6AkLcOCfRW6fLzBIvVuhssYYOn+AnmP6X562p94erJI2llQTg601kGRRHpHLRkizBFxZYsliAEMmFJb2qMx8CqeGfbFmDT67nfZQhlCTMPVfUE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5416.eurprd08.prod.outlook.com (10.141.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Tue, 7 Apr 2020 06:41:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 06:41:41 +0000
Subject: Re: [PATCH for-5.0 v2 2/3] block: Increase BB.in_flight for coroutine
 interfaces
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200406171403.6761-1-kwolf@redhat.com>
 <20200406171403.6761-3-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200407094132107
Message-ID: <9d0aa9cc-61a1-fd14-357e-6fb0ba2742dd@virtuozzo.com>
Date: Tue, 7 Apr 2020 09:41:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200406171403.6761-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0017.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM6P195CA0017.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16 via Frontend Transport; Tue, 7 Apr 2020 06:41:33 +0000
X-Tagtoolbar-Keys: D20200407094132107
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90d61c2c-67ba-4613-3721-08d7dabeb6ec
X-MS-TrafficTypeDiagnostic: AM7PR08MB5416:
X-Microsoft-Antispam-PRVS: <AM7PR08MB541648075BBE1AAEE354F447C1C30@AM7PR08MB5416.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(366004)(39840400004)(346002)(376002)(396003)(36756003)(31686004)(6486002)(956004)(4326008)(2616005)(52116002)(5660300002)(186003)(16526019)(16576012)(2906002)(66476007)(66946007)(66556008)(8676002)(31696002)(316002)(26005)(81166006)(478600001)(8936002)(81156014)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pP57gFntoUirSc+X+3nPNh+EQ+vwkah05rsIJqdhkBIIM6Xn6/yTjvs4bHec9NmbI09Kj3AN4u2l6BJGd+UZS2YF88WHI3Vmg6TKCKqB4wW8OtdZ/krNLvj4Yru0SqZUDnnepsYwOxUPtKNh1hvXEH5NrRfdBA5YtvZVOfWV0gcLizCXraUv3NPJB2fH8x56JH+iw6qfs+hl/JFOeblKB4pEb9WJ6TbayzYsSZqU6OVXTOfk/+8gRmQhTSKC0A6VqvDQxdfSr4zhBEmfUiFNNF4VnnnMqS7ARvHNyj0VxSfeYcADglz62+MGGJXEpXP10Q9SEYampRay0LfwY0mMX3q+Y3oOLfZ0MXjdpSV0AbC7mKDn6XCCmV5bZxkyoPsJF6Zl7H6GsgAB0Va52VlMDn/TxGK85gujsZvqYCq1KmwisIuEIvemtKEIzfahNMaJ
X-MS-Exchange-AntiSpam-MessageData: m2tBzCegcMG87CVNGJR1tLYbAg7e5Di8ZAtxeqQNEwK6VZB4Hkv50XwkstWCH4V/PsnM5H/l797tRrjkWw08tB6Wc4XlE1WibTS46H2xu2HBWI9HaWZlTknGlblxEUzcTUWEaBtdzxg0XbaaM2R8Pw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d61c2c-67ba-4613-3721-08d7dabeb6ec
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 06:41:41.3344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+VC+qVp5CKtbYITsRbIIuKG6EQAyDG+po0QmqYSX/9Q0/ItmGiVDWFCqQZSemOPmEozJbupAeQ635FkleM/TQqMmth015wVu7OSzmLlwOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5416
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.92
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
Cc: s.reiter@proxmox.com, qemu-devel@nongnu.org, dietmar@proxmox.com,
 stefanha@redhat.com, mreitz@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.04.2020 20:14, Kevin Wolf wrote:
> External callers of blk_co_*() don't currently increase the
> BlockBackend.in_flight counter, but calls from blk_aio_*() do, so there
> is an inconsistency whether the counter has been increased or not.
> 
> This patch moves the actual operations to static functions that can
> later know they will always be called with in_flight increased exactly
> once, even for external callers using the blk_co_*() coroutine
> interfaces.
> 
> If the public blk_co_*() interface is unused, remove it.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


Still, did you consider instead just move inc/dec to _co_ functions, like


@@ -1154,6 +1154,7 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
      int ret;
      BlockDriverState *bs;

+    blk_inc_in_flight(blk);
      blk_wait_while_drained(blk);

      /* Call blk_bs() only after waiting, the graph may have changed */
@@ -1175,6 +1176,7 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,

      ret = bdrv_co_preadv(blk->root, offset, bytes, qiov, flags);
      bdrv_dec_in_flight(bs);
+    blk_dec_in_flight(blk);
      return ret;
  }

@@ -1337,7 +1339,6 @@ static void blk_aio_complete(BlkAioEmAIOCB *acb)
  {
      if (acb->has_returned) {
          acb->common.cb(acb->common.opaque, acb->rwco.ret);
-        blk_dec_in_flight(acb->rwco.blk);
          qemu_aio_unref(acb);
      }
  }
@@ -1357,7 +1358,6 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
      BlkAioEmAIOCB *acb;
      Coroutine *co;

-    blk_inc_in_flight(blk);
      acb = blk_aio_get(&blk_aio_em_aiocb_info, blk, cb, opaque);
      acb->rwco = (BlkRwCo) {
          .blk    = blk,
@@ -1388,9 +1388,7 @@ static void blk_aio_read_entry(void *opaque)
      QEMUIOVector *qiov = rwco->iobuf;

      if (rwco->blk->quiesce_counter) {
-        blk_dec_in_flight(rwco->blk);
          blk_wait_while_drained(rwco->blk);
-        blk_inc_in_flight(rwco->blk);
      }

      assert(qiov->size == acb->bytes);



(and same for write, ioctl, flush, discard). It seems more consistent.. Should it work?


-- 
Best regards,
Vladimir

