Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D19C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8FA21569
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hnirh4Lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8FA21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuJJV-0000r2-My
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 11:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuJFa-0005gg-EE
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuJFZ-0003Hh-3C
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:53:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36458
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuJFX-0003H8-VT
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579711983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nl60tMkMWTmkl514bfUwD82Jdd+BVhv50Yt5eJOGbjM=;
 b=Hnirh4Lx5ntWzbh/8VBC/2C9vK23nOJQX7Z3vKmNhcSgJlZIBQ+qphsbeFYBEthKzjwjTs
 vwwMYIlQAuVrMrXwnk3iPotR16TVUawfUjDI1zu90lPcbnaSq/mZtyUi4KGqnUvXNZ0GtQ
 Kwh+QpJTJZ6VLiVCqG8oabYQWLneTLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-l62P5GqaOimUKawXiiAAtw-1; Wed, 22 Jan 2020 11:52:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C038107B27E;
 Wed, 22 Jan 2020 16:52:58 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D05D19C69;
 Wed, 22 Jan 2020 16:52:45 +0000 (UTC)
Date: Wed, 22 Jan 2020 16:52:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 011/109] virtiofsd: Fix common header and define for
 QEMU builds
Message-ID: <20200122165243.GN3263@work-vm>
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-12-dgilbert@redhat.com>
 <8bf51480-fdef-14b5-2d4f-0068fa94e808@redhat.com>
 <f4d282dc-5de9-c3c8-f0e4-ff40a576a7a3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f4d282dc-5de9-c3c8-f0e4-ff40a576a7a3@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: l62P5GqaOimUKawXiiAAtw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: m.mizuma@jp.fujitsu.com, berrange@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, misono.tomohiro@jp.fujitsu.com, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> On 1/21/20 4:24 PM, Philippe Mathieu-Daud=E9 wrote:
> > On 1/21/20 1:22 PM, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >=20
> > > All of the fuse files include config.h and define GNU_SOURCE
> > > where we don't have either under our build - remove them.
> > > Fixup path to the kernel's fuse.h in the QEMUs world.
> > >=20
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---
> > > =A0 tools/virtiofsd/buffer.c=A0=A0=A0=A0=A0=A0=A0=A0 | 3 ---
> > > =A0 tools/virtiofsd/fuse_i.h=A0=A0=A0=A0=A0=A0=A0=A0 | 3 +++
> > > =A0 tools/virtiofsd/fuse_lowlevel.c=A0 | 5 +----
> > > =A0 tools/virtiofsd/fuse_opt.c=A0=A0=A0=A0=A0=A0 | 1 -
> > > =A0 tools/virtiofsd/fuse_signals.c=A0=A0 | 1 -
> > > =A0 tools/virtiofsd/passthrough_ll.c | 7 +------
> > > =A0 6 files changed, 5 insertions(+), 15 deletions(-)
> > >=20
> > > diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
> > > index 5df946c82c..db1885ab19 100644
> > > --- a/tools/virtiofsd/buffer.c
> > > +++ b/tools/virtiofsd/buffer.c
> > > @@ -9,9 +9,6 @@
> > > =A0=A0 * See the file COPYING.LIB
> > > =A0=A0 */
> > > -#define _GNU_SOURCE
> > > -
> > > -#include "config.h"
> > > =A0 #include "fuse_i.h"
> > > =A0 #include "fuse_lowlevel.h"
> > > =A0 #include <assert.h>
> > > diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
> > > index e63cb58388..bae06992e0 100644
> > > --- a/tools/virtiofsd/fuse_i.h
> > > +++ b/tools/virtiofsd/fuse_i.h
> > > @@ -6,6 +6,9 @@
> > > =A0=A0 * See the file COPYING.LIB
> > > =A0=A0 */
> > > +#define FUSE_USE_VERSION 31
> > > +
> > > +
> > > =A0 #include "fuse.h"
> > > =A0 #include "fuse_lowlevel.h"
> > > diff --git a/tools/virtiofsd/fuse_lowlevel.c
> > > b/tools/virtiofsd/fuse_lowlevel.c
> > > index b3d26cab66..f76f3d3fdc 100644
> > > --- a/tools/virtiofsd/fuse_lowlevel.c
> > > +++ b/tools/virtiofsd/fuse_lowlevel.c
> > > @@ -9,11 +9,8 @@
> > > =A0=A0 * See the file COPYING.LIB
> > > =A0=A0 */
> > > -#define _GNU_SOURCE
> > > -
> > > -#include "config.h"
> > > =A0 #include "fuse_i.h"
> > > -#include "fuse_kernel.h"
> > > +#include "standard-headers/linux/fuse.h"
> > > =A0 #include "fuse_misc.h"
> > > =A0 #include "fuse_opt.h"
> > > diff --git a/tools/virtiofsd/fuse_opt.c b/tools/virtiofsd/fuse_opt.c
> > > index edd36f4a3b..1fee55e266 100644
> > > --- a/tools/virtiofsd/fuse_opt.c
> > > +++ b/tools/virtiofsd/fuse_opt.c
> > > @@ -10,7 +10,6 @@
> > > =A0=A0 */
> > > =A0 #include "fuse_opt.h"
> > > -#include "config.h"
> > > =A0 #include "fuse_i.h"
> > > =A0 #include "fuse_misc.h"
> > > diff --git a/tools/virtiofsd/fuse_signals.c
> > > b/tools/virtiofsd/fuse_signals.c
> > > index 19d6791cb9..10a6f88088 100644
> > > --- a/tools/virtiofsd/fuse_signals.c
> > > +++ b/tools/virtiofsd/fuse_signals.c
> > > @@ -8,7 +8,6 @@
> > > =A0=A0 * See the file COPYING.LIB
> > > =A0=A0 */
> > > -#include "config.h"
> > > =A0 #include "fuse_i.h"
> > > =A0 #include "fuse_lowlevel.h"
> > > diff --git a/tools/virtiofsd/passthrough_ll.c
> > > b/tools/virtiofsd/passthrough_ll.c
> > > index 9377718d9d..e702f7dec6 100644
> > > --- a/tools/virtiofsd/passthrough_ll.c
> > > +++ b/tools/virtiofsd/passthrough_ll.c
> > > @@ -35,15 +35,10 @@
> > > =A0=A0 * \include passthrough_ll.c
> > > =A0=A0 */
> > > -#define _GNU_SOURCE
> > > -#define FUSE_USE_VERSION 31
> > > -
> > > -#include "config.h"
> > > -
> > > +#include "fuse_lowlevel.h"
> > > =A0 #include <assert.h>
> > > =A0 #include <dirent.h>
> > > =A0 #include <errno.h>
> > > -#include <fuse_lowlevel.h>
> > > =A0 #include <inttypes.h>
> > > =A0 #include <limits.h>
> > > =A0 #include <pthread.h>
> > >=20
> >=20
> > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> Shouldn't these files include "qemu/osdep.h" first, like the rest of the
> QEMU C files?

Done.

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


