Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E212C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638BD21835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBLooOK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638BD21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuIPB-0005MM-AE
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 10:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuIOD-0004kn-2j
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuIOB-00059C-0q
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:57:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42963
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuIOA-00057t-Ln
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579708673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JWpPGji3kgFRsMhOFA7oPbh0Zz6YotJqMdLGGrFDmI=;
 b=EBLooOK7JJWpg14W0+U2Sfg4kiKUgBLrzWrkkbiTxJhlcLyN77czGs55V5gaTTDW+MM9/6
 HlhrkmA01+tCfBUoEg4nIOEVRSEAuYZiLA3GjpX4sRMa4auDgq4RvMzKlKlD3amp5hHyQM
 fg8hnJ5rOhwlZjXTwwdIrULOOV9ND0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-jFZFRUmzNrWnDpeEb2Ihxg-1; Wed, 22 Jan 2020 10:57:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8C7B1005516;
 Wed, 22 Jan 2020 15:57:49 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F71F9CA3;
 Wed, 22 Jan 2020 15:57:40 +0000 (UTC)
Date: Wed, 22 Jan 2020 15:57:38 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 062/109] virtiofsd: Add timestamp to the log with
 FUSE_LOG_DEBUG level
Message-ID: <20200122155738.GK3263@work-vm>
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-63-dgilbert@redhat.com>
 <5e3fca8d-446a-d550-c53e-a805b452248d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5e3fca8d-446a-d550-c53e-a805b452248d@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: jFZFRUmzNrWnDpeEb2Ihxg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
> On 1/21/20 1:23 PM, Dr. David Alan Gilbert (git) wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> >=20
> > virtiofsd has some threads, so we see a lot of logs with debug option.
> > It would be useful for debugging if we can see the timestamp.
> >=20
> > Add nano second timestamp, which got by get_clock(), to the log with
> > FUSE_LOG_DEBUG level if the syslog option isn't set.
> >=20
> > The log is like as:
> >=20
> >    ]# ./virtiofsd -d -o vhost_user_socket=3D/tmp/vhostqemu0 -o source=
=3D/tmp/share0 -o cache=3Dauto
>=20
> First ']' is incorrect copy/pasting?

Oops yes, removed.

> >    ...
> >    [5365943125463727] [ID: 00000002] fv_queue_thread: Start for queue 0=
 kick_fd 9
> >    [5365943125568644] [ID: 00000002] fv_queue_thread: Waiting for Queue=
 0 event
> >    [5365943125573561] [ID: 00000002] fv_queue_thread: Got queue event o=
n Queue 0
> >=20
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > ---
> >   tools/virtiofsd/passthrough_ll.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index 991de69334..a7fb34ac0c 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -35,6 +35,8 @@
> >    * \include passthrough_ll.c
> >    */
> > +#include "qemu/osdep.h"
>=20
> I think this include belongs to patch #011 "virtiofsd: Fix common header =
and
> define for QEMU builds".

Moved.

> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20

Thanks.

> > +#include "qemu/timer.h"
> >   #include "fuse_virtio.h"
> >   #include "fuse_log.h"
> >   #include "fuse_lowlevel.h"
> > @@ -2275,7 +2277,13 @@ static void log_func(enum fuse_log_level level, =
const char *fmt, va_list ap)
> >       }
> >       if (current_log_level =3D=3D FUSE_LOG_DEBUG) {
> > -        localfmt =3D g_strdup_printf("[ID: %08ld] %s", syscall(__NR_ge=
ttid), fmt);
> > +        if (!use_syslog) {
> > +            localfmt =3D g_strdup_printf("[%" PRId64 "] [ID: %08ld] %s=
",
> > +                                       get_clock(), syscall(__NR_getti=
d), fmt);
> > +        } else {
> > +            localfmt =3D g_strdup_printf("[ID: %08ld] %s", syscall(__N=
R_gettid),
> > +                                       fmt);
> > +        }
> >           fmt =3D localfmt;
> >       }
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


