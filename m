Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,HK_RANDOM_REPLYTO,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD9BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5E820663
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5E820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNwVY-0003yo-Hp
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <baiyaowei@cmss.chinamobile.com>) id 1iNwHY-0007Ey-HG
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <baiyaowei@cmss.chinamobile.com>) id 1iNwHW-0001vP-6P
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:53:20 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:10072)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <baiyaowei@cmss.chinamobile.com>)
 id 1iNwHM-0001mZ-PL; Fri, 25 Oct 2019 05:53:10 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by
 rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5db2c5f0487-60880;
 Fri, 25 Oct 2019 17:52:48 +0800 (CST)
X-RM-TRANSID: 2eec5db2c5f0487-60880
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[112.25.65.41])
 by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65db2c5ee910-bff0d;
 Fri, 25 Oct 2019 17:52:48 +0800 (CST)
X-RM-TRANSID: 2ee65db2c5ee910-bff0d
Date: Fri, 25 Oct 2019 17:53:08 +0800
From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
To: pbonzini@redhat.com, fam@euphon.net, dillaman@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com
Subject: Re: [PATCH 3/4] hw/scsi: add SCSI COMPARE_AND_WRITE support
Message-ID: <20191025095308.GA28031@byw>
References: <1571996163-27688-1-git-send-email-baiyaowei@cmss.chinamobile.com>
 <1571996163-27688-4-git-send-email-baiyaowei@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571996163-27688-4-git-send-email-baiyaowei@cmss.chinamobile.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.81
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
Reply-To: baiyaowei@cmss.chinamobile.com
Cc: baiyaowei@cmss.chinamobile.com, yangjun@cmss.chinamobile.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 25, 2019 at 05:36:01PM +0800, Yaowei Bai wrote:
>  
> diff --git a/include/tcmu/tcmu.h b/include/tcmu/tcmu.h
> new file mode 100644
> index 0000000..656a545
> --- /dev/null
> +++ b/include/tcmu/tcmu.h
> @@ -0,0 +1,14 @@
> +#ifndef QEMU_TCMU_H
> +#define QEMU_TCMU_H
> +
> +#include "qemu-common.h"
> +
> +typedef struct TCMUExport TCMUExport;
> +extern QemuOptsList qemu_tcmu_export_opts;
> +
> +void qemu_tcmu_stop(void);
> +void qemu_tcmu_start(const char *subtype, Error **errp);
> +TCMUExport *tcmu_export_new(BlockBackend *blk, bool writable, Error **errp);
> +int export_init_func(void *opaque, QemuOpts *all_opts, Error **errp);
> +
> +#endif

Please ignore this odd part.

> -- 
> 1.8.3.1
> 



