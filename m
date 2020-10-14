Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F141C43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7F42222C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gkl3fxET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7F42222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSmWl-0003k5-D3
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 15:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kSmRF-0007P0-Lx
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kSmRE-0002ZR-3j
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602703670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=23lwnE/SWKwdg1DKhVYOsZFotB7XBPWrVm8smyqV3co=;
 b=Gkl3fxETBFod4gggZnuIHoqNdvE0c1gbNJ/8GCx07avEZAqe0Y8hkCHJxNox6L521Dc5hc
 rd8z+bYTJ64YdD7TzfK9DcuLRcYVLSyPMam14fbznofEZgjBehV1dNZGhM5VaU3iqAYrnQ
 U9CE6ABr98ksBQO0D22aeTODd63x10s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-qmFhrRdFPHKSRk2vqV2X5w-1; Wed, 14 Oct 2020 15:27:45 -0400
X-MC-Unique: qmFhrRdFPHKSRk2vqV2X5w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 208C4100746B;
 Wed, 14 Oct 2020 19:27:44 +0000 (UTC)
Received: from work-vm (ovpn-113-95.ams2.redhat.com [10.36.113.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91DA676673;
 Wed, 14 Oct 2020 19:27:42 +0000 (UTC)
Date: Wed, 14 Oct 2020 20:27:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Bihong Yu <yubihong@huawei.com>
Subject: Re: [PATCH v2 2/8] migration: Don't use '#' flag of printf format
Message-ID: <20201014192740.GN2996@work-vm>
References: <1602508140-11372-1-git-send-email-yubihong@huawei.com>
 <1602508140-11372-3-git-send-email-yubihong@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1602508140-11372-3-git-send-email-yubihong@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: zhengchuan@huawei.com, quintela@redhat.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, alex.chen@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Bihong Yu (yubihong@huawei.com) wrote:
> Signed-off-by: Bihong Yu <yubihong@huawei.com>
> Reviewed-by: Chuan Zheng <zhengchuan@huawei.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/block.c | 2 +-
>  migration/ram.c   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/block.c b/migration/block.c
> index 4b8576b..273392b 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -998,7 +998,7 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>                     (addr == 100) ? '\n' : '\r');
>              fflush(stdout);
>          } else if (!(flags & BLK_MIG_FLAG_EOS)) {
> -            fprintf(stderr, "Unknown block migration flags: %#x\n", flags);
> +            fprintf(stderr, "Unknown block migration flags: 0x%x\n", flags);
>              return -EINVAL;
>          }
>          ret = qemu_file_get_error(f);
> diff --git a/migration/ram.c b/migration/ram.c
> index 433489d..6ed4f9e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3298,7 +3298,7 @@ static int ram_load_postcopy(QEMUFile *f)
>              multifd_recv_sync_main();
>              break;
>          default:
> -            error_report("Unknown combination of migration flags: %#x"
> +            error_report("Unknown combination of migration flags: 0x%x"
>                           " (postcopy mode)", flags);
>              ret = -EINVAL;
>              break;
> @@ -3576,7 +3576,7 @@ static int ram_load_precopy(QEMUFile *f)
>              if (flags & RAM_SAVE_FLAG_HOOK) {
>                  ram_control_load_hook(f, RAM_CONTROL_HOOK, NULL);
>              } else {
> -                error_report("Unknown combination of migration flags: %#x",
> +                error_report("Unknown combination of migration flags: 0x%x",
>                               flags);
>                  ret = -EINVAL;
>              }
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


