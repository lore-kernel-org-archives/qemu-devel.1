Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TRACKER_ID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE15C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867EC20707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867EC20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqBv-0005wx-NO
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 03:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAq8i-0007j0-F6; Wed, 26 Aug 2020 03:46:36 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:37454 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAq8e-0001zk-0q; Wed, 26 Aug 2020 03:46:36 -0400
Received: from dggemi405-hub.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 50EF5E99EBB7A474A7D2;
 Wed, 26 Aug 2020 15:46:29 +0800 (CST)
Received: from DGGEMI423-HUB.china.huawei.com (10.1.199.152) by
 dggemi405-hub.china.huawei.com (10.3.17.143) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 26 Aug 2020 15:46:29 +0800
Received: from DGGEMI522-MBS.china.huawei.com ([169.254.8.252]) by
 dggemi423-hub.china.huawei.com ([10.1.199.152]) with mapi id 14.03.0487.000;
 Wed, 26 Aug 2020 15:46:20 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: [PATCH V2 03/10] docs/: fix some comment spelling errors
Thread-Topic: [PATCH V2 03/10] docs/: fix some comment spelling errors
Thread-Index: AdZ7e8WVprks61awRIOGvknR5fxuJw==
Date: Wed, 26 Aug 2020 07:46:19 +0000
Message-ID: <640CDEE67BE2784FAE298BB2517210E48AC3BE@dggemi522-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.186.227]
Content-Type: multipart/alternative;
 boundary="_000_640CDEE67BE2784FAE298BB2517210E48AC3BEdggemi522mbschina_"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:45:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, TRACKER_ID=0.1,
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
Cc: zhaolichang <zhaolichang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_640CDEE67BE2784FAE298BB2517210E48AC3BEdggemi522mbschina_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the docs folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index c8e1740935..bc5fb2a1bb 100644
--- a/docs/COLO-FT.txt
+++ b/docs/COLO-FT.txt
@@ -91,7 +91,7 @@ the heartbeat stops responding, the secondary node will t=
rigger a failover
as soon as it determines the absence.

COLO disk Manager:
-When primary VM writes data into image, the colo disk manger captures this=
 data
+When primary VM writes data into image, the colo disk manager captures thi=
s data
and sends it to secondary VM's which makes sure the context of secondary VM=
's
image is consistent with the context of primary VM 's image.
For more details, please refer to docs/block-replication.txt.
@@ -146,12 +146,12 @@ in test procedure.

=3D=3D Test procedure =3D=3D
Note: Here we are running both instances on the same host for testing,
-change the IP Addresses if you want to run it on two hosts. Initally
+change the IP Addresses if you want to run it on two hosts. Initially
127.0.0.1 is the Primary Host and 127.0.0.2 is the Secondary Host.

=3D=3D Startup qemu =3D=3D
1. Primary:
-Note: Initally, $imagefolder/primary.qcow2 needs to be copied to all hosts=
.
+Note: Initially, $imagefolder/primary.qcow2 needs to be copied to all host=
s.
You don't need to change any IP's here, because 0.0.0.0 listens on any
interface. The chardev's with 127.0.0.1 IP's loopback to the local qemu
instance.
diff --git a/docs/devel/blkdebug.txt b/docs/devel/blkdebug.txt
index 43d8e8f9c6..0b0c128d35 100644
--- a/docs/devel/blkdebug.txt
+++ b/docs/devel/blkdebug.txt
@@ -62,7 +62,7 @@ Rules support the following attributes:

   errno - the numeric errno value to return when a request matches this ru=
le.
           The errno values depend on the host since the numeric values are=
 not
-          standarized in the POSIX specification.
+          standardized in the POSIX specification.

   sector - (optional) a sector number that the request must overlap in ord=
er to
            match this rule
diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 2eb08624fc..49112bb27a 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -625,7 +625,7 @@ It can be issued immediately after migration is started=
 or any
