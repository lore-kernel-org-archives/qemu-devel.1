Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72957C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298CB21775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4b/d5rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298CB21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izoqN-0007EK-B5
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoc9-00048b-Np
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoc7-00036s-8P
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:23:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37901
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoc7-000358-2k
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=das4TYwqD3+hVOFsCvYLPKNRr8GpOG0Dph32BDvyBVE=;
 b=S4b/d5rtsvjlDznewJ/Wr5a5H005+In0NfZeZLdv/GpClLoZZmRrd7d03OgyFEsxirYhOm
 YM+7qWOFLuajobRThJ0nuVmRDoBViWeaiF9doaw2TWYdHrkw41R8UDGYz2JACYnb0dBIJw
 FeXLTSqBl0+44FJ5FwpU3xzxm13DUeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-C-aYL-h_OX-80a5N508MJg-1; Thu, 06 Feb 2020 16:23:01 -0500
X-MC-Unique: C-aYL-h_OX-80a5N508MJg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E5FD1081FA3;
 Thu,  6 Feb 2020 21:23:00 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC8D260BEC;
 Thu,  6 Feb 2020 21:22:50 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 45/46] drop "from __future__ import print_function"
Date: Thu,  6 Feb 2020 22:19:35 +0100
Message-Id: <20200206211936.17098-46-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Overall KVM CPUs" <kvm@vger.kernel.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

This is only needed for Python 2, which we do not support anymore.

Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200204160604.19883-1-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/analyse-9p-simpletrace.py        | 1 -
 scripts/analyse-locks-simpletrace.py     | 1 -
 scripts/device-crash-test                | 1 -
 scripts/dump-guest-memory.py             | 1 -
 scripts/kvm/kvm_flightrecorder           | 1 -
 scripts/kvm/vmxcap                       | 1 -
 scripts/minikconf.py                     | 1 -
 scripts/modules/module_block.py          | 1 -
 scripts/qapi-gen.py                      | 1 -
 scripts/qapi/doc.py                      | 1 -
 scripts/qmp/qemu-ga-client               | 1 -
 scripts/qmp/qmp                          | 1 -
 scripts/qmp/qmp-shell                    | 1 -
 scripts/qmp/qom-get                      | 1 -
 scripts/qmp/qom-list                     | 1 -
 scripts/qmp/qom-set                      | 1 -
 scripts/qmp/qom-tree                     | 1 -
 scripts/replay-dump.py                   | 1 -
 scripts/signrom.py                       | 1 -
 scripts/simpletrace.py                   | 1 -
 scripts/vmstate-static-checker.py        | 1 -
 tests/docker/travis.py                   | 1 -
 tests/guest-debug/test-gdbstub.py        | 1 -
 tests/migration/guestperf/engine.py      | 1 -
 tests/migration/guestperf/plot.py        | 1 -
 tests/migration/guestperf/shell.py       | 1 -
 tests/qapi-schema/test-qapi.py           | 1 -
 tests/qemu-iotests/149                   | 1 -
 tests/qemu-iotests/165                   | 1 -
 tests/qemu-iotests/iotests.py            | 1 -
 tests/qemu-iotests/nbd-fault-injector.py | 1 -
 tests/qemu-iotests/qcow2.py              | 1 -
 tests/qemu-iotests/qed.py                | 1 -
 tests/vm/basevm.py                       | 1 -
 34 files changed, 34 deletions(-)

diff --git a/scripts/analyse-9p-simpletrace.py b/scripts/analyse-9p-simpl=
etrace.py
index f20050fddd..7dfcb6ba2f 100755
--- a/scripts/analyse-9p-simpletrace.py
+++ b/scripts/analyse-9p-simpletrace.py
@@ -3,7 +3,6 @@
 # Usage: ./analyse-9p-simpletrace <trace-events> <trace-pid>
 #
 # Author: Harsh Prateek Bora
-from __future__ import print_function
 import os
 import simpletrace
=20
diff --git a/scripts/analyse-locks-simpletrace.py b/scripts/analyse-locks=
-simpletrace.py
index 9c263d6e79..63c11f4fce 100755
--- a/scripts/analyse-locks-simpletrace.py
+++ b/scripts/analyse-locks-simpletrace.py
@@ -6,7 +6,6 @@
 # Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
 #
=20
-from __future__ import print_function
 import simpletrace
 import argparse
 import numpy as np
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 25ee968b66..305d0427af 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -23,7 +23,6 @@
 Run QEMU with all combinations of -machine and -device types,
 check for crashes and unexpected errors.
 """
-from __future__ import print_function
=20
 import os
 import sys
diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 9371e45813..4177261d33 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -12,7 +12,6 @@ Authors:
 This work is licensed under the terms of the GNU GPL, version 2 or later=
. See
 the COPYING file in the top-level directory.
 """
