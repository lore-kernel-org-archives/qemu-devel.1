Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F95C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E722071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbnRHdlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E722071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNfl-0007S4-P8
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUd-0006tm-Iy
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:15 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:36256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUa-0005eW-Sa
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:15 -0400
Received: by mail-wr1-x42d.google.com with SMTP id k6so4452863wrn.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Uqu+G7KWNLFFsBFSWuF2fzigErk1o01AVduM2CJF95Y=;
 b=sbnRHdloFlnP6e2dlUbwNezFOjToBjyM5/4MDayOl3y8lz9ZVNkGGXa1FRNZ86/pAZ
 pItxpPbBeNjMj34UX9yO6ARuuVqQjgC8YsRJTNfs5TYwUnESFwL74XTO0Kl+vhEeDN6V
 1oiHfrbGQ+4QMXkNojdH+pXxW7ZKATsCxg75mYm8RQ0vXGIPzJ23BZ1B7vagOwc2xCb+
 1jDKeyBoGye8RV3QtsAqB3OB0LBnnbJAw6J+kR4kWzUE6HGYfOWPl4JTdS5Ldv/iQKtg
 bZn80fzU3keVltrvRgVB+nQ32oR1/yojHqwxO+Apqks232JzOidx+Z7nubGJ6qOF01hy
 ZCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Uqu+G7KWNLFFsBFSWuF2fzigErk1o01AVduM2CJF95Y=;
 b=lOK7ElB4qr7PdP8WEkrubFTVVVaXbqR4QoGdj5jawIjKxrNNCvwhdWg4GE4TUYfGwJ
 he5dJc3+9MaR7p3STBJITvRNcHDlNr100UQQ7Fkwbm5OP9TLpcEqWN0rb3qEtzmcuB5R
 uVg9WRHhDYs4PEdmpDLDFrTmz5onG0lsjBYOJyTUyPxk0JtVw7aN02Y0fEwon3EcfJrN
 F3D7oiA8pqOB6547aSCGt1VBeJ6QcKT2OihL+zQb6kbFMppht4gSCPzWYX1GMoyk8v2n
 1WDO/hU22bcXHTgX4mkQkvwHJTtQfP7z9uDqullJYA6CzzAsV0t88YaaYlHriwP16zDq
 7noQ==
X-Gm-Message-State: AOAM531tj7CNDXUcu4PEukFvixTZhrGFOpwMuYj+U9BP7iaSX7AHzsTo
 t+zAH9Af5yxK3/BwSMqoCPxmDQ==
X-Google-Smtp-Source: ABdhPJz1KFFr/ADeayV+eZEUzBdByTyLZRqB5fJrYaToeJ5RrQB6R4D6SFBTAXOWFvwwS55CpETnEA==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr19924700wrq.189.1592836331156; 
 Mon, 22 Jun 2020 07:32:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y17sm18970877wrd.58.2020.06.22.07.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 07:32:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0566A1FF8F;
 Mon, 22 Jun 2020 15:32:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 03/18] tests/vm: Add configuration to basevm.py
Date: Mon, 22 Jun 2020 15:31:49 +0100
Message-Id: <20200622143204.12921-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622143204.12921-1-alex.bennee@linaro.org>
References: <20200622143204.12921-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 Peter Puhov <peter.puhov@linaro.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Added use of a configuration to tests/vm/basevm.py.
The configuration provides parameters used to configure a VM.
This allows for providing alternate configurations to the VM being
created/launched. cpu, machine, memory, and NUMA configuration are all
examples of configuration which we might want to vary on the VM being created
or launched.
This will for example allow for creating an aarch64 vm.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200601211421.1277-3-robert.foley@linaro.org>
---
 tests/vm/basevm.py | 172 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 133 insertions(+), 39 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 5a58e6c3930..cfe20c58f7e 100644
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
@@ -57,25 +82,38 @@ class BaseVM(object):
     poweroff = "poweroff"
     # enable IPv6 networking
     ipv6 = True
+    # This is the timeout on the wait for console bytes.
+    socket_timeout = 120
     # Scale up some timeouts under TCG.
     # 4 is arbitrary, but greater than 2,
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
-    def __init__(self, args):
+    def __init__(self, args, config=None):
         self._guest = None
         self._genisoimage = args.genisoimage
         self._build_path = args.build_path
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
 
         self.debug = args.debug
         self._stderr = sys.stderr
@@ -84,11 +122,14 @@ class BaseVM(object):
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
         if args.jobs and args.jobs > 1:
@@ -99,6 +140,55 @@ class BaseVM(object):
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
@@ -130,8 +220,9 @@ class BaseVM(object):
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
@@ -180,14 +271,14 @@ class BaseVM(object):
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
         qemu_path = get_qemu_path(self.arch, self._build_path)
         guest = QEMUMachine(binary=qemu_path, args=args)
-        guest.set_machine('pc')
+        guest.set_machine(self._config['machine'])
         guest.set_console()
         try:
             guest.launch()
@@ -301,7 +392,8 @@ class BaseVM(object):
         self.console_send(command)
 
     def console_ssh_init(self, prompt, user, pw):
-        sshkey_cmd = "echo '%s' > .ssh/authorized_keys\n" % SSH_PUB_KEY.rstrip()
+        sshkey_cmd = "echo '%s' > .ssh/authorized_keys\n" \
+                     % self._config['ssh_pub_key'].rstrip()
         self.console_wait_send("login:",    "%s\n" % user)
         self.console_wait_send("Password:", "%s\n" % pw)
         self.console_wait_send(prompt,      "mkdir .ssh\n")
@@ -360,23 +452,23 @@ class BaseVM(object):
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
@@ -447,15 +539,17 @@ def parse_args(vmcls):
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
-        vm = vmcls(args)
+        vm = vmcls(args, config=config)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
-- 
2.20.1


