Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FA4C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 09:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEE721D40
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 09:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEE721D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGfYs-0001Vh-VA
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 05:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGfXw-0000Xi-SJ; Fri, 11 Sep 2020 05:40:44 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:45231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGfXu-0001jw-Vy; Fri, 11 Sep 2020 05:40:44 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.121])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 0933D59F2CD2;
 Fri, 11 Sep 2020 11:40:12 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 11 Sep
 2020 11:40:12 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002a9726582-7c06-446a-80e4-d396b60e5c3d,
 864FBEA0465FE1F0C66A9C6AC37977A76827B8ED) smtp.auth=groug@kaod.org
Date: Fri, 11 Sep 2020 11:40:11 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 12/14] block/qcow2: read_cache_sizes: return status value
Message-ID: <20200911114011.0a9eba59@bahia.lan>
In-Reply-To: <20200909185930.26524-13-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-13-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 90f77ad8-a500-4f0a-9247-1dd1001daf9a
X-Ovh-Tracer-Id: 5042905683400890811
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehledgvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehkfiholhhfsehrvgguhhgrthdrtghomh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 02:19:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, berto@igalia.com, pavel.dovgaluk@ispras.ru,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  9 Sep 2020 21:59:28 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> It's better to return status together with setting errp. It allows to
> reduce error propagation.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  block/qcow2.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index c2cd9434cc..31dd28d19e 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -869,7 +869,7 @@ static void qcow2_attach_aio_context(BlockDriverState *bs,
>      cache_clean_timer_init(bs, new_context);
>  }
>  
> -static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
> +static bool read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
>                               uint64_t *l2_cache_size,
>                               uint64_t *l2_cache_entry_size,
>                               uint64_t *refcount_cache_size, Error **errp)
> @@ -907,16 +907,16 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
>              error_setg(errp, QCOW2_OPT_CACHE_SIZE ", " QCOW2_OPT_L2_CACHE_SIZE
>                         " and " QCOW2_OPT_REFCOUNT_CACHE_SIZE " may not be set "
>                         "at the same time");
> -            return;
> +            return false;
>          } else if (l2_cache_size_set &&
>                     (l2_cache_max_setting > combined_cache_size)) {
>              error_setg(errp, QCOW2_OPT_L2_CACHE_SIZE " may not exceed "
>                         QCOW2_OPT_CACHE_SIZE);
> -            return;
> +            return false;
>          } else if (*refcount_cache_size > combined_cache_size) {
>              error_setg(errp, QCOW2_OPT_REFCOUNT_CACHE_SIZE " may not exceed "
>                         QCOW2_OPT_CACHE_SIZE);
> -            return;
> +            return false;
>          }
>  
>          if (l2_cache_size_set) {
> @@ -955,8 +955,10 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
>          error_setg(errp, "L2 cache entry size must be a power of two "
>                     "between %d and the cluster size (%d)",
>                     1 << MIN_CLUSTER_BITS, s->cluster_size);
> -        return;
> +        return false;
>      }
> +
> +    return true;
>  }
>  
>  typedef struct Qcow2ReopenState {
> @@ -983,7 +985,6 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
>      int i;
>      const char *encryptfmt;
>      QDict *encryptopts = NULL;
> -    Error *local_err = NULL;
>      int ret;
>  
>      qdict_extract_subqdict(options, &encryptopts, "encrypt.");
> @@ -996,10 +997,8 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
>      }
>  
>      /* get L2 table/refcount block cache size from command line options */
> -    read_cache_sizes(bs, opts, &l2_cache_size, &l2_cache_entry_size,
> -                     &refcount_cache_size, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    if (!read_cache_sizes(bs, opts, &l2_cache_size, &l2_cache_entry_size,
> +                          &refcount_cache_size, errp)) {
>          ret = -EINVAL;
>          goto fail;
>      }