-from __future__ import print_function
=20
 import ctypes
 import struct
diff --git a/scripts/kvm/kvm_flightrecorder b/scripts/kvm/kvm_flightrecor=
der
index 1391a84409..78ca3af9c4 100755
--- a/scripts/kvm/kvm_flightrecorder
+++ b/scripts/kvm/kvm_flightrecorder
@@ -32,7 +32,6 @@
 # consuming CPU cycles.  No disk I/O is performed since the ring buffer =
holds a
 # fixed-size in-memory trace.
=20
-from __future__ import print_function
 import sys
 import os
=20
diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index 5dfeb2e03a..971ed0e721 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -10,7 +10,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2.  See
 # the COPYING file in the top-level directory.
=20
-from __future__ import print_function
 MSR_IA32_VMX_BASIC =3D 0x480
 MSR_IA32_VMX_PINBASED_CTLS =3D 0x481
 MSR_IA32_VMX_PROCBASED_CTLS =3D 0x482
diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 377d6228b9..2f9647d0fa 100755
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -11,7 +11,6 @@
 # or, at your option, any later version.  See the COPYING file in
 # the top-level directory.
=20
-from __future__ import print_function
 import os
 import sys
 import re
diff --git a/scripts/modules/module_block.py b/scripts/modules/module_blo=
ck.py
index 08646af92c..f23191fac1 100644
--- a/scripts/modules/module_block.py
+++ b/scripts/modules/module_block.py
@@ -10,7 +10,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
=20
-from __future__ import print_function
 import sys
 import os
=20
diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index c7b0070db2..4b03f7d53b 100755
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -4,7 +4,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
 # See the COPYING file in the top-level directory.
=20
-from __future__ import print_function
=20
 import argparse
 import re
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 6f1c17f71f..1787a53d91 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -4,7 +4,6 @@
 # See the COPYING file in the top-level directory.
 """This script produces the documentation of a qapi schema in texinfo fo=
rmat"""
=20
-from __future__ import print_function
 import re
 from qapi.gen import QAPIGenDoc, QAPISchemaVisitor
=20
diff --git a/scripts/qmp/qemu-ga-client b/scripts/qmp/qemu-ga-client
index e4568aff68..ce122984a9 100755
--- a/scripts/qmp/qemu-ga-client
+++ b/scripts/qmp/qemu-ga-client
@@ -36,7 +36,6 @@
 # See also: https://wiki.qemu.org/Features/QAPI/GuestAgent
 #
=20
-from __future__ import print_function
 import os
 import sys
 import base64
diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
index f85a14a627..0625fc2aba 100755
--- a/scripts/qmp/qmp
+++ b/scripts/qmp/qmp
@@ -10,7 +10,6 @@
 # This work is licensed under the terms of the GNU GPLv2 or later.
 # See the COPYING file in the top-level directory.
=20
-from __future__ import print_function
 import sys, os
 from qmp import QEMUMonitorProtocol
=20
diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 9e122ad0c6..a01d31de1e 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -65,7 +65,6 @@
 # which will echo back the properly formatted JSON-compliant QMP that is=
 being
 # sent to QEMU, which is useful for debugging and documentation generati=
on.
=20
-from __future__ import print_function
 import json
 import ast
 import readline
diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
index ec5275d53a..007b4cd442 100755
--- a/scripts/qmp/qom-get
+++ b/scripts/qmp/qom-get
@@ -11,7 +11,6 @@
 # the COPYING file in the top-level directory.
 ##
=20
-from __future__ import print_function
 import sys
 import os
 from qmp import QEMUMonitorProtocol
diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
index 0f97440973..03bda3446b 100755
--- a/scripts/qmp/qom-list
+++ b/scripts/qmp/qom-list
@@ -11,7 +11,6 @@
 # the COPYING file in the top-level directory.
 ##
=20
-from __future__ import print_function
 import sys
 import os
 from qmp import QEMUMonitorProtocol
diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index 26ed9e3263..c37fe78b00 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -11,7 +11,6 @@
 # the COPYING file in the top-level directory.
 ##
=20
-from __future__ import print_function
 import sys
 import os
 from qmp import QEMUMonitorProtocol
diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
index 31603c681f..1c8acf61e7 100755
--- a/scripts/qmp/qom-tree
+++ b/scripts/qmp/qom-tree
@@ -13,7 +13,6 @@
 # the COPYING file in the top-level directory.
 ##
=20
-from __future__ import print_function
 import sys
 import os
 from qmp import QEMUMonitorProtocol
diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 0cdae879b7..4cbc1e47c6 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -18,7 +18,6 @@
 # You should have received a copy of the GNU Lesser General Public
 # License along with this library; if not, see <http://www.gnu.org/licen=
ses/>.
=20
-from __future__ import print_function
 import argparse
 import struct
 from collections import namedtuple
