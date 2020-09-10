Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28216C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72F2206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72F2206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGPY2-0007JU-VX
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGPVD-000433-EA; Thu, 10 Sep 2020 12:32:51 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:37615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGPVB-0000cJ-CQ; Thu, 10 Sep 2020 12:32:51 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.51])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id A53F4602E763;
 Thu, 10 Sep 2020 18:32:46 +0200 (CEST)
Received: from kaod.org (37.59.142.95) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 10 Sep
 2020 18:32:45 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001622cbc4c-c7d3-4c34-8879-5f2e6fd2bfe6,
 39F76413F398F3D3265C4F59F57E6F6E33B9D840) smtp.auth=groug@kaod.org
Date: Thu, 10 Sep 2020 18:32:45 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 06/14] block/mirror: drop extra error propagation in
 commit_active_start()
Message-ID: <20200910183245.4321d5b5@bahia.lan>
In-Reply-To: <20200909185930.26524-7-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-7-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: ba458608-4f8e-4540-8120-87388836ab43
X-Ovh-Tracer-Id: 6137843344049478075
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehjedgleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehkfiholhhfsehrvgguhhgrthdrtghomh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 12:21:41
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

On Wed,  9 Sep 2020 21:59:22 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> Let's check return value of mirror_start_job to check for failure
> instead of local_err.
> 
> Rename ret to job, as ret is usually integer variable.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  block/mirror.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index ca250f765d..529ba12b2a 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1788,8 +1788,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
>                                bool auto_complete, Error **errp)
>  {
>      bool base_read_only;
> -    Error *local_err = NULL;
> -    BlockJob *ret;
> +    BlockJob *job;
>  
>      base_read_only = bdrv_is_read_only(base);
>  
> @@ -1799,19 +1798,18 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
>          }
>      }
>  
> -    ret = mirror_start_job(
> +    job = mirror_start_job(
>                       job_id, bs, creation_flags, base, NULL, speed, 0, 0,
>                       MIRROR_LEAVE_BACKING_CHAIN, false,
>                       on_error, on_error, true, cb, opaque,
>                       &commit_active_job_driver, false, base, auto_complete,
>                       filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
> -                     &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +                     errp);
> +    if (!job) {
>          goto error_restore_flags;
>      }
>  
> -    return ret;
> +    return job;
>  
>  error_restore_flags:
>      /* ignore error and errp for bdrv_reopen, because we want to propagate


