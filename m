Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA79C74A21
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC2D208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVjCcXOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC2D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlFI8-00084K-TK
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 12:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55336)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlFEt-00067H-SU
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlFEo-0007Qh-H9
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:37 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:40430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hlFEo-0007Ny-9A
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:34 -0400
Received: by mail-wr1-x42f.google.com with SMTP id r1so3087414wrl.7
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=RnLzTrJA1Mc+QEzQAXuyz6OUoUiesbXhUCgxZxgeYVI=;
 b=KVjCcXOmxGhWjF7T1zNqWztRRF5H/HqRGJADSCimKHZlDzLHVsFO7LaChF/roWl2Kb
 oDNpCbg4OobMMQr0UYj2eOds1xNUcr3ogzXiw7gG9lcIeTFG7B72W0L5y/sqmY/yuG5S
 PY6HiyeumV0HMUQow2C0uz6vezOzRqB9nq5LXxCfmgvCaO4qBlA7OUeCkSCSoLo4HvgH
 pa9thmHVBQa2jm4co2oyhFMTbn5p8Aku3u8KVFPZJzm2G2P/wyAPpKzh06M7JMT8NYYu
 HUHPiUJBxpV6D4yRiN8CbTfDBkzKVyPRApL7DUSJoz/YHbkYpOaYB9uaBCFAcXum69Sk
 SKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=RnLzTrJA1Mc+QEzQAXuyz6OUoUiesbXhUCgxZxgeYVI=;
 b=lJRTYcZh2R8BikjZZ2C0OKEvb96ua+XJLijCO1EbocBu4B/eYOUZsULzcteH76wzQn
 t6lLHfHqx539nUMMySXjmrXtSn0ELENDp1aHIGMdkXEtnz8AAI8f1c2iXwVJ8ohotb/c
 NjCDq6cInmvuirK4RPNFDaWDNukfStNhiatG4xLHBqqDZtlfiPth9Gge1jh1Sd6fS1fX
 IpGgFYty3wOLdsDNvyEgYy43RN8AFFAfe+Hgv+HWtbQ6xAhCZuXQaR0txHV42FJ49Whz
 IfGgg1yaS6qFJmBS/g6xRsb04ICtiEA6qULer2vVvp1bx6Llgdu1UvzWVqsY6xnlP19j
 ymFw==
X-Gm-Message-State: APjAAAWWQ+gx5SOg99vu/m+qUbhEmmADyyOmZoSLvu5wpe9WG6hgxe95
 OycHFcbrMYOJtssfJDr9SCXFNIZD8Zc=
X-Google-Smtp-Source: APXvYqy1ken9rUoCFuX8uzl94SjvkPWsT+/oXNRzk6RoaWjzrZZ89xtxrwt8xSZ7uE8oP/yleP9ahA==
X-Received: by 2002:adf:f84f:: with SMTP id d15mr31821452wrq.53.1562775270503; 
 Wed, 10 Jul 2019 09:14:30 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id w14sm2573747wrk.44.2019.07.10.09.14.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 09:14:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 10 Jul 2019 18:14:19 +0200
Message-Id: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [RFC PATCH v2 0/8] Proof of concept for Meson
 integration
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The main change from v1 is that libqemuutil.a, and with it the tracetool
and QAPI generated code, is now generated with meson.  This shows how
to do some "computations" in meson.build using its array and dictionary
data structures.  It is also a basic usage of the sourceset module for
conditional compilation.

Overall the look of the meson.build code is quite good, but I must
mention the two snags I encountered:

- one is just aboud debuggability.  Quoting rules on Windows are crazy
  so you really do not want to go through quoting there; with Make the
  choice is basically to not support spaces in filenames, Ninja instead
  chose to only do shell expansion on POSIX systems.  For the sake of
  cross-platformness, Meson uses an external script to do "x > y" on both
  POSIX and Windows, and that currently is not very debuggable when you
  use "make V=1".  I know how to fix this and, even though the first
  attempt was rejected at https://github.com/mesonbuild/meson/pull/5573,
  but I have other arrows in my quiver.  Worst case we could pass the
  output file to tracetool as a command line argument, but I'd rather
  not do that as it is not a QEMU-specific issue and my philosophy so
  far has been to improve Meson whenever possible---at least this endeavour
  would provide benefit to the community even if QEMU rejects it.

- the second is more fundamental: with Make we're enjoying much freedom in
  choosing the include path, in particular the tracing headers are using
  $(build_root)/$(<D).  Meson does not like that for reasons I have not
  completely understood.  For now my solution is to generate headers like
  "trace/trace-audio.h" and have sixty one-line forwarding headers in the
  source tree; for example "audio/trace.h" includes "trace/trace-audio.h".
  I'm not sure if it's possible to instead add a one-line "generate
  trace headers" directive to each subdirectory's meson.build file.
  I suspect that it _is_ possible but you'd still have to change the
  #include directives to include the subdirectory name (and then I prefer
  the forwarding headers).

