Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B276C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2259A24685
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9JNotMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2259A24685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6v5l-0001V4-5j
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6uuD-0001Wo-OG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:31:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6uu3-0007Z3-Cp
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:31:09 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:34754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6uu2-0007QO-Mo
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:59 -0500
Received: by mail-wm1-x335.google.com with SMTP id i10so3244094wmd.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rdb2plGkmxji5WacPVT5VJqBD3Z3uvPEcKgdVhr7WSo=;
 b=T9JNotMAtxtvnCcjcgjAhYv8VYEpJkgJtac6iiZF5bSlvch0pVekGshCO5F61q1Sqo
 dyy9hYHWCFHxDvBo+7PuKxfh5gY/ar57dbHVDhN/S3fRW0sO5TrCvoicGDZ5rBFq1uYB
 ytXxzn3fxYxgwNj2b7RawqWw4dPn1LJSsSEFeU2ok+pC8OjlSFgKEZf8Y//ju8omoNc2
 OefCuqDcG0Td3SnnLs6alqdCwvyF9FOdfP1hZFmbJNGCTBOwh008g7NTRqg0b8CFVFMC
 jaob8nrGnbR9iMysnQmA9LBa/R9m0XUoZf309jMvYGwQcLwvdjTvtehz3+i89t/RuBVv
 bucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rdb2plGkmxji5WacPVT5VJqBD3Z3uvPEcKgdVhr7WSo=;
 b=Sqzpp9JSos47aBCbCHjWmr6LfhlEdU0wuNv82YaHwaUMJB6dGbsspbESC07LYPB8Qg
 733aXBVOueSUiIar0m+2/vLFCLJe7DU8BFw2yeprtK5EOlO8gXuTy8SbZyLPO/OsqVRH
 Q2lot30++NZtiUM6N+e5WR5g30ht1jw7ZSFF0T1W9sMKZlwjiG5k3DYQGJOzmMbDqj3V
 HzXjNk8OJk8CD2hdDCUOCuldLO3bJdQRQsgMT7Uca+9ZnaiM4oP2fBtVZ6QREr8oikMA
 RqpmAgUHDCaNO3uraeWuiRLRN3hxehGPN76vQ/ilJmuRqZjf9yhWYHOsEwGlx9YgSRj8
 aiNg==
X-Gm-Message-State: APjAAAVXmIXD9mQASc+aG2ZIkCtGMmzJN7rl4py1VzbwRoPBtssqHqeJ
 y+MlA0fNfSOKUWRHQMHX4wQUIVYA
X-Google-Smtp-Source: APXvYqziD7QGjNB0mI1TcDUZN1TcOS9usE6PIP6ncY+SX4LAQB6AO4D4IURYgYL1Ke+uBSIJ+H/31g==
X-Received: by 2002:a1c:2b44:: with SMTP id r65mr4965896wmr.72.1582716653676; 
 Wed, 26 Feb 2020 03:30:53 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id h128sm2628154wmh.33.2020.02.26.03.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 03:30:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/18] docs/system: convert Texinfo documentation to rST
Date: Wed, 26 Feb 2020 12:30:34 +0100
Message-Id: <20200226113034.6741-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200226113034.6741-1-pbonzini@redhat.com>
References: <20200226113034.6741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Apart from targets.rst, which was written by hand, this is an automated
conversion obtained with the following command:

  makeinfo --force -o - --docbook \
    -D 'qemu_system_x86 QEMU_SYSTEM_X86_MACRO' \
    -D 'qemu_system     QEMU_SYSTEM_MACRO' \
    $texi | pandoc -f docbook -t rst+smart | perl -e '
      $/=undef;
      $_ = <>;
      s/^-  − /-  /gm;
      s/QEMU_SYSTEM_MACRO/|qemu_system|/g;
      s/QEMU_SYSTEM_X86_MACRO/|qemu_system_x86|/g;
      s/(?=::\n\n +\|qemu)/.. parsed-literal/g;
      s/:\n\n::$/::/gm;
      print' > $rst

In addition, the following changes were made manually:

- target-i386.rst and target-mips.rst: replace CPU model documentation with
  an include directive

- monitor.rst: replace the command section with a comment

- images.rst: add toctree

- invocation.rst and ivshmem.rst: annotate more parsed-literal blocks

Content that is not @included remains exclusive to qemu-doc.texi.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/build-platforms.rst |  79 ++++++++
 docs/system/gdb.rst             |  81 ++++++++
 docs/system/images.rst          |  85 +++++++++
 docs/system/index.rst           |  19 +-
 docs/system/invocation.rst      | 242 +++++++++++++++++++++++
 docs/system/ivshmem.rst         |  64 +++++++
 docs/system/keys.rst            |  40 ++++
 docs/system/license.rst         |  11 ++
 docs/system/linuxboot.rst       |  30 +++
 docs/system/monitor.rst         |  25 +++
 docs/system/mux-chardev.rst     |  32 ++++
 docs/system/net.rst             | 100 ++++++++++
 docs/system/quickstart.rst      |  13 ++
 docs/system/target-arm.rst      | 227 ++++++++++++++++++++++
 docs/system/target-i386.rst     |  84 ++++++++
 docs/system/target-m68k.rst     |  32 ++++
 docs/system/target-mips.rst     | 120 ++++++++++++
 docs/system/target-ppc.rst      |  61 ++++++
 docs/system/target-sparc.rst    |  81 ++++++++
 docs/system/target-sparc64.rst  |  49 +++++
 docs/system/target-xtensa.rst   |  39 ++++
 docs/system/targets.rst         |  19 ++
 docs/system/tls.rst             | 328 ++++++++++++++++++++++++++++++++
 docs/system/usb.rst             | 137 +++++++++++++
 docs/system/vnc-security.rst    | 202 ++++++++++++++++++++
 25 files changed, 2199 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/build-platforms.rst
 create mode 100644 docs/system/gdb.rst
 create mode 100644 docs/system/images.rst
 create mode 100644 docs/system/invocation.rst
 create mode 100644 docs/system/ivshmem.rst
 create mode 100644 docs/system/keys.rst
 create mode 100644 docs/system/license.rst
 create mode 100644 docs/system/linuxboot.rst
 create mode 100644 docs/system/monitor.rst
 create mode 100644 docs/system/mux-chardev.rst
 create mode 100644 docs/system/net.rst
 create mode 100644 docs/system/quickstart.rst
 create mode 100644 docs/system/target-arm.rst
 create mode 100644 docs/system/target-i386.rst
 create mode 100644 docs/system/target-m68k.rst
 create mode 100644 docs/system/target-mips.rst
 create mode 100644 docs/system/target-ppc.rst
 create mode 100644 docs/system/target-sparc.rst
 create mode 100644 docs/system/target-sparc64.rst
 create mode 100644 docs/system/target-xtensa.rst
 create mode 100644 docs/system/targets.rst
 create mode 100644 docs/system/tls.rst
 create mode 100644 docs/system/usb.rst
 create mode 100644 docs/system/vnc-security.rst

