Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B27AC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 17:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6803D2070C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 17:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6803D2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5vlC-0006Hp-F1
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 13:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i5vka-0005p5-HU
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 13:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i5vkZ-0003is-AB
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 13:40:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42132)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i5vkZ-0003iG-2Y
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 13:40:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 38D7F2D7E1;
 Thu,  5 Sep 2019 17:40:50 +0000 (UTC)
Received: from work-vm (ovpn-117-197.ams2.redhat.com [10.36.117.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55EB560E3E;
 Thu,  5 Sep 2019 17:40:24 +0000 (UTC)
Date: Thu, 5 Sep 2019 18:40:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190905174021.GR2700@work-vm>
References: <20190905152136.30637-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905152136.30637-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 05 Sep 2019 17:40:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 0/3] virtiofsd: get/set log level via DBus
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
Cc: virtio-fs@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Eryu Guan <eguan@linux.alibaba.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> It is likely that virtiofsd will need to support "management commands" for
> reconfiguring it at runtime.  The first use case was proposed by Eryu Guan for
> getting/setting the current log level.
> 
> I promised to try out DBus as the management interface because it has a rich
> feature set and is accessible from most programming languages.  It should be
> able to support all the use cases we come up with.
> 
> This patch series is a prototype that implements the get-log-level and
> set-log-level management commands via DBus.  Use the new virtiofsctl tool to
> talk to a running virtiofsd process:
> 
>   # dbus-run-session ./virtiofsd ...
>   ...
>   Using dbus address unix:abstract=/tmp/dbus-H9WBbpjk3O,guid=0be16acefb868e6025a8737f5d7124d2
>   # export DBUS_SESSION_BUS_ADDRESS=unix:abstract=/tmp/dbus-H9WBbpjk3O,guid=0be16acefb868e6025a8737f5d7124d2
>   # ./virtiofsctl set-log-level err
> 
> Most of the work is done by gdbus-codegen(1).  It generates code for the
> org.qemu.Virtiofsd.xml interface definition.  Our code can use the simple
> virtiofsd_get/set_log_level() APIs and it will make corresponding DBus calls.
> 
> I'm pretty happy with this approach because the code is straightforward.  It
> hasn't even triggered seccomp failures yet :).

Yes it's less complex than I'd worried.
Now, I do think we've got to think about how qemu in general is going to
use dbus as people were discussing it, because then we have to think
what the security aspects are - do we need to look at some calls only
available to some clients etc.

Dave

> Error handling is a little problematic.  I noticed that virtiofsctl silently
> returns success even if it cannot talk to virtiofsd.  This is due to the code
> generated by gdbus-codegen(1) which has no error reporting :(.  This can be
> solved by writing more low-level GDBus code instead of using the high-level
> generated bindings.
> 
> What do you think about this approach?
> 
> Stefan Hajnoczi (3):
>   virtiofsd: add org.qemu.Virtiofsd interface
>   virtiofsd: add DBus server to handle log level changes
>   virtiofsd: add virtiofsctl command-line management tool
> 
>  configure                                |   7 +
>  Makefile                                 |  16 +++
>  Makefile.objs                            |   1 +
>  contrib/virtiofsd/Makefile.objs          |  10 +-
>  contrib/virtiofsd/dbus.h                 |   9 ++
>  contrib/virtiofsd/dbus.c                 | 162 +++++++++++++++++++++++
>  contrib/virtiofsd/passthrough_ll.c       |   8 +-
>  contrib/virtiofsd/virtiofsctl.c          |  55 ++++++++
>  .gitignore                               |   1 +
>  contrib/virtiofsd/org.qemu.Virtiofsd.xml |   7 +
>  10 files changed, 274 insertions(+), 2 deletions(-)
>  create mode 100644 contrib/virtiofsd/dbus.h
>  create mode 100644 contrib/virtiofsd/dbus.c
>  create mode 100644 contrib/virtiofsd/virtiofsctl.c
>  create mode 100644 contrib/virtiofsd/org.qemu.Virtiofsd.xml
> 
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

