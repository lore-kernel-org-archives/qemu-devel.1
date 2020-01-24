Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877EEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5313D20709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OlvSD5HJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5313D20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2I4-0008PV-II
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iv2Fz-0003nw-2c
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iv2Fx-00032m-CZ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:31 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:44839)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iv2Fx-00031X-42
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:29 -0500
Received: by mail-pl1-x630.google.com with SMTP id d9so1016367plo.11
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aVBYNqhMnJi7bxbz3Ybs5e2VT5E8fdOaR1g785IV9mw=;
 b=OlvSD5HJT5ihWD0gUoygNSLFW9B2C380HIwJ9lFLajAyTWmSQLAc8j4A2HQKqINIPm
 bn8H8dVJDlE+rSRdT3AxQomRFrsIrFrC2amqd8M8OlWB87R03IKf7mBhswCfuKiRP0bh
 sJ8VPJAsLwJeCisrnPjFqcvlGcN18cc9ykoKMWU/kyEJEpuc0Ub0fbEowJSbxASR8oym
 A2orLqf+xFdlr3On1l9ZpWGiRv018NdU4x8qeNk9pVw/UTBqpzv4HOGqfJ++2X14NKRU
 7p55HGm7TN80UP4qkDX+le/m9GbhSMOv0vM+nGq6RME5cXe/becASLtTcoQHMdvFFsM/
 E9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aVBYNqhMnJi7bxbz3Ybs5e2VT5E8fdOaR1g785IV9mw=;
 b=ZZFcC1Zgt/cEQFwsryMc0ytZKGIwxrJ0cXcCUCD92SUAahDjipNLLKOyvja47qOnDE
 I6BSU9I8dL5JxC+xTjFMwRDLJluUHnqbKDom7Yq87+DiC6lS2zRkLdU0e6VCArIYdKd4
 2sb7skB2VSRmV43hN0nTpq2PAXOKg+yP6bt9UG9lsiRvZJyD7UsPm6KQBi/cNdPftGUS
 qifi3bt/lnpzullgeyBEN9tuwjy45FWf+Jg6sM3u54DCqvyuZhAzaclAXmVN4o377T1v
 Iv6B+yILbTTgLnm6DdQqJyAkfqlqz2PLUveAP81lizkLmRXKppP9qZChSUJg5kMtuaKH
 J8og==
X-Gm-Message-State: APjAAAWzCQmVzo0b7IfGB5JeSlRZLfK0Cb/w7d5Hy1OnFMQHDAACMGVv
 ghZbwt8mTIJQIlF97xK/pXaIhBT3Swc=
X-Google-Smtp-Source: APXvYqyb+OOKVoTi8EcT5vYwgXRS15l/TWNbWHtbXiq0xkOv1Uv8D/greU4RNmjX7J941iCv+MfXDQ==
X-Received: by 2002:a17:90a:b10b:: with SMTP id
 z11mr182316pjq.132.1579884987768; 
 Fri, 24 Jan 2020 08:56:27 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id l10sm6969953pjy.5.2020.01.24.08.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 08:56:26 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/8] tests/vm: Add configuration to basevm.py
Date: Fri, 24 Jan 2020 11:53:31 -0500
Message-Id: <20200124165335.422-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124165335.422-1-robert.foley@linaro.org>
References: <20200124165335.422-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::630
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added use of a configuration to tests/vm/basevm.py.
The configuration provides parameters used to configure a VM.
This allows for providing alternate configurations to the VM being
created/launched. cpu, machine, memory, and NUMA configuration are all
examples of configuration which we might want to vary on the VM being created
or launched.
This will for example allow for creating an aarch64 vm.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/basevm.py | 108 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 82 insertions(+), 26 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 3b4403ddcb..ec92c8f105 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -32,15 +32,40 @@ import shutil
 import multiprocessing
 import traceback
 
-SSH_KEY = open(os.path.join(os.path.dirname(__file__),
-               "..", "keys", "id_rsa")).read()
-SSH_PUB_KEY = open(os.path.join(os.path.dirname(__file__),
-                   "..", "keys", "id_rsa.pub")).read()
-
+SSH_KEY_FILE = os.path.join(os.path.dirname(__file__),
+               "..", "keys", "id_rsa")
+SSH_PUB_KEY_FILE = os.path.join(os.path.dirname(__file__),
+                   "..", "keys", "id_rsa.pub")
+SSH_KEY = open(SSH_KEY_FILE).read()
+SSH_PUB_KEY = open(SSH_PUB_KEY_FILE).read()
+
+# This is the standard configuration.
+# Any or all of these can be overridden by
+# passing in a config argument to the VM constructor.
+DEFAULT_CONFIG = {
+    'cpu'             : "max",
+    'machine'         : 'pc',
+    'guest_user'      : "qemu",
+    'guest_pass'      : "qemupass",
+    'root_pass'       : "qemupass",
+    'ssh_key_file'    : SSH_KEY_FILE,
+    'ssh_pub_key_file': SSH_PUB_KEY_FILE,
+    'memory'          : "4G",
+    'extra_args'      : [],
+    'dns'             : "",
+    'ssh_port'        : 0,
+    'install_cmds'    : "",
+    'boot_dev_type'   : "block",
+    'ssh_timeout'     : 1,
+}
+BOOT_DEVICE = {
+    'block' :  "-drive file={},if=none,id=drive0,cache=writeback "\
+               "-device virtio-blk,drive=drive0,bootindex=0",
+    'scsi'  :  "-device virtio-scsi-device,id=scsi "\
+               "-drive file={},format=raw,if=none,id=hd0 "\
+               "-device scsi-hd,drive=hd0,bootindex=0",
+}
 class BaseVM(object):
