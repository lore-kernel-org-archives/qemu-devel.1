Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C99BC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A75A208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A75A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51448 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKFN-0002Ez-Mq
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46429)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hZHuT-000755-Ph
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hZHuR-0002MN-Pr
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:40:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hZHuK-00025u-Lc; Fri, 07 Jun 2019 12:40:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D737730C407A;
 Fri,  7 Jun 2019 16:39:53 +0000 (UTC)
Received: from work-vm (ovpn-116-24.ams2.redhat.com [10.36.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BA4C10A4B3D;
 Fri,  7 Jun 2019 16:39:30 +0000 (UTC)
Date: Fri, 7 Jun 2019 17:39:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190607163927.GQ2631@work-vm>
References: <20190607135430.22149-1-kwolf@redhat.com>
 <20190607135430.22149-7-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607135430.22149-7-kwolf@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 07 Jun 2019 16:39:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 06/10] Move monitor.c to monitor/misc.c
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kevin Wolf (kwolf@redhat.com) wrote:
> Create a new monitor/ subdirectory and move monitor.c there. As the plan
> is to move the monitor core into separate files, use the chance to
> rename it to misc.c.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  monitor.c => monitor/misc.c | 0
>  Makefile.target             | 3 ++-
>  monitor/Makefile.objs       | 1 +

This patch should probably also create monitor/trace-events
and move those events with it.

Dave

>  3 files changed, 3 insertions(+), 1 deletion(-)
>  rename monitor.c => monitor/misc.c (100%)
>  create mode 100644 monitor/Makefile.objs
> 
> diff --git a/monitor.c b/monitor/misc.c
> similarity index 100%
> rename from monitor.c
> rename to monitor/misc.c
> diff --git a/Makefile.target b/Makefile.target
> index ecd856e3a3..72c267f7dc 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -148,9 +148,10 @@ endif #CONFIG_BSD_USER
>  #########################################################
>  # System emulator target
>  ifdef CONFIG_SOFTMMU
> -obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
> +obj-y += arch_init.o cpus.o gdbstub.o balloon.o ioport.o numa.o
>  obj-y += qtest.o
>  obj-y += hw/
> +obj-y += monitor/
>  obj-y += qapi/
>  obj-y += memory.o
>  obj-y += memory_mapping.o
> diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
> new file mode 100644
> index 0000000000..e783b0616b
> --- /dev/null
> +++ b/monitor/Makefile.objs
> @@ -0,0 +1 @@
> +obj-y += misc.o
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

