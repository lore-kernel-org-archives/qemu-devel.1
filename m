Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22047C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F368623428
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F368623428
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3lvR-0000tY-2o
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 14:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i3ltD-0008Ah-Fj
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i3ltC-0000PW-FX
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:44:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i3ltC-0000PG-AW
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:44:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 98B97C057EC0;
 Fri, 30 Aug 2019 18:44:49 +0000 (UTC)
Received: from localhost (ovpn-116-109.gru2.redhat.com [10.97.116.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4C9160872;
 Fri, 30 Aug 2019 18:44:46 +0000 (UTC)
Date: Fri, 30 Aug 2019 15:44:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190830184445.GF3694@habkost.net>
References: <20190830093056.12572-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830093056.12572-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 30 Aug 2019 18:44:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] memory: fetch pmem size in get_file_size()
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
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, Junyan He <junyan.he@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 30, 2019 at 10:30:56AM +0100, Stefan Hajnoczi wrote:
> Neither stat(2) nor lseek(2) report the size of Linux devdax pmem
> character device nodes.  Commit 314aec4a6e06844937f1677f6cba21981005f389
> ("hostmem-file: reject invalid pmem file sizes") added code to
> hostmem-file.c to fetch the size from sysfs and compare against the
> user-provided size=NUM parameter:
> 
>   if (backend->size > size) {
>       error_setg(errp, "size property %" PRIu64 " is larger than "
>                  "pmem file \"%s\" size %" PRIu64, backend->size,
>                  fb->mem_path, size);
>       return;
>   }
> 
> It turns out that exec.c:qemu_ram_alloc_from_fd() already has an
> equivalent size check but it skips devdax pmem character devices because
> lseek(2) returns 0:
> 
>   if (file_size > 0 && file_size < size) {
>       error_setg(errp, "backing store %s size 0x%" PRIx64
>                  " does not match 'size' option 0x" RAM_ADDR_FMT,
>                  mem_path, file_size, size);
>       return NULL;
>   }
> 
> This patch moves the devdax pmem file size code into get_file_size() so
> that we check the memory size in a single place:
> qemu_ram_alloc_from_fd().  This simplifies the code and makes it more
> general.
> 
> This also fixes the problem that hostmem-file only checks the devdax
> pmem file size when the pmem=on parameter is given.  An unchecked
> size=NUM parameter can lead to SIGBUS in QEMU so we must always fetch
> the file size for Linux devdax pmem character device nodes.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Paolo, do you want to queue this, or should it go through my
memory backend queue?

-- 
Eduardo