diff --git a/scripts/signrom.py b/scripts/signrom.py
index 9be5dab1cf..43693dba56 100755
--- a/scripts/signrom.py
+++ b/scripts/signrom.py
@@ -1,6 +1,5 @@
 #!/usr/bin/env python3
=20
-from __future__ import print_function
 #
 # Option ROM signing utility
 #
diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 2bc043112a..20f0026066 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -9,7 +9,6 @@
 #
 # For help see docs/devel/tracing.txt
=20
-from __future__ import print_function
 import struct
 import inspect
 from tracetool import read_events, Event
diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-c=
hecker.py
index d44dedd9e9..539ead62b4 100755
--- a/scripts/vmstate-static-checker.py
+++ b/scripts/vmstate-static-checker.py
@@ -19,7 +19,6 @@
 # You should have received a copy of the GNU General Public License alon=
g
 # with this program; if not, see <http://www.gnu.org/licenses/>.
=20
-from __future__ import print_function
 import argparse
 import json
 import sys
diff --git a/tests/docker/travis.py b/tests/docker/travis.py
index 62fccc5ebb..37307ac366 100755
--- a/tests/docker/travis.py
+++ b/tests/docker/travis.py
@@ -11,7 +11,6 @@
 # or (at your option) any later version. See the COPYING file in
 # the top-level directory.
=20
-from __future__ import print_function
 import sys
 import yaml
 import itertools
diff --git a/tests/guest-debug/test-gdbstub.py b/tests/guest-debug/test-g=
dbstub.py
index c7e3986a24..98a5df4d42 100644
--- a/tests/guest-debug/test-gdbstub.py
+++ b/tests/guest-debug/test-gdbstub.py
@@ -1,4 +1,3 @@
-from __future__ import print_function
 #
 # This script needs to be run on startup
 # qemu -kernel ${KERNEL} -s -S
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestp=
erf/engine.py
index 1dd04ce33b..fd63c66601 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -1,4 +1,3 @@
-from __future__ import print_function
 #
 # Migration test main engine
 #
diff --git a/tests/migration/guestperf/plot.py b/tests/migration/guestper=
f/plot.py
index aa98912a82..34cebd54ba 100644
--- a/tests/migration/guestperf/plot.py
+++ b/tests/migration/guestperf/plot.py
@@ -1,4 +1,3 @@
-from __future__ import print_function
 #
 # Migration test graph plotting
 #
diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestpe=
rf/shell.py
index 61d2abbaad..5bcc066bb9 100644
--- a/tests/migration/guestperf/shell.py
+++ b/tests/migration/guestperf/shell.py
@@ -1,4 +1,3 @@
-from __future__ import print_function
 #
 # Migration test command line shell integration
 #
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 503fb8ad25..41232c11a3 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -11,7 +11,6 @@
 # See the COPYING file in the top-level directory.
 #
=20
-from __future__ import print_function
=20
 import argparse
 import difflib
diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index 0a7b765d07..b4a21bf7b7 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -20,7 +20,6 @@
 # Exercise the QEMU 'luks' block driver to validate interoperability
 # with the Linux dm-crypt + cryptsetup implementation
=20
-from __future__ import print_function
 import subprocess
 import os
 import os.path
diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index b60a803dae..fb56a769b4 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -18,7 +18,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
=20
-from __future__ import print_function
 import os
 import re
 import iotests
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 89aa2df2f3..657d2b8724 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1,4 +1,3 @@
-from __future__ import print_function
 # Common utilities and Python wrappers for qemu-iotests
 #
 # Copyright (C) 2012 IBM Corp.
diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotest=
s/nbd-fault-injector.py
index b158dd65a2..588d62aebf 100755
--- a/tests/qemu-iotests/nbd-fault-injector.py
+++ b/tests/qemu-iotests/nbd-fault-injector.py
@@ -43,7 +43,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
 # See the COPYING file in the top-level directory.
=20
-from __future__ import print_function
 import sys
 import socket
 import struct
diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 1c4fa2b09f..94a07b2f6f 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -1,6 +1,5 @@
 #!/usr/bin/env python3
=20
-from __future__ import print_function
 import sys
 import struct
 import string
diff --git a/tests/qemu-iotests/qed.py b/tests/qemu-iotests/qed.py
index 36bca1de23..d6bec96069 100755
--- a/tests/qemu-iotests/qed.py
+++ b/tests/qemu-iotests/qed.py
@@ -10,7 +10,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
 # See the COPYING file in the top-level directory.
=20
-from __future__ import print_function
 import sys
 import struct
 import random
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 30714fa1a8..4dee6647e6 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -11,7 +11,6 @@
 # the COPYING file in the top-level directory.
 #
=20
-from __future__ import print_function
 import os
 import re
 import sys
--=20
2.21.1