diff --git a/docs/system/build-platforms.rst b/docs/system/build-platforms.rst
new file mode 100644
index 0000000000..c2b92a9698
--- /dev/null
+++ b/docs/system/build-platforms.rst
@@ -0,0 +1,79 @@
+.. _Supported-build-platforms:
+
+Supported build platforms
+=========================
+
+QEMU aims to support building and executing on multiple host OS
+platforms. This appendix outlines which platforms are the major build
+targets. These platforms are used as the basis for deciding upon the
+minimum required versions of 3rd party software QEMU depends on. The
+supported platforms are the targets for automated testing performed by
+the project when patches are submitted for review, and tested before and
+after merge.
+
+If a platform is not listed here, it does not imply that QEMU won't
+work. If an unlisted platform has comparable software versions to a
+listed platform, there is every expectation that it will work. Bug
+reports are welcome for problems encountered on unlisted platforms
+unless they are clearly older vintage than what is described here.
+
+Note that when considering software versions shipped in distros as
+support targets, QEMU considers only the version number, and assumes the
+features in that distro match the upstream release with the same
+version. In other words, if a distro backports extra features to the
+software in their distro, QEMU upstream code will not add explicit
+support for those backports, unless the feature is auto-detectable in a
+manner that works for the upstream releases too.
+
+The Repology site https://repology.org is a useful resource to identify
+currently shipped versions of software in various operating systems,
+though it does not cover all distros listed below.
+
+Linux OS
+--------
+
+For distributions with frequent, short-lifetime releases, the project
+will aim to support all versions that are not end of life by their
+respective vendors. For the purposes of identifying supported software
+versions, the project will look at Fedora, Ubuntu, and openSUSE distros.
+Other short- lifetime distros will be assumed to ship similar software
+versions.
+
+For distributions with long-lifetime releases, the project will aim to
+support the most recent major version at all times. Support for the
+previous major version will be dropped 2 years after the new major
+version is released, or when it reaches "end of life". For the purposes
+of identifying supported software versions, the project will look at
+RHEL, Debian, Ubuntu LTS, and SLES distros. Other long-lifetime distros
+will be assumed to ship similar software versions.
+
+Windows
+-------
+
+The project supports building with current versions of the MinGW
+toolchain, hosted on Linux.
+
+macOS
+-----
+
+The project supports building with the two most recent versions of
+macOS, with the current homebrew package set available.
+
+FreeBSD
+-------
+
+The project aims to support the all the versions which are not end of
+life.
+
+NetBSD
+------
+
+The project aims to support the most recent major version at all times.
+Support for the previous major version will be dropped 2 years after the
+new major version is released.
+
+OpenBSD
+-------
+
+The project aims to support the all the versions which are not end of
+life.
diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
new file mode 100644
index 0000000000..639f814b32
--- /dev/null
+++ b/docs/system/gdb.rst
@@ -0,0 +1,81 @@
+.. _gdb_005fusage:
+
+GDB usage
+---------
+
+QEMU has a primitive support to work with gdb, so that you can do
+'Ctrl-C' while the virtual machine is running and inspect its state.
+
+In order to use gdb, launch QEMU with the '-s' option. It will wait for
+a gdb connection:
+
+.. parsed-literal::
+
+   |qemu_system| -s -kernel bzImage -hda rootdisk.img -append "root=/dev/hda"
+   Connected to host network interface: tun0
+   Waiting gdb connection on port 1234
+
+Then launch gdb on the 'vmlinux' executable::
+
+   > gdb vmlinux
+
+In gdb, connect to QEMU::
+
+   (gdb) target remote localhost:1234
+
+Then you can use gdb normally. For example, type 'c' to launch the
+kernel::
+
+   (gdb) c
+
+Here are some useful tips in order to use gdb on system code:
+
+1. Use ``info reg`` to display all the CPU registers.
+
+2. Use ``x/10i $eip`` to display the code at the PC position.
+
+3. Use ``set architecture i8086`` to dump 16 bit code. Then use
+   ``x/10i $cs*16+$eip`` to dump the code at the PC position.
+
+Advanced debugging options:
+
+The default single stepping behavior is step with the IRQs and timer
+service routines off. It is set this way because when gdb executes a
+single step it expects to advance beyond the current instruction. With
+the IRQs and timer service routines on, a single step might jump into
+the one of the interrupt or exception vectors instead of executing the
+current instruction. This means you may hit the same breakpoint a number
+of times before executing the instruction gdb wants to have executed.
+Because there are rare circumstances where you want to single step into
+an interrupt vector the behavior can be controlled from GDB. There are
+three commands you can query and set the single step behavior:
+
+``maintenance packet qqemu.sstepbits``
+   This will display the MASK bits used to control the single stepping
+   IE:
+
+   ::
+
+      (gdb) maintenance packet qqemu.sstepbits
+      sending: "qqemu.sstepbits"
+      received: "ENABLE=1,NOIRQ=2,NOTIMER=4"
+
+``maintenance packet qqemu.sstep``
+   This will display the current value of the mask used when single
+   stepping IE:
+
+   ::
+
+      (gdb) maintenance packet qqemu.sstep
+      sending: "qqemu.sstep"
+      received: "0x7"
+
+``maintenance packet Qqemu.sstep=HEX_VALUE``
+   This will change the single step mask, so if wanted to enable IRQs on
+   the single step, but not timers, you would use:
+
+   ::
+
+      (gdb) maintenance packet Qqemu.sstep=0x5
+      sending: "qemu.sstep=0x5"
+      received: "OK"
diff --git a/docs/system/images.rst b/docs/system/images.rst
new file mode 100644
index 0000000000..3b13b4a0ca
--- /dev/null
+++ b/docs/system/images.rst
@@ -0,0 +1,85 @@
+.. _disk_005fimages:
+
+Disk Images
+-----------
+
+QEMU supports many disk image formats, including growable disk images
+(their size increase as non empty sectors are written), compressed and
+encrypted disk images.
+
+.. _disk_005fimages_005fquickstart:
+
+Quick start for disk image creation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You can create a disk image with the command::
+
+   qemu-img create myimage.img mysize
+
+where myimage.img is the disk image filename and mysize is its size in
+kilobytes. You can add an ``M`` suffix to give the size in megabytes and
+a ``G`` suffix for gigabytes.
+
+See the qemu-img invocation documentation for more information.
+
+.. _disk_005fimages_005fsnapshot_005fmode:
+
+Snapshot mode
+~~~~~~~~~~~~~
+
+If you use the option ``-snapshot``, all disk images are considered as
+read only. When sectors in written, they are written in a temporary file
+created in ``/tmp``. You can however force the write back to the raw
+disk images by using the ``commit`` monitor command (or C-a s in the
+serial console).
+
+.. _vm_005fsnapshots:
+
+VM snapshots
+~~~~~~~~~~~~
+
+VM snapshots are snapshots of the complete virtual machine including CPU
+state, RAM, device state and the content of all the writable disks. In
+order to use VM snapshots, you must have at least one non removable and
+writable block device using the ``qcow2`` disk image format. Normally
+this device is the first virtual hard drive.
+
+Use the monitor command ``savevm`` to create a new VM snapshot or
+replace an existing one. A human readable name can be assigned to each
+snapshot in addition to its numerical ID.
+
+Use ``loadvm`` to restore a VM snapshot and ``delvm`` to remove a VM
+snapshot. ``info snapshots`` lists the available snapshots with their
+associated information::
+
+   (qemu) info snapshots
+   Snapshot devices: hda
+   Snapshot list (from hda):
+   ID        TAG                 VM SIZE                DATE       VM CLOCK
+   1         start                   41M 2006-08-06 12:38:02   00:00:14.954
+   2                                 40M 2006-08-06 12:43:29   00:00:18.633
+   3         msys                    40M 2006-08-06 12:44:04   00:00:23.514
+
+A VM snapshot is made of a VM state info (its size is shown in
+``info snapshots``) and a snapshot of every writable disk image. The VM
+state info is stored in the first ``qcow2`` non removable and writable
+block device. The disk image snapshots are stored in every disk image.
+The size of a snapshot in a disk image is difficult to evaluate and is
+not shown by ``info snapshots`` because the associated disk sectors are
+shared among all the snapshots to save disk space (otherwise each
+snapshot would need a full copy of all the disk images).
+
+When using the (unrelated) ``-snapshot`` option
+(`disk_images_snapshot_mode <#disk_005fimages_005fsnapshot_005fmode>`__),
+you can always make VM snapshots, but they are deleted as soon as you
+exit QEMU.
+
+VM snapshots currently have the following known limitations:
+
+-  They cannot cope with removable devices if they are removed or
+   inserted after a snapshot is done.
+
+-  A few device drivers still have incomplete snapshot support so their
+   state is not saved or restored properly (in particular USB).
+
+.. include:: qemu-block-drivers.rst.inc
diff --git a/docs/system/index.rst b/docs/system/index.rst
index 467cda3e72..c0f685b818 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -12,7 +12,24 @@ or Hypervisor.Framework.
 Contents:
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 3
+
+   quickstart
+   invocation
+   keys
+   mux-chardev
+   monitor
+   images
+   net
+   usb
+   ivshmem
+   linuxboot
+   vnc-security
+   tls
+   gdb
    managed-startup
+   targets
    security
    deprecated
