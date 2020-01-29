Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3426DC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7B820716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCKgKiKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7B820716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwlaD-0005dX-7C
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 06:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iwlZC-0004sH-0p
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iwlZA-0000kL-DX
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:31:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25409
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iwlZA-0000gM-7T
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580297487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4T9xPb2L3vn9a4CtQLZSaWjYvlXzoqB00Yfv9VspmU=;
 b=dCKgKiKYU0HDP1NTkwCEQnostSb57P56X9vE32EdxCN5B266yYnm/lxUo5a+QIFf5ly0vf
 v564e0ewMuiuDIu5dY1FRBoJO+L3h33btvum0Bz17DofkAZ99nCIJY4pYh0VYm8k9yV3oC
 yksmXYfMFncHP932T74CrbXziA7Sfuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-gMNq90R8NP2hoqi_KdBRxQ-1; Wed, 29 Jan 2020 06:31:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A782A1800D41;
 Wed, 29 Jan 2020 11:31:22 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CEE060BE0;
 Wed, 29 Jan 2020 11:31:15 +0000 (UTC)
Message-ID: <f0576992600c9be2f2644ec1086c0b921d3fc741.camel@redhat.com>
Subject: Re: [PATCH v3 03/13] monitor/hmp: rename device-hotplug.c to
 block/monitor/block-hmp-cmds.c
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Wed, 29 Jan 2020 13:31:15 +0200
In-Reply-To: <87lfpq7ef2.fsf@dusky.pond.sub.org>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-4-mlevitsk@redhat.com>
 <20200128165606.GU3215@work-vm>
 <b8acc4b96e1016e0cae454d8e5980474b4e01374.camel@redhat.com>
 <87lfpq7ef2.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: gMNq90R8NP2hoqi_KdBRxQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-01-29 at 11:19 +0100, Markus Armbruster wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> 
> > On Tue, 2020-01-28 at 16:56 +0000, Dr. David Alan Gilbert wrote:
> > > * Maxim Levitsky (mlevitsk@redhat.com) wrote:
> > > > These days device-hotplug.c only contains the hmp_drive_add
> > > > In the next patch, rest of hmp_drive* functions will be moved
> > > > there.
> > > > 
> > > > Also change the license of that file to GPL2+ since most
> > > > of the code that will be moved there is under that license
> > > 
> > > How do we check that's OK?
> > 
> > Currently that code is BSD licensed, and in next patches I will move
> > here GPLv2+ code, and as far as I know combining them gives you GPLv2+
> 
> Yes, it does.
> 
> I'd change the license in the patch that moves in GPLv2+ code.

