Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1C2C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 19:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF97F2100A
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 19:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF97F2100A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJi9F-0007SV-MA
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 15:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhs1-0006be-0K; Sat, 19 Sep 2020 14:46:01 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrv-0001Sn-O8; Sat, 19 Sep 2020 14:46:00 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MCXhr-1kAfQz204x-009h6x; Sat, 19 Sep 2020 20:45:19 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 11/17] docs/: fix some comment spelling errors
Date: Sat, 19 Sep 2020 20:44:45 +0200
Message-Id: <20200919184451.2129349-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZYsjorq0LaKROTKoJerbXgBgfcWpvclKRL7wQG7Nw6gsuJl+W/E
 w37UA0opGze4NJ43HwTBjtFhG7KzZNt9mkxoztRuq8flFCi7+Se0xmfkxjQentRsxNyWC30
 0F9C6zwY8tMKY4whEYMu9AwCi0ajQqFoul2jt5f2gqMhYwEEzpC3KByeuA1TjNznLmuZra6
 Ys0jxxAxDZtY2QfUowxTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/CB8XFAxxng=:mv95wnM30OoXs01tKC8kgC
 t+8xlVP7Y1s6SscePxQHM7DR1xLPz7GZT9YVs+DDSKRRfLUAhAZ99jbJ4lgo+8/s0+ckv/wmV
 /nuMUYbPE5qRIyWJvZrid1N2c14Ve2zWQiCgWotrtfJldFJmLV7OnYtB35909km3wshslHHXF
 0PQPr4sPBrJ2M0bhTZAAsDhuJv9CE3BH5EUhYhd8UamYorzTB45ogh+T39Alb/gU0xuRFb916
 AYTAu5IdY8FVds182g1N6jYDwLh1KBatJgTaRn9bgGz1vJiLUCtmsG8fnLjBgqzzAWer4YRqG
 XbEFu9NK9828twD3J3xNPiXzUK04d0TBCAwKBFwfKxrZzXv6AKko8g+FagSUidB/lWy/0fvux
 VFZVNT3PnkHK2W5u2nZI+1wNgHB3B0Sf6L7ctxuz9qPtRwJQZ5E6CSIINo3TcvxTpGQqyUpDd
 9ZIB5S/yx1psg7vRntuXcJ0Pk4eRSUtFMfJAp6MUvZyven2o5MfQCm8Tly7uk/C5dKXawS5jG
 r6pgwA0PljuNa+tOmAtZtEjfY/cms6ugD5NomlsE/mdbeDwQzxNdbAOYYORF6PMbDtJMMhh1l
 iDKWUs77P5FcivVCWT2Bw4YWHi5TQtfhsWHr1N06yv3rmkYUZhvoFKxq+fnuMBpywiJT3nWwT
 OMXWzL5HuhJCfz4d5FYAcegHjXlCNtiVxs3lMmtlnLgBG1lmmQ54z/texdULcfKDZE6xlckJu
 zjoKq26e2ahtExaHREypswgiDHskdy/BWA8p+D8ep0oyardjYD5zWDZkrvwF/NN4UlCFrPAyn
 H9kLgZbM1utDKY9DAT34k4vO9TIVgG7KxPXrZxni4019FB4l5x+H3oBciI6RR4YwkoXsQq/
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 zhaolichang <zhaolichang@huawei.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhaolichang <zhaolichang@huawei.com>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the docs folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200917075029.313-4-zhaolichang@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 docs/COLO-FT.txt                 | 6 +++---
 docs/devel/blkdebug.txt          | 2 +-
 docs/devel/migration.rst         | 2 +-
 docs/devel/testing.rst           | 2 +-
 docs/devel/tracing.txt           | 2 +-
 docs/interop/bitmaps.rst         | 2 +-
 docs/interop/dbus.rst            | 4 ++--
 docs/interop/nbd.txt             | 2 +-
 docs/interop/vhost-user-gpu.rst  | 2 +-
 docs/interop/vhost-user.rst      | 4 ++--
 docs/rdma.txt                    | 2 +-
 docs/specs/ppc-spapr-hotplug.txt | 4 ++--
 docs/specs/ppc-spapr-xive.rst    | 4 ++--
 docs/system/arm/aspeed.rst       | 2 +-
 docs/system/deprecated.rst       | 8 ++++----
 docs/system/target-avr.rst       | 4 ++--
 docs/tools/virtiofsd.rst         | 2 +-
 17 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
