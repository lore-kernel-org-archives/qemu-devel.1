Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8B1C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF342083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF342083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45584 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdthz-0003wH-VD
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52931)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hdtgj-0002q9-2E
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hdtgg-0008NE-Lw
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:49:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36158)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hdtge-0008LH-FU
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:48:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7326BC1EB1EE
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 09:48:55 +0000 (UTC)
Received: from work-vm (ovpn-117-203.ams2.redhat.com [10.36.117.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70ED9608A7;
 Thu, 20 Jun 2019 09:48:54 +0000 (UTC)
Date: Thu, 20 Jun 2019 10:48:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190620094851.GC2907@work-vm>
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-4-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619201050.19040-4-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 20 Jun 2019 09:48:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 03/17] hmp: Move hmp.h to include/monitor/
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hmp.h => include/monitor/hmp.h | 0
>  monitor/hmp-cmds.c             | 2 +-
>  monitor/misc.c                 | 2 +-
>  target/i386/monitor.c          | 2 +-
>  target/nios2/monitor.c         | 2 +-
>  target/ppc/monitor.c           | 2 +-
>  target/sh4/monitor.c           | 2 +-
>  target/sparc/monitor.c         | 2 +-
>  target/xtensa/monitor.c        | 2 +-
>  9 files changed, 8 insertions(+), 8 deletions(-)
>  rename hmp.h => include/monitor/hmp.h (100%)
> 
> diff --git a/hmp.h b/include/monitor/hmp.h
> similarity index 100%
> rename from hmp.h
> rename to include/monitor/hmp.h
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index c283dde0e9..5082fcd016 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -14,7 +14,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "hmp.h"
> +#include "monitor/hmp.h"
>  #include "net/net.h"
>  #include "net/eth.h"
>  #include "chardev/char.h"
> diff --git a/monitor/misc.c b/monitor/misc.c
> index bf9faceb86..2fb6896e84 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -56,13 +56,13 @@
>  #include "qom/object_interfaces.h"
>  #include "trace/control.h"
>  #include "monitor/hmp-target.h"
> +#include "monitor/hmp.h"
>  #ifdef CONFIG_TRACE_SIMPLE
>  #include "trace/simple.h"
>  #endif
>  #include "exec/memory.h"
>  #include "exec/exec-all.h"
>  #include "qemu/option.h"
> -#include "hmp.h"
>  #include "qemu/thread.h"
>  #include "block/qapi.h"
>  #include "qapi/qapi-commands.h"
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 56e2dbece7..1f3b532fc2 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -26,11 +26,11 @@
>  #include "cpu.h"
>  #include "monitor/monitor.h"
>  #include "monitor/hmp-target.h"
> +#include "monitor/hmp.h"
>  #include "qapi/qmp/qdict.h"
>  #include "hw/i386/pc.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/sev.h"
> -#include "hmp.h"
>  #include "qapi/error.h"
>  #include "sev_i386.h"
>  #include "qapi/qapi-commands-misc.h"
> diff --git a/target/nios2/monitor.c b/target/nios2/monitor.c
> index d5e3393716..6646836df5 100644
> --- a/target/nios2/monitor.c
> +++ b/target/nios2/monitor.c
> @@ -25,7 +25,7 @@
>  #include "cpu.h"
>  #include "monitor/monitor.h"
>  #include "monitor/hmp-target.h"
> -#include "hmp.h"
> +#include "monitor/hmp.h"
>  
>  void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  {
> diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
> index 7f8360d903..a5a177d717 100644
> --- a/target/ppc/monitor.c
> +++ b/target/ppc/monitor.c
> @@ -27,7 +27,7 @@
>  #include "monitor/monitor.h"
>  #include "qemu/ctype.h"
>  #include "monitor/hmp-target.h"
> -#include "hmp.h"
> +#include "monitor/hmp.h"
>  
>  static target_long monitor_get_ccr(const struct MonitorDef *md, int val)
>  {
> diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
> index 4c7f36c9cc..918a5ccfc6 100644
> --- a/target/sh4/monitor.c
> +++ b/target/sh4/monitor.c
> @@ -25,7 +25,7 @@
>  #include "cpu.h"
>  #include "monitor/monitor.h"
>  #include "monitor/hmp-target.h"
> -#include "hmp.h"
> +#include "monitor/hmp.h"
>  
>  static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
>  {
> diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
> index 3ec3b51a3d..a7ea287cbc 100644
> --- a/target/sparc/monitor.c
> +++ b/target/sparc/monitor.c
> @@ -25,7 +25,7 @@
>  #include "cpu.h"
>  #include "monitor/monitor.h"
>  #include "monitor/hmp-target.h"
> -#include "hmp.h"
> +#include "monitor/hmp.h"
>  
>  
>  void hmp_info_tlb(Monitor *mon, const QDict *qdict)
> diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
> index cf7957bb63..608173c238 100644
> --- a/target/xtensa/monitor.c
> +++ b/target/xtensa/monitor.c
> @@ -25,7 +25,7 @@
>  #include "cpu.h"
>  #include "monitor/monitor.h"
>  #include "monitor/hmp-target.h"
> -#include "hmp.h"
> +#include "monitor/hmp.h"
>  
>  void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  {
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

