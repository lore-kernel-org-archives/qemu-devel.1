Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A8FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626AD206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626AD206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGeWp-0003R3-Gz
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 04:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGeW6-0002Tb-5C; Fri, 11 Sep 2020 04:34:46 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:50647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGeW3-0001Sv-Pw; Fri, 11 Sep 2020 04:34:45 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.98])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 488326067AB5;
 Fri, 11 Sep 2020 10:34:39 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 11 Sep
 2020 10:34:38 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00224bd067e-23a0-447f-bf6b-e09b54b5dfab,
 864FBEA0465FE1F0C66A9C6AC37977A76827B8ED) smtp.auth=groug@kaod.org
Date: Fri, 11 Sep 2020 10:34:37 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 08/14] blockjob: return status from block_job_set_speed()
Message-ID: <20200911103437.39ba59e7@bahia.lan>
In-Reply-To: <20200909185930.26524-9-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-9-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: a025a0a2-29ac-4e72-bccd-afda911e9646
X-Ovh-Tracer-Id: 3935864600211855803
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehledgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehkfiholhhfsehrvgguhhgrthdrtghomh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 04:34:40
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

On Wed,  9 Sep 2020 21:59:24 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> Better to return status together with setting errp. It allows to avoid
> error propagation in the caller.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/block/blockjob.h |  2 +-
>  blockjob.c               | 18 ++++++++----------
>  2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/include/block/blockjob.h b/include/block/blockjob.h
> index 35faa3aa26..d200f33c10 100644
> --- a/include/block/blockjob.h
> +++ b/include/block/blockjob.h
> @@ -139,7 +139,7 @@ bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs);
>   * Set a rate-limiting parameter for the job; the actual meaning may
>   * vary depending on the job type.
>   */
> -void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp);
> +bool block_job_set_speed(BlockJob *job, int64_t speed, Error **errp);
>  
>  /**
>   * block_job_query:
> diff --git a/blockjob.c b/blockjob.c
> index 470facfd47..afddf7a1fb 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -254,28 +254,30 @@ static bool job_timer_pending(Job *job)
>      return timer_pending(&job->sleep_timer);
>  }
>  
> -void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
> +bool block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
>  {
>      int64_t old_speed = job->speed;
>  
> -    if (job_apply_verb(&job->job, JOB_VERB_SET_SPEED, errp)) {
> -        return;
> +    if (job_apply_verb(&job->job, JOB_VERB_SET_SPEED, errp) < 0) {
> +        return false;
>      }
>      if (speed < 0) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
>                     "a non-negative value");
> -        return;
> +        return false;
>      }
>  
>      ratelimit_set_speed(&job->limit, speed, BLOCK_JOB_SLICE_TIME);
>  
>      job->speed = speed;
>      if (speed && speed <= old_speed) {
> -        return;
> +        return true;
>      }
>  
>      /* kick only if a timer is pending */
>      job_enter_cond(&job->job, job_timer_pending);
> +
> +    return true;
>  }
>  
>  int64_t block_job_ratelimit_get_delay(BlockJob *job, uint64_t n)
> @@ -448,12 +450,8 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
>  
>      /* Only set speed when necessary to avoid NotSupported error */
>      if (speed != 0) {
> -        Error *local_err = NULL;
> -
> -        block_job_set_speed(job, speed, &local_err);
> -        if (local_err) {
> +        if (!block_job_set_speed(job, speed, errp)) {
>              job_early_fail(&job->job);
> -            error_propagate(errp, local_err);
>              return NULL;
>          }
>      }


