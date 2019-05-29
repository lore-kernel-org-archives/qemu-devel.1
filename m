Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77FFC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7432E20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7432E20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52117 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVwqc-00006J-Ot
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 07:34:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVwnV-00071O-1u
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVwnT-00033O-Nj
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:31:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVwnT-00032s-GJ
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:31:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id v22so1363054wml.1
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 04:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=pOCFVp0EgAobMfe3sfKcXgL8aZvTsCEzELgf0B/T+Is=;
	b=Olw1ba32HVAVcvT7z2CGGpL9mLiAnct6KArx8wmwPatUhB598yOX98GLMh4KQ2wcNY
	e8wL1MmIDN1nQIyh04CH2Jkh3r4YQN1C0hCv2AEth/BcNhdfllH1uSK8aFiYFQT7YrQl
	lA3g5ytPSh+i6Rs/YJmmECQa2s2oWli8hGC01QqkHdD7Xl9tZhRTbPDbv5fSG1UYJxrE
	Y1hyWFxllskhVkEM91Guzla4yXdW6OK8ff8kEofKg7+4OAncWw5ea5qy6MOHiBAYTP+h
	cp2vAFW5prvk/Sblnr4HSAzK/cBJypAziem0iBEqfJTH8h8+TKtpeX2E8Lo97oebxfOw
	DVGQ==
X-Gm-Message-State: APjAAAVtbgHJDm4YZeZUsCjXccH/668ksbWozTvvMzNYItsDGfDFHcSw
	18bsreyCwOSQqJq9teYNzIAOqQ==
X-Google-Smtp-Source: APXvYqxAl+h/1iZ5dAwZn6NLggTIln0JHfepxGscgNgT8JGlqbU8G8ypmCfXxjwa0O2QBEe9+Vy63g==
X-Received: by 2002:a1c:35c9:: with SMTP id c192mr6645844wma.147.1559129466064;
	Wed, 29 May 2019 04:31:06 -0700 (PDT)
Received: from [10.32.224.40] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
	[159.63.51.90]) by smtp.gmail.com with ESMTPSA id
	v124sm8617645wme.42.2019.05.29.04.31.04
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 04:31:05 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190520124716.30472-1-kraxel@redhat.com>
	<20190520124716.30472-10-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a8840cb8-7a74-5d32-c54f-eca206bd6ef6@redhat.com>
Date: Wed, 29 May 2019 13:31:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520124716.30472-10-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v3 09/14] tests/vm: serial console support
 helpers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 5/20/19 2:47 PM, Gerd Hoffmann wrote:
> Add a bunch of helpers to talk to the guest using the
> serial console.
> 
> Also drop the hard-coded -serial parameter for the vm
> so QEMUMachine.set_console() actually works.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/vm/basevm.py | 85 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 465c7b80d011..17281eaf99e4 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -2,10 +2,11 @@
>  #
>  # VM testing base class
>  #
> -# Copyright 2017 Red Hat Inc.
> +# Copyright 2017-2019 Red Hat Inc.
>  #
>  # Authors:
>  #  Fam Zheng <famz@redhat.com>
> +#  Gerd Hoffmann <kraxel@redhat.com>
>  #
>  # This code is licensed under the GPL version 2 or later.  See
>  # the COPYING file in the top-level directory.
> @@ -13,7 +14,9 @@
>  
>  from __future__ import print_function
>  import os
> +import re
>  import sys
> +import socket
>  import logging
>  import time
>  import datetime
> @@ -79,8 +82,7 @@ class BaseVM(object):
>              "-cpu", "max",
>              "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22",
>              "-device", "virtio-net-pci,netdev=vnet",
> -            "-vnc", "127.0.0.1:0,to=20",
> -            "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.out")]
> +            "-vnc", "127.0.0.1:0,to=20"]
>          if vcpus and vcpus > 1:
>              self._args += ["-smp", "%d" % vcpus]
>          if kvm_available(self.arch):
> @@ -161,6 +163,8 @@ class BaseVM(object):
>          logging.debug("QEMU args: %s", " ".join(args))
>          qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
>          guest = QEMUMachine(binary=qemu_bin, args=args)
> +        guest.set_machine('pc')

This line broke another series I'm working on, I suggest amending:

