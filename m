Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9E7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79969206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b10kpPAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79969206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshnd-0004hm-Mq
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshj5-0004X5-NR
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:53710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshj3-00044m-7o
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id j18so42111855wmi.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ffjD3xFJ7V8ELReeSR1/1F6adXpcPs6lDfrQfmzZ+PU=;
 b=b10kpPAGWV6CJ7Jy6+vaT1nk2+iuYe9ZwOcFf71qZeJXM8HO9L+fEus1JXdqo400s0
 OQd3epHFS8HL/QqwcOzE+EldiRZJ2hxVelxZDHuauI0wSQ1yS8X+9wztu3Tl40RMEj+S
 hlPZYPHolnvQPrS2oLiRdDvgcBWk+YcN2vvi+76nrNWnUpKxR1oSspjlzOEG+U8HUMyx
 mCKhSQKh+aE61kVwPC12HmpwvFYT/k3z3bx5t2HPhe02RynSe2raWUwxZ5AtPGwihYr1
 1Gc5ufP8IjYbCo6aZBB7T/Irzfjr1+tf6zqT/RT/snGckpePQafOSe8YXcFBFi6y0hnk
 Enxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ffjD3xFJ7V8ELReeSR1/1F6adXpcPs6lDfrQfmzZ+PU=;
 b=CG2QvHbYibwo8qnozmSCaS60E1diMea5kcf7kCE6wdOH9gSvVGQUHxrRCxqAh6mDto
 6RKI45/hlpdbakQCGSlTlXFT3U9xGQCtoKyfBJhpEdzltX0RYc5vHRGz7rk0+YZGntpR
 fRomgwwBccKtdyFFgvj/hLkguKg+NYh+eSNnQNTzl5Rq/npsOLenCOVLUpNlLIwf7gSz
 HW4tBeWz7iJU6cKdowIcjtaSGeDAjCdDgk17eRecIik29BepF6us1+1o2XMNB7zoQwKR
 2aMPDfpSNki9RUjRKSA9WogGEpAjA03wV3dT60mAuGy4M6J7qk/lhQHNJ6YXT4/4eOLb
 ImtQ==
X-Gm-Message-State: AOAM533bIKQ8ItJOxGzcHxcZOtzEU7dtLrX0Qb1fz8ZcKXwMja4IR7zH
 5cmk0KUVnrN1xh/vHK88DatmvQ==
X-Google-Smtp-Source: ABdhPJxixE5QVYhIx4zi7joJIXZh6nCCnuSAO4/sCRLERa0IOuruqzznCxFJU/2feL6q/h9cCvHjFw==
X-Received: by 2002:a1c:2e0e:: with SMTP id u14mr2638785wmu.55.1594105746940; 
 Tue, 07 Jul 2020 00:09:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y77sm2348418wmd.36.2020.07.07.00.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:09:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EEEAB1FF91;
 Tue,  7 Jul 2020 08:08:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 05/41] tests/vm: Added configuration file support
Date: Tue,  7 Jul 2020 08:08:22 +0100
Message-Id: <20200707070858.6622-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Changes to tests/vm/basevm.py to allow accepting a configuration file
as a parameter. Allows for specifying VM options such as
cpu, machine, memory, and arbitrary qemu arguments for specifying options
such as NUMA configuration.
Also added an example conf_example_aarch64.yml and conf_example_x86.yml.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200601211421.1277-4-robert.foley@linaro.org>
Message-Id: <20200701135652.1366-8-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 83e36c270cce..3cabd004e329 100755
--- a/configure
+++ b/configure
@@ -960,6 +960,13 @@ do
     fi
 done
 
+# Check for existence of python3 yaml, needed to
+# import yaml config files into vm-build.
+python_yaml="no"
+if $(python3 -c "import yaml" 2> /dev/null); then
+    python_yaml="yes"
+fi
+
 : ${smbd=${SMBD-/usr/sbin/smbd}}
 
 # Default objcc to clang if available, otherwise use CC
@@ -6843,6 +6850,7 @@ if test "$docs" != "no"; then
     echo "sphinx-build      $sphinx_build"
 fi
 echo "genisoimage       $genisoimage"