index c8e174093566..bc5fb2a1bb5f 100644
--- a/docs/COLO-FT.txt
+++ b/docs/COLO-FT.txt
@@ -91,7 +91,7 @@ the heartbeat stops responding, the secondary node will trigger a failover
 as soon as it determines the absence.
 
 COLO disk Manager:
-When primary VM writes data into image, the colo disk manger captures this data
+When primary VM writes data into image, the colo disk manager captures this data
 and sends it to secondary VM's which makes sure the context of secondary VM's
 image is consistent with the context of primary VM 's image.
 For more details, please refer to docs/block-replication.txt.
@@ -146,12 +146,12 @@ in test procedure.
 
 == Test procedure ==
 Note: Here we are running both instances on the same host for testing,
-change the IP Addresses if you want to run it on two hosts. Initally
+change the IP Addresses if you want to run it on two hosts. Initially
 127.0.0.1 is the Primary Host and 127.0.0.2 is the Secondary Host.
 
 == Startup qemu ==
 1. Primary:
-Note: Initally, $imagefolder/primary.qcow2 needs to be copied to all hosts.
+Note: Initially, $imagefolder/primary.qcow2 needs to be copied to all hosts.
 You don't need to change any IP's here, because 0.0.0.0 listens on any
 interface. The chardev's with 127.0.0.1 IP's loopback to the local qemu
 instance.
diff --git a/docs/devel/blkdebug.txt b/docs/devel/blkdebug.txt
index 43d8e8f9c63b..0b0c128d356b 100644
--- a/docs/devel/blkdebug.txt
+++ b/docs/devel/blkdebug.txt
@@ -62,7 +62,7 @@ Rules support the following attributes:
 
   errno - the numeric errno value to return when a request matches this rule.
           The errno values depend on the host since the numeric values are not
-          standarized in the POSIX specification.
+          standardized in the POSIX specification.
 
   sector - (optional) a sector number that the request must overlap in order to
            match this rule
diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 2eb08624fc36..49112bb27aab 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -625,7 +625,7 @@ It can be issued immediately after migration is started or any
 time later on.  Issuing it after the end of a migration is harmless.
 
 Blocktime is a postcopy live migration metric, intended to show how
-long the vCPU was in state of interruptable sleep due to pagefault.
+long the vCPU was in state of interruptible sleep due to pagefault.
 That metric is calculated both for all vCPUs as overlapped value, and
 separately for each vCPU. These values are calculated on destination
 side.  To enable postcopy blocktime calculation, enter following
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 196e3bc35eb6..bd64c1bdcdd4 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -471,7 +471,7 @@ the warning.
 A few important files for suppressing warnings are:
 
 tests/tsan/suppressions.tsan - Has TSan warnings we wish to suppress at runtime.
-The comment on each supression will typically indicate why we are
+The comment on each suppression will typically indicate why we are
 suppressing it.  More information on the file format can be found here:
 
 https://github.com/google/sanitizers/wiki/ThreadSanitizerSuppressions
diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 6144d9921bfd..d2160655b4e3 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -55,7 +55,7 @@ without any sub-directory path prefix. eg io/channel-buffer.c would do
   #include "trace.h"
 
 To access the 'io/trace.h' file. While it is possible to include a trace.h
-file from outside a source files' own sub-directory, this is discouraged in
+file from outside a source file's own sub-directory, this is discouraged in
 general. It is strongly preferred that all events be declared directly in
 the sub-directory that uses them. The only exception is where there are some
 shared trace events defined in the top level directory trace-events file.
diff --git a/docs/interop/bitmaps.rst b/docs/interop/bitmaps.rst
index c20bd37a7971..059ad6792940 100644
--- a/docs/interop/bitmaps.rst
+++ b/docs/interop/bitmaps.rst
@@ -484,7 +484,7 @@ Bitmaps can generally be modified at any time, but certain operations often
 only make sense when paired directly with other commands. When a VM is paused,
 it's easy to ensure that no guest writes occur between individual QMP
 commands. When a VM is running, this is difficult to accomplish with
-individual QMP commands that may allow guest writes to occur inbetween each
+individual QMP commands that may allow guest writes to occur between each
 command.
 
 For example, using only individual QMP commands, we could:
diff --git a/docs/interop/dbus.rst b/docs/interop/dbus.rst
index 76a5bde62534..be596d3f418c 100644
--- a/docs/interop/dbus.rst
+++ b/docs/interop/dbus.rst
@@ -57,7 +57,7 @@ Depending on the use case, you may choose different scenarios:
  - Everything the same UID
 
    - Convenient for developers