-- >8 --
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -154,7 +154,7 @@ class BaseVM(object):
                             "-device",
                             "virtio-blk,drive=%s,serial=%s,bootindex=1"
% (name, name)]

-    def boot(self, img, extra_args=[]):
+    def boot(self, img, machine='pc', extra_args=[]):
         args = self._args + [
             "-device", "VGA",
             "-drive", "file=%s,if=none,id=drive0,cache=writeback" % img,
@@ -163,7 +163,7 @@ class BaseVM(object):
         logging.debug("QEMU args: %s", " ".join(args))
         qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
         guest = QEMUMachine(binary=qemu_bin, args=args)
-        guest.set_machine('pc')
+        guest.set_machine(machine)
         guest.set_console()
         try:
             guest.launch()
---

Anyway I can do it in a separate patch too, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        guest.set_console()
>          try:
>              guest.launch()
>          except:
> @@ -183,6 +187,81 @@ class BaseVM(object):
>              raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
>                              usernet_info)
>  
> +    def console_init(self, timeout = 120):
> +        vm = self._guest
> +        vm.console_socket.settimeout(timeout)
> +
> +    def console_log(self, text):
> +        for line in re.split("[\r\n]", text):
> +            # filter out terminal escape sequences
> +            line = re.sub("\x1b\[[0-9;?]*[a-zA-Z]", "", line)
> +            line = re.sub("\x1b\([0-9;?]*[a-zA-Z]", "", line)
> +            # replace unprintable chars
> +            line = re.sub("\x1b", "<esc>", line)
> +            line = re.sub("[\x00-\x1f]", ".", line)
> +            if line == "":
> +                continue
> +            # log console line
> +            sys.stderr.write("con recv: %s\n" % line)
> +
> +    def console_wait(self, expect):
> +        vm = self._guest
> +        output = ""
> +        while True:
> +            try:
> +                chars = vm.console_socket.recv(1024)
> +            except socket.timeout:
> +                sys.stderr.write("console: *** read timeout ***\n")
> +                sys.stderr.write("console: waiting for: '%s'\n" % expect)
> +                sys.stderr.write("console: line buffer:\n")
> +                sys.stderr.write("\n")
> +                self.console_log(output.rstrip())
> +                sys.stderr.write("\n")
> +                raise
> +            output += chars.decode("latin1")
> +            if expect in output:
> +                break
> +            if "\r" in output or "\n" in output:
> +                lines = re.split("[\r\n]", output)
> +                output = lines.pop()
> +                if self.debug:
> +                    self.console_log("\n".join(lines))
> +        if self.debug:
> +            self.console_log(output)
> +
> +    def console_send(self, command):
> +        vm = self._guest
> +        if self.debug:
> +            logline = re.sub("\n", "<enter>", command)
> +            logline = re.sub("[\x00-\x1f]", ".", logline)
> +            sys.stderr.write("con send: %s\n" % logline)
> +        for char in list(command):
> +            vm.console_socket.send(char.encode("utf-8"))
> +            time.sleep(0.01)
> +
> +    def console_wait_send(self, wait, command):
> +        self.console_wait(wait)
> +        self.console_send(command)
> +
> +    def console_ssh_init(self, prompt, user, pw):
> +        sshkey_cmd = "echo '%s' > .ssh/authorized_keys\n" % SSH_PUB_KEY.rstrip()
> +        self.console_wait_send("login:",    "%s\n" % user)
> +        self.console_wait_send("Password:", "%s\n" % pw)
> +        self.console_wait_send(prompt,      "mkdir .ssh\n")
> +        self.console_wait_send(prompt,      sshkey_cmd)
> +        self.console_wait_send(prompt,      "chmod 755 .ssh\n")
> +        self.console_wait_send(prompt,      "chmod 644 .ssh/authorized_keys\n")
> +
> +    def console_sshd_config(self, prompt):
> +        self.console_wait(prompt)
> +        self.console_send("echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config\n")
> +        for var in self.envvars:
> +            self.console_wait(prompt)
> +            self.console_send("echo 'AcceptEnv %s' >> /etc/ssh/sshd_config\n" % var)
> +
> +    def print_step(self, text):
> +        sys.stderr.write("### %s ...\n" % text)
> +
>      def wait_ssh(self, seconds=300):
>          starttime = datetime.datetime.now()
>          endtime = starttime + datetime.timedelta(seconds=seconds)
> 

