Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08578C10F14
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 10:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19EF20870
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 10:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19EF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50830 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDRdq-0007vH-39
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 06:36:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hDRd2-0007Vm-Ai
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hDRd1-0000Ry-AK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:35:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hDRd0-0000RW-UI
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:35:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C9E687649;
	Mon,  8 Apr 2019 10:35:50 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 86983679DD;
	Mon,  8 Apr 2019 10:35:46 +0000 (UTC)
Date: Mon, 8 Apr 2019 12:35:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Catherine Ho <catherine.hecx@gmail.com>
Message-ID: <20190408123542.1a4de426@redhat.com>
In-Reply-To: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
References: <1554689945-18619-1-git-send-email-catherine.hecx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 08 Apr 2019 10:35:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hostmem-file: warn when
 memory-backend-file, share=on and in incoming migration
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
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408103542.Bs9xEZajBZ2S1A84kspvlXaa5Kuz00-E3APeG_Ib8m4@z>

On Sun,  7 Apr 2019 22:19:05 -0400
Catherine Ho <catherine.hecx@gmail.com> wrote:

> Currently it is not forbidden to use "-object memory-backend-file,share=on"
> and together with "-incoming". But after incoming migration is finished,
> the memory-backend-file will be definitely written if share=on. So the
> memory-backend-file can only be used once, but failed in the 2nd time
> incoming.
> 
> Thus it gives a warning and the users can run the qemu if they really
> want to do it.

Shouldn't we add a migration blocker in such a case instead of warning
and letting qemu run wild?


> Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> ---
>  backends/hostmem-file.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 37ac6445d2..59429ee0b4 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -16,6 +16,7 @@
>  #include "sysemu/hostmem.h"
>  #include "sysemu/sysemu.h"
>  #include "qom/object_interfaces.h"
> +#include "migration/migration.h"
>  
>  /* hostmem-file.c */
>  /**
> @@ -79,6 +80,16 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>          }
>      }
>  
> +    /*
> +     * In ignore shared case, if share=on for host memory backend file,
> +     * the ram might be written after incoming process is finished. Thus
> +     * the memory backend can't be reused for 2nd/3rd... incoming
> +     */
> +    if (backend->share && migrate_ignore_shared()
> +                       && runstate_check(RUN_STATE_INMIGRATE))
> +        warn_report("share=on for memory backend file might be "
> +                        "conflicted with incoming in ignore shared case");
> +
>      backend->force_prealloc = mem_prealloc;
>      name = host_memory_backend_get_name(backend);
>      memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),