-   - Improved reliability - crash of one part doens't take
+   - Improved reliability - crash of one part doesn't take
      out entire VM
    - No security benefit over traditional QEMU, unless additional
      unless additional controls such as SELinux or AppArmor are
@@ -87,7 +87,7 @@ For example, to allow only ``qemu`` user to talk to ``qemu-helper``
   </policy>
 
 
-dbus-daemon can also perfom SELinux checks based on the security
+dbus-daemon can also perform SELinux checks based on the security
 context of the source and the target. For example, ``virtiofs_t``
 could be allowed to send a message to ``svirt_t``, but ``virtiofs_t``
 wouldn't be allowed to send a message to ``virtiofs_t``.
diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
index 45118809618e..f3b3cacc9621 100644
--- a/docs/interop/nbd.txt
+++ b/docs/interop/nbd.txt
@@ -53,5 +53,5 @@ the operation of that feature.
 * 2.12: NBD_CMD_BLOCK_STATUS for "base:allocation"
 * 3.0: NBD_OPT_STARTTLS with TLS Pre-Shared Keys (PSK),
 NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE
-* 4.2: NBD_FLAG_CAN_MULTI_CONN for sharable read-only exports,
+* 4.2: NBD_FLAG_CAN_MULTI_CONN for shareable read-only exports,
 NBD_CMD_FLAG_FAST_ZERO
diff --git a/docs/interop/vhost-user-gpu.rst b/docs/interop/vhost-user-gpu.rst
index 688f8b425999..3268bf405ce3 100644
--- a/docs/interop/vhost-user-gpu.rst
+++ b/docs/interop/vhost-user-gpu.rst
@@ -66,7 +66,7 @@ VhostUserGpuCursorPos
 
 :scanout-id: ``u32``, the scanout where the cursor is located
 
-:x/y: ``u32``, the cursor postion
+:x/y: ``u32``, the cursor position
 
 VhostUserGpuCursorUpdate
 ^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 10e3e3475ed8..988f1541447d 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -464,7 +464,7 @@ the ``VHOST_USER_SET_MEM_TABLE`` request. For invalidation events, the
 (3), the I/O virtual address and the size. On success, the slave is
 expected to reply with a zero payload, non-zero otherwise.
 
