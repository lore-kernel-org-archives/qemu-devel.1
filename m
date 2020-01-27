Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E47C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1215E24679
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDpe6sTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1215E24679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwAKd-0004NM-AY
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 14:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iwAJx-0003i0-6D
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:45:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iwAJw-000576-3p
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:45:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50598
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iwAJv-00056J-W3
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580154315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/AxpvaK/HbbxnTlABG3Xa5o+Ezzn3iLyTQEEx+NiJ4=;
 b=GDpe6sTB+/zfSLk2S5mHXNIIY8GkhzN3oDdFnbIFV95Ckn5deafQfgFKFM2nOwHWa6gcxo
 s9p13eiRzigwsIyNU0bMvGh9iUhBlsk9lavnDB5lXgiBEKXzr99t654/Y0itvAvdH2+w2w
 DLSYXC29ZRCnswVzOHOCwrxJy4Q5g6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-aRL0ZC0MP6i4sA2bwAL_Mg-1; Mon, 27 Jan 2020 14:45:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C13858010C5
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 19:45:12 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AC928702E;
 Mon, 27 Jan 2020 19:45:06 +0000 (UTC)
Date: Mon, 27 Jan 2020 19:45:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PULL 111/111] virtiofsd: add some options to the help message
Message-ID: <20200127194504.GC3419@work-vm>
References: <20200123115841.138849-1-dgilbert@redhat.com>
 <20200123115841.138849-112-dgilbert@redhat.com>
 <m1o8upqdfv.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <m1o8upqdfv.fsf@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: aRL0ZC0MP6i4sA2bwAL_Mg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Christophe de Dinechin (dinechin@redhat.com) wrote:
>=20
> Dr. David Alan Gilbert (git) writes:
>=20
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> >
> > Add following options to the help message:
> > - cache
> > - flock|no_flock
> > - norace
> > - posix_lock|no_posix_lock
> > - readdirplus|no_readdirplus
> > - timeout
> > - writeback|no_writeback
> > - xattr|no_xattr
> >
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> >
> > dgilbert: Split cache, norace, posix_lock, readdirplus off
> >   into our own earlier patches that added the options
> >
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  tools/virtiofsd/helper.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> > index f98d8f2eb2..0801cf752c 100644
> > --- a/tools/virtiofsd/helper.c
> > +++ b/tools/virtiofsd/helper.c
> > @@ -148,6 +148,8 @@ void fuse_cmdline_help(void)
> >             "    -o cache=3D<mode>            cache mode. could be one =
of \"auto, "
> >             "always, none\"\n"
> >             "                               default: auto\n"
> > +           "    -o flock|no_flock          enable/disable flock\n"
> > +           "                               default: no_flock\n"
> >             "    -o log_level=3D<level>       log level, default to \"i=
nfo\"\n"
> >             "                               level could be one of \"deb=
ug, "
> >             "info, warn, err\"\n"
> > @@ -163,7 +165,13 @@ void fuse_cmdline_help(void)
> >             "                               enable/disable readirplus\n=
"
> >             "                               default: readdirplus except=
 with "
> >             "cache=3Dnone\n"
> > -          );
> > +           "    -o timeout=3D<number>        I/O timeout (second)\n"
>=20
> s/second/seconds/ ? (Not sure, I'm not a native speaker)

Yes, it should.

Dave

> > +           "                               default: depends on cache=
=3D option.\n"
> > +           "    -o writeback|no_writeback  enable/disable writeback ca=
che\n"
> > +           "                               default: no_writeback\n"
> > +           "    -o xattr|no_xattr          enable/disable xattr\n"
> > +           "                               default: no_xattr\n"
> > +           );
> >  }
> >
> >  static int fuse_helper_opt_proc(void *data, const char *arg, int key,
>=20
>=20
> --
> Cheers,
> Christophe de Dinechin (IRC c3d)
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


