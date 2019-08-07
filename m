Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F72C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C9321E6E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C9321E6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIJq-00027R-4t
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57742)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hvIJ0-0001g6-7m
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hvIIz-0000oy-7B
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:32:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hvIIz-0000oS-1z
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:32:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E337307BCC4
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 09:32:24 +0000 (UTC)
Received: from localhost (ovpn-117-144.ams2.redhat.com [10.36.117.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4C215D9E1;
 Wed,  7 Aug 2019 09:32:23 +0000 (UTC)
Date: Wed, 7 Aug 2019 10:32:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190807093222.GE13267@stefanha-x1.localdomain>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-8-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806151435.10740-8-armbru@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 07 Aug 2019 09:32:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 07/29] trace: Do not include qom/cpu.h
 into generated trace.h
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 06, 2019 at 05:14:13PM +0200, Markus Armbruster wrote:
> docs/devel/tracing.txt explains "since many source files include
> trace.h, [the generated trace.h use] a minimum of types and other
> header files included to keep the namespace clean and compile times
> and dependencies down."
> 
> Commit 4815185902 "trace: Add per-vCPU tracing states for events with
> the 'vcpu' property" made them all include qom/cpu.h via
> control-internal.h.  qom/cpu.h in turn includes about thirty headers.
> Ouch.
> 
> Per-vCPU tracing is currently not supported in sub-directories'
> trace-events.  In other words, qom/cpu.h can only be used in
> trace-root.h, not in any trace.h.
> 
> Split trace/control-vcpu.h off trace/control.h and
> trace/control-internal.h.  Have the generated trace.h include
> trace/control.h (which no longer includes qom/cpu.h), and trace-root.h
> include trace/control-vcpu.h (which includes it).
> 
> The resulting improvement is a bit disappointing: in my "build
> everything" tree, some 1100 out of 6600 objects (not counting tests
> and objects that don't depend on qemu/osdep.h) depend on a trace.h,
> and about 600 of them no longer depend on qom/cpu.h.  But more than
> 1300 others depend on trace-root.h.  More work is clearly needed.
> Left for another day.
> 
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/block-backend.c         |  1 +
>  qom/object.c                  |  1 +
>  scripts/tracetool/format/c.py |  1 +
>  scripts/tracetool/format/h.py |  7 +++-
>  trace/control-internal.h      | 25 --------------
>  trace/control-vcpu.h          | 63 +++++++++++++++++++++++++++++++++++
>  trace/control.h               | 24 -------------
>  trace/qmp.c                   |  2 +-
>  ui/vnc.c                      |  1 +
>  9 files changed, 74 insertions(+), 51 deletions(-)
>  create mode 100644 trace/control-vcpu.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

