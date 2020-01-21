Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13CCC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BEFA20882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ew9cuU/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEFA20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itsc0-00065c-6M
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 07:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsaU-0004T5-SV
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itsaR-0001Yo-CV
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:24:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37469
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsaR-0001YQ-5N
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cipwhz1d6s/c7RH7yfw7yAwkGTKPWfOuNTjmokbAel8=;
 b=ew9cuU/ucD7VkOw8VpfEDZQiD0nvZHit3asSZZiKXeriRF+rOh6fhNPvOqjZLHbisjkyk8
 gXm8m/LnUdEvwVh6zzyYG/eqvN89NHx71kOg6Xf+TDsQj4cVodj8g/mntCu8Mp5gmWbH8+
 h/XaVZCUlVhoMpbrZdEBO2Ws86Y5uio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-OpSxLdn4MASvXFPMYZs3yw-1; Tue, 21 Jan 2020 07:24:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AA1B800D41;
 Tue, 21 Jan 2020 12:24:48 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 468C060BE0;
 Tue, 21 Jan 2020 12:24:36 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 000/109] virtiofs daemon [all]
Date: Tue, 21 Jan 2020 12:22:44 +0000
Message-Id: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: OpSxLdn4MASvXFPMYZs3yw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This is a full set for virtiofsd - a daemon
that implements the user space side of virtiofs.

I've addressed most review comments from V1; we've got
95 Reviewed-by's out of 110 - I'd like to get a PULL out ASAP.

