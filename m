Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7D8C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4971C208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4971C208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb28e-0004Qo-Fl
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 08:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46888)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hb24b-0001X9-H3
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hb1x8-0005dj-00
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:02:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hb1x5-0005b8-IJ; Wed, 12 Jun 2019 08:02:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A6245D5E6;
 Wed, 12 Jun 2019 12:02:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CD3E5D968;
 Wed, 12 Jun 2019 12:01:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB54E1138648; Wed, 12 Jun 2019 14:01:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-8-kwolf@redhat.com>
Date: Wed, 12 Jun 2019 14:01:55 +0200
In-Reply-To: <20190611134043.9524-8-kwolf@redhat.com> (Kevin Wolf's message of
 "Tue, 11 Jun 2019 15:40:39 +0200")
Message-ID: <87wohr107g.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 12 Jun 2019 12:02:01 +0000 (UTC)
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
Cc: dgilbert@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Now that we have a monitor/ subdirectory, let's move hmp.c and qmp.c
> from the root directory there. As they contain implementations of
> monitor commands, rename them to {hmp,qmp}-cmds.c, so that {hmp,qmp}.c
> are free for the HMP and QMP infrastructure.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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

Not this patch's fault: the "All" is wrong, and the entire sentence is
bad English.

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

Move hmp.h to include/monitor/ ?

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

Reviewed-by: Markus Armbruster <armbru@redhat.com>