+   build-platforms
+   license
diff --git a/docs/system/invocation.rst b/docs/system/invocation.rst
new file mode 100644
index 0000000000..bdc6a10fb8
--- /dev/null
+++ b/docs/system/invocation.rst
@@ -0,0 +1,242 @@
+.. _sec_005finvocation:
+
+Invocation
+----------
+
+.. parsed-literal::
+
+   |qemu_system| [options] [disk_image]
+
+disk_image is a raw hard disk image for IDE hard disk 0. Some targets do
+not need a disk image.
+
+Device URL Syntax
+~~~~~~~~~~~~~~~~~
+
+In addition to using normal file images for the emulated storage
+devices, QEMU can also use networked resources such as iSCSI devices.
+These are specified using a special URL syntax.
+
+``iSCSI``
+   iSCSI support allows QEMU to access iSCSI resources directly and use
+   as images for the guest storage. Both disk and cdrom images are
+   supported.
+
+   Syntax for specifying iSCSI LUNs is
+   "iscsi://<target-ip>[:<port>]/<target-iqn>/<lun>"
+
+   By default qemu will use the iSCSI initiator-name
+   'iqn.2008-11.org.linux-kvm[:<name>]' but this can also be set from
+   the command line or a configuration file.
+
+   Since version Qemu 2.4 it is possible to specify a iSCSI request
+   timeout to detect stalled requests and force a reestablishment of the
+   session. The timeout is specified in seconds. The default is 0 which
+   means no timeout. Libiscsi 1.15.0 or greater is required for this
+   feature.
+
+   Example (without authentication):
+
+   .. parsed-literal::
+
+      |qemu_system| -iscsi initiator-name=iqn.2001-04.com.example:my-initiator \
+                       -cdrom iscsi://192.0.2.1/iqn.2001-04.com.example/2 \
+                       -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
+
+   Example (CHAP username/password via URL):
+
+   .. parsed-literal::
+
+      |qemu_system| -drive file=iscsi://user%password@192.0.2.1/iqn.2001-04.com.example/1
+
+   Example (CHAP username/password via environment variables):
+
+   .. parsed-literal::
+
+      LIBISCSI_CHAP_USERNAME="user" \
+      LIBISCSI_CHAP_PASSWORD="password" \
+      |qemu_system| -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
+
+``NBD``
+   QEMU supports NBD (Network Block Devices) both using TCP protocol as
+   well as Unix Domain Sockets. With TCP, the default port is 10809.
+
+   Syntax for specifying a NBD device using TCP, in preferred URI form:
+   "nbd://<server-ip>[:<port>]/[<export>]"
+
+   Syntax for specifying a NBD device using Unix Domain Sockets;
+   remember that '?' is a shell glob character and may need quoting:
+   "nbd+unix:///[<export>]?socket=<domain-socket>"
+
+   Older syntax that is also recognized:
+   "nbd:<server-ip>:<port>[:exportname=<export>]"
+
+   Syntax for specifying a NBD device using Unix Domain Sockets
+   "nbd:unix:<domain-socket>[:exportname=<export>]"
+
+   Example for TCP
+
+   .. parsed-literal::
+
+      |qemu_system| --drive file=nbd:192.0.2.1:30000
+
+   Example for Unix Domain Sockets
+
+   .. parsed-literal::
+
+      |qemu_system| --drive file=nbd:unix:/tmp/nbd-socket
+
+``SSH``
+   QEMU supports SSH (Secure Shell) access to remote disks.
+
+   Examples:
+
+   .. parsed-literal::
+
+      |qemu_system| -drive file=ssh://user@host/path/to/disk.img
+      |qemu_system| -drive file.driver=ssh,file.user=user,file.host=host,file.port=22,file.path=/path/to/disk.img
+
+   Currently authentication must be done using ssh-agent. Other
+   authentication methods may be supported in future.
+
+``Sheepdog``
+   Sheepdog is a distributed storage system for QEMU. QEMU supports
+   using either local sheepdog devices or remote networked devices.
+
+   Syntax for specifying a sheepdog device
+
+   ::
+
+      sheepdog[+tcp|+unix]://[host:port]/vdiname[?socket=path][#snapid|#tag]
+
+   Example
+
+   .. parsed-literal::
+
+      |qemu_system| --drive file=sheepdog://192.0.2.1:30000/MyVirtualMachine
+
+   See also https://sheepdog.github.io/sheepdog/.
+
+``GlusterFS``
+   GlusterFS is a user space distributed file system. QEMU supports the
+   use of GlusterFS volumes for hosting VM disk images using TCP, Unix
+   Domain Sockets and RDMA transport protocols.
+
+   Syntax for specifying a VM disk image on GlusterFS volume is
+
+   .. parsed-literal::
+
+      URI:
+      gluster[+type]://[host[:port]]/volume/path[?socket=...][,debug=N][,logfile=...]
+
+      JSON:
+      'json:{"driver":"qcow2","file":{"driver":"gluster","volume":"testvol","path":"a.img","debug":N,"logfile":"...",
+                                       "server":[{"type":"tcp","host":"...","port":"..."},
+                                                 {"type":"unix","socket":"..."}]}}'
+
+   Example
+
+   .. parsed-literal::
+
+      URI:
+      |qemu_system| --drive file=gluster://192.0.2.1/testvol/a.img,
+                                     file.debug=9,file.logfile=/var/log/qemu-gluster.log
+
+      JSON:
+      |qemu_system| 'json:{"driver":"qcow2",
+                                "file":{"driver":"gluster",
+                                         "volume":"testvol","path":"a.img",
+                                         "debug":9,"logfile":"/var/log/qemu-gluster.log",
+                                         "server":[{"type":"tcp","host":"1.2.3.4","port":24007},
+                                                   {"type":"unix","socket":"/var/run/glusterd.socket"}]}}'
+      |qemu_system| -drive driver=qcow2,file.driver=gluster,file.volume=testvol,file.path=/path/a.img,
+                                            file.debug=9,file.logfile=/var/log/qemu-gluster.log,
+                                            file.server.0.type=tcp,file.server.0.host=1.2.3.4,file.server.0.port=24007,
+                                            file.server.1.type=unix,file.server.1.socket=/var/run/glusterd.socket
+
+   See also http://www.gluster.org.
+
+``HTTP/HTTPS/FTP/FTPS``
+   QEMU supports read-only access to files accessed over http(s) and
+   ftp(s).
+
+   Syntax using a single filename:
+
+   ::
+
+      <protocol>://[<username>[:<password>]@]<host>/<path>
+
+   where:
+
+   ``protocol``
+      'http', 'https', 'ftp', or 'ftps'.
+
+   ``username``
+      Optional username for authentication to the remote server.
+
+   ``password``
+      Optional password for authentication to the remote server.
+
+   ``host``
+      Address of the remote server.
+
+   ``path``
+      Path on the remote server, including any query string.
+
+   The following options are also supported:
+
+   ``url``
+      The full URL when passing options to the driver explicitly.
+
+   ``readahead``
+      The amount of data to read ahead with each range request to the
+      remote server. This value may optionally have the suffix 'T', 'G',
+      'M', 'K', 'k' or 'b'. If it does not have a suffix, it will be
+      assumed to be in bytes. The value must be a multiple of 512 bytes.
+      It defaults to 256k.
+
+   ``sslverify``
+      Whether to verify the remote server's certificate when connecting
+      over SSL. It can have the value 'on' or 'off'. It defaults to
+      'on'.
+
+   ``cookie``
+      Send this cookie (it can also be a list of cookies separated by
+      ';') with each outgoing request. Only supported when using
+      protocols such as HTTP which support cookies, otherwise ignored.
+
+   ``timeout``
+      Set the timeout in seconds of the CURL connection. This timeout is
+      the time that CURL waits for a response from the remote server to
+      get the size of the image to be downloaded. If not set, the
+      default timeout of 5 seconds is used.
+
+   Note that when passing options to qemu explicitly, ``driver`` is the
+   value of <protocol>.
+
+   Example: boot from a remote Fedora 20 live ISO image
+
+   .. parsed-literal::
+
+      |qemu_system_x86| --drive media=cdrom,file=https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
+
+      |qemu_system_x86| --drive media=cdrom,file.driver=http,file.url=http://archives.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
+
+   Example: boot from a remote Fedora 20 cloud image using a local
+   overlay for writes, copy-on-read, and a readahead of 64k
+
+   ::
+
+      qemu-img create -f qcow2 -o backing_file='json:{"file.driver":"http",, "file.url":"http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.readahead":"64k"}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
+
+      |qemu_system_x86| -drive file=/tmp/Fedora-x86_64-20-20131211.1-sda.qcow2,copy-on-read=on
+
+   Example: boot from an image stored on a VMware vSphere server with a
+   self-signed certificate using a local overlay for writes, a readahead
+   of 64k and a timeout of 10 seconds.
+
+   ::
+
+      qemu-img create -f qcow2 -o backing_file='json:{"file.driver":"https",, "file.url":"https://user:password@vsphere.example.com/folder/test/test-flat.vmdk?dcPath=Datacenter&dsName=datastore1",, "file.sslverify":"off",, "file.readahead":"64k",, "file.timeout":10}' /tmp/test.qcow2
+
+      |qemu_system_x86| -drive file=/tmp/test.qcow2
diff --git a/docs/system/ivshmem.rst b/docs/system/ivshmem.rst
new file mode 100644
index 0000000000..b03a48afa3
--- /dev/null
+++ b/docs/system/ivshmem.rst
@@ -0,0 +1,64 @@
+.. _pcsys_005fivshmem:
+
+Inter-VM Shared Memory device
+-----------------------------
+
+On Linux hosts, a shared memory device is available. The basic syntax
+is:
+
+.. parsed-literal::
+
+   |qemu_system_x86| -device ivshmem-plain,memdev=hostmem
+
+where hostmem names a host memory backend. For a POSIX shared memory
+backend, use something like
+
+::
+
+   -object memory-backend-file,size=1M,share,mem-path=/dev/shm/ivshmem,id=hostmem
+
+If desired, interrupts can be sent between guest VMs accessing the same
+shared memory region. Interrupt support requires using a shared memory
+server and using a chardev socket to connect to it. The code for the
+shared memory server is qemu.git/contrib/ivshmem-server. An example
+syntax when using the shared memory server is:
+
+.. parsed-literal::
+
+   # First start the ivshmem server once and for all
+   ivshmem-server -p pidfile -S path -m shm-name -l shm-size -n vectors
+
+   # Then start your qemu instances with matching arguments
+   |qemu_system_x86| -device ivshmem-doorbell,vectors=vectors,chardev=id
+                    -chardev socket,path=path,id=id
+
+When using the server, the guest will be assigned a VM ID (>=0) that
+allows guests using the same server to communicate via interrupts.
+Guests can read their VM ID from a device register (see
+ivshmem-spec.txt).
+
+Migration with ivshmem
+~~~~~~~~~~~~~~~~~~~~~~
+
+With device property ``master=on``, the guest will copy the shared
+memory on migration to the destination host. With ``master=off``, the
+guest will not be able to migrate with the device attached. In the
+latter case, the device should be detached and then reattached after
+migration using the PCI hotplug support.
+
+At most one of the devices sharing the same memory can be master. The
+master must complete migration before you plug back the other devices.
+
+ivshmem and hugepages
+~~~~~~~~~~~~~~~~~~~~~
+
+Instead of specifying the <shm size> using POSIX shm, you may specify a
+memory backend that has hugepage support:
+
+.. parsed-literal::
+
+   |qemu_system_x86| -object memory-backend-file,size=1G,mem-path=/dev/hugepages/my-shmem-file,share,id=mb1
+                    -device ivshmem-plain,memdev=mb1
+
+ivshmem-server also supports hugepages mount points with the ``-m``
+memory path argument.
diff --git a/docs/system/keys.rst b/docs/system/keys.rst
new file mode 100644
index 0000000000..bf99ee8d5b
--- /dev/null
+++ b/docs/system/keys.rst
@@ -0,0 +1,40 @@
+.. _pcsys_005fkeys:
+
+Keys in the graphical frontends
+-------------------------------
+
+During the graphical emulation, you can use special key combinations to
+change modes. The default key mappings are shown below, but if you use
+``-alt-grab`` then the modifier is Ctrl-Alt-Shift (instead of Ctrl-Alt)
+and if you use ``-ctrl-grab`` then the modifier is the right Ctrl key
+(instead of Ctrl-Alt):
+
+Ctrl-Alt-f
+   Toggle full screen
+
+Ctrl-Alt-+
+   Enlarge the screen
+
+Ctrl-Alt\--
+   Shrink the screen
+
+Ctrl-Alt-u
+   Restore the screen's un-scaled dimensions
+
+Ctrl-Alt-n
+   Switch to virtual console 'n'. Standard console mappings are:
+
+   *1*
+      Target system display
+
+   *2*
+      Monitor
+
+   *3*
+      Serial port
+
+Ctrl-Alt
+   Toggle mouse and keyboard grab.
+
+In the virtual consoles, you can use Ctrl-Up, Ctrl-Down, Ctrl-PageUp and
+Ctrl-PageDown to move in the back log.
diff --git a/docs/system/license.rst b/docs/system/license.rst
new file mode 100644
index 0000000000..cde3d2d25d
--- /dev/null
+++ b/docs/system/license.rst
@@ -0,0 +1,11 @@
+.. _License:
+
+License
+=======
+
+QEMU is a trademark of Fabrice Bellard.
+
+QEMU is released under the `GNU General Public
+License <https://www.gnu.org/licenses/gpl-2.0.txt>`__, version 2. Parts
+of QEMU have specific licenses, see file
+`LICENSE <https://git.qemu.org/?p=qemu.git;a=blob_plain;f=LICENSE>`__.
diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
new file mode 100644
index 0000000000..e2f976db96
--- /dev/null
+++ b/docs/system/linuxboot.rst
@@ -0,0 +1,30 @@
+.. _direct_005flinux_005fboot:
+
+Direct Linux Boot
+-----------------
+
+This section explains how to launch a Linux kernel inside QEMU without
+having to make a full bootable image. It is very useful for fast Linux
+kernel testing.
+
+The syntax is:
+
+.. parsed-literal::
+
+   |qemu_system| -kernel bzImage -hda rootdisk.img -append "root=/dev/hda"
+
+Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
+give the kernel command line arguments. The ``-initrd`` option can be
+used to provide an INITRD image.
+
+If you do not need graphical output, you can disable it and redirect the
+virtual serial port and the QEMU monitor to the console with the
+``-nographic`` option. The typical command line is:
+
+.. parsed-literal::
+
+   |qemu_system| -kernel bzImage -hda rootdisk.img \
+                    -append "root=/dev/hda console=ttyS0" -nographic
+
+Use Ctrl-a c to switch between the serial console and the monitor (see
+`pcsys_keys <#pcsys_005fkeys>`__).
diff --git a/docs/system/monitor.rst b/docs/system/monitor.rst
new file mode 100644
index 0000000000..482f391f32
--- /dev/null
+++ b/docs/system/monitor.rst
@@ -0,0 +1,25 @@
+.. _pcsys_005fmonitor:
+
+QEMU Monitor
+------------
+
+The QEMU monitor is used to give complex commands to the QEMU emulator.
+You can use it to:
+
+-  Remove or insert removable media images (such as CD-ROM or
+   floppies).
+
+-  Freeze/unfreeze the Virtual Machine (VM) and save or restore its
+   state from a disk file.
+
+-  Inspect the VM state without an external debugger.
+
+..
+  The commands section goes here once it's converted from Texinfo to RST.
+
+Integer expressions
+~~~~~~~~~~~~~~~~~~~
+
+The monitor understands integers expressions for every integer argument.
+You can use register names to get the value of specifics CPU registers
+by prefixing them with *$*.
diff --git a/docs/system/mux-chardev.rst b/docs/system/mux-chardev.rst
new file mode 100644
index 0000000000..e50172c081
--- /dev/null
+++ b/docs/system/mux-chardev.rst
@@ -0,0 +1,32 @@
+.. _mux_005fkeys:
+
+Keys in the character backend multiplexer
+-----------------------------------------
+
+During emulation, if you are using a character backend multiplexer
+(which is the default if you are using ``-nographic``) then several
+commands are available via an escape sequence. These key sequences all
+start with an escape character, which is Ctrl-a by default, but can be
+changed with ``-echr``. The list below assumes you're using the default.
+
+Ctrl-a h
+   Print this help
+
+Ctrl-a x
+   Exit emulator
+
+Ctrl-a s
+   Save disk data back to file (if -snapshot)
+
+Ctrl-a t
+   Toggle console timestamps
+
+Ctrl-a b
+   Send break (magic sysrq in Linux)
+
+Ctrl-a c
+   Rotate between the frontends connected to the multiplexer (usually
+   this switches between the monitor and the console)
+
+Ctrl-a Ctrl-a
+   Send the escape character to the frontend
diff --git a/docs/system/net.rst b/docs/system/net.rst
new file mode 100644
index 0000000000..0956f967d7
--- /dev/null
+++ b/docs/system/net.rst
@@ -0,0 +1,100 @@
+.. _pcsys_005fnetwork:
+
+Network emulation
+-----------------
+
+QEMU can simulate several network cards (e.g. PCI or ISA cards on the PC
+target) and can connect them to a network backend on the host or an
+emulated hub. The various host network backends can either be used to
+connect the NIC of the guest to a real network (e.g. by using a TAP
+devices or the non-privileged user mode network stack), or to other
+guest instances running in another QEMU process (e.g. by using the
+socket host network backend).
+
+Using TAP network interfaces
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This is the standard way to connect QEMU to a real network. QEMU adds a
+virtual network device on your host (called ``tapN``), and you can then
+configure it as if it was a real ethernet card.
+
+Linux host
+^^^^^^^^^^
+
+As an example, you can download the ``linux-test-xxx.tar.gz`` archive
+and copy the script ``qemu-ifup`` in ``/etc`` and configure properly
+``sudo`` so that the command ``ifconfig`` contained in ``qemu-ifup`` can
+be executed as root. You must verify that your host kernel supports the
+TAP network interfaces: the device ``/dev/net/tun`` must be present.
+
+See `sec_invocation <#sec_005finvocation>`__ to have examples of command
+lines using the TAP network interfaces.
+
+Windows host
+^^^^^^^^^^^^
+
+There is a virtual ethernet driver for Windows 2000/XP systems, called
+TAP-Win32. But it is not included in standard QEMU for Windows, so you
+will need to get it separately. It is part of OpenVPN package, so
+download OpenVPN from : https://openvpn.net/.
+
+Using the user mode network stack
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+By using the option ``-net user`` (default configuration if no ``-net``
+option is specified), QEMU uses a completely user mode network stack
+(you don't need root privilege to use the virtual network). The virtual
+network configuration is the following::
+
+        guest (10.0.2.15)  <------>  Firewall/DHCP server <-----> Internet
+                              |          (10.0.2.2)
+                              |
+                              ---->  DNS server (10.0.2.3)
+                              |
+                              ---->  SMB server (10.0.2.4)
+
+The QEMU VM behaves as if it was behind a firewall which blocks all
+incoming connections. You can use a DHCP client to automatically
+configure the network in the QEMU VM. The DHCP server assign addresses
+to the hosts starting from 10.0.2.15.
+
+In order to check that the user mode network is working, you can ping
+the address 10.0.2.2 and verify that you got an address in the range
+10.0.2.x from the QEMU virtual DHCP server.
+
+Note that ICMP traffic in general does not work with user mode
+networking. ``ping``, aka. ICMP echo, to the local router (10.0.2.2)
+shall work, however. If you're using QEMU on Linux >= 3.0, it can use
+unprivileged ICMP ping sockets to allow ``ping`` to the Internet. The
+host admin has to set the ping_group_range in order to grant access to
+those sockets. To allow ping for GID 100 (usually users group)::
+
+   echo 100 100 > /proc/sys/net/ipv4/ping_group_range
+
+When using the built-in TFTP server, the router is also the TFTP server.
+
+When using the ``'-netdev user,hostfwd=...'`` option, TCP or UDP
+connections can be redirected from the host to the guest. It allows for
+example to redirect X11, telnet or SSH connections.
+
+Hubs
+~~~~
+
+QEMU can simulate several hubs. A hub can be thought of as a virtual
+connection between several network devices. These devices can be for
+example QEMU virtual ethernet cards or virtual Host ethernet devices
+(TAP devices). You can connect guest NICs or host network backends to
+such a hub using the ``-netdev
+hubport`` or ``-nic hubport`` options. The legacy ``-net`` option also
+connects the given device to the emulated hub with ID 0 (i.e. the
+default hub) unless you specify a netdev with ``-net nic,netdev=xxx``
+here.
+
+Connecting emulated networks between QEMU instances
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Using the ``-netdev socket`` (or ``-nic socket`` or ``-net socket``)
+option, it is possible to create emulated networks that span several
+QEMU instances. See the description of the ``-netdev socket`` option in
+the `Invocation chapter <#sec_005finvocation>`__ to have a basic
+example.
diff --git a/docs/system/quickstart.rst b/docs/system/quickstart.rst
new file mode 100644
index 0000000000..3a3acab5e7
--- /dev/null
+++ b/docs/system/quickstart.rst
@@ -0,0 +1,13 @@
+.. _pcsys_005fquickstart:
+
+Quick Start
+-----------
+
+Download and uncompress a PC hard disk image with Linux installed (e.g.
+``linux.img``) and type:
+
+.. parsed-literal::
+
+   |qemu_system| linux.img
+
+Linux should boot and give you a prompt.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
new file mode 100644
index 0000000000..fcd8f43eef
--- /dev/null
+++ b/docs/system/target-arm.rst
@@ -0,0 +1,227 @@
+.. _ARM-System-emulator:
+
+ARM System emulator
+-------------------
+
+Use the executable ``qemu-system-arm`` to simulate a ARM machine. The
+ARM Integrator/CP board is emulated with the following devices:
+
+-  ARM926E, ARM1026E, ARM946E, ARM1136 or Cortex-A8 CPU
+
+-  Two PL011 UARTs
+
+-  SMC 91c111 Ethernet adapter
+
+-  PL110 LCD controller
+
+-  PL050 KMI with PS/2 keyboard and mouse.
+
+-  PL181 MultiMedia Card Interface with SD card.
+
+The ARM Versatile baseboard is emulated with the following devices:
+
+-  ARM926E, ARM1136 or Cortex-A8 CPU
+
+-  PL190 Vectored Interrupt Controller
+
+-  Four PL011 UARTs
+
+-  SMC 91c111 Ethernet adapter
+
+-  PL110 LCD controller
+
+-  PL050 KMI with PS/2 keyboard and mouse.
+
+-  PCI host bridge. Note the emulated PCI bridge only provides access
+   to PCI memory space. It does not provide access to PCI IO space. This
+   means some devices (eg. ne2k_pci NIC) are not usable, and others (eg.
+   rtl8139 NIC) are only usable when the guest drivers use the memory
+   mapped control registers.
+
+-  PCI OHCI USB controller.
+
+-  LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM
+   devices.
+
+-  PL181 MultiMedia Card Interface with SD card.
+
+Several variants of the ARM RealView baseboard are emulated, including
+the EB, PB-A8 and PBX-A9. Due to interactions with the bootloader, only
+certain Linux kernel configurations work out of the box on these boards.
+
+Kernels for the PB-A8 board should have CONFIG_REALVIEW_HIGH_PHYS_OFFSET
+enabled in the kernel, and expect 512M RAM. Kernels for The PBX-A9 board
+should have CONFIG_SPARSEMEM enabled, CONFIG_REALVIEW_HIGH_PHYS_OFFSET
+disabled and expect 1024M RAM.
+
+The following devices are emulated:
+
+-  ARM926E, ARM1136, ARM11MPCore, Cortex-A8 or Cortex-A9 MPCore CPU
+
+-  ARM AMBA Generic/Distributed Interrupt Controller
+
+-  Four PL011 UARTs
+
+-  SMC 91c111 or SMSC LAN9118 Ethernet adapter
+
+-  PL110 LCD controller
+
+-  PL050 KMI with PS/2 keyboard and mouse
+
+-  PCI host bridge
+
+-  PCI OHCI USB controller
+
+-  LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM
+   devices
+
+-  PL181 MultiMedia Card Interface with SD card.
+
+The XScale-based clamshell PDA models (\"Spitz\", \"Akita\", \"Borzoi\"
+and \"Terrier\") emulation includes the following peripherals:
+
+-  Intel PXA270 System-on-chip (ARM V5TE core)
+
+-  NAND Flash memory
+
+-  IBM/Hitachi DSCM microdrive in a PXA PCMCIA slot - not in \"Akita\"
+
+-  On-chip OHCI USB controller
+
+-  On-chip LCD controller
+
+-  On-chip Real Time Clock
+
+-  TI ADS7846 touchscreen controller on SSP bus
+
+-  Maxim MAX1111 analog-digital converter on I\ :math:`^2`\ C bus
+
+-  GPIO-connected keyboard controller and LEDs
+
+-  Secure Digital card connected to PXA MMC/SD host
+
+-  Three on-chip UARTs
+
+-  WM8750 audio CODEC on I\ :math:`^2`\ C and I\ :math:`^2`\ S busses
+
+The Palm Tungsten|E PDA (codename \"Cheetah\") emulation includes the
+following elements:
+
+-  Texas Instruments OMAP310 System-on-chip (ARM 925T core)
+
+-  ROM and RAM memories (ROM firmware image can be loaded with
+   -option-rom)
+
+-  On-chip LCD controller
+
+-  On-chip Real Time Clock
+
+-  TI TSC2102i touchscreen controller / analog-digital converter /
+   Audio CODEC, connected through MicroWire and I\ :math:`^2`\ S busses
+
+-  GPIO-connected matrix keypad
+
+-  Secure Digital card connected to OMAP MMC/SD host
+
+-  Three on-chip UARTs
+
+Nokia N800 and N810 internet tablets (known also as RX-34 and RX-44 /
+48) emulation supports the following elements:
+
+-  Texas Instruments OMAP2420 System-on-chip (ARM 1136 core)
+
+-  RAM and non-volatile OneNAND Flash memories
+
+-  Display connected to EPSON remote framebuffer chip and OMAP on-chip
+   display controller and a LS041y3 MIPI DBI-C controller
+
+-  TI TSC2301 (in N800) and TI TSC2005 (in N810) touchscreen
+   controllers driven through SPI bus
+
+-  National Semiconductor LM8323-controlled qwerty keyboard driven
+   through I\ :math:`^2`\ C bus
+
+-  Secure Digital card connected to OMAP MMC/SD host
+
+-  Three OMAP on-chip UARTs and on-chip STI debugging console
+
+-  Mentor Graphics \"Inventra\" dual-role USB controller embedded in a
+   TI TUSB6010 chip - only USB host mode is supported
+
+-  TI TMP105 temperature sensor driven through I\ :math:`^2`\ C bus
+
+-  TI TWL92230C power management companion with an RTC on
+   I\ :math:`^2`\ C bus
+
+-  Nokia RETU and TAHVO multi-purpose chips with an RTC, connected
+   through CBUS
+
+The Luminary Micro Stellaris LM3S811EVB emulation includes the following
+devices:
+
+-  Cortex-M3 CPU core.
+
+-  64k Flash and 8k SRAM.
+
+-  Timers, UARTs, ADC and I\ :math:`^2`\ C interface.
+
+-  OSRAM Pictiva 96x16 OLED with SSD0303 controller on
+   I\ :math:`^2`\ C bus.
+
+The Luminary Micro Stellaris LM3S6965EVB emulation includes the
+following devices:
+
+-  Cortex-M3 CPU core.
+
+-  256k Flash and 64k SRAM.
+
+-  Timers, UARTs, ADC, I\ :math:`^2`\ C and SSI interfaces.
+
+-  OSRAM Pictiva 128x64 OLED with SSD0323 controller connected via
+   SSI.
+
+The Freecom MusicPal internet radio emulation includes the following
+elements:
+
+-  Marvell MV88W8618 ARM core.
+
+-  32 MB RAM, 256 KB SRAM, 8 MB flash.
+
+-  Up to 2 16550 UARTs
+
+-  MV88W8xx8 Ethernet controller
+
+-  MV88W8618 audio controller, WM8750 CODEC and mixer
+
+-  128x64 display with brightness control
+
+-  2 buttons, 2 navigation wheels with button function
+
+The Siemens SX1 models v1 and v2 (default) basic emulation. The
+emulation includes the following elements:
+
+-  Texas Instruments OMAP310 System-on-chip (ARM 925T core)
+
+-  ROM and RAM memories (ROM firmware image can be loaded with
+   -pflash) V1 1 Flash of 16MB and 1 Flash of 8MB V2 1 Flash of 32MB
+
+-  On-chip LCD controller
+
+-  On-chip Real Time Clock
+
+-  Secure Digital card connected to OMAP MMC/SD host
+
+-  Three on-chip UARTs
+
+A Linux 2.6 test image is available on the QEMU web site. More
+information is available in the QEMU mailing-list archive.
+
+The following options are specific to the ARM emulation:
+
+``-semihosting``
+   Enable semihosting syscall emulation.
+
+   On ARM this implements the \"Angel\" interface.
+
+   Note that this allows guest direct access to the host filesystem, so
+   should only be used with trusted guest OS.
diff --git a/docs/system/target-i386.rst b/docs/system/target-i386.rst
new file mode 100644
index 0000000000..391170351d
--- /dev/null
+++ b/docs/system/target-i386.rst
@@ -0,0 +1,84 @@
+.. _QEMU-PC-System-emulator:
+
+x86 (PC) System emulator
+------------------------
+
+.. _pcsys_005fdevices:
+
+Peripherals
+~~~~~~~~~~~
+
+The QEMU PC System emulator simulates the following peripherals:
+
+-  i440FX host PCI bridge and PIIX3 PCI to ISA bridge
+
+-  Cirrus CLGD 5446 PCI VGA card or dummy VGA card with Bochs VESA
+   extensions (hardware level, including all non standard modes).
+
+-  PS/2 mouse and keyboard
+
+-  2 PCI IDE interfaces with hard disk and CD-ROM support
+
+-  Floppy disk
+
+-  PCI and ISA network adapters
+
+-  Serial ports
+
+-  IPMI BMC, either and internal or external one
+
+-  Creative SoundBlaster 16 sound card
+
+-  ENSONIQ AudioPCI ES1370 sound card
+
+-  Intel 82801AA AC97 Audio compatible sound card
+
+-  Intel HD Audio Controller and HDA codec
+
+-  Adlib (OPL2) - Yamaha YM3812 compatible chip
+
+-  Gravis Ultrasound GF1 sound card
+
+-  CS4231A compatible sound card
+
+-  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
+   hub.
+
+SMP is supported with up to 255 CPUs.
+
+QEMU uses the PC BIOS from the Seabios project and the Plex86/Bochs LGPL
+VGA BIOS.
+
+QEMU uses YM3812 emulation by Tatsuyuki Satoh.
+
+QEMU uses GUS emulation (GUSEMU32 http://www.deinmeister.de/gusemu/) by
+Tibor \"TS\" Schütz.
+
+Note that, by default, GUS shares IRQ(7) with parallel ports and so QEMU
+must be told to not have parallel ports to have working GUS.
+
+.. parsed-literal::
+
+   |qemu_system_x86| dos.img -soundhw gus -parallel none
+
+Alternatively:
+
+.. parsed-literal::
+
+   |qemu_system_x86| dos.img -device gus,irq=5
+
+Or some other unclaimed IRQ.
+
+CS4231A is the chip used in Windows Sound System and GUSMAX products
+
+.. include:: cpu-models-x86.rst.inc
+
+.. _pcsys_005freq:
+
+OS requirements
+---------------
+
+On x86_64 hosts, the default set of CPU features enabled by the KVM
+accelerator require the host to be running Linux v4.5 or newer. Red Hat
+Enterprise Linux 7 is also supported, since the required
+functionality was backported.
diff --git a/docs/system/target-m68k.rst b/docs/system/target-m68k.rst
new file mode 100644
index 0000000000..50b7dd9d63
--- /dev/null
+++ b/docs/system/target-m68k.rst
@@ -0,0 +1,32 @@
+.. _ColdFire-System-emulator:
+
+ColdFire System emulator
+------------------------
+
+Use the executable ``qemu-system-m68k`` to simulate a ColdFire machine.
+The emulator is able to boot a uClinux kernel.
+
+The M5208EVB emulation includes the following devices:
+
+-  MCF5208 ColdFire V2 Microprocessor (ISA A+ with EMAC).
+
+-  Three Two on-chip UARTs.
+
+-  Fast Ethernet Controller (FEC)
+
+The AN5206 emulation includes the following devices:
+
+-  MCF5206 ColdFire V2 Microprocessor.
+
+-  Two on-chip UARTs.
+
+The following options are specific to the ColdFire emulation:
+
+``-semihosting``
+   Enable semihosting syscall emulation.
+
+   On M68K this implements the \"ColdFire GDB\" interface used by
+   libgloss.
+
+   Note that this allows guest direct access to the host filesystem, so
+   should only be used with trusted guest OS.
diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
new file mode 100644
index 0000000000..2736fd0509
--- /dev/null
+++ b/docs/system/target-mips.rst
@@ -0,0 +1,120 @@
+.. _MIPS-System-emulator:
+
+MIPS System emulator
+--------------------
+
+Four executables cover simulation of 32 and 64-bit MIPS systems in both
+endian options, ``qemu-system-mips``, ``qemu-system-mipsel``
+``qemu-system-mips64`` and ``qemu-system-mips64el``. Five different
+machine types are emulated:
+
+-  A generic ISA PC-like machine \"mips\"
+
+-  The MIPS Malta prototype board \"malta\"
+
+-  An ACER Pica \"pica61\". This machine needs the 64-bit emulator.
+
+-  MIPS emulator pseudo board \"mipssim\"
+
+-  A MIPS Magnum R4000 machine \"magnum\". This machine needs the
+   64-bit emulator.
+
+The generic emulation is supported by Debian 'Etch' and is able to
+install Debian into a virtual disk image. The following devices are
+emulated:
+
+-  A range of MIPS CPUs, default is the 24Kf
+
+-  PC style serial port
+
+-  PC style IDE disk
+
+-  NE2000 network card
+
+The Malta emulation supports the following devices:
+
+-  Core board with MIPS 24Kf CPU and Galileo system controller
+
+-  PIIX4 PCI/USB/SMbus controller
+
+-  The Multi-I/O chip's serial device
+
+-  PCI network cards (PCnet32 and others)
+
+-  Malta FPGA serial device
+
+-  Cirrus (default) or any other PCI VGA graphics card
+
+The Boston board emulation supports the following devices:
+
+-  Xilinx FPGA, which includes a PCIe root port and an UART
+
+-  Intel EG20T PCH connects the I/O peripherals, but only the SATA bus
+   is emulated
+
+The ACER Pica emulation supports:
+
+-  MIPS R4000 CPU
+
+-  PC-style IRQ and DMA controllers
+
+-  PC Keyboard
+
+-  IDE controller
+
+The MIPS Magnum R4000 emulation supports:
+
+-  MIPS R4000 CPU
+
+-  PC-style IRQ controller
+
+-  PC Keyboard
+
+-  SCSI controller
+
+-  G364 framebuffer
+
+The Fulong 2E emulation supports:
+
+-  Loongson 2E CPU
+
+-  Bonito64 system controller as North Bridge
+
+-  VT82C686 chipset as South Bridge
+
+-  RTL8139D as a network card chipset
+
+The mipssim pseudo board emulation provides an environment similar to
+what the proprietary MIPS emulator uses for running Linux. It supports:
+
+-  A range of MIPS CPUs, default is the 24Kf
+
+-  PC style serial port
+
+-  MIPSnet network emulation
+
+.. include:: cpu-models-mips.rst.inc
+
+.. _nanoMIPS-System-emulator:
+
+nanoMIPS System emulator
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Executable ``qemu-system-mipsel`` also covers simulation of 32-bit
+nanoMIPS system in little endian mode:
+
+-  nanoMIPS I7200 CPU
+
+Example of ``qemu-system-mipsel`` usage for nanoMIPS is shown below:
+
+Download ``<disk_image_file>`` from
+https://mipsdistros.mips.com/LinuxDistro/nanomips/buildroot/index.html.
+
+Download ``<kernel_image_file>`` from
+https://mipsdistros.mips.com/LinuxDistro/nanomips/kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/index.html.
+
+Start system emulation of Malta board with nanoMIPS I7200 CPU::
+
+   qemu-system-mipsel -cpu I7200 -kernel <kernel_image_file> \
+       -M malta -serial stdio -m <memory_size> -hda <disk_image_file> \
+       -append "mem=256m@0x0 rw console=ttyS0 vga=cirrus vesa=0x111 root=/dev/sda"
diff --git a/docs/system/target-ppc.rst b/docs/system/target-ppc.rst
new file mode 100644
index 0000000000..43fadf3c00
--- /dev/null
+++ b/docs/system/target-ppc.rst
@@ -0,0 +1,61 @@
+.. _PowerPC-System-emulator:
+
+PowerPC System emulator
+-----------------------
+
+Use the executable ``qemu-system-ppc`` to simulate a complete 40P (PREP)
+or PowerMac PowerPC system.
+
+QEMU emulates the following PowerMac peripherals:
+
+-  UniNorth or Grackle PCI Bridge
+
+-  PCI VGA compatible card with VESA Bochs Extensions
+
+-  2 PMAC IDE interfaces with hard disk and CD-ROM support
+
+-  NE2000 PCI adapters
+
+-  Non Volatile RAM
+
+-  VIA-CUDA with ADB keyboard and mouse.
+
+QEMU emulates the following 40P (PREP) peripherals:
+
+-  PCI Bridge
+
+-  PCI VGA compatible card with VESA Bochs Extensions
+
+-  2 IDE interfaces with hard disk and CD-ROM support
+
+-  Floppy disk
+
+-  PCnet network adapters
+
+-  Serial port
+
+-  PREP Non Volatile RAM
+
+-  PC compatible keyboard and mouse.
+
+Since version 0.9.1, QEMU uses OpenBIOS https://www.openbios.org/ for
+the g3beige and mac99 PowerMac and the 40p machines. OpenBIOS is a free
+(GPL v2) portable firmware implementation. The goal is to implement a
+100% IEEE 1275-1994 (referred to as Open Firmware) compliant firmware.
+
+The following options are specific to the PowerPC emulation:
+
+``-g WxH[xDEPTH]``
+   Set the initial VGA graphic mode. The default is 800x600x32.
+
+``-prom-env string``
+   Set OpenBIOS variables in NVRAM, for example:
+
+   ::
+
+      qemu-system-ppc -prom-env 'auto-boot?=false' \
+       -prom-env 'boot-device=hd:2,\yaboot' \
+       -prom-env 'boot-args=conf=hd:2,\yaboot.conf'
+
+More information is available at
+http://perso.magic.fr/l_indien/qemu-ppc/.
diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
new file mode 100644
index 0000000000..589c88d175
--- /dev/null
+++ b/docs/system/target-sparc.rst
@@ -0,0 +1,81 @@
+.. _Sparc32-System-emulator:
+
+Sparc32 System emulator
+-----------------------
+
+Use the executable ``qemu-system-sparc`` to simulate the following Sun4m
+architecture machines:
+
+-  SPARCstation 4
+
+-  SPARCstation 5
+
+-  SPARCstation 10
+
+-  SPARCstation 20
+
+-  SPARCserver 600MP
+
+-  SPARCstation LX
+
+-  SPARCstation Voyager
+
+-  SPARCclassic
+
+-  SPARCbook
+
+The emulation is somewhat complete. SMP up to 16 CPUs is supported, but
+Linux limits the number of usable CPUs to 4.
+
+QEMU emulates the following sun4m peripherals:
+
+-  IOMMU
+
+-  TCX or cgthree Frame buffer
+
+-  Lance (Am7990) Ethernet
+
+-  Non Volatile RAM M48T02/M48T08
+
+-  Slave I/O: timers, interrupt controllers, Zilog serial ports,
+   keyboard and power/reset logic
+
+-  ESP SCSI controller with hard disk and CD-ROM support
+
+-  Floppy drive (not on SS-600MP)
+
+-  CS4231 sound device (only on SS-5, not working yet)
+
+The number of peripherals is fixed in the architecture. Maximum memory
+size depends on the machine type, for SS-5 it is 256MB and for others
+2047MB.
+
+Since version 0.8.2, QEMU uses OpenBIOS https://www.openbios.org/.
+OpenBIOS is a free (GPL v2) portable firmware implementation. The goal
+is to implement a 100% IEEE 1275-1994 (referred to as Open Firmware)
+compliant firmware.
+
+A sample Linux 2.6 series kernel and ram disk image are available on the
+QEMU web site. There are still issues with NetBSD and OpenBSD, but most
+kernel versions work. Please note that currently older Solaris kernels
+don't work probably due to interface issues between OpenBIOS and
+Solaris.
+
+The following options are specific to the Sparc32 emulation:
+
+``-g WxHx[xDEPTH]``
+   Set the initial graphics mode. For TCX, the default is 1024x768x8
+   with the option of 1024x768x24. For cgthree, the default is
+   1024x768x8 with the option of 1152x900x8 for people who wish to use
+   OBP.
+
+``-prom-env string``
+   Set OpenBIOS variables in NVRAM, for example:
+
+   ::
+
+      qemu-system-sparc -prom-env 'auto-boot?=false' \
+       -prom-env 'boot-device=sd(0,2,0):d' -prom-env 'boot-args=linux single'
+
+``-M [SS-4|SS-5|SS-10|SS-20|SS-600MP|LX|Voyager|SPARCClassic] [|SPARCbook]``
+   Set the emulated machine type. Default is SS-5.
diff --git a/docs/system/target-sparc64.rst b/docs/system/target-sparc64.rst
new file mode 100644
index 0000000000..ca76ba9c48
--- /dev/null
+++ b/docs/system/target-sparc64.rst
@@ -0,0 +1,49 @@
+.. _Sparc64-System-emulator:
+
+Sparc64 System emulator
+-----------------------
+
+Use the executable ``qemu-system-sparc64`` to simulate a Sun4u
+(UltraSPARC PC-like machine), Sun4v (T1 PC-like machine), or generic
+Niagara (T1) machine. The Sun4u emulator is mostly complete, being able
+to run Linux, NetBSD and OpenBSD in headless (-nographic) mode. The
+Sun4v emulator is still a work in progress.
+
+The Niagara T1 emulator makes use of firmware and OS binaries supplied
+in the S10image/ directory of the OpenSPARC T1 project
+http://download.oracle.com/technetwork/systems/opensparc/OpenSPARCT1_Arch.1.5.tar.bz2
+and is able to boot the disk.s10hw2 Solaris image.
+
+::
+
+   qemu-system-sparc64 -M niagara -L /path-to/S10image/ \
+                       -nographic -m 256 \
+                       -drive if=pflash,readonly=on,file=/S10image/disk.s10hw2
+
+QEMU emulates the following peripherals:
+
+-  UltraSparc IIi APB PCI Bridge
+
+-  PCI VGA compatible card with VESA Bochs Extensions
+
+-  PS/2 mouse and keyboard
+
+-  Non Volatile RAM M48T59
+
+-  PC-compatible serial ports
+
+-  2 PCI IDE interfaces with hard disk and CD-ROM support
+
+-  Floppy disk
+
+The following options are specific to the Sparc64 emulation:
+
+``-prom-env string``
+   Set OpenBIOS variables in NVRAM, for example:
+
+   ::
+
+      qemu-system-sparc64 -prom-env 'auto-boot?=false'
+
+``-M [sun4u|sun4v|niagara]``
+   Set the emulated machine type. The default is sun4u.
diff --git a/docs/system/target-xtensa.rst b/docs/system/target-xtensa.rst
new file mode 100644
index 0000000000..43cab8dc4d
--- /dev/null
+++ b/docs/system/target-xtensa.rst
@@ -0,0 +1,39 @@
+.. _Xtensa-System-emulator:
+
+Xtensa System emulator
+----------------------
+
+Two executables cover simulation of both Xtensa endian options,
+``qemu-system-xtensa`` and ``qemu-system-xtensaeb``. Two different
+machine types are emulated:
+
+-  Xtensa emulator pseudo board \"sim\"
+
+-  Avnet LX60/LX110/LX200 board
+
+The sim pseudo board emulation provides an environment similar to one
+provided by the proprietary Tensilica ISS. It supports:
+
+-  A range of Xtensa CPUs, default is the DC232B
+
+-  Console and filesystem access via semihosting calls
+
+The Avnet LX60/LX110/LX200 emulation supports:
+
+-  A range of Xtensa CPUs, default is the DC232B
+
+-  16550 UART
+
+-  OpenCores 10/100 Mbps Ethernet MAC
+
+The following options are specific to the Xtensa emulation:
+
+``-semihosting``
+   Enable semihosting syscall emulation.
+
+   Xtensa semihosting provides basic file IO calls, such as
+   open/read/write/seek/select. Tensilica baremetal libc for ISS and
+   linux platform \"sim\" use this interface.
+
+   Note that this allows guest direct access to the host filesystem, so
+   should only be used with trusted guest OS.
diff --git a/docs/system/targets.rst b/docs/system/targets.rst
new file mode 100644
index 0000000000..eba3111247
--- /dev/null
+++ b/docs/system/targets.rst
@@ -0,0 +1,19 @@
+QEMU System Emulator Targets
+============================
+
+QEMU is a generic emulator and it emulates many machines. Most of the
+options are similar for all machines. Specific information about the
+various targets are mentioned in the following sections.
+
+Contents:
+
+.. toctree::
+
+   target-i386
+   target-ppc
+   target-sparc
+   target-sparc64
+   target-mips
+   target-arm
+   target-m68k
+   target-xtensa
diff --git a/docs/system/tls.rst b/docs/system/tls.rst
new file mode 100644
index 0000000000..dc2b94257f
--- /dev/null
+++ b/docs/system/tls.rst
@@ -0,0 +1,328 @@
+.. _network_005ftls:
+
+TLS setup for network services
+------------------------------
+
+Almost all network services in QEMU have the ability to use TLS for
+session data encryption, along with x509 certificates for simple client
+authentication. What follows is a description of how to generate
+certificates suitable for usage with QEMU, and applies to the VNC
+server, character devices with the TCP backend, NBD server and client,
+and migration server and client.
+
+At a high level, QEMU requires certificates and private keys to be
+provided in PEM format. Aside from the core fields, the certificates
+should include various extension data sets, including v3 basic
+constraints data, key purpose, key usage and subject alt name.
+
+The GnuTLS package includes a command called ``certtool`` which can be
+used to easily generate certificates and keys in the required format
+with expected data present. Alternatively a certificate management
+service may be used.
+
+At a minimum it is necessary to setup a certificate authority, and issue
+certificates to each server. If using x509 certificates for
+authentication, then each client will also need to be issued a
+certificate.
+
+Assuming that the QEMU network services will only ever be exposed to
+clients on a private intranet, there is no need to use a commercial
+certificate authority to create certificates. A self-signed CA is
+sufficient, and in fact likely to be more secure since it removes the
+ability of malicious 3rd parties to trick the CA into mis-issuing certs
+for impersonating your services. The only likely exception where a
+commercial CA might be desirable is if enabling the VNC websockets
+server and exposing it directly to remote browser clients. In such a
+case it might be useful to use a commercial CA to avoid needing to
+install custom CA certs in the web browsers.
+
+The recommendation is for the server to keep its certificates in either
+``/etc/pki/qemu`` or for unprivileged users in ``$HOME/.pki/qemu``.
+
+.. _tls_005fgenerate_005fca:
+
+Setup the Certificate Authority
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This step only needs to be performed once per organization /
+organizational unit. First the CA needs a private key. This key must be
+kept VERY secret and secure. If this key is compromised the entire trust
+chain of the certificates issued with it is lost.
+
+::
+
+   # certtool --generate-privkey > ca-key.pem
+
+To generate a self-signed certificate requires one core piece of
+information, the name of the organization. A template file ``ca.info``
+should be populated with the desired data to avoid having to deal with
+interactive prompts from certtool::
+
+   # cat > ca.info <<EOF
+   cn = Name of your organization
+   ca
+   cert_signing_key
+   EOF
+   # certtool --generate-self-signed \
+              --load-privkey ca-key.pem
+              --template ca.info \
+              --outfile ca-cert.pem
+
+The ``ca`` keyword in the template sets the v3 basic constraints
+extension to indicate this certificate is for a CA, while
+``cert_signing_key`` sets the key usage extension to indicate this will
+be used for signing other keys. The generated ``ca-cert.pem`` file
+should be copied to all servers and clients wishing to utilize TLS
+support in the VNC server. The ``ca-key.pem`` must not be
+disclosed/copied anywhere except the host responsible for issuing
+certificates.
+
+.. _tls_005fgenerate_005fserver:
+
+Issuing server certificates
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Each server (or host) needs to be issued with a key and certificate.
+When connecting the certificate is sent to the client which validates it
+against the CA certificate. The core pieces of information for a server
+certificate are the hostnames and/or IP addresses that will be used by
+clients when connecting. The hostname / IP address that the client
+specifies when connecting will be validated against the hostname(s) and
+IP address(es) recorded in the server certificate, and if no match is
+found the client will close the connection.
+
+Thus it is recommended that the server certificate include both the
+fully qualified and unqualified hostnames. If the server will have
+permanently assigned IP address(es), and clients are likely to use them
+when connecting, they may also be included in the certificate. Both IPv4
+and IPv6 addresses are supported. Historically certificates only
+included 1 hostname in the ``CN`` field, however, usage of this field
+for validation is now deprecated. Instead modern TLS clients will
+validate against the Subject Alt Name extension data, which allows for
+multiple entries. In the future usage of the ``CN`` field may be
+discontinued entirely, so providing SAN extension data is strongly
+recommended.
+
+On the host holding the CA, create template files containing the
+information for each server, and use it to issue server certificates.
+
+::
+
+   # cat > server-hostNNN.info <<EOF
+   organization = Name  of your organization
+   cn = hostNNN.foo.example.com
+   dns_name = hostNNN
+   dns_name = hostNNN.foo.example.com
+   ip_address = 10.0.1.87
+   ip_address = 192.8.0.92
+   ip_address = 2620:0:cafe::87
+   ip_address = 2001:24::92
+   tls_www_server
+   encryption_key
+   signing_key
+   EOF
+   # certtool --generate-privkey > server-hostNNN-key.pem
+   # certtool --generate-certificate \
+              --load-ca-certificate ca-cert.pem \
+              --load-ca-privkey ca-key.pem \
+              --load-privkey server-hostNNN-key.pem \
+              --template server-hostNNN.info \
+              --outfile server-hostNNN-cert.pem
+
+The ``dns_name`` and ``ip_address`` fields in the template are setting
+the subject alt name extension data. The ``tls_www_server`` keyword is
+the key purpose extension to indicate this certificate is intended for
+usage in a web server. Although QEMU network services are not in fact
+HTTP servers (except for VNC websockets), setting this key purpose is
+still recommended. The ``encryption_key`` and ``signing_key`` keyword is
+the key usage extension to indicate this certificate is intended for
+usage in the data session.
+
+The ``server-hostNNN-key.pem`` and ``server-hostNNN-cert.pem`` files
+should now be securely copied to the server for which they were
+generated, and renamed to ``server-key.pem`` and ``server-cert.pem``
+when added to the ``/etc/pki/qemu`` directory on the target host. The
+``server-key.pem`` file is security sensitive and should be kept
+protected with file mode 0600 to prevent disclosure.
+
+.. _tls_005fgenerate_005fclient:
+
+Issuing client certificates
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The QEMU x509 TLS credential setup defaults to enabling client
+verification using certificates, providing a simple authentication
+mechanism. If this default is used, each client also needs to be issued
+a certificate. The client certificate contains enough metadata to
+uniquely identify the client with the scope of the certificate
+authority. The client certificate would typically include fields for
+organization, state, city, building, etc.
+
+Once again on the host holding the CA, create template files containing
+the information for each client, and use it to issue client
+certificates.
+
+::
+
+   # cat > client-hostNNN.info <<EOF
+   country = GB
+   state = London
+   locality = City Of London
+   organization = Name of your organization
+   cn = hostNNN.foo.example.com
+   tls_www_client
+   encryption_key
+   signing_key
+   EOF
+   # certtool --generate-privkey > client-hostNNN-key.pem
+   # certtool --generate-certificate \
+              --load-ca-certificate ca-cert.pem \
+              --load-ca-privkey ca-key.pem \
+              --load-privkey client-hostNNN-key.pem \
+              --template client-hostNNN.info \
+              --outfile client-hostNNN-cert.pem
+
+The subject alt name extension data is not required for clients, so the
+the ``dns_name`` and ``ip_address`` fields are not included. The
+``tls_www_client`` keyword is the key purpose extension to indicate this
+certificate is intended for usage in a web client. Although QEMU network
+clients are not in fact HTTP clients, setting this key purpose is still
+recommended. The ``encryption_key`` and ``signing_key`` keyword is the
+key usage extension to indicate this certificate is intended for usage
+in the data session.
+
+The ``client-hostNNN-key.pem`` and ``client-hostNNN-cert.pem`` files
+should now be securely copied to the client for which they were
+generated, and renamed to ``client-key.pem`` and ``client-cert.pem``
+when added to the ``/etc/pki/qemu`` directory on the target host. The
+``client-key.pem`` file is security sensitive and should be kept
+protected with file mode 0600 to prevent disclosure.
+
+If a single host is going to be using TLS in both a client and server
+role, it is possible to create a single certificate to cover both roles.
+This would be quite common for the migration and NBD services, where a
+QEMU process will be started by accepting a TLS protected incoming
+migration, and later itself be migrated out to another host. To generate
+a single certificate, simply include the template data from both the
+client and server instructions in one.
+
+::
+
+   # cat > both-hostNNN.info <<EOF
+   country = GB
+   state = London
+   locality = City Of London
+   organization = Name of your organization
+   cn = hostNNN.foo.example.com
+   dns_name = hostNNN
+   dns_name = hostNNN.foo.example.com
+   ip_address = 10.0.1.87
+   ip_address = 192.8.0.92
+   ip_address = 2620:0:cafe::87
+   ip_address = 2001:24::92
+   tls_www_server
+   tls_www_client
+   encryption_key
+   signing_key
+   EOF
+   # certtool --generate-privkey > both-hostNNN-key.pem
+   # certtool --generate-certificate \
+              --load-ca-certificate ca-cert.pem \
+              --load-ca-privkey ca-key.pem \
+              --load-privkey both-hostNNN-key.pem \
+              --template both-hostNNN.info \
+              --outfile both-hostNNN-cert.pem
+
+When copying the PEM files to the target host, save them twice, once as
+``server-cert.pem`` and ``server-key.pem``, and again as
+``client-cert.pem`` and ``client-key.pem``.
+
+.. _tls_005fcreds_005fsetup:
+
+TLS x509 credential configuration
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+QEMU has a standard mechanism for loading x509 credentials that will be
+used for network services and clients. It requires specifying the
+``tls-creds-x509`` class name to the ``--object`` command line argument
+for the system emulators. Each set of credentials loaded should be given
+a unique string identifier via the ``id`` parameter. A single set of TLS
+credentials can be used for multiple network backends, so VNC,
+migration, NBD, character devices can all share the same credentials.
+Note, however, that credentials for use in a client endpoint must be
+loaded separately from those used in a server endpoint.
+
+When specifying the object, the ``dir`` parameters specifies which
+directory contains the credential files. This directory is expected to
+contain files with the names mentioned previously, ``ca-cert.pem``,
+``server-key.pem``, ``server-cert.pem``, ``client-key.pem`` and
+``client-cert.pem`` as appropriate. It is also possible to include a set
+of pre-generated Diffie-Hellman (DH) parameters in a file
+``dh-params.pem``, which can be created using the
+``certtool --generate-dh-params`` command. If omitted, QEMU will
+dynamically generate DH parameters when loading the credentials.
+
+The ``endpoint`` parameter indicates whether the credentials will be
+used for a network client or server, and determines which PEM files are
+loaded.
+
+The ``verify`` parameter determines whether x509 certificate validation
+should be performed. This defaults to enabled, meaning clients will
+always validate the server hostname against the certificate subject alt
+name fields and/or CN field. It also means that servers will request
+that clients provide a certificate and validate them. Verification
+should never be turned off for client endpoints, however, it may be
+turned off for server endpoints if an alternative mechanism is used to
+authenticate clients. For example, the VNC server can use SASL to
+authenticate clients instead.
+
+To load server credentials with client certificate validation enabled
+
+.. parsed-literal::
+
+   |qemu_system| -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server
+
+while to load client credentials use
+
+.. parsed-literal::
+
+   |qemu_system| -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=client
+
+Network services which support TLS will all have a ``tls-creds``
+parameter which expects the ID of the TLS credentials object. For
+example with VNC:
+
+.. parsed-literal::
+
+   |qemu_system| -vnc 0.0.0.0:0,tls-creds=tls0
+
+.. _tls_005fpsk:
+
+TLS Pre-Shared Keys (PSK)
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Instead of using certificates, you may also use TLS Pre-Shared Keys
+(TLS-PSK). This can be simpler to set up than certificates but is less
+scalable.
+
+Use the GnuTLS ``psktool`` program to generate a ``keys.psk`` file
+containing one or more usernames and random keys::
+
+   mkdir -m 0700 /tmp/keys
+   psktool -u rich -p /tmp/keys/keys.psk
+
+TLS-enabled servers such as qemu-nbd can use this directory like so::
+
+   qemu-nbd \
+     -t -x / \
+     --object tls-creds-psk,id=tls0,endpoint=server,dir=/tmp/keys \
+     --tls-creds tls0 \
+     image.qcow2
+
+When connecting from a qemu-based client you must specify the directory
+containing ``keys.psk`` and an optional username (defaults to "qemu")::
+
+   qemu-img info \
+     --object tls-creds-psk,id=tls0,dir=/tmp/keys,username=rich,endpoint=client \
+     --image-opts \
+     file.driver=nbd,file.host=localhost,file.port=10809,file.tls-creds=tls0,file.export=/
diff --git a/docs/system/usb.rst b/docs/system/usb.rst
new file mode 100644
index 0000000000..cabe9d3134
--- /dev/null
+++ b/docs/system/usb.rst
@@ -0,0 +1,137 @@
+.. _pcsys_005fusb:
+
+USB emulation
+-------------
+
+QEMU can emulate a PCI UHCI, OHCI, EHCI or XHCI USB controller. You can
+plug virtual USB devices or real host USB devices (only works with
+certain host operating systems). QEMU will automatically create and
+connect virtual USB hubs as necessary to connect multiple USB devices.
+
+.. _usb_005fdevices:
+
+Connecting USB devices
+~~~~~~~~~~~~~~~~~~~~~~
+
+USB devices can be connected with the ``-device usb-...`` command line
+option or the ``device_add`` monitor command. Available devices are:
+
+``usb-mouse``
+   Virtual Mouse. This will override the PS/2 mouse emulation when
+   activated.
+
+``usb-tablet``
+   Pointer device that uses absolute coordinates (like a touchscreen).
+   This means QEMU is able to report the mouse position without having
+   to grab the mouse. Also overrides the PS/2 mouse emulation when
+   activated.
+
+``usb-storage,drive=drive_id``
+   Mass storage device backed by drive_id (see
+   `disk_images <#disk_005fimages>`__)
+
+``usb-uas``
+   USB attached SCSI device, see
+   `usb-storage.txt <https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/usb-storage.txt>`__
+   for details
+
+``usb-bot``
+   Bulk-only transport storage device, see
+   `usb-storage.txt <https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/usb-storage.txt>`__
+   for details here, too
+
+``usb-mtp,rootdir=dir``
+   Media transfer protocol device, using dir as root of the file tree
+   that is presented to the guest.
+
+``usb-host,hostbus=bus,hostaddr=addr``
+   Pass through the host device identified by bus and addr
+
+``usb-host,vendorid=vendor,productid=product``
+   Pass through the host device identified by vendor and product ID
+
+``usb-wacom-tablet``
+   Virtual Wacom PenPartner tablet. This device is similar to the
+   ``tablet`` above but it can be used with the tslib library because in
+   addition to touch coordinates it reports touch pressure.
+
+``usb-kbd``
+   Standard USB keyboard. Will override the PS/2 keyboard (if present).
+
+``usb-serial,chardev=id``
+   Serial converter. This emulates an FTDI FT232BM chip connected to
+   host character device id.
+
+``usb-braille,chardev=id``
+   Braille device. This will use BrlAPI to display the braille output on
+   a real or fake device referenced by id.
+
+``usb-net[,netdev=id]``
+   Network adapter that supports CDC ethernet and RNDIS protocols. id
+   specifies a netdev defined with ``-netdev …,id=id``. For instance,
+   user-mode networking can be used with
+
+   .. parsed-literal::
+
+      |qemu_system| [...] -netdev user,id=net0 -device usb-net,netdev=net0
+
+``usb-ccid``
+   Smartcard reader device
+
+``usb-audio``
+   USB audio device
+
+.. _host_005fusb_005fdevices:
+
+Using host USB devices on a Linux host
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+WARNING: this is an experimental feature. QEMU will slow down when using
+it. USB devices requiring real time streaming (i.e. USB Video Cameras)
+are not supported yet.
+
+1. If you use an early Linux 2.4 kernel, verify that no Linux driver is
+   actually using the USB device. A simple way to do that is simply to
+   disable the corresponding kernel module by renaming it from
+   ``mydriver.o`` to ``mydriver.o.disabled``.
+
+2. Verify that ``/proc/bus/usb`` is working (most Linux distributions
+   should enable it by default). You should see something like that:
+
+   ::
+
+      ls /proc/bus/usb
+      001  devices  drivers
+
+3. Since only root can access to the USB devices directly, you can
+   either launch QEMU as root or change the permissions of the USB
+   devices you want to use. For testing, the following suffices:
+
+   ::
+
+      chown -R myuid /proc/bus/usb
+
+4. Launch QEMU and do in the monitor:
+
+   ::
+
+      info usbhost
+        Device 1.2, speed 480 Mb/s
+          Class 00: USB device 1234:5678, USB DISK
+
+   You should see the list of the devices you can use (Never try to use
+   hubs, it won't work).
+
+5. Add the device in QEMU by using:
+
+   ::
+
+      device_add usb-host,vendorid=0x1234,productid=0x5678
+
+   Normally the guest OS should report that a new USB device is plugged.
+   You can use the option ``-device usb-host,...`` to do the same.
+
+6. Now you can try to use the host USB device in QEMU.
+
+When relaunching QEMU, you may have to unplug and plug again the USB
+device to make it work again (this is a bug).
diff --git a/docs/system/vnc-security.rst b/docs/system/vnc-security.rst
new file mode 100644
index 0000000000..b237b07330
--- /dev/null
+++ b/docs/system/vnc-security.rst
@@ -0,0 +1,202 @@
+.. _vnc_005fsecurity:
+
+VNC security
+------------
+
+The VNC server capability provides access to the graphical console of
+the guest VM across the network. This has a number of security
+considerations depending on the deployment scenarios.
+
+.. _vnc_005fsec_005fnone:
+
+Without passwords
+~~~~~~~~~~~~~~~~~
+
+The simplest VNC server setup does not include any form of
+authentication. For this setup it is recommended to restrict it to
+listen on a UNIX domain socket only. For example
+
+.. parsed-literal::
+
+   |qemu_system| [...OPTIONS...] -vnc unix:/home/joebloggs/.qemu-myvm-vnc
+
+This ensures that only users on local box with read/write access to that
+path can access the VNC server. To securely access the VNC server from a
+remote machine, a combination of netcat+ssh can be used to provide a
+secure tunnel.
+
+.. _vnc_005fsec_005fpassword:
+
+With passwords
+~~~~~~~~~~~~~~
+
+The VNC protocol has limited support for password based authentication.
+Since the protocol limits passwords to 8 characters it should not be
+considered to provide high security. The password can be fairly easily
+brute-forced by a client making repeat connections. For this reason, a
+VNC server using password authentication should be restricted to only
+listen on the loopback interface or UNIX domain sockets. Password
+authentication is not supported when operating in FIPS 140-2 compliance
+mode as it requires the use of the DES cipher. Password authentication
+is requested with the ``password`` option, and then once QEMU is running
+the password is set with the monitor. Until the monitor is used to set
+the password all clients will be rejected.
+
+.. parsed-literal::
+
+   |qemu_system| [...OPTIONS...] -vnc :1,password -monitor stdio
+   (qemu) change vnc password
+   Password: ********
+   (qemu)
+
+.. _vnc_005fsec_005fcertificate:
+
+With x509 certificates
+~~~~~~~~~~~~~~~~~~~~~~
+
+The QEMU VNC server also implements the VeNCrypt extension allowing use
+of TLS for encryption of the session, and x509 certificates for
+authentication. The use of x509 certificates is strongly recommended,
+because TLS on its own is susceptible to man-in-the-middle attacks.
+Basic x509 certificate support provides a secure session, but no
+authentication. This allows any client to connect, and provides an
+encrypted session.
+
+.. parsed-literal::
+
+   |qemu_system| [...OPTIONS...] \
+     -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=no \
+     -vnc :1,tls-creds=tls0 -monitor stdio
+
+In the above example ``/etc/pki/qemu`` should contain at least three
+files, ``ca-cert.pem``, ``server-cert.pem`` and ``server-key.pem``.
+Unprivileged users will want to use a private directory, for example
+``$HOME/.pki/qemu``. NB the ``server-key.pem`` file should be protected
+with file mode 0600 to only be readable by the user owning it.
+
+.. _vnc_005fsec_005fcertificate_005fverify:
+
+With x509 certificates and client verification
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Certificates can also provide a means to authenticate the client
+connecting. The server will request that the client provide a
+certificate, which it will then validate against the CA certificate.
+This is a good choice if deploying in an environment with a private
+internal certificate authority. It uses the same syntax as previously,
+but with ``verify-peer`` set to ``yes`` instead.
+
+.. parsed-literal::
+
+   |qemu_system| [...OPTIONS...] \
+     -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=yes \
+     -vnc :1,tls-creds=tls0 -monitor stdio
+
+.. _vnc_005fsec_005fcertificate_005fpw:
+
+With x509 certificates, client verification and passwords
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Finally, the previous method can be combined with VNC password
+authentication to provide two layers of authentication for clients.
+
+.. parsed-literal::
+
+   |qemu_system| [...OPTIONS...] \
+     -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=yes \
+     -vnc :1,tls-creds=tls0,password -monitor stdio
+   (qemu) change vnc password
+   Password: ********
+   (qemu)
+
+.. _vnc_005fsec_005fsasl:
+
+With SASL authentication
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+The SASL authentication method is a VNC extension, that provides an
+easily extendable, pluggable authentication method. This allows for
+integration with a wide range of authentication mechanisms, such as PAM,
+GSSAPI/Kerberos, LDAP, SQL databases, one-time keys and more. The
+strength of the authentication depends on the exact mechanism
+configured. If the chosen mechanism also provides a SSF layer, then it
+will encrypt the datastream as well.
+
+Refer to the later docs on how to choose the exact SASL mechanism used
+for authentication, but assuming use of one supporting SSF, then QEMU
+can be launched with:
+
+.. parsed-literal::
+
+   |qemu_system| [...OPTIONS...] -vnc :1,sasl -monitor stdio
+
+.. _vnc_005fsec_005fcertificate_005fsasl:
+
+With x509 certificates and SASL authentication
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If the desired SASL authentication mechanism does not supported SSF
+layers, then it is strongly advised to run it in combination with TLS
+and x509 certificates. This provides securely encrypted data stream,
+avoiding risk of compromising of the security credentials. This can be
+enabled, by combining the 'sasl' option with the aforementioned TLS +
+x509 options:
+
+.. parsed-literal::
+
+   |qemu_system| [...OPTIONS...] \
+     -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=yes \
+     -vnc :1,tls-creds=tls0,sasl -monitor stdio
+
+.. _vnc_005fsetup_005fsasl:
+
+Configuring SASL mechanisms
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following documentation assumes use of the Cyrus SASL implementation
+on a Linux host, but the principles should apply to any other SASL
+implementation or host. When SASL is enabled, the mechanism
+configuration will be loaded from system default SASL service config
+/etc/sasl2/qemu.conf. If running QEMU as an unprivileged user, an
+environment variable SASL_CONF_PATH can be used to make it search
+alternate locations for the service config file.
+
+If the TLS option is enabled for VNC, then it will provide session
+encryption, otherwise the SASL mechanism will have to provide
+encryption. In the latter case the list of possible plugins that can be
+used is drastically reduced. In fact only the GSSAPI SASL mechanism
+provides an acceptable level of security by modern standards. Previous
+versions of QEMU referred to the DIGEST-MD5 mechanism, however, it has
+multiple serious flaws described in detail in RFC 6331 and thus should
+never be used any more. The SCRAM-SHA-1 mechanism provides a simple
+username/password auth facility similar to DIGEST-MD5, but does not
+support session encryption, so can only be used in combination with TLS.
+
+When not using TLS the recommended configuration is
+
+::
+
+   mech_list: gssapi
+   keytab: /etc/qemu/krb5.tab
+
+This says to use the 'GSSAPI' mechanism with the Kerberos v5 protocol,
+with the server principal stored in /etc/qemu/krb5.tab. For this to work
+the administrator of your KDC must generate a Kerberos principal for the
+server, with a name of 'qemu/somehost.example.com@EXAMPLE.COM' replacing
+'somehost.example.com' with the fully qualified host name of the machine
+running QEMU, and 'EXAMPLE.COM' with the Kerberos Realm.
+
+When using TLS, if username+password authentication is desired, then a
+reasonable configuration is
+
+::
+
+   mech_list: scram-sha-1
+   sasldb_path: /etc/qemu/passwd.db
+
+The ``saslpasswd2`` program can be used to populate the ``passwd.db``
+file with accounts.
+
+Other SASL configurations will be left as an exercise for the reader.
+Note that all mechanisms, except GSSAPI, should be combined with use of
+TLS to ensure a secure data channel.
-- 
2.21.1


