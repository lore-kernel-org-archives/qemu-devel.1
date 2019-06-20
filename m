Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0577C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B99204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B99204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdups-0002Ip-Lj
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 07:02:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45442)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdufS-0002G7-1y
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hduTN-0003AA-8d
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:40:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hduTN-0003A1-1U
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:39:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so2532394wru.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 03:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3yrGOjoGZ30tlzKiwVtDNCe7DgqFcrSRFDsN9z+Pz+U=;
 b=oi+nW9txqZxWnftIwl6/Dfcx9RPnb+DjhvHN6NypKYrapHsp6JghEt4PBGEBMeySL+
 DfRYa2KDeHCdPUGd/hdWA7UdXRuJKa+6SwxjShmKi0ogJ3f5EoAfDOmmGJYURzWUgaEr
 LK7KtX0PPghmbTwaa58MJEzjyZF/lqNVQgdj5BsOOLpGDo34bkk6iXDUHVXryJHGF9td
 6wX/fOOhhkvYjvZoRsivWwQuQju/pG1S1f0mPUsuPDQnKAJL9Y8W0JVZbmqT/M9SWszb
 0R7agGnOm8aESwBD1If4+vLavPhxHjgPVeK4SFOQ3KZnQUFXSky/dLWUFgQ05l+xfaDb
 MtfQ==
X-Gm-Message-State: APjAAAWm61mOtsXg8T5Hly5KmcboRqUlX1A+q0I2Xg6/7AoE6pF0P9Zl
 8DPdXNHz6OUUplXYIS7D215XuUz7pDc=
X-Google-Smtp-Source: APXvYqznApFYTcyab9iFjHjweHRAdQaOAiKrTdCZ7bHdpgVwZ1QHysGmEP3azQOrrc6f42aJy/TUJA==
X-Received: by 2002:adf:9003:: with SMTP id h3mr9981010wrh.172.1561027155980; 
 Thu, 20 Jun 2019 03:39:15 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id u2sm7942103wmc.3.2019.06.20.03.39.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 03:39:15 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190619194021.8240-1-alex.bennee@linaro.org>
 <20190619194021.8240-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d9b49b4d-424b-1ad1-511e-fc5ad7cdafe6@redhat.com>
