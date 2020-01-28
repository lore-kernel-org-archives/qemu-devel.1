Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8AFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A738F214D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIGhhm/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A738F214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWu9-0005Au-Tn
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iwWXm-0006f7-0S
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iwWXj-00059q-Er
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:29:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48763
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iwWXj-00056C-9T
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580239734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4TW3r9XunmmDmkXdxI6cpLpQwPiy82gpoQBGqC+gQIk=;
 b=KIGhhm/pzyHX33H+2mpw36vnFWELQAoBvHZwAaIfJl2KkqTIRAtrntzEDdZLPduEW7NERu
 xzeoAjHC5MxgTT1PRRdn0NPceYNfRzH1aSeIIpy/nrCKAju78Yv9xSLVOM4x0bDdB1iQEH
 Zrsykaw4u3XshbFxvErR+7CefBlIXac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-TjnBIIBxPUSf8tqCTLx-iw-1; Tue, 28 Jan 2020 14:28:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FB291800D41;
 Tue, 28 Jan 2020 19:28:52 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 858A9396;
 Tue, 28 Jan 2020 19:28:48 +0000 (UTC)
Message-ID: <b8acc4b96e1016e0cae454d8e5980474b4e01374.camel@redhat.com>
Subject: Re: [PATCH v3 03/13] monitor/hmp: rename device-hotplug.c to
 block/monitor/block-hmp-cmds.c
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Date: Tue, 28 Jan 2020 21:28:47 +0200
In-Reply-To: <20200128165606.GU3215@work-vm>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-4-mlevitsk@redhat.com>
 <20200128165606.GU3215@work-vm>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: TjnBIIBxPUSf8tqCTLx-iw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-01-28 at 16:56 +0000, Dr. David Alan Gilbert wrote:
> * Maxim Levitsky (mlevitsk@redhat.com) wrote:
> > These days device-hotplug.c only contains the hmp_drive_add
> > In the next patch, rest of hmp_drive* functions will be moved
> > there.
> > 
> > Also change the license of that file to GPL2+ since most
> > of the code that will be moved there is under that license
> 
> How do we check that's OK?

Currently that code is BSD licensed, and in next patches I will move
here GPLv2+ code, and as far as I know combining them gives you GPLv2+

I wasn't even aware that we have mixed licenses, and so this change was done
after Markus pointed this out in the previous patchset review.

Best regards,
	Maxim Levitsky

