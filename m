Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587C3C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1D420672
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="RGtOqTr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1D420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXqqH-0007dF-Tk
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 13:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iXqak-0000GC-Mh
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iXqai-00076X-8M
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:50:06 -0500
Received: from mout.web.de ([212.227.15.3]:47873)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1iXqah-000766-Rk
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574358579;
 bh=yXu8lwW3nSXeCgvYXToXRi5ZquVyneVbYn6+LKIl2/s=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=RGtOqTr4mEtz0Uy3gIqCIDoHToNJi79fk/2vax9NeMVNC64ZJhfsJhkbwKSYt1ua+
 fyvYyo9O0ga+/lHewaEnneHdUiQWasqMsq2soG6wVuLcHzRolepUmNHy7AxCGXuID7
 oMso6epzOofwgB0G5Y/EtoeF+O3n7C9UJu2iZbOk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.160]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZAp2-1iHGbn0EP6-00KxTH; Thu, 21
 Nov 2019 18:49:39 +0100
Date: Thu, 21 Nov 2019 18:49:38 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 3/4] colo: Introduce high-level test
Message-ID: <8415b472eb0b5ed9e787850d70f7952a29b93934.1574356137.git.lukasstraub2@web.de>
In-Reply-To: <cover.1574356137.git.lukasstraub2@web.de>
References: <cover.1574356137.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GddmsFf24tQM+2bWN7uo92zhAOkad+mt+q2fjAYhNXNA8W8bu9N
 laWwne7a3jIIt6OIDcr5FhXECDd3HgrjVXZKEt89yfZ/oLaUm31gGon3WJM5pGayMxiSG9Q
 T4m6uJA8WfXrcCA2pixTdRn3pq4YdLQc6sXsPcKQmZfnuVf5RQDbaB7y5HQnOoOR7/nPgyS
 3jk3yFy3WypqsUR4qq81A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z+aRLUIZEjg=:kVwx94ADFL0GTNHMfdc3YH
 5H3K1Gv3VKxHhMEAsUtL2A8iEbzWxGcF2AdW4Bf3lIhb9eh7sBSlnR+V6q1ODAWYN7GGIuVFa
 K0zGIU9wnuT53GtvN2kIUAcnsxt0NIUYYrpe9tOSnj9ByKKl92EElKMn9JObEhtdY62Tohl7S
 3k4NNeI/UC5ILDc9ocKMFPELl2sBYTFwPEr4lBn37Lt636djZdFacBrSoEI71EplmwkykPDs+
 wFYPbzjlWQ0nwjovDUpKoLPpgFWXwhXxbFQ8L3BCSAeVEiVm5WHnU3B78h7CL9e4u9oSVOjcG
 VqWTvyPmhj8kJIoeynryF5bNG/Dm2jqepNP0YFBpxsBvlDs76ar/jjJYKzPogCR8hyh2r02np
 karBbnXi+NcgJ/tEHxE4+POauPeveDL/63DZ07zVFXYafUuvN6uW6YA1HPDskXoo+sg11prbk
 AMAH3Spmo7hzCDb2P09CJilorQH91nAtkHHTd0Qvr5rUfaieJQGM2dkEAyxXQthu9ovXMo0aw
 eOVBs3qTBk2NGodvVbI/8sxTYPPd9bYjCD1M+HQBlT0T0OTs4SqbyW8o7Z5EgdzeV6KIpxcRn
 22onMp9x0kPSjn/oAr0UqsEjZMhBpOB3jOZV01uqJVDdQO21pVllQlU+NE4H+QMDwuSR/thS/
 k7A/MurlTDw1EnmX1/kta84FDMrhqsCwwlK8qvuVg7O7KtG3WbgkkmWUe5MPZEwuarHJTg5ck
 3axTHmHYUUrPcIsaNIi7s+X9IFQeF48fLfR7ytRMm77wcgYC8rU/RWUF5KEA3Dx3RYUhfIkYG
 /n3aIjV8CK4B+lQp9BcTXikEwTZHpKfUzeoVss6sVhBon2VEhDX4IgYK+N1GdpsOtyMoEsN6l
 J48kpUZK+wu6Do2l3hFtRx4YRLuh7uulTV+Gfn1gMK2zzlsk5WGwRi/05liovBMGmDuj93VHR
 JsoFZuJHvtCV2ByBdjv2pmWfBdNSyfeM3WZrqlcd2gnD464qXzDmLKU44y8Nvc7VgL9J7LrY2
 Qq+l07uUmtbDQpgo/YMnXLaplmWjIYKYRczb/koGcZpjiqORvBvgsmuWNGpwObJje52aQhndR
 LPXO+aqLFZLGgljJ6HKuhRCXveKJvekytQbzFxlR/vVTgzegkl1Lbq0FL1CupFoLEZCIOieVs
 qqMP9cPO4ZPV8LCISwRCXc/Bsknh9orknAdJXY94HMj72cf83VqkD+4oSRh6Gjka8IAF/S+gz
 LY11GtMY72By3zGBO5ruiy09IC0PmnirKTH387mwvBS83MNNFeXRX7cb9T8o=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.3
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add high-level test relying on the colo resource-agent to test
all failover cases while checking guest network connectivity

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 scripts/colo-resource-agent/crm_master |  44 +++
 tests/acceptance/colo.py               | 444 +++++++++++++++++++++++++
 2 files changed, 488 insertions(+)
 create mode 100755 scripts/colo-resource-agent/crm_master
 create mode 100644 tests/acceptance/colo.py

