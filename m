Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9E8C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 06:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F5620692
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 06:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Vb+/9r13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F5620692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLi7C-0006ZW-An
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 02:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLi6C-0005ru-73
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLi69-0001VA-Dp
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:52:39 -0400
Received: from mail-db3eur04on0724.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::724]:15609
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLi69-0001UC-71; Tue, 07 Apr 2020 02:52:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuYaYqT7ojO0x4LqL/L/FzQ4JtlMGL+A1IiwOvuipbaZ3ucvON8M6mnHDBs3mO6nM1ymqTq03Z2lLFp/V7DBl0ze0d+4lcyfLR2DxgiAq7ZIim0xqQ6xkUwF/gohKuiifTqLLMwN9QdxzDxhZOf5HcArPfXGE8I0aKEu+Zan+GpCATrJ9ZLa3C5+ar42FumLiY5FobqM5siqmm32Ji5jtMcdRoIv0dTHtSTQV1Alsk+lxJwV15W8S79ikPRcER+xlBDfk94pMJRAyhzuO/MaG6yUprXuONdYw4VyEvDce5VivOaxx77mrSj0pFP6w1UUBoiAnbP3UPkpW5ski7suzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGaXM+i/tRBo3tZK5AQkObnTQ5Hu3jgGGczWTgZhvK8=;
 b=Ao8K0gxCcb3Y/5l8iDKgecTIDSPRzKFt7VgX9hkZ/ToQ8hs23jImhbHyiEQ3vb+rP6MEfQBixqFkMHGVzSGOOWj8bUKypHDXRVPCYHG2ydkf+r/oeg5QmiS7+VEitNCSqyRINWaxaw8EL4Ty9bUz8om/o+QmOosXXNcSrTtlcMFksMv49axE3Vp1LKjlfQkydYF3ksdSO3L69N1Ozcz5pXr4Idw+Z9VtCkhrDnMCFXx/bgzgcmE9XHIX8XXezO+iOrJHMNtuI9tfz1mJ3bwuwo/K295H+CjKc7PGBgNXlB9Zc3kjw731HdHpqdWIV0rVYs6uMNd/lEQRCac45nXN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGaXM+i/tRBo3tZK5AQkObnTQ5Hu3jgGGczWTgZhvK8=;
 b=Vb+/9r132WNYpOT/JJWCUt4/5kpCN13LJ9WGj51MzTG4Up4IR4J7Zdb1MoEcGvuedZfk6OfWMSVpEKlacGfWSZBwaAa9UUWZthOol7eCV8PKAW6maPX039Qz/WqJImjZgkZMy5wa0dHEGc1JI2wKjaOC/yXRmU+xkFRzy5616OE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5381.eurprd08.prod.outlook.com (10.141.172.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.20; Tue, 7 Apr 2020 06:52:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 06:52:34 +0000
Subject: Re: [PATCH for-5.0 v2 3/3] block: Fix blk->in_flight during
 blk_wait_while_drained()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200406171403.6761-1-kwolf@redhat.com>
 <20200406171403.6761-4-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200407095232352
Message-ID: <3c8fd1b8-5138-b6eb-1e9d-55e03ad078c7@virtuozzo.com>
Date: Tue, 7 Apr 2020 09:52:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200406171403.6761-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0048.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 ZR0P278CA0048.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Tue, 7 Apr 2020 06:52:33 +0000
X-Tagtoolbar-Keys: D20200407095232352
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e39d033a-cae3-4244-3351-08d7dac0405c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381B65B7FFC3D57D7A304EFC1C30@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(4326008)(8936002)(8676002)(186003)(81166006)(26005)(478600001)(31696002)(16526019)(86362001)(36756003)(5660300002)(52116002)(81156014)(31686004)(66556008)(2906002)(2616005)(316002)(16576012)(956004)(66476007)(6486002)(66946007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMe5B0jsS+Hp75kBNSXbY3p+WMIltczFKcuu9u9K85aAp1mhJZCJLQ2oImnmJnDGIGLWrSvotzII9tfq74SBsSWK3dq9Z8qnt2TaSqB1Y1cA4X9ies+9h1O28Naew1frPrROgayav5s3oigT1FINBfyjZSsiO9nzLCsvbgjdJWXjCDXJQXvDi7aSqs6OSheP62abEUUB6ur+3LUZgC+Y6Q3ePwjqDFzrsq9k2SZnIr2BnQFUpfhsNT86R5oTZbYktRUSv4IlnEfQJ8Kfv6RVwZVPsMhuUgIMBqC0rSfefH5QIEg5veRlloqo2XSjMdR1F1PXLoumHQnnXZDoVxerzKinU6kzHhLdaPcx3MrTA6X8Kdw3oYWIq2MsqJ2X/sRJ1wywbmO3lR4z49OeYq84u6Trm5rZgdgKLGPL63jR36M9P0AFrQbpGV2p3xiCOn0H
X-MS-Exchange-AntiSpam-MessageData: AZVEzUNpnUcprUB+zGqc+TIMUu/O2lcwXVZ/VssgJeh64LMcZrPDPf0lfHcuLNE7bOkaH/KHDlj+etbo1MnTLoqlRXC3xgqN8kcG76E05nLXL61Mc4h6HB7xxh9V9q79XUFzzIP4xeGMAgrFdM9NXg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39d033a-cae3-4244-3351-08d7dac0405c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 06:52:34.6536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnqqUabK5pTVf9G+pAyH+W3Uwp+cVBvssoAw5cqg9QGcNUsD9JfU+z6JJIHWldIGs+6iY2fCNtXOUAY/LigkITO7m+Uh8CG7KGjW96Ay/8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0c::724
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
> Waiting in blk_wait_while_drained() while blk->in_flight is increased
> for the current request is wrong because it will cause the drain
> operation to deadlock.
> 
> This patch makes sure that blk_wait_while_drained() is called with
> blk->in_flight increased exactly once for the current request, and that
> it temporarily decreases the counter while it waits.
> 
> Fixes: cf3129323f900ef5ddbccbe86e4fa801e88c566e
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/block-backend.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index d330e08b05..f621435f0b 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -1140,10 +1140,15 @@ static int blk_check_byte_request(BlockBackend *blk, int64_t offset,
>       return 0;
>   }
>   
> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
>   static void coroutine_fn blk_wait_while_drained(BlockBackend *blk)
>   {
> +    assert(blk->in_flight > 0);

Hmm. You promise to make sure that in_flight increased exactly once. Shouldn't it be assert(blk->in_flight == 1) ?

> +
>       if (blk->quiesce_counter && !blk->disable_request_queuing) {
> +        blk_dec_in_flight(blk);
>           qemu_co_queue_wait(&blk->queued_requests, NULL);
> +        blk_inc_in_flight(blk);
>       }
>   }
>   
> @@ -1416,12 +1421,6 @@ static void blk_aio_read_entry(void *opaque)
>       BlkRwCo *rwco = &acb->rwco;
>       QEMUIOVector *qiov = rwco->iobuf;
>   
> -    if (rwco->blk->quiesce_counter) {
> -        blk_dec_in_flight(rwco->blk);
> -        blk_wait_while_drained(rwco->blk);
> -        blk_inc_in_flight(rwco->blk);
> -    }

Hm, you drop it as it's called from blk_do_preadv too. I think it worth mentioning in commit message still.

> -
>       assert(qiov->size == acb->bytes);
>       rwco->ret = blk_do_preadv(rwco->blk, rwco->offset, acb->bytes,
>                                 qiov, rwco->flags);
> @@ -1434,12 +1433,6 @@ static void blk_aio_write_entry(void *opaque)
>       BlkRwCo *rwco = &acb->rwco;
>       QEMUIOVector *qiov = rwco->iobuf;
>   
> -    if (rwco->blk->quiesce_counter) {
> -        blk_dec_in_flight(rwco->blk);
> -        blk_wait_while_drained(rwco->blk);
> -        blk_inc_in_flight(rwco->blk);
> -    }
> -
>       assert(!qiov || qiov->size == acb->bytes);
>       rwco->ret = blk_do_pwritev_part(rwco->blk, rwco->offset, acb->bytes,
>                                       qiov, 0, rwco->flags);
> 

With assert(blk->in_flight == 1) and mention extra wait removing in commit message:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


And still, if my suggestion in previous patch works, we may fix it all without extra blk_dec/blk_inc pair, by just moving blk_inc_ after blk_wait_while_drained in my previous suggestion.. It looks more native for me (but may be I miss something?):


@@ -1154,6 +1154,7 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
      int ret;
      BlockDriverState *bs;

      blk_wait_while_drained(blk);
+    blk_inc_in_flight(blk);

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


(and same for write, ioctl, flush, discard)

-- 
Best regards,
Vladimir

