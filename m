Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B83CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C64A20659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRt9I3cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C64A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgHM-0001Lr-C0
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNfpx-0000dr-AC
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNfpu-0006tK-96
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:19:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53958
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNfpu-0006t6-50
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571933981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HkHYyCNWQ+JbYzBu1PU9HBH1LY0GgfKVzYAYHerbarY=;
 b=CRt9I3cmIxnHRN45YQhX+aOeCSIQyh99Ee1NjjqgJk71neslPNA32zUes6nYSFEGhl+B4O
 Kct/cTPJOprCJDUAC3v2YBdCoG1f3ME1F8/RlKTKGvMn1DVOJBRvoPbn0Y54BlSsQO5a7F
 ZuzMuqhTGq1MJrMWi+6ctKC+UVZBPh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-T47ouCagORqtplRn96Srxg-1; Thu, 24 Oct 2019 12:19:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18D58107AD34;
 Thu, 24 Oct 2019 16:19:35 +0000 (UTC)
Received: from work-vm (ovpn-117-248.ams2.redhat.com [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F8555D9CA;
 Thu, 24 Oct 2019 16:19:23 +0000 (UTC)
Date: Thu, 24 Oct 2019 17:19:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 00/30] virtiofs daemon (base)
Message-ID: <20191024161921.GL2877@work-vm>
References: <20191021105832.36574-1-dgilbert@redhat.com>
 <20191024071352-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191024071352-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: T47ouCagORqtplRn96Srxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, piaojun@huawei.com, stefanha@redhat.com,
 marcandre.lureau@redhat.com, eguan@linux.alibaba.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Mon, Oct 21, 2019 at 11:58:02AM +0100, Dr. David Alan Gilbert (git) wr=
ote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Hi,
> >   This is the 1st set for the virtiofsd - a daemon
> > that implements the user space side of virtiofs.
> >=20
> >   The kernel and qemu device parts recently went in,
> > so the daemon is the only thing missing to have a working
> > set.
> >=20
> >   This set is the absolute minimal base set of patches;
> > it's not yet safe to use (from security or correctness);
> >=20
> > I'll follow up with ~3 more series in the next few days
> > with:
> >=20
> >     a) Security patches that add sandboxing and checking
> >        compared with normal fuse - that makes it safe.
> >     b) Performance improvements including threading
> >     c) Other fixes, including correctness.
> >=20
> > but, this is a good start and gets things rolling.
> >=20
> > The set pulls in a big chunk of the upstream libfuse library
> > (unmodified so that it's easy to check it really is upstream),
> > chops all the stuff out we don't need and then adds the
> > new transport we need.
> >=20
> > For new files I've formatted the code according to qemu
> > standards; for files that are from upstream libfuse
> > I've kept with their standards for ease of future updating.
>=20
> Thinking of future updates, have you given any thought to
> automating them? Something along the lines of
> update-linux-headers maybe?

The problem is we're changing the code in some of them;
libfuse changes slowly enough that rebasing on a new libfuse isn't too
bad; but once committed, just copying new versions in like update-linux-hea=
ders
does isn't going to work because we have to merge in our changes.
I expect to have to cherry-pick changes.  Libfuse has had 75 patches in
the last year; so it doesn't worry me too much.

Dave

>=20
> > We can't just link with libfuse, since we have to make ABI incompatible
> > changes for the new transport.
> >=20
> > Running this daemon is typically done with:
> >=20
> >    ./virtiofsd -o vhost_user_socket=3D/path/socket -o source=3D/path/to=
/fs
> >=20
> > connected to a qemu that's then started with:
> >    -chardev socket,id=3Dchar0,path=3D/path/socket -device vhost-user-fs=
-pci,queue-size=3D1024,chardev=3Dchar0,tag=3Dmyfs
> >=20
> > and then in the guest mount with:
> >    mount -t virtiofs myfs /mnt
> >=20
> > Our development branch is: https://gitlab.com/virtio-fs/qemu/tree/virti=
o-fs-dev
> >=20
> > Dave
> >=20
> >=20
> > Dr. David Alan Gilbert (22):
> >   virtiofsd: Pull in upstream headers
> >   virtiofsd: Pull in kernel's fuse.h
> >   virtiofsd: Add auxiliary .c's
> >   virtiofsd: Add fuse_lowlevel.c
> >   virtiofsd: Add passthrough_ll
> >   virtiofsd: Trim down imported files
> >   virtiofsd: Fix fuse_daemonize ignored return values
> >   virtiofsd: Fix common header and define for QEMU builds
> >   virtiofsd: fuse: Make iov_length usable outside fuse_lowlevel.c
> >   virtiofsd: Add options for virtio
> >   virtiofsd: Open vhost connection instead of mounting
> >   virtiofsd: Start wiring up vhost-user
> >   virtiofsd: Add main virtio loop
> >   virtiofsd: get/set features callbacks
> >   virtiofsd: Start queue threads
> >   virtiofsd: Poll kick_fd for queue
> >   virtiofsd: Start reading commands from queue
> >   virtiofsd: Send replies to messages
> >   virtiofsd: Keep track of replies
> >   virtiofsd: Add Makefile wiring for virtiofsd contrib
> >   virtiofsd: Fast path for virtio read
> >   virtiofs: Add maintainers entry
> >=20
> > Stefan Hajnoczi (7):
> >   virtiofsd: remove mountpoint dummy argument
> >   virtiofsd: remove unused notify reply support
> >   virtiofsd: add -o source=3DPATH to help output
> >   virtiofsd: add --fd=3DFDNUM fd passing option
> >   virtiofsd: make -f (foreground) the default
> >   virtiofsd: add vhost-user.json file
> >   virtiofsd: add --print-capabilities option
> >=20
> > Vivek Goyal (1):
> >   virtiofsd: Make fsync work even if only inode is passed in
> >=20
> >  .gitignore                                  |    1 +
> >  MAINTAINERS                                 |    8 +
> >  Makefile                                    |    9 +
> >  Makefile.objs                               |    1 +
> >  contrib/virtiofsd/50-qemu-virtiofsd.json.in |    5 +
> >  contrib/virtiofsd/Makefile.objs             |   10 +
> >  contrib/virtiofsd/buffer.c                  |  318 +++
> >  contrib/virtiofsd/fuse.h                    | 1268 ++++++++++
> >  contrib/virtiofsd/fuse_common.h             |  823 +++++++
> >  contrib/virtiofsd/fuse_i.h                  |  131 ++
> >  contrib/virtiofsd/fuse_kernel.h             |  858 +++++++
> >  contrib/virtiofsd/fuse_log.c                |   40 +
> >  contrib/virtiofsd/fuse_log.h                |   82 +
> >  contrib/virtiofsd/fuse_loop_mt.c            |   54 +
> >  contrib/virtiofsd/fuse_lowlevel.c           | 2302 +++++++++++++++++++
> >  contrib/virtiofsd/fuse_lowlevel.h           | 2024 ++++++++++++++++
> >  contrib/virtiofsd/fuse_misc.h               |   59 +
> >  contrib/virtiofsd/fuse_opt.c                |  422 ++++
> >  contrib/virtiofsd/fuse_opt.h                |  271 +++
> >  contrib/virtiofsd/fuse_signals.c            |   90 +
> >  contrib/virtiofsd/fuse_virtio.c             |  717 ++++++
> >  contrib/virtiofsd/fuse_virtio.h             |   33 +
> >  contrib/virtiofsd/helper.c                  |  300 +++
> >  contrib/virtiofsd/passthrough_helpers.h     |   76 +
> >  contrib/virtiofsd/passthrough_ll.c          | 1341 +++++++++++
> >  docs/interop/vhost-user.json                |    4 +-
> >  26 files changed, 11246 insertions(+), 1 deletion(-)
> >  create mode 100644 contrib/virtiofsd/50-qemu-virtiofsd.json.in
> >  create mode 100644 contrib/virtiofsd/Makefile.objs
> >  create mode 100644 contrib/virtiofsd/buffer.c
> >  create mode 100644 contrib/virtiofsd/fuse.h
> >  create mode 100644 contrib/virtiofsd/fuse_common.h
> >  create mode 100644 contrib/virtiofsd/fuse_i.h
> >  create mode 100644 contrib/virtiofsd/fuse_kernel.h
> >  create mode 100644 contrib/virtiofsd/fuse_log.c
> >  create mode 100644 contrib/virtiofsd/fuse_log.h
> >  create mode 100644 contrib/virtiofsd/fuse_loop_mt.c
> >  create mode 100644 contrib/virtiofsd/fuse_lowlevel.c
> >  create mode 100644 contrib/virtiofsd/fuse_lowlevel.h
> >  create mode 100644 contrib/virtiofsd/fuse_misc.h
> >  create mode 100644 contrib/virtiofsd/fuse_opt.c
> >  create mode 100644 contrib/virtiofsd/fuse_opt.h
> >  create mode 100644 contrib/virtiofsd/fuse_signals.c
> >  create mode 100644 contrib/virtiofsd/fuse_virtio.c
> >  create mode 100644 contrib/virtiofsd/fuse_virtio.h
> >  create mode 100644 contrib/virtiofsd/helper.c
> >  create mode 100644 contrib/virtiofsd/passthrough_helpers.h
> >  create mode 100644 contrib/virtiofsd/passthrough_ll.c
> >=20
> > --=20
> > 2.23.0
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