time later on.  Issuing it after the end of a migration is harmless.

Blocktime is a postcopy live migration metric, intended to show how
-long the vCPU was in state of interruptable sleep due to pagefault.
+long the vCPU was in state of interruptible sleep due to pagefault.
That metric is calculated both for all vCPUs as overlapped value, and
separately for each vCPU. These values are calculated on destination
side.  To enable postcopy blocktime calculation, enter following
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 196e3bc35e..bd64c1bdcd 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -471,7 +471,7 @@ the warning.
A few important files for suppressing warnings are:

tests/tsan/suppressions.tsan - Has TSan warnings we wish to suppress at run=
time.
-The comment on each supression will typically indicate why we are
+The comment on each suppression will typically indicate why we are
suppressing it.  More information on the file format can be found here:

https://github.com/google/sanitizers/wiki/ThreadSanitizerSuppressions
diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 6144d9921b..d2160655b4 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -55,7 +55,7 @@ without any sub-directory path prefix. eg io/channel-buff=
er.c would do
   #include "trace.h"

To access the 'io/trace.h' file. While it is possible to include a trace.h
-file from outside a source files' own sub-directory, this is discouraged i=
n
+file from outside a source file's own sub-directory, this is discouraged i=
n
general. It is strongly preferred that all events be declared directly in
the sub-directory that uses them. The only exception is where there are som=
e
shared trace events defined in the top level directory trace-events file.
diff --git a/docs/interop/bitmaps.rst b/docs/interop/bitmaps.rst
index c20bd37a79..059ad67929 100644
--- a/docs/interop/bitmaps.rst
+++ b/docs/interop/bitmaps.rst
@@ -484,7 +484,7 @@ Bitmaps can generally be modified at any time, but cert=
ain operations often
only make sense when paired directly with other commands. When a VM is paus=
ed,
it's easy to ensure that no guest writes occur between individual QMP
commands. When a VM is running, this is difficult to accomplish with
-individual QMP commands that may allow guest writes to occur inbetween eac=
h
+individual QMP commands that may allow guest writes to occur between each
command.

For example, using only individual QMP commands, we could:
diff --git a/docs/interop/dbus.rst b/docs/interop/dbus.rst
index 76a5bde625..be596d3f41 100644
--- a/docs/interop/dbus.rst
+++ b/docs/interop/dbus.rst
@@ -57,7 +57,7 @@ Depending on the use case, you may choose different scena=
rios:
  - Everything the same UID

    - Convenient for developers
-   - Improved reliability - crash of one part doens't take
+   - Improved reliability - crash of one part doesn't take
      out entire VM
    - No security benefit over traditional QEMU, unless additional
      unless additional controls such as SELinux or AppArmor are
@@ -87,7 +87,7 @@ For example, to allow only ``qemu`` user to talk to ``qem=
u-helper``
   </policy>


-dbus-daemon can also perfom SELinux checks based on the security
+dbus-daemon can also perform SELinux checks based on the security
context of the source and the target. For example, ``virtiofs_t``
could be allowed to send a message to ``svirt_t``, but ``virtiofs_t``
wouldn't be allowed to send a message to ``virtiofs_t``.
diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
index 4511880961..f3b3cacc96 100644
--- a/docs/interop/nbd.txt
+++ b/docs/interop/nbd.txt
@@ -53,5 +53,5 @@ the operation of that feature.
* 2.12: NBD_CMD_BLOCK_STATUS for "base:allocation"
* 3.0: NBD_OPT_STARTTLS with TLS Pre-Shared Keys (PSK),
NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE
-* 4.2: NBD_FLAG_CAN_MULTI_CONN for sharable read-only exports,
+* 4.2: NBD_FLAG_CAN_MULTI_CONN for shareable read-only exports,
NBD_CMD_FLAG_FAST_ZERO
diff --git a/docs/interop/vhost-user-gpu.rst b/docs/interop/vhost-user-gpu.=
rst
index 688f8b4259..3268bf405c 100644
--- a/docs/interop/vhost-user-gpu.rst
+++ b/docs/interop/vhost-user-gpu.rst
@@ -66,7 +66,7 @@ VhostUserGpuCursorPos