diff --git a/scripts/colo-resource-agent/crm_master b/scripts/colo-resourc=
e-agent/crm_master
new file mode 100755
index 0000000000..00c386b949
=2D-- /dev/null
+++ b/scripts/colo-resource-agent/crm_master
@@ -0,0 +1,44 @@
+#!/bin/bash
+
+# Fake crm_master for COLO testing
+#
+# Copyright (c) Lukas Straub <lukasstraub2@web.de>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+TMPDIR=3D"$HA_RSCTMP"
+score=3D0
+query=3D0
+
+OPTIND=3D1
+while getopts 'Qql:Dv:N:G' opt; do
+    case "$opt" in
+        Q|q)
+            # Noop
+        ;;
+        "l")
+            # Noop
+        ;;
+        "D")
+            score=3D0
+        ;;
+        "v")
+            score=3D$OPTARG
+        ;;
+        "N")
+            TMPDIR=3D"$COLO_SMOKE_REMOTE_TMP"
+        ;;
+        "G")
+            query=3D1
+        ;;
+    esac
+done
+
+if (( query )); then
+    cat "${TMPDIR}/master_score" || exit 1
+else
+    echo $score > "${TMPDIR}/master_score" || exit 1
+fi
+
+exit 0
diff --git a/tests/acceptance/colo.py b/tests/acceptance/colo.py
new file mode 100644
index 0000000000..94a6adabdd
=2D-- /dev/null
+++ b/tests/acceptance/colo.py
@@ -0,0 +1,444 @@
+#!/usr/bin/env python
+
+# High-level test for qemu COLO testing all failover cases while checking
+# guest network connectivity
+#
+# Copyright (c) Lukas Straub <lukasstraub2@web.de>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import select
+import sys
+import subprocess
+import shutil
+import os
+import signal
+import os.path
+import json
+import time
+import tempfile
+
+from avocado import Test
+from avocado.utils.archive import gzip_uncompress
+from avocado.utils import network
+from avocado_qemu import pick_default_qemu_bin, SRC_ROOT_DIR
+
+class ColoTest(Test):
+    timeout =3D 120
+
+    # Constants
+    OCF_SUCCESS =3D 0
+    OCF_ERR_GENERIC =3D 1
+    OCF_ERR_ARGS =3D 2
+    OCF_ERR_UNIMPLEMENTED =3D 3
+    OCF_ERR_PERM =3D 4
+    OCF_ERR_INSTALLED =3D 5
+    OCF_ERR_CONFIGURED =3D 6
+    OCF_NOT_RUNNING =3D 7
+    OCF_RUNNING_MASTER =3D 8
+    OCF_FAILED_MASTER =3D 9
+
+    HOSTA =3D 10
+    HOSTB =3D 11
+
+    QEMU_OPTIONS =3D (" -enable-kvm -cpu qemu64,+kvmclock -m 256"
+                    " -device virtio-net,netdev=3Dhn0"
+                    " -device virtio-blk,drive=3Dcolo-disk0")
+    COLO_RA =3D "scripts/colo-resource-agent/colo"
+    FAKEPATH =3D ".:scripts/colo-resource-agent"
+
+    bridge_proc =3D None
+    ssh_proc =3D None
+
+    def setUp(self):
+        # Qemu binary
+        default_qemu_bin =3D pick_default_qemu_bin()
+        self.QEMU_BINARY =3D self.params.get('qemu_bin', default=3Ddefaul=
t_qemu_bin)
+
+        # Find free port range
+        base_port =3D 1024
+        while True:
+            base_port =3D network.find_free_port(start_port=3Dbase_port, =
\
+                                               address=3D"127.0.0.1")
+            if base_port =3D=3D None:
+                self.cancel("Failed to find a free port")
+            for n in range(base_port, base_port +6):
+                if not network.is_port_free(n, "127.0.0.1"):
+                    base_port =3D n +1
+                    break
+            else:
+                # for loop above didn't break
+                break
+
+        self.BRIDGE_HOSTA_PORT =3D base_port
+        self.BRIDGE_HOSTB_PORT =3D base_port + 1
+        self.SSH_PORT =3D base_port + 2
+        self.COLO_BASE_PORT =3D base_port + 3
+
+        # Temporary directories
+        self.TMPDIR =3D tempfile.mkdtemp()
+        self.TMPA =3D os.path.join(self.TMPDIR, "hosta")
+        self.TMPB =3D os.path.join(self.TMPDIR, "hostb")
+        os.makedirs(self.TMPA)
+        os.makedirs(self.TMPB)
+
+        # Disk images
+        self.HOSTA_IMAGE =3D os.path.join(self.TMPA, "image.raw")
+        self.HOSTB_IMAGE =3D os.path.join(self.TMPB, "image.raw")
+
+        image_url =3D ("https://downloads.openwrt.org/releases/18.06.5/ta=
rgets/"
+                     "x86/64/openwrt-18.06.5-x86-64-combined-ext4.img.gz"=
)
+        image_hash =3D ("55589a3a9b943218b1734d196bcaa92a"
+                      "3cfad91c07fa6891474b4291ce1b8ec2")
+        self.IMAGE_SIZE =3D "285736960b"
+        download =3D self.fetch_asset(image_url, asset_hash=3Dimage_hash,=
 \
+                                    algorithm=3D"sha256")
+        gzip_uncompress(download, self.HOSTA_IMAGE)
+        shutil.copyfile(self.HOSTA_IMAGE, self.HOSTB_IMAGE)
+
+        self.log.info("Will put logs in \"%s\"" % self.outputdir)
+        self.RA_LOG =3D os.path.join(self.outputdir, "resource-agent.log"=
)
+        self.HOSTA_LOGDIR =3D os.path.join(self.outputdir, "hosta")
+        self.HOSTB_LOGDIR =3D os.path.join(self.outputdir, "hostb")
+        os.makedirs(self.HOSTA_LOGDIR)
+        os.makedirs(self.HOSTB_LOGDIR)
+
+        # Network bridge
+        self.BRIDGE_PIDFILE =3D os.path.join(self.TMPDIR, "bridge.pid")
+        pid =3D self.read_pidfile(self.BRIDGE_PIDFILE)
+        if not (pid and self.check_pid(pid)):
+            self.run_command(("%s -M none -daemonize -pidfile '%s'"
+                " -netdev socket,id=3Dhosta,listen=3D127.0.0.1:%s"
+                " -netdev hubport,id=3Dporta,hubid=3D0,netdev=3Dhosta"
+                " -netdev socket,id=3Dhostb,listen=3D127.0.0.1:%s"
+                " -netdev hubport,id=3Dportb,hubid=3D0,netdev=3Dhostb"
+                " -netdev user,net=3D192.168.1.1/24,host=3D192.168.1.2,"
+                "hostfwd=3Dtcp:127.0.0.1:%s-192.168.1.1:22,id=3Dhost"
+                " -netdev hubport,id=3Dhostport,hubid=3D0,netdev=3Dhost")
+                % (self.QEMU_BINARY, self.BRIDGE_PIDFILE,
+                   self.BRIDGE_HOSTA_PORT, self.BRIDGE_HOSTB_PORT,
+                   self.SSH_PORT), 0)
+
+    def tearDown(self):
+        try:
+            pid =3D self.read_pidfile(self.BRIDGE_PIDFILE)
+            if pid and self.check_pid(pid):
+                os.kill(pid, signal.SIGKILL)
+        except Exception():
+            pass
+        try:
+            self.ra_stop(self.HOSTA)
+        except Exception():
+            pass
+        try:
+            self.ra_stop(self.HOSTB)
+        except Exception():
+            pass
+        try:
+            if self.ssh_proc:
+                self.ssh_proc.terminate()
+        except Exception():
+            pass
+
+        shutil.rmtree(self.TMPDIR)
+
+    def run_command(self, cmdline, expected_status, env=3DNone, error_fai=
l=3DTrue):
+        proc =3D subprocess.Popen(cmdline, shell=3DTrue, stdout=3Dsubproc=
ess.PIPE, \
+                                stderr=3Dsubprocess.STDOUT, \
+                                universal_newlines=3DTrue, env=3Denv)
+        stdout, stderr =3D proc.communicate()
+        if proc.returncode !=3D expected_status:
+            message =3D "command \"%s\" failed with code %s:\n%s" \
+                           % (cmdline, proc.returncode, stdout)
+            if error_fail:
+                self.log.error(message)
+                self.fail("command \"%s\" failed" % cmdline)
+            else:
+                self.log.info(message)
+
+        return proc.returncode
+
+    def cat_line(self, path):
+        line=3D""
+        try:
+            fd =3D open(path, "r")
+            line =3D str.strip(fd.readline())
+            fd.close()
+        except:
+            pass
+        return line
+
+    def read_pidfile(self, pidfile):
+        try:
+            pid =3D int(self.cat_line(pidfile))
+        except ValueError:
+            return None
+        else:
+            return pid
+
+    def check_pid(self, pid):
+        try:
+            os.kill(pid, 0)
+        except OSError:
+            return False
+        else:
+            return True
+
+    def ssh_ping(self, proc):
+        proc.stdin.write("ping\n")
+        if not select.select([proc.stdout], [], [], 30)[0]:
+            raise self.fail("ssh ping timeout reached")
+        if proc.stdout.readline() !=3D "ping\n":
+            raise self.fail("unexpected ssh ping answer")
+
+    def ssh_open(self):
+        commandline =3D ("ssh -o \"UserKnownHostsFile /dev/null\""
+                       " -o \"StrictHostKeyChecking no\""
+                       " -p%s root@127.0.0.1") % self.SSH_PORT
+
+        self.log.info("Connecting via ssh")
+        for i in range(10):
+            if self.run_command(commandline + " exit", 0, error_fail=3DFa=
lse) \
+                =3D=3D 0:
+                proc =3D subprocess.Popen(commandline + " cat", shell=3DT=
rue, \
+                                            stdin=3Dsubprocess.PIPE, \
+                                            stdout=3Dsubprocess.PIPE, \
+                                            stderr=3D0, \
+                                            universal_newlines=3DTrue,
+                                            bufsize=3D1)
+                self.ssh_ping(proc)
+                return proc
+            else:
+                time.sleep(5)
+        self.fail("ssh connect timeout reached")
+
+    def ssh_close(self, proc):
+        proc.terminate()
+
+    def setup_base_env(self, host):
+        PATH =3D os.getenv("PATH", "")
+        env =3D { "PATH": "%s:%s" % (self.FAKEPATH, PATH),
+                "HA_LOGFILE": self.RA_LOG,
+                "OCF_RESOURCE_INSTANCE": "colo-test",
+                "OCF_RESKEY_CRM_meta_clone_max": "2",
+                "OCF_RESKEY_CRM_meta_notify": "true",
+                "OCF_RESKEY_CRM_meta_timeout": "30000",
+                "OCF_RESKEY_binary": self.QEMU_BINARY,
+                "OCF_RESKEY_disk_size": str(self.IMAGE_SIZE),
+                "OCF_RESKEY_checkpoint_interval": "1000",
+                "OCF_RESKEY_base_port": str(self.COLO_BASE_PORT),
+                "OCF_RESKEY_debug": "true"}
+
+        if host =3D=3D self.HOSTA:
+            env.update({"OCF_RESKEY_options":
+                            ("%s -netdev socket,id=3Dhn0,connect=3D127.0.=
0.1:%s"
+                             " -drive if=3Dnone,id=3Dparent0,format=3Draw=
,file=3D'%s'")
+                            % (self.QEMU_OPTIONS, self.BRIDGE_HOSTA_PORT,
+                                self.HOSTA_IMAGE),
+                        "OCF_RESKEY_active_hidden_dir": self.TMPA,
+                        "OCF_RESKEY_listen_address": "127.0.0.1",
+                        "OCF_RESKEY_log_dir": self.HOSTA_LOGDIR,
+                        "OCF_RESKEY_CRM_meta_on_node": "127.0.0.1",
+                        "HA_RSCTMP": self.TMPA,
+                        "COLO_SMOKE_REMOTE_TMP": self.TMPB})
+        else:
+            env.update({"OCF_RESKEY_options":
+                            ("%s -netdev socket,id=3Dhn0,connect=3D127.0.=
0.1:%s"
+                             " -drive if=3Dnone,id=3Dparent0,format=3Draw=
,file=3D'%s'")
+                            % (self.QEMU_OPTIONS, self.BRIDGE_HOSTB_PORT,
+                                self.HOSTB_IMAGE),
+                        "OCF_RESKEY_active_hidden_dir": self.TMPB,
+                        "OCF_RESKEY_listen_address": "127.0.0.2",
+                        "OCF_RESKEY_log_dir": self.HOSTB_LOGDIR,
+                        "OCF_RESKEY_CRM_meta_on_node": "127.0.0.2",
+                        "HA_RSCTMP": self.TMPB,
+                        "COLO_SMOKE_REMOTE_TMP": self.TMPA})
+        return env
+
+    def ra_start(self, host):
+        env =3D self.setup_base_env(host)
+        self.run_command(self.COLO_RA + " start", self.OCF_SUCCESS, env)
+
+    def ra_stop(self, host):
+        env =3D self.setup_base_env(host)
+        self.run_command(self.COLO_RA + " stop", self.OCF_SUCCESS, env)
+
+    def ra_monitor(self, host, expected_status):
+        env =3D self.setup_base_env(host)
+        self.run_command(self.COLO_RA + " monitor", expected_status, env)
+
+    def ra_promote(self, host):
+        env =3D self.setup_base_env(host)
+        self.run_command(self.COLO_RA + " promote", self.OCF_SUCCESS, env=
)
+
+    def ra_notify_start(self, host):
+        env =3D self.setup_base_env(host)
+
+        env.update({"OCF_RESKEY_CRM_meta_notify_type": "post",
+                    "OCF_RESKEY_CRM_meta_notify_operation": "start"})
+
+        if host =3D=3D self.HOSTA:
+            env.update({"OCF_RESKEY_CRM_meta_notify_master_uname": "127.0=
.0.1",
+                        "OCF_RESKEY_CRM_meta_notify_start_uname": "127.0.=
0.2"})
+        else:
+            env.update({"OCF_RESKEY_CRM_meta_notify_master_uname": "127.0=
.0.2",
+                        "OCF_RESKEY_CRM_meta_notify_start_uname": "127.0.=
0.1"})
+
+        self.run_command(self.COLO_RA + " notify", self.OCF_SUCCESS, env)
+
+    def ra_notify_stop(self, host):
+        env =3D self.setup_base_env(host)
+
+        env.update({"OCF_RESKEY_CRM_meta_notify_type": "pre",
+                    "OCF_RESKEY_CRM_meta_notify_operation": "stop"})
+
+        if host =3D=3D self.HOSTA:
+            env.update({"OCF_RESKEY_CRM_meta_notify_master_uname": "127.0=
.0.1",
+                        "OCF_RESKEY_CRM_meta_notify_stop_uname": "127.0.0=
.2"})
+        else:
+            env.update({"OCF_RESKEY_CRM_meta_notify_master_uname": "127.0=
.0.2",
+                        "OCF_RESKEY_CRM_meta_notify_stop_uname": "127.0.0=
.1"})
+
+        self.run_command(self.COLO_RA + " notify", self.OCF_SUCCESS, env)
+
+    def kill_qemu_pre(self, host, hang_qemu=3DFalse):
+        if host =3D=3D self.HOSTA:
+            pid =3D self.read_pidfile(os.path.join(self.TMPA, \
+                                                        "colo-test-qemu.p=
id"))
+        else:
+            pid =3D self.read_pidfile(os.path.join(self.TMPB, \
+                                                        "colo-test-qemu.p=
id"))
+
+        if pid and self.check_pid(pid):
+            if hang_qemu:
+                os.kill(pid, signal.SIGSTOP)
+            else:
+                os.kill(pid, signal.SIGKILL)
+                while self.check_pid(pid):
+                    time.sleep(1)
+
+    def kill_qemu_post(self, host, hang_qemu=3DFalse):
+        if host =3D=3D self.HOSTA:
+            pid =3D self.read_pidfile(os.path.join(self.TMPA, \
+                                                        "colo-test-qemu.p=
id"))
+        else:
+            pid =3D self.read_pidfile(os.path.join(self.TMPB, \
+                                                        "colo-test-qemu.p=
id"))
+
+        if hang_qemu and pid and self.check_pid(pid):
+            os.kill(pid, signal.SIGKILL)
+            while self.check_pid(pid):
+                time.sleep(1)
+
+    def get_master_score(self, host):
+        if host =3D=3D self.HOSTA:
+            return int(self.cat_line(os.path.join(self.TMPA, "master_scor=
e")))
+        else:
+            return int(self.cat_line(os.path.join(self.TMPB, "master_scor=
e")))
+
+    def _test_colo(self, hang_qemu=3DFalse, loop=3DFalse, do_ssh_ping=3DT=
rue):
+        self.ra_stop(self.HOSTA)
+        self.ra_stop(self.HOSTB)
+
+        self.log.info("Startup")
+        self.ra_start(self.HOSTA)
+        self.ra_start(self.HOSTB)
+
+        self.ra_monitor(self.HOSTA, self.OCF_SUCCESS)
+        self.ra_monitor(self.HOSTB, self.OCF_SUCCESS)
+
+        self.log.info("Promoting")
+        self.ra_promote(self.HOSTA)
+        self.ra_notify_start(self.HOSTA)
+
+        while self.get_master_score(self.HOSTB) !=3D 100:
+            self.ra_monitor(self.HOSTA, self.OCF_RUNNING_MASTER)
+            self.ra_monitor(self.HOSTB, self.OCF_SUCCESS)
+            time.sleep(1)
+
+        if do_ssh_ping:
+            self.ssh_proc =3D self.ssh_open()
+
+        primary =3D self.HOSTA
+        secondary =3D self.HOSTB
+
+        while True:
+            self.log.info("Secondary failover")
+            self.kill_qemu_pre(primary, hang_qemu)
+            self.ra_notify_stop(secondary)
+            self.ra_monitor(secondary, self.OCF_SUCCESS)
+            self.ra_promote(secondary)
+            self.ra_monitor(secondary, self.OCF_RUNNING_MASTER)
+            self.kill_qemu_post(primary, hang_qemu)
+            if do_ssh_ping:
+                self.ssh_ping(self.ssh_proc)
+            tmp =3D primary
+            primary =3D secondary
+            secondary =3D tmp
+
+            self.log.info("Secondary continue replication")
+            self.ra_start(secondary)
+            self.ra_notify_start(primary)
+            if do_ssh_ping:
+                self.ssh_ping(self.ssh_proc)
+
+            # Wait for resync
+            while self.get_master_score(secondary) !=3D 100:
+                self.ra_monitor(primary, self.OCF_RUNNING_MASTER)
+                self.ra_monitor(secondary, self.OCF_SUCCESS)
+                time.sleep(1)
+            if do_ssh_ping:
+                self.ssh_ping(self.ssh_proc)
+
+            self.log.info("Primary failover")
+            self.kill_qemu_pre(secondary, hang_qemu)
+            self.ra_monitor(primary, self.OCF_RUNNING_MASTER)
+            self.ra_notify_stop(primary)
+            self.ra_monitor(primary, self.OCF_RUNNING_MASTER)
+            self.kill_qemu_post(secondary, hang_qemu)
+            if do_ssh_ping:
+                self.ssh_ping(self.ssh_proc)
+
+            self.log.info("Primary continue replication")
+            self.ra_start(secondary)
+            self.ra_notify_start(primary)
+            if do_ssh_ping:
+                self.ssh_ping(self.ssh_proc)
+
+            # Wait for resync
+            while self.get_master_score(secondary) !=3D 100:
+                self.ra_monitor(primary, self.OCF_RUNNING_MASTER)
+                self.ra_monitor(secondary, self.OCF_SUCCESS)
+                time.sleep(1)
+            if do_ssh_ping:
+                self.ssh_ping(self.ssh_proc)
+
+            if not loop:
+                break
+
+        if do_ssh_ping:
+            self.ssh_close(self.ssh_proc)
+
+        self.ra_stop(self.HOSTA)
+        self.ra_stop(self.HOSTB)
+
+        self.ra_monitor(self.HOSTA, self.OCF_NOT_RUNNING)
+        self.ra_monitor(self.HOSTB, self.OCF_NOT_RUNNING)
+        self.log.info("all ok")
+
+    def test_colo_peer_crashing(self):
+        """
+        :avocado: tags=3Dcolo
+        :avocado: tags=3Darch:x86_64
+        """
+        self.log.info("Testing with peer qemu crashing")
+        self._test_colo()
+
+    def test_colo_peer_hanging(self):
+        """
+        :avocado: tags=3Dcolo
+        :avocado: tags=3Darch:x86_64
+        """
+        self.log.info("Testing with peer qemu hanging")
+        self._test_colo(hang_qemu=3DTrue)
=2D-
2.20.1


