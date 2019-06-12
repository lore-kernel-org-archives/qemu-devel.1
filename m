Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C2DC31E48
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4092020874
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4092020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb2N4-0007vW-Hv
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 08:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47100)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hb24u-0001pv-3D
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hb1t4-0000v1-11
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 07:57:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36234)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hb1t2-0000ri-Lg; Wed, 12 Jun 2019 07:57:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5DB0E3004425;
 Wed, 12 Jun 2019 11:57:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BBF6614C4;
 Wed, 12 Jun 2019 11:57:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 90E571138648; Wed, 12 Jun 2019 13:57:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-7-kwolf@redhat.com>
Date: Wed, 12 Jun 2019 13:57:43 +0200
In-Reply-To: <20190611134043.9524-7-kwolf@redhat.com> (Kevin Wolf's message of
 "Tue, 11 Jun 2019 15:40:38 +0200")
Message-ID: <874l4v2eyw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 12 Jun 2019 11:57:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 06/11] Move monitor.c to monitor/misc.c
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
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Create a new monitor/ subdirectory and move monitor.c there. As the plan
> is to move the monitor core into separate files, use the chance to
> rename it to misc.c.

I figure we'll want to move most of (all of?) monitor/misc.c out.  Not a
job this series must finish, of course.

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  docs/devel/writing-qmp-commands.txt |  2 +-
>  monitor.c => monitor/misc.c         |  2 +-
>  MAINTAINERS                         |  4 ++--
>  Makefile.objs                       |  1 +
>  Makefile.target                     |  3 ++-
>  monitor/Makefile.objs               |  1 +
>  monitor/trace-events                | 11 +++++++++++
>  trace-events                        | 10 ----------
>  8 files changed, 19 insertions(+), 15 deletions(-)
>  rename monitor.c => monitor/misc.c (99%)
>  create mode 100644 monitor/Makefile.objs
>  create mode 100644 monitor/trace-events
>
> diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp-commands.txt
> index 9dfc62bf5a..cc6ecd6d5d 100644
> --- a/docs/devel/writing-qmp-commands.txt
> +++ b/docs/devel/writing-qmp-commands.txt
> @@ -470,7 +470,7 @@ it's good practice to always check for errors.
>  
>  Another important detail is that HMP's "info" commands don't go into the
>  hmp-commands.hx. Instead, they go into the info_cmds[] table, which is defined
> -in the monitor.c file. The entry for the "info alarmclock" follows:
> +in the monitor/misc.c file. The entry for the "info alarmclock" follows:

Not this patch's fault, but this is wrong since commit da76ee76f78 (Sep
2015).

Funny, the one place that provides advice on writing HMP commands is
called writing-qmp-commands.txt %-}

>  
>      {
>          .name       = "alarmclock",

[...]

Reviewed-by: Markus Armbruster <armbru@redhat.com>

