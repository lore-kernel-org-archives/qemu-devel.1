Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D417C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0992339D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0992339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Qau-0005QN-6F
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 04:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i5QZb-0004yk-3E
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i5QZY-0001bn-U0
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:23:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36756)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i5QZY-0001bM-LV
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:23:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 97B5B307D976;
 Wed,  4 Sep 2019 08:23:23 +0000 (UTC)
Received: from redhat.com (ovpn-112-33.ams2.redhat.com [10.36.112.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A561160127;
 Wed,  4 Sep 2019 08:23:01 +0000 (UTC)
Date: Wed, 4 Sep 2019 09:22:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Message-ID: <20190904082258.GC19582@redhat.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <51220007b0f8a34cc72ff2847f5deb1f85c9c0e4.1567534653.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51220007b0f8a34cc72ff2847f5deb1f85c9c0e4.1567534653.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 04 Sep 2019 08:23:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v3 PATCH 07/45] multi-process: define
 proxy-link object
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, mst@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 john.g.johnson@oracle.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 03, 2019 at 04:37:33PM -0400, Jagannathan Raman wrote:
> Defines proxy-link object which forms the communication link between
> QEMU & emulation program.
> Adds functions to configure members of proxy-link object instance.
> Adds functions to send and receive messages over the communication
> channel.
> Adds GMainLoop to handle events received on the communication channel.
> 
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  v1 -> v2:
>    - Use default context for main loop instead of a new context
> 
>  v2 -> v3:
>    - Enabled multi-channel support in the communication link
> 
>  include/glib-compat.h   |   4 +
>  include/io/proxy-link.h | 147 ++++++++++++++++++++++++
>  io/Makefile.objs        |   2 +
>  io/proxy-link.c         | 292 ++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 445 insertions(+)
>  create mode 100644 include/io/proxy-link.h
>  create mode 100644 io/proxy-link.c
> 
> diff --git a/include/glib-compat.h b/include/glib-compat.h
> index 1291628..6189b9a 100644
> --- a/include/glib-compat.h
> +++ b/include/glib-compat.h
> @@ -19,12 +19,16 @@
>  /* Ask for warnings for anything that was marked deprecated in
>   * the defined version, or before. It is a candidate for rewrite.
>   */
> +#ifndef GLIB_VERSION_MIN_REQUIRED
>  #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40
> +#endif
>  
>  /* Ask for warnings if code tries to use function that did not
>   * exist in the defined version. These risk breaking builds
>   */
> +#ifndef GLIB_VERSION_MAX_ALLOWED
>  #define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_40
> +#endif

This does not look good. This header can only be included
once thanks to the #ifndef QEMU_GLIB_COMPAT_H. So the fact
that you need these conditionals is a hint of a bug elsewhere
in the code related to glib usage.


> diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
> new file mode 100644
> index 0000000..ee78cdd
> --- /dev/null
> +++ b/include/io/proxy-link.h
> @@ -0,0 +1,147 @@
> +/*
> + * Communication channel between QEMU and remote device process
> + *
> + * Copyright 2019, Oracle and/or its affiliates.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef PROXY_LINK_H
> +#define PROXY_LINK_H
> +
> +#include <stddef.h>
> +#include <stdint.h>
> +#include <glib.h>

I'm guessing this is the cause - nothing should be including this
directly - it is pulled  in for you via qemu/osdep.h

> +#include <pthread.h>
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +#include "qemu/thread.h"

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

