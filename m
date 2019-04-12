Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615DCC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 18:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361D320663
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 18:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361D320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41195 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF16W-0003lW-Gt
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 14:40:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hF15d-0003OR-U5
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hF15c-0006md-U3
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:39:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hF15c-0006m6-Kg
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:39:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD670821C6
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 18:39:51 +0000 (UTC)
Received: from work-vm (unknown [10.36.117.255])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C7075D9CD;
	Fri, 12 Apr 2019 18:39:49 +0000 (UTC)
Date: Fri, 12 Apr 2019 19:39:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190412183946.GS2906@work-vm>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-18-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411152520.10061-18-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 12 Apr 2019 18:39:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 17/17] include: Move fprintf_function to
 disas/
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412183947.w8vCRqbCgZWteJovY-Hdn2R1JRWJHjzh22Go3NpDqYU@z>

* Markus Armbruster (armbru@redhat.com) wrote:
> The previous commits have eliminated fprintf_function outside
> disassemblers, simplifying code and cleaning up the ugly type-punning
> fprintf_function seems to attract.  Move fprintf_function to
> include/disas/dis-asm.h to reduce the temptation to abuse it.
> 
> I considered renaming it to fprintf_ftype (reverting that part of
> commit 6e2d864edf5, v0.14.0) to get us closer to binutils, but I
> figure the fork is too distant to make this worthwhile.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

I'm OKish with this - although it's the only place we currently
use it, it's a fairly common concept, so I'm not sure it's worth
banishing.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/disas/dis-asm.h   |  5 +++--
>  include/qemu/fprintf-fn.h | 14 --------------
>  2 files changed, 3 insertions(+), 16 deletions(-)
>  delete mode 100644 include/qemu/fprintf-fn.h
> 
> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
> index 41b61c85f9..9240ec32c2 100644
> --- a/include/disas/dis-asm.h
> +++ b/include/disas/dis-asm.h
> @@ -9,8 +9,6 @@
>  #ifndef DISAS_BFD_H
>  #define DISAS_BFD_H
>  
> -#include "qemu/fprintf-fn.h"
> -
>  typedef void *PTR;
>  typedef uint64_t bfd_vma;
>  typedef int64_t bfd_signed_vma;
> @@ -243,6 +241,9 @@ typedef struct symbol_cache_entry
>      } udata;
>  } asymbol;
>  
> +typedef int (*fprintf_function)(FILE *f, const char *fmt, ...)
> +    GCC_FMT_ATTR(2, 3);
> +
>  enum dis_insn_type {
>    dis_noninsn,			/* Not a valid instruction */
>    dis_nonbranch,		/* Not a branch instruction */
> diff --git a/include/qemu/fprintf-fn.h b/include/qemu/fprintf-fn.h
> deleted file mode 100644
> index 9068a960b3..0000000000
> --- a/include/qemu/fprintf-fn.h
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -/*
> - * Typedef for fprintf-alike function pointers.
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or later.
> - * See the COPYING file in the top-level directory.
> - */
> -
> -#ifndef QEMU_FPRINTF_FN_H
> -#define QEMU_FPRINTF_FN_H
> -
> -typedef int (*fprintf_function)(FILE *f, const char *fmt, ...)
> -    GCC_FMT_ATTR(2, 3);
> -
> -#endif
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