All right.
> 
> > I wasn't even aware that we have mixed licenses, and so this change was done
> > after Markus pointed this out in the previous patchset review.
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > > 
> > > > Also add block-hmp-commands.h to contain prototypes of these
> > > > functions
> > > > 
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  MAINTAINERS                                   |  1 +
> > > >  Makefile.objs                                 |  2 +-
> > > >  block/Makefile.objs                           |  1 +
> > > >  block/monitor/Makefile.objs                   |  1 +
> > > >  .../monitor/block-hmp-cmds.c                  | 23 ++++---------------
> > > >  include/block/block-hmp-commands.h            |  8 +++++++
> > > >  include/sysemu/sysemu.h                       |  3 ---
> > > >  monitor/misc.c                                |  1 +
> > > >  8 files changed, 18 insertions(+), 22 deletions(-)
> > > >  create mode 100644 block/monitor/Makefile.objs
> > > >  rename device-hotplug.c => block/monitor/block-hmp-cmds.c (55%)
> > > >  create mode 100644 include/block/block-hmp-commands.h
> > > > 
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index f6511d5120..5d50d09ad8 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -1882,6 +1882,7 @@ Block QAPI, monitor, command line
> > > >  M: Markus Armbruster <armbru@redhat.com>
> > > >  S: Supported
> > > >  F: blockdev.c
> > > > +F: blockdev-hmp-cmds.c
> > > >  F: block/qapi.c
> > > >  F: qapi/block*.json
> > > >  F: qapi/transaction.json
> > > > diff --git a/Makefile.objs b/Makefile.objs
> > > > index ff396b9209..15209eb6b5 100644
> > > > --- a/Makefile.objs
> > > > +++ b/Makefile.objs
> > > > @@ -48,7 +48,7 @@ common-obj-y += dump/
> > > >  common-obj-y += job-qmp.o
> > > >  common-obj-y += monitor/
> > > >  common-obj-y += net/
> > > > -common-obj-y += qdev-monitor.o device-hotplug.o
> > > > +common-obj-y += qdev-monitor.o
> > > >  common-obj-$(CONFIG_WIN32) += os-win32.o
> > > >  common-obj-$(CONFIG_POSIX) += os-posix.o
> > > >  
> > > > diff --git a/block/Makefile.objs b/block/Makefile.objs
> > > > index 330529b0b7..3f65544a6b 100644
> > > > --- a/block/Makefile.objs
> > > > +++ b/block/Makefile.objs
> > > > @@ -44,6 +44,7 @@ block-obj-y += crypto.o
> > > >  block-obj-y += aio_task.o
> > > >  block-obj-y += backup-top.o
> > > >  block-obj-y += filter-compress.o
> > > > +common-obj-y += monitor/
> > > >  
> > > >  common-obj-y += stream.o
> > > >  
> > > > diff --git a/block/monitor/Makefile.objs b/block/monitor/Makefile.objs
> > > > new file mode 100644
> > > > index 0000000000..0a74f9a8b5
> > > > --- /dev/null
> > > > +++ b/block/monitor/Makefile.objs
> > > > @@ -0,0 +1 @@
> > > > +common-obj-y += block-hmp-cmds.o
> > > > diff --git a/device-hotplug.c b/block/monitor/block-hmp-cmds.c
> > > > similarity index 55%
> > > > rename from device-hotplug.c
> > > > rename to block/monitor/block-hmp-cmds.c
> > > > index 554e4d98db..c65aaa86ea 100644
> > > > --- a/device-hotplug.c
> > > > +++ b/block/monitor/block-hmp-cmds.c
> > > > @@ -1,25 +1,11 @@
> > > >  /*
> > > > - * QEMU device hotplug helpers
> > > > + * Blockdev HMP commands
> > > >   *
> > > >   * Copyright (c) 2004 Fabrice Bellard
> > > >   *
> > > > - * Permission is hereby granted, free of charge, to any person obtaining a copy
> > > > - * of this software and associated documentation files (the "Software"), to deal
> > > > - * in the Software without restriction, including without limitation the rights
> > > > - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > > > - * copies of the Software, and to permit persons to whom the Software is
> > > > - * furnished to do so, subject to the following conditions:
> > > > - *
> > > > - * The above copyright notice and this permission notice shall be included in
> > > > - * all copies or substantial portions of the Software.
> > > > - *
> > > > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > > > - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > > - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > > > - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > > > - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > > > - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > > > - * THE SOFTWARE.
> > > > + * This work is licensed under the terms of the GNU GPL, version 2.
> > > > + * or (at your option) any later version.
> > > > + * See the COPYING file in the top-level directory.
> > > >   */
> > > >  
> > > >  #include "qemu/osdep.h"
> > > > @@ -33,6 +19,7 @@
> > > >  #include "sysemu/sysemu.h"
> > > >  #include "monitor/monitor.h"
> > > >  #include "block/block_int.h"
> > > > +#include "block/block-hmp-commands.h"
> > > >  
> > > >  
> > > >  void hmp_drive_add(Monitor *mon, const QDict *qdict)
> > > > diff --git a/include/block/block-hmp-commands.h b/include/block/block-hmp-commands.h
> > > > new file mode 100644
> > > > index 0000000000..4f9033a8a6
> > > > --- /dev/null
> > > > +++ b/include/block/block-hmp-commands.h
> > > > @@ -0,0 +1,8 @@
> > > > +#ifndef BLOCK_HMP_COMMANDS_H
> > > > +#define BLOCK_HMP_COMMANDS_H
> > > > +
> > > > +/* HMP commands related to the block layer*/
> 
> Space before */, please.
No problem!
> 
> > > Should this file get a copyright header as well?
> 
> I think it should.
I'll add. GPLv2+ too I guess.
> 
> > > > +
> > > > +void hmp_drive_add(Monitor *mon, const QDict *qdict);
> > > > +
> > > > +#endif
> > > > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > > > index 80c57fdc4e..c48635666d 100644
> > > > --- a/include/sysemu/sysemu.h
> > > > +++ b/include/sysemu/sysemu.h
> > > > @@ -68,9 +68,6 @@ extern int nb_option_roms;
> > > >  extern const char *prom_envs[MAX_PROM_ENVS];
> > > >  extern unsigned int nb_prom_envs;
> > > >  
> > > > -/* generic hotplug */
> > > > -void hmp_drive_add(Monitor *mon, const QDict *qdict);
> > > > -
> > > >  /* pcie aer error injection */
> > > >  void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict);
> > > >  
> > > > diff --git a/monitor/misc.c b/monitor/misc.c
> > > > index de1ca4d114..0466c00830 100644
> > > > --- a/monitor/misc.c
> > > > +++ b/monitor/misc.c
> > > > @@ -79,6 +79,7 @@
> > > >  #include "sysemu/cpus.h"
> > > >  #include "qemu/cutils.h"
> > > >  #include "tcg/tcg.h"
> > > > +#include "block/block-hmp-commands.h"
> 
> Put this next to #include "block/qapi.h", please.
Also no problem!
> 
> > > >  
> > > >  #if defined(TARGET_S390X)
> > > >  #include "hw/s390x/storage-keys.h"
> > > > -- 
> > > > 2.17.2
> > > > 
> 
> Preferably with my nitpicks addressed:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thank you very much for the review.
Best regards,
	Maxim Levitsky



