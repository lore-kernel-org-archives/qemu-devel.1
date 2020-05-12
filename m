Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D885FCA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9539A20731
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNobTaSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9539A20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYagE-0001s7-Kz
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 15:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYaej-0000K8-L0
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:33:34 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d]:41612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYaeh-0001q7-Pm
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:33:33 -0400
Received: by mail-qk1-x72d.google.com with SMTP id n14so14913763qke.8
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 12:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IHVxQvHLGmuAsOe7Our5n+V2vriioUviLGm8LCdzEg4=;
 b=VNobTaSht+DGyk/GTwbQcYUVC/3h5zk4hkLIhzb/lhD65yDyrAKQEKPXImz3Kp4B3u
 CuLulFQLxYm6FPaKukYJESwODCK+Jwaz8QwDvk8VhpJ6ipun7vuz+miAqegMNNLIrwak
 uIU1j8gou1XkaJjnV3GUSDlmOJMpeSvUYwDdNzRTeQeZiuivEE7dUQHgOh01WC5i902R
 KIYGMhoZPsMw06gDKwltZfKRW/bdbVpcIiVHluNINTAebvNqTk+NTZ1gruOa55v8VQIr
 kZbHyWNHDJGCN6ENnRK66VCDhLDS3DBGC6h4JPcsTTa96lhYI2ha/GwdlpyC2x6npIE8
 frMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IHVxQvHLGmuAsOe7Our5n+V2vriioUviLGm8LCdzEg4=;
 b=QXkic65z4RgQSwYfiKZc7ei202LkjBp5LrgJIZeo28HgxNdmmLsf971Y1qATcenHxg
 kynqGNJ4HUQzl0zhJa/nHVq9erDJH3pcQVn8jm5V736db0BKuIBgF95ncuyMuKlzUNGN
 N59Ivm6mmz7fI7i20VzmTWN6FL1qeZHV42ul0yhJcviNH/eQd0oBVqBe3++sFMwzx/s/
 Xhi4WqEk9Ncj/zauPx4PGyfaHTeVGP+5ww9g9sfC2BafxWgLwHQP2evPIu07w9FySQba
 Q+co6QdEIJ/xjOmSgbMdGeYxyA44LT65WOV3j+8ExmjDWDlhdmA5udA8vj6tnZU32X3c
 y8aA==
X-Gm-Message-State: AGi0PuY9a3/+J1oIpCv1Sz5r0WL9ULIQ4WcoG4lXQgten3pgxsoe188k
 kO/lRD7/2fmdu5MwEbi3MP66zdA2X/Vy7w==
X-Google-Smtp-Source: APiQypIjxhT8M4F13SFKY/4mGL8MggqFy9blAYcZM+h+fH1GShI48rfl9zQaoKcb446LBwsoVqN0YA==
X-Received: by 2002:a37:8902:: with SMTP id l2mr21610049qkd.127.1589312009833; 
 Tue, 12 May 2020 12:33:29 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:d31:9f53:b3eb:9b53])
 by smtp.gmail.com with ESMTPSA id j45sm2100998qtk.14.2020.05.12.12.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 12:33:29 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 1/9] tests/vm: Add configuration to basevm.py
Date: Tue, 12 May 2020 15:33:32 -0400
Message-Id: <20200512193340.265-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512193340.265-1-robert.foley@linaro.org>
References: <20200512193340.265-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x72d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
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
 tests/vm/basevm.py | 170 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 131 insertions(+), 39 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 756ccf7aca..fb93a111c1 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -29,16 +29,41 @@ import tempfile
 import shutil
 import multiprocessing
 import traceback
