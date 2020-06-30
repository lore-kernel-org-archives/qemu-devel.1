Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9D4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C572068F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLiJX5bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C572068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFvj-0002CR-I2
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqFv3-0001QV-AV
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:03:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40476
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqFv1-0000n4-HQ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593522202;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=tcyFQ/3OOmzgDduD4M6R95G6K4AD0YENT6gDYfzC+fg=;
 b=XLiJX5bfQftGLO0rWcgEqMxCV1yo9XsxhHDxRdT5bQrRasdVthJz1eDEXz0sFJ00HMWZTs
 ktNurXcw4jaDYR2uLQUPhCmM9G7eLN3PQsvcyZgg9CPJc7axyPSrDhElevcC2JsnTd0hya
 NderADfRxHprOZm62MHs3OfGrS6WuHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-XNcYTsTIN7uOZwVDYAm0Zw-1; Tue, 30 Jun 2020 09:03:13 -0400
X-MC-Unique: XNcYTsTIN7uOZwVDYAm0Zw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5472106B217;
 Tue, 30 Jun 2020 13:03:12 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C05082B472;
 Tue, 30 Jun 2020 13:03:00 +0000 (UTC)
Date: Tue, 30 Jun 2020 14:02:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v2 2/3] trace: Add support for recorder back-end
Message-ID: <20200630130257.GP1370404@redhat.com>
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200626162706.3304357-3-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200626162706.3304357-3-dinechin@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 06:27:05PM +0200, Christophe de Dinechin wrote:
> The recorder library provides support for low-cost continuous
> recording of events, which can then be replayed. This makes it
> possible to collect data "after the fact",for example to show the
> events that led to a crash.
> 
> Recorder support in qemu is implemented using the existing tracing
> interface. In addition, it is possible to individually enable
> recorders that are not traces, although this is probably not
> recommended.
> 
> HMP COMMAND:
> The 'recorder' hmp command has been added, which supports two
> sub-commands:
> - recorder dump: Dump the current state of the recorder. You can
> - recorder trace: Set traces using the recorder_trace_set() syntax.
>   You can use "recorder trace help" to list all available recorders.
> 
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  configure                             |  5 +++
>  hmp-commands.hx                       | 19 ++++++++--
>  monitor/misc.c                        | 27 ++++++++++++++
>  scripts/tracetool/backend/recorder.py | 51 +++++++++++++++++++++++++++
>  trace/Makefile.objs                   |  2 ++
>  trace/control.c                       |  7 ++++
>  trace/recorder.c                      | 22 ++++++++++++
>  trace/recorder.h                      | 34 ++++++++++++++++++
>  util/module.c                         |  8 +++++
>  9 files changed, 173 insertions(+), 2 deletions(-)
>  create mode 100644 scripts/tracetool/backend/recorder.py
>  create mode 100644 trace/recorder.c
>  create mode 100644 trace/recorder.h

> +RECORDER_CONSTRUCTOR
> +void recorder_trace_init(void)
> +{
> +    recorder_trace_set(getenv("RECORDER_TRACES"));
> +
> +    // Allow a dump in case we receive some unhandled signal
> +    // For example, send USR2 to a hung process to get a dump
> +    if (getenv("RECORDER_TRACES"))
> +        recorder_dump_on_common_signals(0,0);
> +}

What is the syntax of this RECORDER_TRACES env variable, and perhaps
more importantly should we have this modelled as a command line arg
instead of an env variable. We've generally been aiming to get rid
of env variables and have QAPI modelled CLI. QAPI modelling would be
particularly important if we want to expose the ablity to change
settings on the fly via QMP.


> diff --git a/trace/recorder.h b/trace/recorder.h
> new file mode 100644
> index 0000000000..00b11a2d2f
> --- /dev/null
> +++ b/trace/recorder.h
> @@ -0,0 +1,34 @@
> +/*
> + * Recorder-based trace backend
> + *
> + * Copyright Red Hat 2020
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.

Why "version 2" (only), instead of "version 2 or later" ? QEMU generally
expects the latter for any new code, unless it is derived from existing
v2-only code in QEMU.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