+echo "python_yaml       $python_yaml"
 echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
 if test "$slirp" != "no" ; then
     echo "smbd              $smbd"
@@ -7928,6 +7936,7 @@ echo "PYTHON=$python" >> $config_host_mak
 echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
 echo "SPHINX_WERROR=$sphinx_werror" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
+echo "PYTHON_YAML=$python_yaml" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=$iasl" >> $config_host_mak
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index a253aba45796..f6c3892bb28e 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -44,6 +44,12 @@ endif
 	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
+ifeq ($(PYTHON_YAML),yes)
+	@echo "    QEMU_CONFIG=/path/conf.yml   - Change path to VM configuration .yml file."
+else
+	@echo "    (install python3-yaml to enable support for yaml file to configure a VM.)"
+endif
+	@echo "                                   See conf_example_*.yml for file format details."
 
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
 
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index cfe20c58f7ef..fa56fbbb4b60 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -481,7 +481,6 @@ class BaseVM(object):
                               cwd=cidir,
                               stdin=self._devnull, stdout=self._stdout,
                               stderr=self._stdout)
-
         return os.path.join(cidir, "cloud-init.iso")
 
 def get_qemu_path(arch, build_path=None):
@@ -497,6 +496,41 @@ def get_qemu_path(arch, build_path=None):
         qemu_path = "qemu-system-" + arch
     return qemu_path
 
+def parse_config(config, args):
+    """ Parse yaml config and populate our config structure.
+        The yaml config allows the user to override the
+        defaults for VM parameters.  In many cases these
+        defaults can be overridden without rebuilding the VM."""
+    if args.config:
+        config_file = args.config
+    elif 'QEMU_CONFIG' in os.environ:
+        config_file = os.environ['QEMU_CONFIG']
+    else:
+        return config
+    if not os.path.exists(config_file):
+        raise Exception("config file {} does not exist".format(config_file))
+    # We gracefully handle importing the yaml module
+    # since it might not be installed.
+    # If we are here it means the user supplied a .yml file,
+    # so if the yaml module is not installed we will exit with error.
+    try:
+        import yaml
+    except ImportError:
+        print("The python3-yaml package is needed "\
+              "to support config.yaml files")
+        # Instead of raising an exception we exit to avoid
+        # a raft of messy (expected) errors to stdout.
+        exit(1)
+    with open(config_file) as f:
+        yaml_dict = yaml.safe_load(f)
+
+    if 'qemu-conf' in yaml_dict:
+        config.update(yaml_dict['qemu-conf'])
+    else:
+        raise Exception("config file {} is not valid"\
+                        " missing qemu-conf".format(config_file))
+    return config
+
 def parse_args(vmcls):
 
     def get_default_jobs():
@@ -536,6 +570,9 @@ def parse_args(vmcls):
                       help="run tests with a snapshot")
     parser.add_option("--genisoimage", default="genisoimage",
                       help="iso imaging tool")
+    parser.add_option("--config", "-c", default=None,
+                      help="Provide config yaml for configuration. "\
+                           "See config_example.yaml for example.")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -547,6 +584,7 @@ def main(vmcls, config=None):
         if not argv and not args.build_qemu and not args.build_image:
             print("Nothing to do?")
             return 1
+        config = parse_config(config, args)
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
         vm = vmcls(args, config=config)