-
-SSH_KEY = open(os.path.join(os.path.dirname(__file__),
-               "..", "keys", "id_rsa")).read()
-SSH_PUB_KEY = open(os.path.join(os.path.dirname(__file__),
-                   "..", "keys", "id_rsa.pub")).read()
-
+import shlex
+
+SSH_KEY_FILE = os.path.join(os.path.dirname(__file__),
+               "..", "keys", "id_rsa")
+SSH_PUB_KEY_FILE = os.path.join(os.path.dirname(__file__),
+                   "..", "keys", "id_rsa.pub")
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
+    'qemu_args'       : "",
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
@@ -61,19 +86,30 @@ class BaseVM(object):
     # 4 is arbitrary, but greater than 2,
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
-    def __init__(self, debug=False, vcpus=None):
+    def __init__(self, debug=False, vcpus=None, config=None):
         self._guest = None
+        # Allow input config to override defaults.
+        self._config = DEFAULT_CONFIG.copy()
+        if config != None:
+            self._config.update(config)
+        self.validate_ssh_keys()
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
                                                          suffix=".tmp",
                                                          dir="."))
         atexit.register(shutil.rmtree, self._tmpdir)
-
-        self._ssh_key_file = os.path.join(self._tmpdir, "id_rsa")
-        open(self._ssh_key_file, "w").write(SSH_KEY)
-        subprocess.check_call(["chmod", "600", self._ssh_key_file])
-
-        self._ssh_pub_key_file = os.path.join(self._tmpdir, "id_rsa.pub")
-        open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
+        # Copy the key files to a temporary directory.
+        # Also chmod the key file to agree with ssh requirements.
+        self._config['ssh_key'] = \
+            open(self._config['ssh_key_file']).read().rstrip()
+        self._config['ssh_pub_key'] = \
+            open(self._config['ssh_pub_key_file']).read().rstrip()
+        self._ssh_tmp_key_file = os.path.join(self._tmpdir, "id_rsa")
+        open(self._ssh_tmp_key_file, "w").write(self._config['ssh_key'])
+        subprocess.check_call(["chmod", "600", self._ssh_tmp_key_file])
+
+        self._ssh_tmp_pub_key_file = os.path.join(self._tmpdir, "id_rsa.pub")
+        open(self._ssh_tmp_pub_key_file,
+             "w").write(self._config['ssh_pub_key'])
 
         self.debug = debug
         self._stderr = sys.stderr
@@ -82,11 +118,14 @@ class BaseVM(object):
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
@@ -97,6 +136,55 @@ class BaseVM(object):
             logging.info("KVM not available, not using -enable-kvm")
         self._data_args = []
 
+        if self._config['qemu_args'] != None:
+            qemu_args = self._config['qemu_args']
+            qemu_args = qemu_args.replace('\n',' ').replace('\r','')
+            # shlex groups quoted arguments together
+            # we need this to keep the quoted args together for when
+            # the QEMU command is issued later.
+            args = shlex.split(qemu_args)
+            self._config['extra_args'] = []
+            for arg in args:
+                if arg:
+                    # Preserve quotes around arguments.
+                    # shlex above takes them out, so add them in.
+                    if " " in arg:
+                        arg = '"{}"'.format(arg)
+                    self._config['extra_args'].append(arg)
+
+    def validate_ssh_keys(self):
+        """Check to see if the ssh key files exist."""
+        if 'ssh_key_file' not in self._config or\
+           not os.path.exists(self._config['ssh_key_file']):
+            raise Exception("ssh key file not found.")
+        if 'ssh_pub_key_file' not in self._config or\
+           not os.path.exists(self._config['ssh_pub_key_file']):
+               raise Exception("ssh pub key file not found.")
+
+    def wait_boot(self, wait_string=None):
+        """Wait for the standard string we expect
+           on completion of a normal boot.
+           The user can also choose to override with an
+           alternate string to wait for."""
+        if wait_string is None:
+            if self.login_prompt is None:
+                raise Exception("self.login_prompt not defined")
+            wait_string = self.login_prompt
+        # Intentionally bump up the default timeout under TCG,
+        # since the console wait below takes longer.
+        timeout = self.socket_timeout
+        if not kvm_available(self.arch):
+            timeout *= 8
+        self.console_init(timeout=timeout)
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
@@ -128,8 +216,9 @@ class BaseVM(object):
                    "-t",
                    "-o", "StrictHostKeyChecking=no",
                    "-o", "UserKnownHostsFile=" + os.devnull,