Date: Thu, 20 Jun 2019 12:39:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190619194021.8240-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v1 12/17] tests/vm: freebsd autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/19 9:40 PM, Alex Bennée wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
> 
> Instead of fetching the prebuilt image from patchew download the install
> iso and prepare the image locally.  Install to disk, using the serial
> console.  Create qemu user, configure ssh login.  Install packages
> needed for qemu builds.
> 
> Note that freebsd package downloads are delivered as non-cachable
> content, so I had to configure squid with "ignore-no-store
> ignore-private ignore-reload" for pkgmir.geo.freebsd.org to make the
> caching actually work.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20190617043858.8290-9-kraxel@redhat.com>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tests/vm/freebsd | 182 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 172 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 091be1a065..2a19461a90 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -2,41 +2,203 @@
>  #
>  # FreeBSD VM image
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
>  #
>  
>  import os
> +import re
>  import sys
> +import time
> +import socket
>  import subprocess
>  import basevm
>  
>  class FreeBSDVM(basevm.BaseVM):
>      name = "freebsd"
>      arch = "x86_64"
> +
> +    link = "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12.0/FreeBSD-12.0-RELEASE-amd64-disc1.iso.xz"
> +    csum = "1d40015bea89d05b8bd13e2ed80c40b522a9ec1abd8e7c8b80954fb485fb99db"
> +    size = "20G"
> +    pkgs = [
> +        # build tools
> +        "git",
> +        "pkgconf",
> +        "bzip2",
> +
> +        # gnu tools
> +        "bash",
> +        "gmake",
> +        "gsed",
> +        "flex", "bison",
> +
> +        # libs: crypto
> +        "gnutls",
> +
> +        # libs: images
> +        "jpeg-turbo",
> +        "png",
> +
> +        # libs: ui
> +        "sdl2",
> +        "gtk3",
> +        "libxkbcommon",
> +
> +        # libs: opengl
> +        "libepoxy",
> +        "mesa-libs",
> +    ]
> +
>      BUILD_SCRIPT = """
>          set -e;
> -        rm -rf /var/tmp/qemu-test.*
> -        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> +        rm -rf /home/qemu/qemu-test.*
> +        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
> +        mkdir src build; cd src;
>          tar -xf /dev/vtbd1;
> -        ./configure {configure_opts};
> +        cd ../build
> +        ../src/configure --python=python3.6 {configure_opts};
>          gmake --output-sync -j{jobs} {target} {verbose};
>      """
>  
> +    def console_boot_serial(self):
> +        self.console_wait_send("Autoboot", "3")
> +        self.console_wait_send("OK", "set console=comconsole\n")
> +        self.console_wait_send("OK", "boot\n")
> +
>      def build_image(self, img):
> -        cimg = self._download_with_cache("http://download.patchew.org/freebsd-11.1-amd64.img.xz",
> -                sha256sum='adcb771549b37bc63826c501f05121a206ed3d9f55f49145908f7e1432d65891')
> -        img_tmp_xz = img + ".tmp.xz"
> +        self.print_step("Downloading install iso")
> +        cimg = self._download_with_cache(self.link, sha256sum=self.csum)
>          img_tmp = img + ".tmp"
> -        sys.stderr.write("Extracting the image...\n")
> -        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
> +        iso = img + ".install.iso"
> +        iso_xz = iso + ".xz"
> +
> +        self.print_step("Preparing iso and disk image")
> +        subprocess.check_call(["cp", "-f", cimg, iso_xz])
> +        subprocess.check_call(["xz", "-dvf", iso_xz])
> +        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
> +                               img_tmp, self.size])
> +
> +        self.print_step("Booting installer")
> +        self.boot(img_tmp, extra_args = [
> +            "-bios", "pc-bios/bios-256k.bin",
> +            "-machine", "graphics=off",
> +            "-cdrom", iso
> +        ])
> +        self.console_init()
> +        self.console_boot_serial()
> +        self.console_wait_send("Console type",          "xterm\n")
> +
> +        # pre-install configuration
> +        self.console_wait_send("Welcome",               "\n")
> +        self.console_wait_send("Keymap Selection",      "\n")
> +        self.console_wait_send("Set Hostname",          "freebsd\n")
> +        self.console_wait_send("Distribution Select",   "\n")
> +        self.console_wait_send("Partitioning",          "\n")
> +        self.console_wait_send("Partition",             "\n")
> +        self.console_wait_send("Scheme",                "\n")
> +        self.console_wait_send("Editor",                "f")
> +        self.console_wait_send("Confirmation",          "c")
> +
> +        self.print_step("Installation started now, this will take a while")
> +
> +        # post-install configuration
> +        self.console_wait("New Password:")
> +        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_wait("Retype New Password:")
> +        self.console_send("%s\n" % self.ROOT_PASS)
> +
> +        self.console_wait_send("Network Configuration", "\n")
> +        self.console_wait_send("IPv4",                  "y")
> +        self.console_wait_send("DHCP",                  "y")
> +        self.console_wait_send("IPv6",                  "n")
> +        self.console_wait_send("Resolver",              "\n")
> +
> +        self.console_wait_send("Time Zone Selector",    "a\n")
> +        self.console_wait_send("Confirmation",          "y")
> +        self.console_wait_send("Time & Date",           "\n")
> +        self.console_wait_send("Time & Date",           "\n")
> +
> +        self.console_wait_send("System Configuration",  "\n")
> +        self.console_wait_send("System Hardening",      "\n")
> +
> +        # qemu user
> +        self.console_wait_send("Add User Accounts", "y")
> +        self.console_wait("Username")
> +        self.console_send("%s\n" % self.GUEST_USER)
> +        self.console_wait("Full name")
> +        self.console_send("%s\n" % self.GUEST_USER)
> +        self.console_wait_send("Uid",                   "\n")
> +        self.console_wait_send("Login group",           "\n")
> +        self.console_wait_send("Login group",           "\n")
> +        self.console_wait_send("Login class",           "\n")
> +        self.console_wait_send("Shell",                 "\n")
> +        self.console_wait_send("Home directory",        "\n")
> +        self.console_wait_send("Home directory perm",   "\n")
> +        self.console_wait_send("Use password",          "\n")
> +        self.console_wait_send("Use an empty password", "\n")
> +        self.console_wait_send("Use a random password", "\n")
> +        self.console_wait("Enter password:")
> +        self.console_send("%s\n" % self.GUEST_PASS)
> +        self.console_wait("Enter password again:")
> +        self.console_send("%s\n" % self.GUEST_PASS)
> +        self.console_wait_send("Lock out",              "\n")
> +        self.console_wait_send("OK",                    "yes\n")
> +        self.console_wait_send("Add another user",      "no\n")
> +
> +        self.console_wait_send("Final Configuration",   "\n")
> +        self.console_wait_send("Manual Configuration",  "\n")
> +        self.console_wait_send("Complete",              "\n")
> +
> +        self.print_step("Installation finished, rebooting")
> +        self.console_boot_serial()
> +
> +        # setup qemu user
> +        prompt = "$"
> +        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
> +        self.console_wait_send(prompt, "exit\n")
> +
> +        # setup root user
> +        prompt = "root@freebsd:~ #"
> +        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
> +        self.console_sshd_config(prompt)
> +
> +        # setup serial console
> +        self.console_wait(prompt)
> +        self.console_send("echo 'console=comconsole' >> /boot/loader.conf\n")
> +
> +        # setup boot delay
> +        self.console_wait(prompt)
> +        self.console_send("echo 'autoboot_delay=1' >> /boot/loader.conf\n")
> +
> +        # setup virtio-blk #1 (tarfile)
> +        self.console_wait(prompt)
> +        self.console_send("echo 'chmod 666 /dev/vtbd1' >> /etc/rc.local\n")
> +
> +        self.print_step("Configuration finished, rebooting")
> +        self.console_wait_send(prompt, "reboot\n")
> +        self.console_wait("login:")
> +        self.wait_ssh()
> +
> +        self.print_step("Installing packages")
> +        self.ssh_root_check("pkg install -y %s\n" % " ".join(self.pkgs))
> +
> +        # shutdown
> +        self.ssh_root(self.poweroff)
> +        self.console_wait("Uptime:")
> +        self.wait()
> +
> +        if os.path.exists(img):
> +            os.remove(img)
>          os.rename(img_tmp, img)
> +        os.remove(iso)
> +        self.print_step("All done")
>  
>  if __name__ == "__main__":
>      sys.exit(basevm.main(FreeBSDVM))
> 

