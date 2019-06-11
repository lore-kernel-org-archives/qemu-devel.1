Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E38C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF1E2086D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF1E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60872 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hajic-0000O1-G3
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 12:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41687)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hajLn-0008Vb-VB
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hajLm-0007NA-0M
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:10:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hajLh-0007FI-RK; Tue, 11 Jun 2019 12:10:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C7153092675;
 Tue, 11 Jun 2019 16:10:08 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8EF860BF1;
 Tue, 11 Jun 2019 16:10:00 +0000 (UTC)
Date: Tue, 11 Jun 2019 17:09:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190611160957.GG2777@work-vm>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-8-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611134043.9524-8-kwolf@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 11 Jun 2019 16:10:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 07/11] monitor: Move {hmp,
 qmp}.c to monitor/{hmp, qmp}-cmds.c
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kevin Wolf (kwolf@redhat.com) wrote:
> Now that we have a monitor/ subdirectory, let's move hmp.c and qmp.c
> from the root directory there. As they contain implementations of
> monitor commands, rename them to {hmp,qmp}-cmds.c, so that {hmp,qmp}.c
> are free for the HMP and QMP infrastructure.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  docs/devel/writing-qmp-commands.txt | 9 +++++----
>  hmp.c => monitor/hmp-cmds.c         | 2 +-
>  qmp.c => monitor/qmp-cmds.c         | 2 +-
>  MAINTAINERS                         | 5 +++--
>  Makefile.objs                       | 2 +-
>  monitor/Makefile.objs               | 1 +
>  6 files changed, 12 insertions(+), 9 deletions(-)
>  rename hmp.c => monitor/hmp-cmds.c (99%)
>  rename qmp.c => monitor/qmp-cmds.c (99%)
> 
> diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp-commands.txt
> index cc6ecd6d5d..46a6c48683 100644
> --- a/docs/devel/writing-qmp-commands.txt
> +++ b/docs/devel/writing-qmp-commands.txt
> @@ -20,7 +20,7 @@ new QMP command.
>  
>  2. Write the QMP command itself, which is a regular C function. Preferably,
>     the command should be exported by some QEMU subsystem. But it can also be
> -   added to the qmp.c file
> +   added to the monitor/qmp-cmds.c file
>  
>  3. At this point the command can be tested under the QMP protocol
>  
> @@ -101,7 +101,8 @@ protocol data.
>  
>  The next step is to write the "hello-world" implementation. As explained
>  earlier, it's preferable for commands to live in QEMU subsystems. But
> -"hello-world" doesn't pertain to any, so we put its implementation in qmp.c:
> +"hello-world" doesn't pertain to any, so we put its implementation in
> +monitor/qmp-cmds.c:
>  
>  void qmp_hello_world(Error **errp)
>  {
> @@ -146,7 +147,7 @@ for mandatory arguments). Finally, 'str' is the argument's type, which
>  stands for "string". The QAPI also supports integers, booleans, enumerations
>  and user defined types.
>  
> -Now, let's update our C implementation in qmp.c:
> +Now, let's update our C implementation in monitor/qmp-cmds.c:
>  
>  void qmp_hello_world(bool has_message, const char *message, Error **errp)
>  {
> @@ -267,7 +268,7 @@ monitor (HMP).
>  
>  With the introduction of the QAPI, HMP commands make QMP calls. Most of the
>  time HMP commands are simple wrappers. All HMP commands implementation exist in
> -the hmp.c file.
> +the monitor/hmp-cmds.c file.
>  
>  Here's the implementation of the "hello-world" HMP command:
>  
> diff --git a/hmp.c b/monitor/hmp-cmds.c
> similarity index 99%
> rename from hmp.c
> rename to monitor/hmp-cmds.c
> index 99414cd39c..712737cd18 100644
> --- a/hmp.c
> +++ b/monitor/hmp-cmds.c
> @@ -1,5 +1,5 @@
>  /*
> - * Human Monitor Interface
> + * Human Monitor Interface commands
>   *
>   * Copyright IBM, Corp. 2011
>   *
> diff --git a/qmp.c b/monitor/qmp-cmds.c
> similarity index 99%
> rename from qmp.c
> rename to monitor/qmp-cmds.c
> index fa1b3c1577..65520222ca 100644
> --- a/qmp.c
> +++ b/monitor/qmp-cmds.c
> @@ -1,5 +1,5 @@
>  /*
> - * QEMU Management Protocol
> + * QEMU Management Protocol commands
>   *
>   * Copyright IBM, Corp. 2011
>   *
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10c082314c..8789c82e5c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1925,7 +1925,8 @@ Human Monitor (HMP)
>  M: Dr. David Alan Gilbert <dgilbert@redhat.com>
>  S: Maintained
>  F: monitor/misc.c
> -F: hmp.[ch]
> +F: monitor/hmp*
> +F: hmp.h
>  F: hmp-commands*.hx
>  F: include/monitor/hmp-target.h
>  F: tests/test-hmp.c
> @@ -2045,7 +2046,7 @@ F: tests/check-qom-proplist.c
>  QMP
>  M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
> -F: qmp.c
> +F: monitor/qmp*
>  F: monitor/misc.c
>  F: docs/devel/*qmp-*
>  F: docs/interop/*qmp-*
> diff --git a/Makefile.objs b/Makefile.objs
> index dd39a70b48..9495fcbc7e 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -83,8 +83,8 @@ common-obj-$(CONFIG_FDT) += device_tree.o
>  ######################################################################
>  # qapi
>  
> -common-obj-y += qmp.o hmp.o
>  common-obj-y += qapi/
> +common-obj-y += monitor/
>  endif
>  
>  #######################################################################
> diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
> index e783b0616b..a7170af6e1 100644
> --- a/monitor/Makefile.objs
> +++ b/monitor/Makefile.objs
> @@ -1 +1,2 @@
>  obj-y += misc.o
> +common-obj-y += qmp-cmds.o hmp-cmds.o
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