-                   "-o", "ConnectTimeout=1",
-                   "-p", self.ssh_port, "-i", self._ssh_key_file]
+                   "-o",
+                   "ConnectTimeout={}".format(self._config["ssh_timeout"]),
+                   "-p", self.ssh_port, "-i", self._ssh_tmp_key_file]
         # If not in debug mode, set ssh to quiet mode to
         # avoid printing the results of commands.
         if not self.debug:
@@ -178,14 +267,14 @@ class BaseVM(object):
                             "virtio-blk,drive=%s,serial=%s,bootindex=1" % (name, name)]
 
     def boot(self, img, extra_args=[]):
-        args = self._args + [
-            "-drive", "file=%s,if=none,id=drive0,cache=writeback" % img,
-            "-device", "virtio-blk,drive=drive0,bootindex=0"]
-        args += self._data_args + extra_args
+        boot_dev = BOOT_DEVICE[self._config['boot_dev_type']]
+        boot_params = boot_dev.format(img)
+        args = self._args + boot_params.split(' ')
+        args += self._data_args + extra_args + self._config['extra_args']
         logging.debug("QEMU args: %s", " ".join(args))
         qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
         guest = QEMUMachine(binary=qemu_bin, args=args)
-        guest.set_machine('pc')
+        guest.set_machine(self._config['machine'])
         guest.set_console()
         try:
             guest.launch()
@@ -299,7 +388,8 @@ class BaseVM(object):
         self.console_send(command)
 
     def console_ssh_init(self, prompt, user, pw):
-        sshkey_cmd = "echo '%s' > .ssh/authorized_keys\n" % SSH_PUB_KEY.rstrip()
+        sshkey_cmd = "echo '%s' > .ssh/authorized_keys\n" \
+                     % self._config['ssh_pub_key'].rstrip()
         self.console_wait_send("login:",    "%s\n" % user)
         self.console_wait_send("Password:", "%s\n" % pw)
         self.console_wait_send(prompt,      "mkdir .ssh\n")
@@ -358,23 +448,23 @@ class BaseVM(object):
                           "local-hostname: {}-guest\n".format(name)])
         mdata.close()
         udata = open(os.path.join(cidir, "user-data"), "w")
-        print("guest user:pw {}:{}".format(self.GUEST_USER,
-                                           self.GUEST_PASS))
+        print("guest user:pw {}:{}".format(self._config['guest_user'],
+                                           self._config['guest_pass']))
         udata.writelines(["#cloud-config\n",
                           "chpasswd:\n",
                           "  list: |\n",
-                          "    root:%s\n" % self.ROOT_PASS,
-                          "    %s:%s\n" % (self.GUEST_USER,
-                                           self.GUEST_PASS),
+                          "    root:%s\n" % self._config['root_pass'],
+                          "    %s:%s\n" % (self._config['guest_user'],
+                                           self._config['guest_pass']),
                           "  expire: False\n",
                           "users:\n",
-                          "  - name: %s\n" % self.GUEST_USER,
+                          "  - name: %s\n" % self._config['guest_user'],
                           "    sudo: ALL=(ALL) NOPASSWD:ALL\n",
                           "    ssh-authorized-keys:\n",
-                          "    - %s\n" % SSH_PUB_KEY,
+                          "    - %s\n" % self._config['ssh_pub_key'],
                           "  - name: root\n",
                           "    ssh-authorized-keys:\n",
-                          "    - %s\n" % SSH_PUB_KEY,
+                          "    - %s\n" % self._config['ssh_pub_key'],
                           "locale: en_US.UTF-8\n"])
         proxy = os.environ.get("http_proxy")
         if not proxy is None:
@@ -427,15 +517,17 @@ def parse_args(vmcls):
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


