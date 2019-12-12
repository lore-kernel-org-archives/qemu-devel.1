Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3191C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680CD21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0i5zRWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680CD21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRWY-0006Z3-1z
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRUj-0004nj-HB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRUg-0000f1-Uo
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42708
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRUg-0000cj-PS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XT88oaFDH5/YkfRHJPFkhJwNQkvAjADeLx3eV2Wyf6c=;
 b=g0i5zRWPVU2PRT8VGgf789pEluEmyRTB4aIcoMaGFS87cKUiZVutsMxdVaQWDYclq8VfE9
 F8sjolSaQ3xdHMbOxpr+vbvFyqX6y9csgjcOjJQYKhrTZVB29Lf7ofWCE7eBZFGKiG7ued
 zHf6VwKulY0MDvRzz6unhfLmvNCFd80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-IV6PI5WhOlG2S50jHu7Cng-1; Thu, 12 Dec 2019 11:39:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0738E800D41
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70DB860BE1;
 Thu, 12 Dec 2019 16:39:07 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 000/104] virtiofs daemon [all]
Date: Thu, 12 Dec 2019 16:37:20 +0000
Message-Id: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: IV6PI5WhOlG2S50jHu7Cng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This is a full set for virtiofsd - a daemon
that implements the user space side of virtiofs.

Unlike my previous post, this is a full set rather
than split up into base/security etc.