-    GUEST_USER = "qemu"
-    GUEST_PASS = "qemupass"
-    ROOT_PASS = "qemupass"
 
     envvars = [
         "https_proxy",
@@ -59,19 +84,26 @@ class BaseVM(object):
     poweroff = "poweroff"
     # enable IPv6 networking
     ipv6 = True
-    def __init__(self, debug=False, vcpus=None):
+    def __init__(self, debug=False, vcpus=None, config=None):
         self._guest = None
+        # Allow input config to override defaults.
+        self._config = DEFAULT_CONFIG.copy()
+        if config != None:
+            self._config.update(config)
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
                                                          suffix=".tmp",
                                                          dir="."))
         atexit.register(shutil.rmtree, self._tmpdir)
-
+        self._config['ssh_key'] = \
+            open(self._config['ssh_key_file']).read().rstrip()
+        self._config['ssh_pub_key'] = \
+            open(self._config['ssh_pub_key_file']).read().rstrip()
         self._ssh_key_file = os.path.join(self._tmpdir, "id_rsa")
-        open(self._ssh_key_file, "w").write(SSH_KEY)
+        open(self._ssh_key_file, "w").write(self._config['ssh_key'])
         subprocess.check_call(["chmod", "600", self._ssh_key_file])
 
         self._ssh_pub_key_file = os.path.join(self._tmpdir, "id_rsa.pub")
-        open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
+        open(self._ssh_pub_key_file, "w").write(self._config['ssh_pub_key'])
 
         self.debug = debug
         self._stderr = sys.stderr
@@ -80,11 +112,14 @@ class BaseVM(object):
             self._stdout = sys.stdout
         else:
             self._stdout = self._devnull
+        netdev = "user,id=vnet,hostfwd=:127.0.0.1:{}-:22"
         self._args = [ \
-            "-nodefaults", "-m", "4G",
-            "-cpu", "max",
-            "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22" +
-                       (",ipv6=no" if not self.ipv6 else ""),
+            "-nodefaults", "-m", self._config['memory'],
+            "-cpu", self._config['cpu'],
+            "-netdev",
+            netdev.format(self._config['ssh_port']) +
+            (",ipv6=no" if not self.ipv6 else "") +
+            (",dns=" + self._config['dns'] if self._config['dns'] else ""),
             "-device", "virtio-net-pci,netdev=vnet",
             "-vnc", "127.0.0.1:0,to=20"]
         if vcpus and vcpus > 1:
@@ -95,6 +130,25 @@ class BaseVM(object):
             logging.info("KVM not available, not using -enable-kvm")
         self._data_args = []
 
+    def wait_boot(self, wait_string=None):
+        """Wait for the standard string we expect
+           on completion of a normal boot.
+           The user can also choose to override with an
+           alternate string to wait for."""
+        if wait_string is None:
+            if self.login_prompt is None:
+                raise Exception("self.login_prompt not defined")
+            wait_string = self.login_prompt
+        self.console_init()
+        self.console_wait(wait_string)
+
+    def __getattr__(self, name):
+        # Support direct access to config by key.
+        # for example, access self._config['cpu'] by self.cpu
+        if name.lower() in self._config.keys():
+            return self._config[name.lower()]
+        return object.__getattribute__(self, name)
+
     def _download_with_cache(self, url, sha256sum=None, sha512sum=None):
         def check_sha256sum(fname):
             if not sha256sum:
@@ -126,7 +180,8 @@ class BaseVM(object):
                    "-t",
                    "-o", "StrictHostKeyChecking=no",
                    "-o", "UserKnownHostsFile=" + os.devnull,
-                   "-o", "ConnectTimeout=1",
+                   "-o",
+                   "ConnectTimeout={}".format(self._config["ssh_timeout"]),
                    "-p", self.ssh_port, "-i", self._ssh_key_file]
         # If not in debug mode, set ssh to quiet mode to
         # avoid printing the results of commands.
@@ -176,15 +231,15 @@ class BaseVM(object):
                             "virtio-blk,drive=%s,serial=%s,bootindex=1" % (name, name)]
 
     def boot(self, img, extra_args=[]):
-        args = self._args + [
-            "-device", "VGA",
-            "-drive", "file=%s,if=none,id=drive0,cache=writeback" % img,
-            "-device", "virtio-blk,drive=drive0,bootindex=0"]
-        args += self._data_args + extra_args
+        boot_dev = BOOT_DEVICE[self._config['boot_dev_type']]
+        boot_params = boot_dev.format(img)
+        args = self._args + boot_params.split(' ')
+        args += self._data_args + extra_args + self._config['extra_args']
+        args += ["-device", "VGA"]
         logging.debug("QEMU args: %s", " ".join(args))
         qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
         guest = QEMUMachine(binary=qemu_bin, args=args)
-        guest.set_machine('pc')
+        guest.set_machine(self._config['machine'])
         guest.set_console()
         try:
             guest.launch()
@@ -331,7 +386,6 @@ class BaseVM(object):
 
     def shutdown(self):
         self._guest.shutdown()
-
     def wait(self):
         self._guest.wait()
 
@@ -379,15 +433,17 @@ def parse_args(vmcls):
     parser.disable_interspersed_args()
     return parser.parse_args()
 
-def main(vmcls):
+def main(vmcls, config=None):
     try:
+        if config == None:
+            config = {}
         args, argv = parse_args(vmcls)
         if not argv and not args.build_qemu and not args.build_image:
             print("Nothing to do?")
             return 1
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
-        vm = vmcls(debug=args.debug, vcpus=args.jobs)
+        vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
-- 
2.17.1


