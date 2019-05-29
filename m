Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A48C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6D32081C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6D32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52345 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVx73-00006z-Hc
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 07:51:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVx6E-0008FQ-Rh
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVx6D-0001pj-9V
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:50:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVx6D-0001ot-47
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:50:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id y3so1469729wmm.2
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 04:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=33ZmxqWT9ywRyy+z2NlogBGAH8NxzDpHx3qU5TDATes=;
	b=KsdZiFzjupnHoUIIPphe/hd/Vpd8plnPuwjhZEvJAs9RqqRrUOA56oWe2sLT3PYGXx
	m2GSNXGntdnF+O+gzN0OYtAZbrG+mqkMcWMwnIA0QLojw+8f6LmSIgfHzht0J73lQkWj
	ajwG6KQitK/LFrUaIh3zW3xXdCgdXecXwHKSifuT8iZZhbY6iZQWkK1V2WoZDwmI737l
	P6JV2ppJWGJ61o2STV4srjdquE6M2AtxWuWhg8gQpxCdkUw3aSn06AGs7AX5noxY1hlA
	LRXenzcyNZ+6ld2r/HZ6ZtlR+2v9+6p5hf56t7tNGBklKnLQumIqRe64zQGdBT8Z4J+i
	lEYQ==
X-Gm-Message-State: APjAAAUp6bfjNAxy9FNRWb8a8s8qJh+a+Pezz49o/3RyX5I6j9t6oRXn
	GC3JnVVT34f+Ait8zzSWPnU3Rw==
X-Google-Smtp-Source: APXvYqxOIrOi/uS+rXEAUheXoSTjPGsjkdMSgPeYzTiEEHxcUGhHiolL/L6Fdsr4PD+ge5yqKhJC6Q==
X-Received: by 2002:a1c:7001:: with SMTP id l1mr6894703wmc.40.1559130628028;
	Wed, 29 May 2019 04:50:28 -0700 (PDT)
Received: from [10.32.224.40] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
	[159.63.51.90])
	by smtp.gmail.com with ESMTPSA id n7sm6053671wrw.64.2019.05.29.04.50.26
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 04:50:27 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190520124716.30472-1-kraxel@redhat.com>
	<20190520124716.30472-11-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c293af5d-08a1-4890-5584-c7693dcd48a7@redhat.com>
Date: Wed, 29 May 2019 13:50:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520124716.30472-11-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v3 10/14] tests/vm: openbsd autoinstall,
 using serial console
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