The set pulls in a big chunk of the upstream libfuse library
(unmodified so that it's easy to check it really is upstream),
chops all the stuff out we don't need and then adds the
new transport we need.

I've formatted everything into qemu's code style - using indent
and the clang tools for the files I've imported.  I've cleared all
reviewed-by's given how much I've rebased and tweeked it.

We can't just link with libfuse, since we have to make ABI incompatible
changes for the new transport and it's quite invasive; the library is
designed to be the basis for multiple filesystems, but all on the same
transport.

Running this daemon is typically done with:

   ./virtiofsd -o vhost_user_socket=3D/path/socket -o source=3D/path/to/fs

connected to a qemu that's then started with:
   -chardev socket,id=3Dchar0,path=3D/path/socket -device vhost-user-fs-pci=
,queue-size=3D1024,chardev=3Dchar0,tag=3Dmyfs

and then in the guest mount with:
   mount -t virtiofs myfs /mnt

Our development branch is: https://gitlab.com/virtio-fs/qemu/tree/virtio-fs=
-dev

This code is going into tools/virtiofsd  based on the previous long
discussion.
It relies on Paolo's 'build: rename CONFIG_LIBCAP to
CONFIG_LIBCAP_NG' patch.

Breakdown:
  Patches 1..12: Importing upstream libfuse
         13..31: Basic wiring to get vhost transport
         32..56: Security changes
         57..  : Individual fixes

Thank you to all those who have contributed code.

Dave

Dr. David Alan Gilbert (34):
  virtiofsd: Pull in upstream headers
  virtiofsd: Pull in kernel's fuse.h
  virtiofsd: Add auxiliary .c's
  virtiofsd: Add fuse_lowlevel.c
  virtiofsd: Add passthrough_ll
  virtiofsd: Trim down imported files
  virtiofsd: Format imported files to qemu style
  virtiofsd: Fix fuse_daemonize ignored return values
  virtiofsd: Fix common header and define for QEMU builds
  virtiofsd: Trim out compatibility code
  virtiofsd: Add options for virtio
  virtiofsd: Open vhost connection instead of mounting
  virtiofsd: Start wiring up vhost-user
  virtiofsd: Add main virtio loop
  virtiofsd: get/set features callbacks
  virtiofsd: Start queue threads
  virtiofsd: Poll kick_fd for queue
  virtiofsd: Start reading commands from queue
  virtiofsd: Send replies to messages
  virtiofsd: Keep track of replies
  virtiofsd: Add Makefile wiring for virtiofsd contrib
  virtiofsd: Fast path for virtio read
  virtiofs: Add maintainers entry
  virtiofsd: Plumb fuse_bufvec through to do_write_buf
  virtiofsd: Pass write iov's all the way through
  virtiofsd: cap-ng helpers
  virtiofsd: Handle reinit
  virtiofsd: Handle hard reboot
  virtiofsd: Kill threads when queues are stopped
  vhost-user: Print unexpected slave message types
  contrib/libvhost-user: Protect slave fd with mutex
  virtiofsd: Clean up inodes on destroy
  libvhost-user: Fix some memtable remap cases
  virtiofsd: Convert lo_destroy to take the lo->mutex lock itself

Eric Ren (1):
  virtiofsd: fix incorrect error handling in lo_do_lookup

Eryu Guan (2):
  virtiofsd: print log only when priority is high enough
  virtiofsd: convert more fprintf and perror to use fuse log infra

Jiufei Xue (1):
  virtiofsd: support nanosecond resolution for file timestamp

Liu Bo (6):
  virtiofsd: fix error handling in main()
  virtiofsd: cleanup allocated resource in se
  virtiofsd: fix memory leak on lo.source
  virtiofsd: add helper for lo_data cleanup
  virtiofsd: enable PARALLEL_DIROPS during INIT
  Virtiofsd: fix memory leak on fuse queueinfo

Masayoshi Mizuma (3):
  virtiofsd: Add ID to the log with FUSE_LOG_DEBUG level
  virtiofsd: Add timestamp to the log with FUSE_LOG_DEBUG level
  virtiofsd: Prevent multiply running with same vhost_user_socket

Miklos Szeredi (10):
  virtiofsd: passthrough_ll: add fallback for racy ops
  virtiofsd: passthrough_ll: add renameat2 support
  virtiofsd: passthrough_ll: disable readdirplus on cache=3Dnever
  virtiofsd: passthrough_ll: control readdirplus
  virtiofsd: rename unref_inode() to unref_inode_lolocked()
  virtiofsd: fail when parent inode isn't known in lo_do_lookup()
  virtiofsd: extract root inode init into setup_root()
  virtiofsd: passthrough_ll: fix refcounting on remove/rename
  virtiofsd: passthrough_ll: clean up cache related options
  virtiofsd: passthrough_ll: use hashtable

Misono Tomohiro (1):
  virtiofsd: Fix data corruption with O_APPEND wirte in writeback mode

Peng Tao (1):
  virtiofsd: do not always set FUSE_FLOCK_LOCKS

Stefan Hajnoczi (37):
  virtiofsd: remove mountpoint dummy argument
  virtiofsd: remove unused notify reply support
  virtiofsd: add -o source=3DPATH to help output
  virtiofsd: add --fd=3DFDNUM fd passing option
  virtiofsd: make -f (foreground) the default
  virtiofsd: add vhost-user.json file
  virtiofsd: add --print-capabilities option
  virtiofsd: passthrough_ll: add lo_map for ino/fh indirection
  virtiofsd: passthrough_ll: add ino_map to hide lo_inode pointers
  virtiofsd: passthrough_ll: add dirp_map to hide lo_dirp pointers
  virtiofsd: passthrough_ll: add fd_map to hide file descriptors
  virtiofsd: validate path components
  virtiofsd: add fuse_mbuf_iter API
  virtiofsd: validate input buffer sizes in do_write_buf()
  virtiofsd: check input buffer size in fuse_lowlevel.c ops
  virtiofsd: prevent ".." escape in lo_do_lookup()
  virtiofsd: prevent ".." escape in lo_do_readdir()
  virtiofsd: use /proc/self/fd/ O_PATH file descriptor
  virtiofsd: sandbox mount namespace
  virtiofsd: move to an empty network namespace
  virtiofsd: move to a new pid namespace
  virtiofsd: add seccomp whitelist
  virtiofsd: set maximum RLIMIT_NOFILE limit
  virtiofsd: fix libfuse information leaks
  virtiofsd: add security guide document
  virtiofsd: add --syslog command-line option
  virtiofsd: use fuse_lowlevel_is_virtio() in fuse_session_destroy()
  virtiofsd: prevent fv_queue_thread() vs virtio_loop() races
  virtiofsd: make lo_release() atomic
  virtiofsd: prevent races with lo_dirp_put()
  virtiofsd: rename inode->refcount to inode->nlookup
  virtiofsd: add man page
  virtiofsd: introduce inode refcount to prevent use-after-free
  virtiofsd: process requests in a thread pool
  virtiofsd: prevent FUSE_INIT/FUSE_DESTROY races
  virtiofsd: fix lo_destroy() resource leaks
  virtiofsd: add --thread-pool-size=3DNUM option

Vivek Goyal (6):
  virtiofsd: Make fsync work even if only inode is passed in
  virtiofsd: passthrough_ll: create new files in caller's context
  virtiofsd: Parse flag FUSE_WRITE_KILL_PRIV
  virtiofsd: Drop CAP_FSETID if client asked for it
  virtiofsd: Support remote posix locks
  virtiofsd: Reset O_DIRECT flag during file open

piaojun (2):
  virtiofsd: add definition of fuse_buf_writev()
  virtiofsd: use fuse_buf_writev to replace fuse_buf_write for better
    performance

 .gitignore                                |    1 +
 MAINTAINERS                               |    8 +
 Makefile                                  |   20 +
 Makefile.objs                             |    1 +
 configure                                 |   16 +
 contrib/libvhost-user/libvhost-user.c     |   57 +-
 contrib/libvhost-user/libvhost-user.h     |    6 +
 docs/interop/vhost-user.json              |    4 +-
 hw/virtio/vhost-user.c                    |    2 +-
 include/standard-headers/linux/fuse.h     |  891 ++++++
 scripts/update-linux-headers.sh           |    1 +
 tools/virtiofsd/50-qemu-virtiofsd.json.in |    5 +
 tools/virtiofsd/Makefile.objs             |   13 +
 tools/virtiofsd/buffer.c                  |  422 +++
 tools/virtiofsd/fuse.h                    | 1287 +++++++++
 tools/virtiofsd/fuse_common.h             |  884 ++++++
 tools/virtiofsd/fuse_i.h                  |  134 +
 tools/virtiofsd/fuse_log.c                |   44 +
 tools/virtiofsd/fuse_log.h                |   74 +
 tools/virtiofsd/fuse_loop_mt.c            |   56 +
 tools/virtiofsd/fuse_lowlevel.c           | 2782 +++++++++++++++++++
 tools/virtiofsd/fuse_lowlevel.h           | 2043 ++++++++++++++
 tools/virtiofsd/fuse_misc.h               |   60 +
 tools/virtiofsd/fuse_opt.c                |  449 +++
 tools/virtiofsd/fuse_opt.h                |  272 ++
 tools/virtiofsd/fuse_signals.c            |   98 +
 tools/virtiofsd/fuse_virtio.c             |  968 +++++++
 tools/virtiofsd/fuse_virtio.h             |   33 +
 tools/virtiofsd/helper.c                  |  333 +++
 tools/virtiofsd/passthrough_helpers.h     |   51 +
 tools/virtiofsd/passthrough_ll.c          | 2998 +++++++++++++++++++++
 tools/virtiofsd/seccomp.c                 |  155 ++
 tools/virtiofsd/seccomp.h                 |   16 +
 tools/virtiofsd/security.rst              |  118 +
 tools/virtiofsd/virtiofsd.texi            |   85 +
 35 files changed, 14373 insertions(+), 14 deletions(-)
 create mode 100644 include/standard-headers/linux/fuse.h
 create mode 100644 tools/virtiofsd/50-qemu-virtiofsd.json.in
 create mode 100644 tools/virtiofsd/Makefile.objs
 create mode 100644 tools/virtiofsd/buffer.c
 create mode 100644 tools/virtiofsd/fuse.h
 create mode 100644 tools/virtiofsd/fuse_common.h
 create mode 100644 tools/virtiofsd/fuse_i.h
 create mode 100644 tools/virtiofsd/fuse_log.c
 create mode 100644 tools/virtiofsd/fuse_log.h
 create mode 100644 tools/virtiofsd/fuse_loop_mt.c
 create mode 100644 tools/virtiofsd/fuse_lowlevel.c
 create mode 100644 tools/virtiofsd/fuse_lowlevel.h
 create mode 100644 tools/virtiofsd/fuse_misc.h
 create mode 100644 tools/virtiofsd/fuse_opt.c
 create mode 100644 tools/virtiofsd/fuse_opt.h
 create mode 100644 tools/virtiofsd/fuse_signals.c
 create mode 100644 tools/virtiofsd/fuse_virtio.c
 create mode 100644 tools/virtiofsd/fuse_virtio.h
 create mode 100644 tools/virtiofsd/helper.c
 create mode 100644 tools/virtiofsd/passthrough_helpers.h
 create mode 100644 tools/virtiofsd/passthrough_ll.c
 create mode 100644 tools/virtiofsd/seccomp.c
 create mode 100644 tools/virtiofsd/seccomp.h
 create mode 100644 tools/virtiofsd/security.rst
 create mode 100644 tools/virtiofsd/virtiofsd.texi

--=20
2.23.0