The forwarding headers mechanism would of course be possible with the
current Makefiles too, of course.

Other notes:

1) this is only very lightly tested (./configure && make basically)

2) I have not yet converted qemu-ga, which would be next, but I can
already say that the conversion probably will *not* remove the code
duplication we have between Makefile's rules for qemu-ga's QAPI files,
and qapi/Makefile.objs's rules for QEMU's QAPI files.

3) there are two main changes outside patch 4: scripts/ninjatool is now
built from meson.build, which removes duplicate code between Makefile and
configure; and  "type -p" is replaced throughout with the more correct
"command -v".

Paolo Bonzini (8):
  configure: do not include $(...) variables in config-host.mak
  configure: set $PYTHON to a full path
  configure: integrate Meson in the build system
  convert libqemuutil to meson
  libvhost-user: convert to Meson
  vhost-user-blk: convert to Meson
  vhost-user-scsi: convert to Meson
  rdmacm-mux: convert to Meson

 .gitignore                            |  13 +-
 Makefile                              | 191 ++-----
 Makefile.objs                         |  94 +---
 audio/trace.h                         |   1 +
 chardev/trace.h                       |   1 +
 configure                             |  63 ++-
 contrib/libvhost-user/Makefile.objs   |   1 -
 contrib/libvhost-user/meson.build     |   2 +
 contrib/rdmacm-mux/Makefile.objs      |   3 -
 contrib/rdmacm-mux/meson.build        |   6 +
 contrib/vhost-user-blk/Makefile.objs  |   1 -
 contrib/vhost-user-blk/meson.build    |   3 +
 contrib/vhost-user-scsi/Makefile.objs |   1 -
 contrib/vhost-user-scsi/meson.build   |   3 +
 crypto/Makefile.objs                  |   3 +-
 hw/9pfs/trace.h                       |   1 +
 hw/acpi/trace.h                       |   1 +
 hw/alpha/trace.h                      |   1 +
 hw/arm/trace.h                        |   1 +
 hw/audio/trace.h                      |   1 +
 hw/block/dataplane/trace.h            |   1 +
 hw/block/trace.h                      |   1 +
 hw/char/trace.h                       |   1 +
 hw/display/trace.h                    |   1 +
 hw/dma/trace.h                        |   1 +
 hw/gpio/trace.h                       |   1 +
 hw/hppa/trace.h                       |   1 +
 hw/i2c/trace.h                        |   1 +
 hw/i386/trace.h                       |   1 +
 hw/i386/xen/trace.h                   |   1 +
 hw/ide/trace.h                        |   1 +
 hw/input/trace.h                      |   1 +
 hw/intc/trace.h                       |   1 +
 hw/isa/trace.h                        |   1 +
 hw/mem/trace.h                        |   1 +
 hw/misc/macio/trace.h                 |   1 +
 hw/misc/trace.h                       |   1 +
 hw/net/trace.h                        |   1 +
 hw/nvram/trace.h                      |   1 +
 hw/pci-host/trace.h                   |   1 +
 hw/pci/trace.h                        |   1 +
 hw/ppc/trace.h                        |   1 +
 hw/rdma/trace.h                       |   1 +
 hw/rdma/vmw/trace.h                   |   1 +
 hw/riscv/trace.h                      |   1 +
 hw/s390x/trace.h                      |   1 +
 hw/scsi/trace.h                       |   1 +
 hw/sd/trace.h                         |   1 +
 hw/sparc/trace.h                      |   1 +
 hw/sparc64/trace.h                    |   1 +
 hw/timer/trace.h                      |   1 +
 hw/tpm/trace.h                        |   1 +
 hw/usb/trace.h                        |   1 +
 hw/vfio/trace.h                       |   1 +
 hw/virtio/trace.h                     |   1 +
 hw/watchdog/trace.h                   |   1 +
 hw/xen/trace.h                        |   1 +
 meson.build                           | 154 ++++++
 migration/trace.h                     |   1 +
 net/trace.h                           |   1 +
 qapi/Makefile.objs                    |  20 -
 qapi/meson.build                      |  54 ++
 qapi/trace.h                          |   1 +
 qobject/Makefile.objs                 |   3 -
 qobject/meson.build                   |   3 +
 qom/trace.h                           |   1 +
 scripts/ninjatool.py                  | 988 ++++++++++++++++++++++++++++++++++
 scripts/qapi-gen.py                   |   2 +-
 scripts/tracetool.py                  |   2 +-
 scripts/tracetool/backend/ust.py      |   6 +-
 scripts/tracetool/format/c.py         |   5 +-
 stubs/Makefile.objs                   |  43 --
 stubs/meson.build                     |  45 ++
 target/arm/trace.h                    |   1 +
 target/hppa/trace.h                   |   1 +
 target/i386/trace.h                   |   1 +
 target/mips/trace.h                   |   1 +
 target/ppc/trace.h                    |   1 +
 target/riscv/trace.h                  |   1 +
 target/s390x/trace.h                  |   1 +
 target/sparc/trace.h                  |   1 +
 trace/Makefile.objs                   |  51 --
 trace/meson.build                     |  75 +++
 ui/trace.h                            |   1 +
 util/Makefile.objs                    |  59 --
 util/meson.build                      |  57 ++
 util/trace.h                          |   1 +
 87 files changed, 1536 insertions(+), 473 deletions(-)
 create mode 100644 audio/trace.h
 create mode 100644 chardev/trace.h
 delete mode 100644 contrib/libvhost-user/Makefile.objs
 create mode 100644 contrib/libvhost-user/meson.build
 delete mode 100644 contrib/rdmacm-mux/Makefile.objs
 create mode 100644 contrib/rdmacm-mux/meson.build
 delete mode 100644 contrib/vhost-user-blk/Makefile.objs
 create mode 100644 contrib/vhost-user-blk/meson.build
 delete mode 100644 contrib/vhost-user-scsi/Makefile.objs
 create mode 100644 contrib/vhost-user-scsi/meson.build
 create mode 100644 hw/9pfs/trace.h
 create mode 100644 hw/acpi/trace.h
 create mode 100644 hw/alpha/trace.h
 create mode 100644 hw/arm/trace.h
 create mode 100644 hw/audio/trace.h
 create mode 100644 hw/block/dataplane/trace.h
 create mode 100644 hw/block/trace.h
 create mode 100644 hw/char/trace.h
 create mode 100644 hw/display/trace.h
 create mode 100644 hw/dma/trace.h
 create mode 100644 hw/gpio/trace.h
 create mode 100644 hw/hppa/trace.h
 create mode 100644 hw/i2c/trace.h
 create mode 100644 hw/i386/trace.h
 create mode 100644 hw/i386/xen/trace.h
 create mode 100644 hw/ide/trace.h
 create mode 100644 hw/input/trace.h
 create mode 100644 hw/intc/trace.h
 create mode 100644 hw/isa/trace.h
 create mode 100644 hw/mem/trace.h
 create mode 100644 hw/misc/macio/trace.h
 create mode 100644 hw/misc/trace.h
 create mode 100644 hw/net/trace.h
 create mode 100644 hw/nvram/trace.h
 create mode 100644 hw/pci-host/trace.h
 create mode 100644 hw/pci/trace.h
 create mode 100644 hw/ppc/trace.h
 create mode 100644 hw/rdma/trace.h
 create mode 100644 hw/rdma/vmw/trace.h
 create mode 100644 hw/riscv/trace.h
 create mode 100644 hw/s390x/trace.h
 create mode 100644 hw/scsi/trace.h
 create mode 100644 hw/sd/trace.h
 create mode 100644 hw/sparc/trace.h
 create mode 100644 hw/sparc64/trace.h
 create mode 100644 hw/timer/trace.h
 create mode 100644 hw/tpm/trace.h
 create mode 100644 hw/usb/trace.h
 create mode 100644 hw/vfio/trace.h
 create mode 100644 hw/virtio/trace.h
 create mode 100644 hw/watchdog/trace.h
 create mode 100644 hw/xen/trace.h
 create mode 100644 meson.build
 create mode 100644 migration/trace.h
 create mode 100644 net/trace.h
 create mode 100644 qapi/meson.build
 create mode 100644 qapi/trace.h
 delete mode 100644 qobject/Makefile.objs
 create mode 100644 qobject/meson.build
 create mode 100644 qom/trace.h
 create mode 100755 scripts/ninjatool.py
 delete mode 100644 stubs/Makefile.objs
 create mode 100644 stubs/meson.build
 create mode 100644 target/arm/trace.h
 create mode 100644 target/hppa/trace.h
 create mode 100644 target/i386/trace.h
 create mode 100644 target/mips/trace.h
 create mode 100644 target/ppc/trace.h
 create mode 100644 target/riscv/trace.h
 create mode 100644 target/s390x/trace.h
 create mode 100644 target/sparc/trace.h
 create mode 100644 trace/meson.build
 create mode 100644 ui/trace.h
 delete mode 100644 util/Makefile.objs
 create mode 100644 util/meson.build
 create mode 100644 util/trace.h

-- 
1.8.3.1