-The slave relies on the slave communcation channel (see :ref:`Slave
+The slave relies on the slave communication channel (see :ref:`Slave
 communication <slave_communication>` section below) to send IOTLB miss
 and access failure events, by sending ``VHOST_USER_SLAVE_IOTLB_MSG``
 requests to the master with a ``struct vhost_iotlb_msg`` as
@@ -1450,7 +1450,7 @@ vhost-user backends can provide various devices & services and may
 need to be configured manually depending on the use case. However, it
 is a good idea to follow the conventions listed here when
 possible. Users, QEMU or libvirt, can then rely on some common
-behaviour to avoid heterogenous configuration and management of the
+behaviour to avoid heterogeneous configuration and management of the
 backend programs and facilitate interoperability.
 
 Each backend installed on a host system should come with at least one
diff --git a/docs/rdma.txt b/docs/rdma.txt
index a86e992c8453..49dc9f8bcab4 100644
--- a/docs/rdma.txt
+++ b/docs/rdma.txt
@@ -261,7 +261,7 @@ qemu_rdma_exchange_send(header, data, optional response header & data):
    of the connection (described below).
 
 All of the remaining command types (not including 'ready')
-described above all use the aformentioned two functions to do the hard work:
+described above all use the aforementioned two functions to do the hard work:
 
 1. After connection setup, RAMBlock information is exchanged using
    this protocol before the actual migration begins. This information includes
diff --git a/docs/specs/ppc-spapr-hotplug.txt b/docs/specs/ppc-spapr-hotplug.txt
index 859d52cce6c8..d4fb2d46d950 100644
--- a/docs/specs/ppc-spapr-hotplug.txt
+++ b/docs/specs/ppc-spapr-hotplug.txt
@@ -371,7 +371,7 @@ ibm,dynamic-memory
 
 This property describes the dynamically reconfigurable memory. It is a
 property encoded array that has an integer N, the number of LMBs followed
-by N LMB list entires.
+by N LMB list entries.
 
 Each LMB list entry consists of the following elements:
 
@@ -390,7 +390,7 @@ Each LMB list entry consists of the following elements:
 ibm,dynamic-memory-v2
 
 This property describes the dynamically reconfigurable memory. This is
-an alternate and newer way to describe dyanamically reconfigurable memory.
+an alternate and newer way to describe dynamically reconfigurable memory.
 It is a property encoded array that has an integer N (the number of
 LMB set entries) followed by N LMB set entries. There is an LMB set entry
 for each sequential group of LMBs that share common attributes.
diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rst
index 7144347560f1..f47f739e0190 100644
--- a/docs/specs/ppc-spapr-xive.rst
+++ b/docs/specs/ppc-spapr-xive.rst
@@ -46,7 +46,7 @@ default mode. ``dual`` means that both modes XICS **and** XIVE are
 supported and if the guest OS supports XIVE, this mode will be
 selected.
 
-The choosen interrupt mode is activated after a reconfiguration done
+The chosen interrupt mode is activated after a reconfiguration done
 in a machine reset.
 
 KVM negotiation
@@ -158,7 +158,7 @@ XIVE Device tree properties
 ---------------------------
 
 The properties for the PAPR interrupt controller node when the *XIVE
-native exploitation mode* is selected shoud contain:
+native exploitation mode* is selected should contain:
 
 - ``device_type``
 
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 45f891eb3cad..fe45840fbe15 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -72,7 +72,7 @@ Boot options
 ------------
 
 The Aspeed machines can be started using the -kernel option to load a
-Linux kernel or from a firmare image which can be downloaded from the
+Linux kernel or from a firmware image which can be downloaded from the
 OpenPOWER jenkins :
 
    https://openpower.xyz/
diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 0cb8b0142447..808c334fe74d 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -79,7 +79,7 @@ Creating sound card devices and vnc without ``audiodev=`` property (since 4.2)
 
 When not using the deprecated legacy audio config, each sound card
 should specify an ``audiodev=`` property.  Additionally, when using
-vnc, you should specify an ``audiodev=`` propery if you plan to
+vnc, you should specify an ``audiodev=`` property if you plan to
 transmit audio through the VNC protocol.
 
 Creating sound card devices using ``-soundhw`` (since 5.1)
@@ -111,7 +111,7 @@ Splitting RAM by default between NUMA nodes has the same issues as ``mem``
 parameter described above with the difference that the role of the user plays
 QEMU using implicit generic or board specific splitting rule.
 Use ``memdev`` with *memory-backend-ram* backend or ``mem`` (if
-it's supported by used machine type) to define mapping explictly instead.
+it's supported by used machine type) to define mapping explicitly instead.
 
 ``-mem-path`` fallback to RAM (since 4.1)
 '''''''''''''''''''''''''''''''''''''''''
@@ -541,10 +541,10 @@ The ``[hub_id name]`` parameter tuple of the 'hostfwd_add' and
 Guest Emulator ISAs
 -------------------
 
-RISC-V ISA privledge specification version 1.09.1 (removed in 5.1)
+RISC-V ISA privilege specification version 1.09.1 (removed in 5.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
-The RISC-V ISA privledge specification version 1.09.1 has been removed.
+The RISC-V ISA privilege specification version 1.09.1 has been removed.
 QEMU supports both the newer version 1.10.0 and the ratified version 1.11.0, these
 should be used instead of the 1.09.1 version.
 
diff --git a/docs/system/target-avr.rst b/docs/system/target-avr.rst
index eb5c513cce09..25ab46ef05cc 100644
--- a/docs/system/target-avr.rst
+++ b/docs/system/target-avr.rst
@@ -10,7 +10,7 @@ xmega6 and xmega7.
 
 As for now it supports few Arduino boards for educational and testing purposes.
 These boards use a ATmega controller, which model is limited to USART & 16-bit
-timer devices, enought to run FreeRTOS based applications (like
+timer devices, enough to run FreeRTOS based applications (like
 https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
 ).
 
@@ -30,7 +30,7 @@ AVR cpu
 
    telnet localhost 5678
 
-- Debugging wit GDB debugger::
+- Debugging with GDB debugger::
 
    qemu-system-avr -machine mega2560 -bios demo.elf -s -S
 
diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index e33c81ed41f1..7fe6a87291c2 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -76,7 +76,7 @@ Options
     I/O timeout in seconds.  The default depends on cache= option.
 
   * writeback|no_writeback -
-    Enable/disable writeback cache. The cache alows the FUSE client to buffer
+    Enable/disable writeback cache. The cache allows the FUSE client to buffer
     and merge write requests.  The default is ``no_writeback``.
 
   * xattr|no_xattr -
-- 
2.26.2


