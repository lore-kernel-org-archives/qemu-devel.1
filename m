Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BD6CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605DF21897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605DF21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLNil-00033z-HM
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 04:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iLNfI-0000XZ-AB
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iLNfG-000096-B9
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:31:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iLNfG-00007G-3j
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:31:14 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7E85910F0E
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 08:31:11 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j14so1967255wrm.6
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 01:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=t/TQfPA0hAXJ5ts/4Euck+8Ln2s48TU/JjhsfsQsYbE=;
 b=IjX7wlJQ3FwcKznNOizWjK8RalzVAejHGWeBdxQAjgCpNCOo5wrvroNGQBWERMaAuj
 NMJeY+0FSIzwS1fzy2klVYoU83zcPIUOgvY6J4i/pewwe7nab+n6mjqjVFq2Z+ddIoqA
 YWzSySsHm1fRrkGtKFLpcco2whQ43M6D5ncp6Fakh23aPhBmZTqeo0vUDD+Ys5DGtGyY
 1z4JRdhHiCSJYoMAQyKdd3bfdXTenQkeqifCsB+pUOtZ2BjyNUbZFunbipJSPLUvw5L2
 5Noy+DMqPpNpKcqtKtnFfUZqghUTTxOVKJ2yh14cbumwTZum5wSnIA96Kf2BQGLjL2ol
 IHJA==
X-Gm-Message-State: APjAAAUFJ+K30U94f3D8a4Isc8Q0L57UeZukfpL+h0c2Tk74zirdQnF6
 qa5S+4xCadWS6Cml5omuIPRBzcsh5W0D3nq66VTeQ6bjydf3whjSTzkxTs43CBuYBUtOawbZox1
 Yeq9gYB2q5Kf1vZQ=
X-Received: by 2002:a7b:cf28:: with SMTP id m8mr6673826wmg.63.1571387470128;
 Fri, 18 Oct 2019 01:31:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwG3GFyYGz15I8b1Ua84hYOEJanSgw3R1Lfo2nZPTkcEJYCxYwVIZ6T5OWgzpC6qh3znCfDgg==
X-Received: by 2002:a7b:cf28:: with SMTP id m8mr6673801wmg.63.1571387469856;
 Fri, 18 Oct 2019 01:31:09 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.200.174])
 by smtp.gmail.com with ESMTPSA id l9sm4341468wme.45.2019.10.18.01.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 01:31:09 -0700 (PDT)
Date: Fri, 18 Oct 2019 10:31:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH] block/backup: drop dead code from backup_job_create
Message-ID: <20191018083107.7wfoaadk4huulxmo@steredhat>
References: <20191017142122.20897-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017142122.20897-1-vsementsov@virtuozzo.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Vladimir,

On Thu, Oct 17, 2019 at 05:21:22PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> After commit 00e30f05de1d195, there is no more "goto error" points
> after job creation, so after "error:" @job is always NULL and we don't
> need roll-back job creation.

I don't know this code very well, but IIUC only block_job_add_bdrv() could
fail after the job creation, but this shouldn't happen because "Required
permissions are already taken by backup-top target", so it seems safe
for me:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

> 
> Reported-by: Coverity (CID 1406402)
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/block/backup.c b/block/backup.c
> index 46978c1785..6e1497f7bb 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -474,10 +474,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>      if (sync_bitmap) {
>          bdrv_reclaim_dirty_bitmap(bs, sync_bitmap, NULL);
>      }
> -    if (job) {
> -        backup_clean(&job->common.job);
> -        job_early_fail(&job->common.job);
> -    } else if (backup_top) {
> +    if (backup_top) {
>          bdrv_backup_top_drop(backup_top);
>      }
>  
> -- 
> 2.21.0
> 
> 

