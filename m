Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DEBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB49206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB49206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i16qq-0002P3-VY
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 06:31:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i16pg-0001XL-Jt
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i16pf-0004uy-9h
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:30:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43410)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i16pf-0004uV-41
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:30:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B1BA43091754;
 Fri, 23 Aug 2019 10:30:09 +0000 (UTC)
Received: from work-vm (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA112600CD;
 Fri, 23 Aug 2019 10:30:08 +0000 (UTC)
Date: Fri, 23 Aug 2019 11:30:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190823103006.GE2784@work-vm>
References: <20190731144225.3784-1-richardw.yang@linux.intel.com>
 <20190731144225.3784-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731144225.3784-2-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 23 Aug 2019 10:30:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] migration/qemu-file: remove check on
 writev_buffer in qemu_put_compression_data
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> The check of writev_buffer is in qemu_fflush, which means it is not
> harmful if it is NULL.
> 
> And removing it will make the code consistent since all other
> add_to_iovec() is called without the check.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

So I think the real reason here is commit 11808bb  which removed
support for non-iovec writers.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/qemu-file.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 0431585502..35c22605dd 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -717,9 +717,7 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
>      }
>  
>      qemu_put_be32(f, blen);
> -    if (f->ops->writev_buffer) {
> -        add_to_iovec(f, f->buf + f->buf_index, blen, false);
> -    }
> +    add_to_iovec(f, f->buf + f->buf_index, blen, false);
>      f->buf_index += blen;
>      if (f->buf_index == IO_BUF_SIZE) {
>          qemu_fflush(f);
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