:scanout-id: ``u32``, the scanout where the cursor is located

-:x/y: ``u32``, the cursor postion
+:x/y: ``u32``, the cursor position

VhostUserGpuCursorUpdate
^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 10e3e3475e..988f154144 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -464,7 +464,7 @@ the ``VHOST_USER_SET_MEM_TABLE`` request. For invalidat=
ion events, the
(3), the I/O virtual address and the size. On success, the slave is
expected to reply with a zero payload, non-zero otherwise.

-The slave relies on the slave communcation channel (see :ref:`Slave
+The slave relies on the slave communication channel (see :ref:`Slave
communication <slave_communication>` section below) to send IOTLB miss
and access failure events, by sending ``VHOST_USER_SLAVE_IOTLB_MSG``
requests to the master with a ``struct vhost_iotlb_msg`` as
@@ -1450,7 +1450,7 @@ vhost-user backends can provide various devices & ser=
vices and may
need to be configured manually depending on the use case. However, it
is a good idea to follow the conventions listed here when
possible. Users, QEMU or libvirt, can then rely on some common
-behaviour to avoid heterogenous configuration and management of the
+behaviour to avoid heterogeneous configuration and management of the
backend programs and facilitate interoperability.

Each backend installed on a host system should come with at least one
diff --git a/docs/rdma.txt b/docs/rdma.txt
index a86e992c84..49dc9f8bca 100644
--- a/docs/rdma.txt
+++ b/docs/rdma.txt
@@ -261,7 +261,7 @@ qemu_rdma_exchange_send(header, data, optional response=
 header & data):
    of the connection (described below).

All of the remaining command types (not including 'ready')
-described above all use the aformentioned two functions to do the hard wor=
k:
+described above all use the aforementioned two functions to do the hard wo=
rk:

1. After connection setup, RAMBlock information is exchanged using
    this protocol before the actual migration begins. This information incl=
udes
diff --git a/docs/specs/ppc-spapr-hotplug.txt b/docs/specs/ppc-spapr-hotplu=
g.txt
index 859d52cce6..d4fb2d46d9 100644
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
index 7144347560..f47f739e01 100644
--- a/docs/specs/ppc-spapr-xive.rst
+++ b/docs/specs/ppc-spapr-xive.rst
@@ -46,7 +46,7 @@ default mode. ``dual`` means that both modes XICS **and**=
 XIVE are
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
index 45f891eb3c..fe45840fbe 100644
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
index 851dbdeb8a..8a4721cae3 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -79,7 +79,7 @@ Creating sound card devices and vnc without ``audiodev=3D=
`` property (since 4.2)

When not using the deprecated legacy audio config, each sound card
should specify an ``audiodev=3D`` property.  Additionally, when using
-vnc, you should specify an ``audiodev=3D`` propery if you plan to
+vnc, you should specify an ``audiodev=3D`` property if you plan to
transmit audio through the VNC protocol.

Creating sound card devices using ``-soundhw`` (since 5.1)
@@ -111,7 +111,7 @@ Splitting RAM by default between NUMA nodes has the sam=
e issues as ``mem``
parameter described above with the difference that the role of the user pla=
ys
QEMU using implicit generic or board specific splitting rule.
Use ``memdev`` with *memory-backend-ram* backend or ``mem`` (if
-it's supported by used machine type) to define mapping explictly instead.
+it's supported by used machine type) to define mapping explicitly instead.

``-mem-path`` fallback to RAM (since 4.1)
'''''''''''''''''''''''''''''''''''''''''
@@ -526,10 +526,10 @@ The ``[hub_id name]`` parameter tuple of the 'hostfwd=
_add' and
Guest Emulator ISAs
-------------------

-RISC-V ISA privledge specification version 1.09.1 (removed in 5.1)
+RISC-V ISA privilege specification version 1.09.1 (removed in 5.1)
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

-The RISC-V ISA privledge specification version 1.09.1 has been removed.
+The RISC-V ISA privilege specification version 1.09.1 has been removed.
QEMU supports both the newer version 1.10.0 and the ratified version 1.11.0=
, these
should be used instead of the 1.09.1 version.

diff --git a/docs/system/target-avr.rst b/docs/system/target-avr.rst
index dc99afc895..86781ce5c2 100644
--- a/docs/system/target-avr.rst
+++ b/docs/system/target-avr.rst
@@ -10,7 +10,7 @@ xmega6 and xmega7.

As for now it supports few Arduino boards for educational and testing purpo=
ses.
These boards use a ATmega controller, which model is limited to USART & 16-=
bit
-timer devices, enought to run FreeRTOS based applications (like
+timer devices, enough to run FreeRTOS based applications (like
https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR_A=
TMega2560_GCC/demo.elf
).

@@ -26,7 +26,7 @@ AVR cpu
    and then in another shell
    ``telnet localhost 5678``

- - Debugging wit GDB debugger:
+ - Debugging with GDB debugger:
    ``qemu-system-avr -machine mega2560 -bios demo.elf -s -S``
    and then in another shell
    ``avr-gdb demo.elf``
diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index 824e713491..48f7926be3 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -79,7 +79,7 @@ Options
     I/O timeout in seconds.  The default depends on cache=3D option.

   * writeback|no_writeback -
-    Enable/disable writeback cache. The cache alows the FUSE client to buf=
fer
+    Enable/disable writeback cache. The cache allows the FUSE client to bu=
ffer
     and merge write requests.  The default is ``no_writeback``.

   * xattr|no_xattr -
--
2.26.2.windows.1


--_000_640CDEE67BE2784FAE298BB2517210E48AC3BEdggemi522mbschina_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.5pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justi=
fy-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">I found that there are many spe=
lling errors in the comments of qemu,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">so I used the spellcheck tool t=
o check the spelling errors<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">and finally found some spelling=
 errors in the docs folder.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: zhaolichang &lt;=
zhaolichang@huawei.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Reviewed-by: Peter Maydell &lt;=
peter.maydell@linaro.org&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/COLO-FT.txt&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 6 &#43;&#43;&#43;---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/devel/blkdebug.txt&nbsp; &=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 2 &#43;-<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/devel/migration.rst&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/devel/testing.rst&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/devel/tracing.txt&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/interop/bitmaps.rst&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/interop/dbus.rst&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4 &#43;&#43;--<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/interop/nbd.txt&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/interop/vhost-user-gpu.rst=
&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/interop/vhost-user.rst&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; | 4 &#43;&#43;--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/rdma.txt&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/specs/ppc-spapr-hotplug.tx=
t | 4 &#43;&#43;--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/specs/ppc-spapr-xive.rst&n=
bsp;&nbsp;&nbsp; | 4 &#43;&#43;--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/system/arm/aspeed.rst&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/system/deprecated.rst&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 8 &#43;&#43;&#43;&#43;----<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/system/target-avr.rst&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4 &#43;&#43;--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">docs/tools/virtiofsd.rst&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">17 files changed, 27 insertions=
(&#43;), 27 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/COLO-FT.txt b=
/docs/COLO-FT.txt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index c8e1740935..bc5fb2a1bb 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/COLO-FT.txt<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/COLO-FT.=
txt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -91,7 &#43;91,7 @@ the heart=
beat stops responding, the secondary node will trigger a failover<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">as soon as it determines the ab=
sence.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">COLO disk Manager:<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-When primary VM writes data in=
to image, the colo disk manger captures this data<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;When primary VM writes dat=
a into image, the colo disk manager captures this data<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">and sends it to secondary VM's =
which makes sure the context of secondary VM's<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">image is consistent with the co=
ntext of primary VM 's image.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">For more details, please refer =
to docs/block-replication.txt.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -146,12 &#43;146,12 @@ in te=
st procedure.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">=3D=3D Test procedure =3D=3D<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Note: Here we are running both =
instances on the same host for testing,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-change the IP Addresses if you=
 want to run it on two hosts. Initally<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;change the IP Addresses if=
 you want to run it on two hosts. Initially<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">127.0.0.1 is the Primary Host a=
nd 127.0.0.2 is the Secondary Host.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">=3D=3D Startup qemu =3D=3D<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1. Primary:<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-Note: Initally, $imagefolder/p=
rimary.qcow2 needs to be copied to all hosts.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;Note: Initially, $imagefol=
der/primary.qcow2 needs to be copied to all hosts.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">You don't need to change any IP=
's here, because 0.0.0.0 listens on any<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">interface. The chardev's with 1=
27.0.0.1 IP's loopback to the local qemu<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">instance.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/devel/blkdebu=
g.txt b/docs/devel/blkdebug.txt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 43d8e8f9c6..0b0c128d35 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/devel/blkdebug.txt<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/devel/bl=
kdebug.txt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -62,7 &#43;62,7 @@ Rules sup=
port the following attributes:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; errno - the numeri=
c errno value to return when a request matches this rule.<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The errno values depend on the host since the=
 numeric values are not<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; standarized in the POSIX specification.<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; standardized in the POSIX specification.<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; sector - (optional=
) a sector number that the request must overlap in order to<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; match this rule<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/devel/migrati=
on.rst b/docs/devel/migration.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 2eb08624fc..49112bb27a 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/devel/migration.rst<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/devel/mi=
gration.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -625,7 &#43;625,7 @@ It can =
be issued immediately after migration is started or any<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">time later on.&nbsp; Issuing it=
 after the end of a migration is harmless.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Blocktime is a postcopy live mi=
gration metric, intended to show how<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-long the vCPU was in state of =
interruptable sleep due to pagefault.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;long the vCPU was in state=
 of interruptible sleep due to pagefault.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">That metric is calculated both =
for all vCPUs as overlapped value, and<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">separately for each vCPU. These=
 values are calculated on destination<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">side.&nbsp; To enable postcopy =
blocktime calculation, enter following<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/devel/testing=
.rst b/docs/devel/testing.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 196e3bc35e..bd64c1bdcd 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/devel/testing.rst<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/devel/te=
sting.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -471,7 &#43;471,7 @@ the war=
ning.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">A few important files for suppr=
essing warnings are:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">tests/tsan/suppressions.tsan - =
Has TSan warnings we wish to suppress at runtime.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-The comment on each supression=
 will typically indicate why we are<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;The comment on each suppre=
ssion will typically indicate why we are<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">suppressing it.&nbsp; More info=
rmation on the file format can be found here:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">https://github.com/google/sanit=
izers/wiki/ThreadSanitizerSuppressions<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/devel/tracing=
.txt b/docs/devel/tracing.txt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 6144d9921b..d2160655b4 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/devel/tracing.txt<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/devel/tr=
acing.txt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -55,7 &#43;55,7 @@ without a=
ny sub-directory path prefix. eg io/channel-buffer.c would do<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; #include &quot;tra=
ce.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">To access the 'io/trace.h' file=
. While it is possible to include a trace.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-file from outside a source fil=
es' own sub-directory, this is discouraged in<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;file from outside a source=
 file's own sub-directory, this is discouraged in<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">general. It is strongly preferr=
ed that all events be declared directly in<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">the sub-directory that uses the=
m. The only exception is where there are some<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">shared trace events defined in =
the top level directory trace-events file.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/interop/bitma=
ps.rst b/docs/interop/bitmaps.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index c20bd37a79..059ad67929 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/interop/bitmaps.rst<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/interop/=
bitmaps.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -484,7 &#43;484,7 @@ Bitmaps=
 can generally be modified at any time, but certain operations often<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">only make sense when paired dir=
ectly with other commands. When a VM is paused,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">it's easy to ensure that no gue=
st writes occur between individual QMP<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">commands. When a VM is running,=
 this is difficult to accomplish with<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-individual QMP commands that m=
ay allow guest writes to occur inbetween each<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;individual QMP commands th=
at may allow guest writes to occur between each<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">command.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">For example, using only individ=
ual QMP commands, we could:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/interop/dbus.=
rst b/docs/interop/dbus.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 76a5bde625..be596d3f41 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/interop/dbus.rst<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/interop/=
dbus.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -57,7 &#43;57,7 @@ Depending=
 on the use case, you may choose different scenarios:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; - Everything the same UI=
D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; - Convenient=
 for developers<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp; - Improved reliab=
ility - crash of one part doens't take<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp; - Improved re=
liability - crash of one part doesn't take<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
out entire VM<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; - No securit=
y benefit over traditional QEMU, unless additional<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
unless additional controls such as SELinux or AppArmor are<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -87,7 &#43;87,7 @@ For examp=
le, to allow only ``qemu`` user to talk to ``qemu-helper``<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; &lt;/policy&gt;<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-dbus-daemon can also perfom SE=
Linux checks based on the security<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;dbus-daemon can also perfo=
rm SELinux checks based on the security<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">context of the source and the t=
arget. For example, ``virtiofs_t``<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">could be allowed to send a mess=
age to ``svirt_t``, but ``virtiofs_t``<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">wouldn't be allowed to send a m=
essage to ``virtiofs_t``.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/interop/nbd.t=
xt b/docs/interop/nbd.txt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 4511880961..f3b3cacc96 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/interop/nbd.txt<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/interop/=
nbd.txt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -53,5 &#43;53,5 @@ the opera=
tion of that feature.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">* 2.12: NBD_CMD_BLOCK_STATUS fo=
r &quot;base:allocation&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">* 3.0: NBD_OPT_STARTTLS with TL=
S Pre-Shared Keys (PSK),<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">NBD_CMD_BLOCK_STATUS for &quot;=
qemu:dirty-bitmap:&quot;, NBD_CMD_CACHE<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-* 4.2: NBD_FLAG_CAN_MULTI_CONN=
 for sharable read-only exports,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;* 4.2: NBD_FLAG_CAN_MULTI_=
CONN for shareable read-only exports,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">NBD_CMD_FLAG_FAST_ZERO<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/interop/vhost=
-user-gpu.rst b/docs/interop/vhost-user-gpu.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 688f8b4259..3268bf405c 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/interop/vhost-user-g=
pu.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/interop/=
vhost-user-gpu.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -66,7 &#43;66,7 @@ VhostUser=
GpuCursorPos<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">:scanout-id: ``u32``, the scano=
ut where the cursor is located<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-:x/y: ``u32``, the cursor post=
ion<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;:x/y: ``u32``, the cursor =
position<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">VhostUserGpuCursorUpdate<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">^^^^^^^^^^^^^^^^^^^^^^^^<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/interop/vhost=
-user.rst b/docs/interop/vhost-user.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 10e3e3475e..988f154144 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/interop/vhost-user.r=
st<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/interop/=
vhost-user.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -464,7 &#43;464,7 @@ the ``V=
HOST_USER_SET_MEM_TABLE`` request. For invalidation events, the<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">(3), the I/O virtual address an=
d the size. On success, the slave is<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">expected to reply with a zero p=
ayload, non-zero otherwise.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-The slave relies on the slave =
communcation channel (see :ref:`Slave<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;The slave relies on the sl=
ave communication channel (see :ref:`Slave<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">communication &lt;slave_communi=
cation&gt;` section below) to send IOTLB miss<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">and access failure events, by s=
ending ``VHOST_USER_SLAVE_IOTLB_MSG``<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">requests to the master with a `=
`struct vhost_iotlb_msg`` as<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -1450,7 &#43;1450,7 @@ vhost=
-user backends can provide various devices &amp; services and may<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">need to be configured manually =
depending on the use case. However, it<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">is a good idea to follow the co=
nventions listed here when<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">possible. Users, QEMU or libvir=
t, can then rely on some common<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-behaviour to avoid heterogenou=
s configuration and management of the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;behaviour to avoid heterog=
eneous configuration and management of the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">backend programs and facilitate=
 interoperability.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Each backend installed on a hos=
t system should come with at least one<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/rdma.txt b/do=
cs/rdma.txt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index a86e992c84..49dc9f8bca 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/rdma.txt<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/rdma.txt=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -261,7 &#43;261,7 @@ qemu_rd=
ma_exchange_send(header, data, optional response header &amp; data):<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; of the conne=
ction (described below).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">All of the remaining command ty=
pes (not including 'ready')<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-described above all use the af=
ormentioned two functions to do the hard work:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;described above all use th=
e aforementioned two functions to do the hard work:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1. After connection setup, RAMB=
lock information is exchanged using<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; this protoco=
l before the actual migration begins. This information includes<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/specs/ppc-spa=
pr-hotplug.txt b/docs/specs/ppc-spapr-hotplug.txt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 859d52cce6..d4fb2d46d9 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/specs/ppc-spapr-hotp=
lug.txt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/specs/pp=
c-spapr-hotplug.txt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -371,7 &#43;371,7 @@ ibm,dyn=
amic-memory<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">This property describes the dyn=
amically reconfigurable memory. It is a<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">property encoded array that has=
 an integer N, the number of LMBs followed<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-by N LMB list entires.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;by N LMB list entries.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Each LMB list entry consists of=
 the following elements:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -390,7 &#43;390,7 @@ Each LM=
B list entry consists of the following elements:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">ibm,dynamic-memory-v2<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">This property describes the dyn=
amically reconfigurable memory. This is<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-an alternate and newer way to =
describe dyanamically reconfigurable memory.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;an alternate and newer way=
 to describe dynamically reconfigurable memory.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">It is a property encoded array =
that has an integer N (the number of<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">LMB set entries) followed by N =
LMB set entries. There is an LMB set entry<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">for each sequential group of LM=
Bs that share common attributes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/specs/ppc-spa=
pr-xive.rst b/docs/specs/ppc-spapr-xive.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 7144347560..f47f739e01 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/specs/ppc-spapr-xive=
.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/specs/pp=
c-spapr-xive.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -46,7 &#43;46,7 @@ default m=
ode. ``dual`` means that both modes XICS **and** XIVE are<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">supported and if the guest OS s=
upports XIVE, this mode will be<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">selected.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-The choosen interrupt mode is =
activated after a reconfiguration done<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;The chosen interrupt mode =
is activated after a reconfiguration done<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">in a machine reset.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">KVM negotiation<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -158,7 &#43;158,7 @@ XIVE De=
vice tree properties<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---------------------------<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The properties for the PAPR int=
errupt controller node when the *XIVE<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-native exploitation mode* is s=
elected shoud contain:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;native exploitation mode* =
is selected should contain:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- ``device_type``<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/system/arm/as=
peed.rst b/docs/system/arm/aspeed.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 45f891eb3c..fe45840fbe 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/system/arm/aspeed.rs=
t<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/system/a=
rm/aspeed.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -72,7 &#43;72,7 @@ Boot opti=
ons<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">------------<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The Aspeed machines can be star=
ted using the -kernel option to load a<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-Linux kernel or from a firmare=
 image which can be downloaded from the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;Linux kernel or from a fir=
mware image which can be downloaded from the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">OpenPOWER jenkins :<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; https://open=
power.xyz/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/system/deprec=
ated.rst b/docs/system/deprecated.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 851dbdeb8a..8a4721cae3 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/system/deprecated.rs=
t<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/system/d=
eprecated.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -79,7 &#43;79,7 @@ Creating =
sound card devices and vnc without ``audiodev=3D`` property (since 4.2)<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">When not using the deprecated l=
egacy audio config, each sound card<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">should specify an ``audiodev=3D=
`` property.&nbsp; Additionally, when using<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-vnc, you should specify an ``a=
udiodev=3D`` propery if you plan to<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;vnc, you should specify an=
 ``audiodev=3D`` property if you plan to<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">transmit audio through the VNC =
protocol.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Creating sound card devices usi=
ng ``-soundhw`` (since 5.1)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -111,7 &#43;111,7 @@ Splitti=
ng RAM by default between NUMA nodes has the same issues as ``mem``<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">parameter described above with =
the difference that the role of the user plays<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">QEMU using implicit generic or =
board specific splitting rule.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Use ``memdev`` with *memory-bac=
kend-ram* backend or ``mem`` (if<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-it's supported by used machine=
 type) to define mapping explictly instead.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;it's supported by used mac=
hine type) to define mapping explicitly instead.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">``-mem-path`` fallback to RAM (=
since 4.1)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">'''''''''''''''''''''''''''''''=
''''''''''<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -526,10 &#43;526,10 @@ The `=
`[hub_id name]`` parameter tuple of the 'hostfwd_add' and<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Guest Emulator ISAs<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-------------------<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-RISC-V ISA privledge specifica=
tion version 1.09.1 (removed in 5.1)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;RISC-V ISA privilege speci=
fication version 1.09.1 (removed in 5.1)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">'''''''''''''''''''''''''''''''=
'''''''''''''''''''''''''''''''''''<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-The RISC-V ISA privledge speci=
fication version 1.09.1 has been removed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;The RISC-V ISA privilege s=
pecification version 1.09.1 has been removed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">QEMU supports both the newer ve=
rsion 1.10.0 and the ratified version 1.11.0, these<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">should be used instead of the 1=
.09.1 version.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/system/target=
-avr.rst b/docs/system/target-avr.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index dc99afc895..86781ce5c2 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/system/target-avr.rs=
t<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/system/t=
arget-avr.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -10,7 &#43;10,7 @@ xmega6 an=
d xmega7.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">As for now it supports few Ardu=
ino boards for educational and testing purposes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">These boards use a ATmega contr=
oller, which model is limited to USART &amp; 16-bit<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-timer devices, enought to run =
FreeRTOS based applications (like<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;timer devices, enough to r=
un FreeRTOS based applications (like<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">https://github.com/seharris/qem=
u-avr-tests/blob/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -26,7 &#43;26,7 @@ AVR cpu<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; and then in =
another shell<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; ``telnet loc=
alhost 5678``<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- - Debugging wit GDB debugger:=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; - Debugging with GDB debu=
gger:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; ``qemu-syste=
m-avr -machine mega2560 -bios demo.elf -s -S``<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; and then in =
another shell<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; ``avr-gdb de=
mo.elf``<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/docs/tools/virtiof=
sd.rst b/docs/tools/virtiofsd.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 824e713491..48f7926be3 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/docs/tools/virtiofsd.rst<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/docs/tools/vi=
rtiofsd.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -79,7 &#43;79,7 @@ Options<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; I/O ti=
meout in seconds.&nbsp; The default depends on cache=3D option.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; * writeback|no_wri=
teback -<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp; Enable/disa=
ble writeback cache. The cache alows the FUSE client to buffer<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp; Enable/=
disable writeback cache. The cache allows the FUSE client to buffer<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; and me=
rge write requests.&nbsp; The default is ``no_writeback``.<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; * xattr|no_xattr -=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2.26.2.windows.1<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_640CDEE67BE2784FAE298BB2517210E48AC3BEdggemi522mbschina_--