On 5/20/19 2:47 PM, Gerd Hoffmann wrote:
> Instead of fetching the prebuilt image from patchew download the install
> iso and prepare the image locally.  Install to disk, using the serial
> console.  Create qemu user, configure ssh login.  Install packages
> needed for qemu builds.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/vm/openbsd | 158 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 145 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 2105c01a267a..c5f0a1521833 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -2,10 +2,11 @@
>  #
>  # OpenBSD VM image
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
> @@ -13,34 +14,165 @@
>  
>  import os
>  import sys
> +import socket
>  import subprocess
>  import basevm
>  
>  class OpenBSDVM(basevm.BaseVM):
>      name = "openbsd"
>      arch = "x86_64"
> +
> +    link = "https://cdn.openbsd.org/pub/OpenBSD/6.5/amd64/install65.iso"
> +    csum = "38d1f8cadd502f1c27bf05c5abde6cc505dd28f3f34f8a941048ff9a54f9f608"
> +    size = "20G"
> +    pkgs = [
> +        # tools
> +        "git",
> +        "pkgconf",
> +        "bzip2", "xz",
> +
> +        # gnu tools
> +        "bash",
> +        "gmake",
> +        "gsed",
> +        "bison",
> +
> +        # libs: usb
> +        "libusb1",
> +
> +        # libs: crypto
> +        "gnutls",
> +
> +        # libs: images
> +        "jpeg",
> +        "png",
> +
> +	# libs: ui
> +        "sdl2",
> +        "gtk+3",
> +        "libxkbcommon",
> +    ]
> +
>      BUILD_SCRIPT = """
>          set -e;
> -        rm -rf /var/tmp/qemu-test.*
> -        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> +        rm -rf /home/qemu/qemu-test.*
> +        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
> +        mkdir src build; cd src;
>          tar -xf /dev/rsd1c;
> -        ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 {configure_opts};
> -        gmake --output-sync -j{jobs} {verbose};
> -        # XXX: "gmake check" seems to always hang or fail
> -        #gmake --output-sync -j{jobs} check {verbose};
> +        cd ../build
> +        ../src/configure --cc=cc --python=python3 {configure_opts};
> +        gmake --output-sync -j{jobs} {target} {verbose};
>      """
> +    poweroff = "halt -p"
>  
>      def build_image(self, img):
> -        cimg = self._download_with_cache("http://download.patchew.org/openbsd-6.1-amd64.img.xz",
> -                sha256sum='8c6cedc483e602cfee5e04f0406c64eb99138495e8ca580bc0293bcf0640c1bf')
> -        img_tmp_xz = img + ".tmp.xz"
> +        self.print_step("Downloading install iso")
> +        cimg = self._download_with_cache(self.link, sha256sum=self.csum)
>          img_tmp = img + ".tmp"
> -        sys.stderr.write("Extracting the image...\n")
> -        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
> +        iso = img + ".install.iso"
> +
> +        self.print_step("Preparing iso and disk image")
> +        subprocess.check_call(["cp", "-f", cimg, iso])
> +        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
> +                               img_tmp, self.size])
> +
> +        self.print_step("Booting installer")
> +        self.boot(img_tmp, extra_args = [
> +            "-machine", "graphics=off",
> +            "-cdrom", iso
> +        ])
> +        self.console_init()
> +        self.console_wait_send("boot>", "set tty com0\n")
> +        self.console_wait_send("boot>", "\n")
> +
> +        # pre-install configuration
> +        self.console_wait_send("(I)nstall",               "i\n")
> +        self.console_wait_send("Terminal type",           "xterm\n")
> +        self.console_wait_send("System hostname",         "openbsd\n")
> +        self.console_wait_send("Which network interface", "vio0\n")
> +        self.console_wait_send("IPv4 address",            "dhcp\n")
> +        self.console_wait_send("IPv6 address",            "none\n")
> +        self.console_wait_send("Which network interface", "done\n")
> +        self.console_wait_send("DNS domain name",         "localnet\n")
> +        self.console_wait("Password for root account")
> +        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_wait("Password for root account")
> +        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_wait_send("Start sshd(8)",           "yes\n")
> +        self.console_wait_send("X Window System",         "\n")
> +        self.console_wait_send("xenodm",                  "\n")
> +        self.console_wait_send("console to com0",         "\n")
> +        self.console_wait_send("Which speed",             "\n")
> +
> +        self.console_wait("Setup a user")
> +        self.console_send("%s\n" % self.GUEST_USER)
> +        self.console_wait("Full name")
> +        self.console_send("%s\n" % self.GUEST_USER)
> +        self.console_wait("Password")
> +        self.console_send("%s\n" % self.GUEST_PASS)
> +        self.console_wait("Password")
> +        self.console_send("%s\n" % self.GUEST_PASS)
> +
> +        self.console_wait_send("Allow root ssh login",    "yes\n")
> +        self.console_wait_send("timezone",                "UTC\n")
> +        self.console_wait_send("root disk",               "\n")
> +        self.console_wait_send("(W)hole disk",            "\n")
> +        self.console_wait_send("(A)uto layout",           "\n")
> +        self.console_wait_send("Location of sets",        "cd0\n")
> +        self.console_wait_send("Pathname to the sets",    "\n")
> +        self.console_wait_send("Set name(s)",             "\n")
> +        self.console_wait_send("without verification",    "yes\n")
> +
> +        self.print_step("Installation started now, this will take a while")
> +        self.console_wait_send("Location of sets",        "done\n")
> +
> +        self.console_wait("successfully completed")
> +        self.print_step("Installation finished, rebooting")
> +        self.console_wait_send("(R)eboot",                "reboot\n")
> +
> +        # setup qemu user
> +        prompt = "$"
> +        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
> +        self.console_wait_send(prompt, "exit\n")
> +
> +        # setup root user
> +        prompt = "openbsd#"
> +        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
> +        self.console_sshd_config(prompt)
> +
> +        # setup virtio-blk #1 (tarfile)
> +        self.console_wait(prompt)
> +        self.console_send("echo 'chmod 666 /dev/rsd1c' >> /etc/rc.local\n")
> +
> +        # enable w+x for /home
> +        self.console_wait(prompt)
> +        self.console_send("sed -i -e '/home/s/rw,/rw,wxallowed,/' /etc/fstab\n")
> +
> +        # tweak datasize limit
> +        self.console_wait(prompt)
> +        self.console_send("sed -i -e 's/\\(datasize[^=]*\\)=[^:]*/\\1=infinity/' /etc/login.conf\n")
> +
> +        # use http (be proxy cache friendly)
> +        self.console_wait(prompt)
> +        self.console_send("sed -i -e 's/https/http/' /etc/installurl\n")
> +
> +        self.print_step("Configuration finished, rebooting")
> +        self.console_wait_send(prompt, "reboot\n")
> +        self.console_wait("login:")
> +        self.wait_ssh()
> +
> +        self.print_step("Installing packages")
> +        self.ssh_root_check("pkg_add %s\n" % " ".join(self.pkgs))
> +
> +        # shutdown
> +        self.ssh_root(self.poweroff)
> +        self.wait()
> +
>          if os.path.exists(img):
>              os.remove(img)
>          os.rename(img_tmp, img)
> +        os.remove(iso)
> +        self.print_step("All done")
>  
>  if __name__ == "__main__":
>      sys.exit(basevm.main(OpenBSDVM))
> 

This works like charm.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