diff --git a/tests/vm/conf_example_aarch64.yml b/tests/vm/conf_example_aarch64.yml
new file mode 100644
index 000000000000..9d44ae356f7c
--- /dev/null
+++ b/tests/vm/conf_example_aarch64.yml
@@ -0,0 +1,51 @@
+#
+# Example yaml for use by any of the scripts in tests/vm.
+# Can be provided as an environment variable QEMU_CONFIG
+#
+qemu-conf:
+
+    # If any of the below are not provided, we will just use the qemu defaults.
+
+    # Login username and password(has to be sudo enabled)
+    guest_user: qemu
+    guest_pass: "qemupass"
+
+    # Password for root user can be different from guest.
+    root_pass: "qemupass"
+
+    # If one key is provided, both must be provided.
+    #ssh_key: /complete/path/of/your/keyfile/id_rsa
+    #ssh_pub_key: /complete/path/of/your/keyfile/id_rsa.pub
+
+    cpu: max
+    machine: virt,gic-version=max
+    memory: 16G
+
+    # The below is a example for how to configure NUMA topology with
+    # 4 NUMA nodes and 2 different NUMA distances.
+    qemu_args: "-smp cpus=16,sockets=2,cores=8
+                -numa node,cpus=0-3,nodeid=0 -numa node,cpus=4-7,nodeid=1
+                -numa node,cpus=8-11,nodeid=2 -numa node,cpus=12-15,nodeid=3
+                -numa dist,src=0,dst=1,val=15 -numa dist,src=2,dst=3,val=15
+                -numa dist,src=0,dst=2,val=20 -numa dist,src=0,dst=3,val=20
+                -numa dist,src=1,dst=2,val=20 -numa dist,src=1,dst=3,val=20"
+
+    # By default we do not set the DNS.
+    # You override the defaults by setting the below.
+    #dns: 1.234.567.89
+
+    # By default we will use a "block" device, but
+    # you can also boot from a "scsi" device.
+    # Just keep in mind your scripts might need to change
+    # As you will have /dev/sda instead of /dev/vda (for block device)
+    boot_dev_type: "block"
+
+    # By default the ssh port is not fixed.
+    # A fixed ssh port makes it easier for automated tests.
+    #ssh_port: 5555
+
+    # To install a different set of packages, provide a command to issue
+    #install_cmds: "apt-get update ; apt-get build-dep -y qemu"
+
+    # Or to skip the install entirely, just provide ""
+    #install_cmds: ""
diff --git a/tests/vm/conf_example_x86.yml b/tests/vm/conf_example_x86.yml
new file mode 100644
index 000000000000..78d3f5830fa2
--- /dev/null
+++ b/tests/vm/conf_example_x86.yml
@@ -0,0 +1,50 @@
+#
+# Example yaml for use by any of the x86 based scripts in tests/vm.
+# Can be provided as an environment variable QEMU_CONFIG
+#
+qemu-conf:
+
+    # If any of the below are not provided, we will just use the qemu defaults.
+
+    # Login username and password(has to be sudo enabled)
+    guest_user: "qemu"
+    guest_pass: "qemupass"
+
+    # Password for root user can be different from guest.
+    root_pass: "qemupass"
+
+    # Provide default ssh keys of current user.
+    # You need to edit the below for your user.
+    #ssh_key_file: /home/<user>/.ssh/id_rsa
+    #ssh_pub_key_file: /home/<user>/.ssh/id_rsa.pub
+
+    cpu: max
+    machine: pc
+    memory: 8G
+
+    # The below is a example for how to configure NUMA topology with
+    # 4 NUMA nodes and 2 different NUMA distances.
+    qemu_args: "-smp cpus=8,sockets=2,cores=4
+                -object memory-backend-ram,size=4G,policy=bind,host-nodes=0,id=ram-node0
+                -object memory-backend-ram,size=4G,policy=bind,host-nodes=0,id=ram-node1
+                -object memory-backend-ram,size=4G,policy=bind,host-nodes=1,id=ram-node2
+                -object memory-backend-ram,size=4G,policy=bind,host-nodes=1,id=ram-node3
+                -numa node,cpus=0-1,nodeid=0 -numa node,cpus=2-3,nodeid=1
+                -numa node,cpus=4-5,nodeid=2 -numa node,cpus=6-7,nodeid=3
+                -numa dist,src=0,dst=1,val=15 -numa dist,src=2,dst=3,val=15
+                -numa dist,src=0,dst=2,val=20 -numa dist,src=0,dst=3,val=20
+                -numa dist,src=1,dst=2,val=20 -numa dist,src=1,dst=3,val=20"
+
+    # By default we do not set the DNS.
+    # You override the defaults by setting the below.
+    #dns: "1.234.567.89"
+
+    # By default we will use a "block" device, but
+    # you can also boot from a "scsi" device.
+    # Just keep in mind your scripts might need to change
+    # As you will have /dev/sda instead of /dev/vda (for block device)
+    boot_dev_type: "block"
+
+    # By default the ssh port is not fixed.
+    # A fixed ssh port makes it easier for automated tests.
+    ssh_port: 5555
-- 
2.20.1