> 
> > Also add block-hmp-commands.h to contain prototypes of these
> > functions
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  MAINTAINERS                                   |  1 +
> >  Makefile.objs                                 |  2 +-
> >  block/Makefile.objs                           |  1 +
> >  block/monitor/Makefile.objs                   |  1 +
> >  .../monitor/block-hmp-cmds.c                  | 23 ++++---------------
> >  include/block/block-hmp-commands.h            |  8 +++++++
> >  include/sysemu/sysemu.h                       |  3 ---
> >  monitor/misc.c                                |  1 +
> >  8 files changed, 18 insertions(+), 22 deletions(-)
> >  create mode 100644 block/monitor/Makefile.objs
> >  rename device-hotplug.c => block/monitor/block-hmp-cmds.c (55%)
> >  create mode 100644 include/block/block-hmp-commands.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f6511d5120..5d50d09ad8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1882,6 +1882,7 @@ Block QAPI, monitor, command line
> >  M: Markus Armbruster <armbru@redhat.com>
> >  S: Supported
> >  F: blockdev.c
> > +F: blockdev-hmp-cmds.c
> >  F: block/qapi.c
> >  F: qapi/block*.json
> >  F: qapi/transaction.json
> > diff --git a/Makefile.objs b/Makefile.objs
> > index ff396b9209..15209eb6b5 100644
> > --- a/Makefile.objs
> > +++ b/Makefile.objs
> > @@ -48,7 +48,7 @@ common-obj-y += dump/
> >  common-obj-y += job-qmp.o
> >  common-obj-y += monitor/
> >  common-obj-y += net/
> > -common-obj-y += qdev-monitor.o device-hotplug.o
> > +common-obj-y += qdev-monitor.o
> >  common-obj-$(CONFIG_WIN32) += os-win32.o
> >  common-obj-$(CONFIG_POSIX) += os-posix.o
> >  
> > diff --git a/block/Makefile.objs b/block/Makefile.objs
> > index 330529b0b7..3f65544a6b 100644
> > --- a/block/Makefile.objs
> > +++ b/block/Makefile.objs
> > @@ -44,6 +44,7 @@ block-obj-y += crypto.o
> >  block-obj-y += aio_task.o
> >  block-obj-y += backup-top.o
> >  block-obj-y += filter-compress.o
> > +common-obj-y += monitor/
> >  
> >  common-obj-y += stream.o
> >  
> > diff --git a/block/monitor/Makefile.objs b/block/monitor/Makefile.objs
> > new file mode 100644
> > index 0000000000..0a74f9a8b5
> > --- /dev/null
> > +++ b/block/monitor/Makefile.objs
> > @@ -0,0 +1 @@
> > +common-obj-y += block-hmp-cmds.o
> > diff --git a/device-hotplug.c b/block/monitor/block-hmp-cmds.c
> > similarity index 55%
> > rename from device-hotplug.c
> > rename to block/monitor/block-hmp-cmds.c
> > index 554e4d98db..c65aaa86ea 100644
> > --- a/device-hotplug.c
> > +++ b/block/monitor/block-hmp-cmds.c
> > @@ -1,25 +1,11 @@
> >  /*
> > - * QEMU device hotplug helpers
> > + * Blockdev HMP commands
> >   *
> >   * Copyright (c) 2004 Fabrice Bellard
> >   *
> > - * Permission is hereby granted, free of charge, to any person obtaining a copy
> > - * of this software and associated documentation files (the "Software"), to deal
> > - * in the Software without restriction, including without limitation the rights
> > - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > - * copies of the Software, and to permit persons to whom the Software is
> > - * furnished to do so, subject to the following conditions:
> > - *
> > - * The above copyright notice and this permission notice shall be included in
> > - * all copies or substantial portions of the Software.
> > - *
> > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > - * THE SOFTWARE.
> > + * This work is licensed under the terms of the GNU GPL, version 2.
> > + * or (at your option) any later version.
> > + * See the COPYING file in the top-level directory.
> >   */
> >  
> >  #include "qemu/osdep.h"
> > @@ -33,6 +19,7 @@
> >  #include "sysemu/sysemu.h"
> >  #include "monitor/monitor.h"
> >  #include "block/block_int.h"
> > +#include "block/block-hmp-commands.h"
> >  
> >  
> >  void hmp_drive_add(Monitor *mon, const QDict *qdict)
> > diff --git a/include/block/block-hmp-commands.h b/include/block/block-hmp-commands.h
> > new file mode 100644
> > index 0000000000..4f9033a8a6
> > --- /dev/null
> > +++ b/include/block/block-hmp-commands.h
> > @@ -0,0 +1,8 @@
> > +#ifndef BLOCK_HMP_COMMANDS_H
> > +#define BLOCK_HMP_COMMANDS_H
> > +
> > +/* HMP commands related to the block layer*/
> 
> Should this file get a copyright header as well?
> 
> > +
> > +void hmp_drive_add(Monitor *mon, const QDict *qdict);
> > +
> > +#endif
> > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > index 80c57fdc4e..c48635666d 100644
> > --- a/include/sysemu/sysemu.h
> > +++ b/include/sysemu/sysemu.h
> > @@ -68,9 +68,6 @@ extern int nb_option_roms;
> >  extern const char *prom_envs[MAX_PROM_ENVS];
> >  extern unsigned int nb_prom_envs;
> >  
> > -/* generic hotplug */
> > -void hmp_drive_add(Monitor *mon, const QDict *qdict);
> > -
> >  /* pcie aer error injection */
> >  void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict);
> >  
> > diff --git a/monitor/misc.c b/monitor/misc.c
> > index de1ca4d114..0466c00830 100644
> > --- a/monitor/misc.c
> > +++ b/monitor/misc.c
> > @@ -79,6 +79,7 @@
> >  #include "sysemu/cpus.h"
> >  #include "qemu/cutils.h"
> >  #include "tcg/tcg.h"
> > +#include "block/block-hmp-commands.h"
> >  
> >  #if defined(TARGET_S390X)
> >  #include "hw/s390x/storage-keys.h"
> > -- 
> > 2.17.2
> > 
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