The set pulls in a big chunk of the upstream libfuse library
(unmodified so that it's easy to check it really is upstream),
chops all the stuff out we don't need and then adds the
new transport we need.  I've formatted everything into qemu's code style -
using indent and the clang tools for the files I've imported.

We can't just link with libfuse, since we have to make ABI incompatible
changes for the new transport and it's quite invasive; the library is
designed to be the basis for multiple filesystems, but all on the same
transport.

Running this daemon is typically done with:

   ./virtiofsd --socket-path=3D/path/socket -o source=3D/path/to/fs

connected to a qemu that's then started with:
   -chardev socket,id=3Dchar0,path=3D/path/socket -device vhost-user-fs-pci=
,queue-size=3D1024,chardev=3Dchar0,tag=3Dmyfs

and then in the guest mount with:
   mount -t virtiofs myfs /mnt

Our development branch is: https://gitlab.com/virtio-fs/qemu/tree/virtio-fs=
-dev

This code is going into tools/virtiofsd  based on the previous long
discussion.

Thank you to all those who have contributed code and to those who have
reviewed the previous version.

Dave

Dr. David Alan Gilbert (35):
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
  docs:  Add docs/tools
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

Eryu Guan (3):
  virtiofsd: print log only when priority is high enough
  virtiofsd: convert more fprintf and perror to use fuse log infra
  virtiofsd: stop all queue threads on exit in virtio_loop()

Jiufei Xue (1):
  virtiofsd: support nanosecond resolution for file timestamp

Liu Bo (6):
  virtiofsd: fix error handling in main()
  virtiofsd: cleanup allocated resource in se
  virtiofsd: fix memory leak on lo.source
  virtiofsd: add helper for lo_data cleanup
  virtiofsd: enable PARALLEL_DIROPS during INIT
  Virtiofsd: fix memory leak on fuse queueinfo

Masayoshi Mizuma (4):
  virtiofsd: Add ID to the log with FUSE_LOG_DEBUG level
  virtiofsd: Add timestamp to the log with FUSE_LOG_DEBUG level
  virtiofsd: Prevent multiply running with same vhost_user_socket
  virtiofsd: add some options to the help message

Miklos Szeredi (10):
  virtiofsd: passthrough_ll: add fallback for racy ops
  virtiofsd: passthrough_ll: add renameat2 support
  virtiofsd: passthrough_ll: disable readdirplus on cache=3Dnever
  virtiofsd: passthrough_ll: control readdirplus
  virtiofsd: rename unref_inode() to unref_inode_lolocked()
  virtiofsd: fail when parent inode isn't known in lo_do_lookup()
  virtiofsd: extract root inode init into setup_root()
  virtiofsd: passthrough_ll: clean up cache related options
  virtiofsd: passthrough_ll: use hashtable
  virtiofsd: passthrough_ll: fix refcounting on remove/rename

Misono Tomohiro (1):
  virtiofsd: Fix data corruption with O_APPEND write in writeback mode

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

Xiao Yang (2):
  vitriofsd/passthrough_ll: fix fallocate() ifdefs
  virtiofsd/passthrough_ll: Pass errno to fuse_reply_err()

piaojun (2):
  virtiofsd: add definition of fuse_buf_writev()
  virtiofsd: use fuse_buf_writev to replace fuse_buf_write for better
    performance

 .gitignore                                |    1 +
 MAINTAINERS                               |    8 +
 Makefile                                  |   27 +-
 Makefile.objs                             |    1 +
 configure                                 |   16 +
 contrib/libvhost-user/libvhost-user.c     |   57 +-
 contrib/libvhost-user/libvhost-user.h     |    6 +
 docs/index.rst                            |    1 +
 docs/interop/vhost-user.json              |    4 +-
 docs/tools/conf.py                        |   16 +
 docs/tools/index.rst                      |   14 +
 docs/tools/virtiofsd-security.rst         |  118 +
 hw/virtio/vhost-user.c                    |    2 +-
 include/standard-headers/linux/fuse.h     |  891 ++++++
 scripts/update-linux-headers.sh           |    1 +
 tools/virtiofsd/50-qemu-virtiofsd.json.in |    5 +
 tools/virtiofsd/Makefile.objs             |   12 +
 tools/virtiofsd/buffer.c                  |  351 +++
 tools/virtiofsd/fuse.h                    | 1249 +++++++++
 tools/virtiofsd/fuse_common.h             |  860 ++++++
 tools/virtiofsd/fuse_i.h                  |  115 +
 tools/virtiofsd/fuse_log.c                |   40 +
 tools/virtiofsd/fuse_log.h                |   74 +
 tools/virtiofsd/fuse_lowlevel.c           | 2779 +++++++++++++++++++
 tools/virtiofsd/fuse_lowlevel.h           | 2023 ++++++++++++++
 tools/virtiofsd/fuse_misc.h               |   60 +
 tools/virtiofsd/fuse_opt.c                |  449 +++
 tools/virtiofsd/fuse_opt.h                |  272 ++
 tools/virtiofsd/fuse_signals.c            |   97 +
 tools/virtiofsd/fuse_virtio.c             |  985 +++++++
 tools/virtiofsd/fuse_virtio.h             |   33 +
 tools/virtiofsd/helper.c                  |  349 +++
 tools/virtiofsd/passthrough_helpers.h     |   51 +
 tools/virtiofsd/passthrough_ll.c          | 3006 +++++++++++++++++++++
 tools/virtiofsd/seccomp.c                 |  164 ++
 tools/virtiofsd/seccomp.h                 |   16 +
 tools/virtiofsd/virtiofsd.texi            |  104 +
 37 files changed, 14242 insertions(+), 15 deletions(-)
 create mode 100644 docs/tools/conf.py
 create mode 100644 docs/tools/index.rst
 create mode 100644 docs/tools/virtiofsd-security.rst
 create mode 100644 include/standard-headers/linux/fuse.h
 create mode 100644 tools/virtiofsd/50-qemu-virtiofsd.json.in
 create mode 100644 tools/virtiofsd/Makefile.objs
 create mode 100644 tools/virtiofsd/buffer.c
 create mode 100644 tools/virtiofsd/fuse.h
 create mode 100644 tools/virtiofsd/fuse_common.h
 create mode 100644 tools/virtiofsd/fuse_i.h
 create mode 100644 tools/virtiofsd/fuse_log.c
 create mode 100644 tools/virtiofsd/fuse_log.h
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
 create mode 100644 tools/virtiofsd/virtiofsd.texi

--=20
2.24.1


