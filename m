Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98E5CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D132080F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D132080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRhMz-00057r-5v
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 13:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iRhKl-0003Fp-Lb
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iRhKj-0005Kv-O9
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:44:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iRhKj-0005EC-01
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:44:09 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 22F593D1B
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 18:44:06 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id g17so6127508wru.4
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 10:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=msU8Z5paFulFm2K3FqQlGxs/AgV8Pk0ZD/Yc1NluM8w=;
 b=nNgE0FSwmcygg+LjDlz1rX0131K17VR22QATagHxfIyyROlPNpbvKQzN1Efl6ME+tB
 1nwYR+bT62Kqt+WidFECSL3ND1S3cZR11B6ktrN+GNcMC+Q2VEgjoCVQ2JmTnlnr04e8
 UsFcj+a9fL73usvR/TRR8HEJRb3A9dcdsnxNW6sdEqsaM+B5mJwGRamMy7Cpxk6JReRV
 itrsawPOL89IarZe3PFuM4M3rlC1WvpI0QF6jpZfS1niRI/DihbvSL2SKk4Hk0civa0i
 bpNmKYC7NHcNuWoU1NZgMeii35/lbRK6qvHWPFWJM8ItjYzjtKeCfD27+dwGN813yR46
 pUmQ==
X-Gm-Message-State: APjAAAWpjDcS/XIm3QFWHSoEPpu5SIYOVI0r7ppz/Y28/HbjSEWn54mU
 PUsoJH6z/Ps+Zm7m19qMoUXGp9vtNFNbmCF03aMzL2TssIUaNczmygZOSqbLx9Rx50PcUE2Fvx9
 VLhqewpTxl8Iorkw=
X-Received: by 2002:a05:600c:2257:: with SMTP id
 a23mr475332wmm.143.1572893044763; 
 Mon, 04 Nov 2019 10:44:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqzMw1Y/++Ct7Tpk+bZqqLXX+Svzu4mLEPWQjDKXG3aZll6uwnFPPy7PX005V8vB7OglRr59OQ==
X-Received: by 2002:a05:600c:2257:: with SMTP id
 a23mr475298wmm.143.1572893044450; 
 Mon, 04 Nov 2019 10:44:04 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id p4sm9739330wrx.71.2019.11.04.10.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2019 10:44:03 -0800 (PST)
Subject: Re: [PATCH v1 1/6] tests/vm: netbsd autoinstall, using serial console
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191104173654.30125-1-alex.bennee@linaro.org>
 <20191104173654.30125-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <23f9e440-b371-2df6-1ea4-6a516a784949@redhat.com>
Date: Mon, 4 Nov 2019 19:44:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104173654.30125-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Kamil Rytarowski <kamil@netbsd.org>, cota@braap.org,
 Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com,
 Kamil Rytarowski <n54@gmx.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/19 6:36 PM, Alex Benn=C3=A9e wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
>=20
> Instead of fetching the prebuilt image from patchew download the instal=
l
> iso and prepare the image locally.  Install to disk, using the serial
> console.  Create qemu user, configure ssh login.  Install packages
> needed for qemu builds.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Kamil Rytarowski <n54@gmx.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> [ehabkost: rebased to latest qemu.git master]
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Message-Id: <20191031085306.28888-2-kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/vm/netbsd | 189 +++++++++++++++++++++++++++++++++++++++++++++--=
-
>   1 file changed, 179 insertions(+), 10 deletions(-)
>=20
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 18aa56ae826..5e04dcd9b16 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -2,10 +2,11 @@
>   #
>   # NetBSD VM image
>   #
> -# Copyright 2017 Red Hat Inc.
> +# Copyright 2017-2019 Red Hat Inc.
>   #
>   # Authors:
>   #  Fam Zheng <famz@redhat.com>
> +#  Gerd Hoffmann <kraxel@redhat.com>
>   #
>   # This code is licensed under the GPL version 2 or later.  See
>   # the COPYING file in the top-level directory.
> @@ -13,20 +14,53 @@
>  =20
>   import os
>   import sys
> +import time
>   import subprocess
>   import basevm
>  =20
>   class NetBSDVM(basevm.BaseVM):
>       name =3D "netbsd"
>       arch =3D "x86_64"
> +
> +    link =3D "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.0/images/NetB=
SD-8.0-amd64.iso"
> +    size =3D "20G"
> +    pkgs =3D [
> +        # tools
> +        "git-base",
> +        "pkgconf",
> +        "xz",
> +        "python37",
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
> +        "jpeg",
> +        "png",
> +
> +	# libs: ui
> +        "SDL2",
> +        "gtk3+",
> +        "libxkbcommon",
> +    ]
> +
>       BUILD_SCRIPT =3D """
>           set -e;
> -        rm -rf /var/tmp/qemu-test.*
> -        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> +        rm -rf /home/qemu/qemu-test.*
> +        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
> +        mkdir src build; cd src;
>           tar -xf /dev/rld1a;
> -        ./configure --python=3Dpython2.7 {configure_opts};
> +        cd ../build
> +        ../src/configure --python=3Dpython3.7 --disable-opengl {config=
ure_opts};
>           gmake --output-sync -j{jobs} {target} {verbose};
>       """
> +    poweroff =3D "/sbin/poweroff"
>  =20
>       # Workaround for NetBSD + IPv6 + slirp issues.
>       # NetBSD seems to ignore the ICMPv6 Destination Unreachable
> @@ -36,14 +70,149 @@ class NetBSDVM(basevm.BaseVM):
>       ipv6 =3D False
>  =20
>       def build_image(self, img):
> -        cimg =3D self._download_with_cache("http://download.patchew.or=
g/netbsd-7.1-amd64.img.xz",
> -                                         sha256sum=3D'b633d565b0eac3d0=
2015cd0c81440bd8a7a8df8512615ac1ee05d318be015732')
> -        img_tmp_xz =3D img + ".tmp.xz"
> +        cimg =3D self._download_with_cache(self.link)
>           img_tmp =3D img + ".tmp"
> -        sys.stderr.write("Extracting the image...\n")
> -        subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
> +        iso =3D img + ".install.iso"
> +
> +        self.print_step("Preparing iso and disk image")
> +        subprocess.check_call(["ln", "-f", cimg, iso])
> +        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
> +                               img_tmp, self.size])
> +
> +        self.print_step("Booting installer")
> +        self.boot(img_tmp, extra_args =3D [
> +            "-bios", "pc-bios/bios-256k.bin",
> +            "-machine", "graphics=3Doff",
> +            "-cdrom", iso
> +        ])
> +        self.console_init()
> +        self.console_wait("Primary Bootstrap")
> +
> +        # serial console boot menu output doesn't work for some
> +        # reason, so we have to fly blind ...
> +        for char in list("5consdev com0\n"):
> +            time.sleep(0.2)
> +            self.console_send(char)
> +            self.console_wait("")
> +        self.console_wait_send("> ", "boot\n")
> +
> +        self.console_wait_send("Terminal type",            "xterm\n")
> +        self.console_wait_send("a: Installation messages", "a\n")
> +        self.console_wait_send("b: US-English",            "b\n")
> +        self.console_wait_send("a: Install NetBSD",        "a\n")
> +        self.console_wait("Shall we continue?")
> +        self.console_wait_send("b: Yes",                   "b\n")
> +
> +        self.console_wait_send("a: ld0",                   "a\n")
> +        self.console_wait_send("a: This is the correct",   "a\n")
> +        self.console_wait_send("b: Use the entire disk",   "b\n")
> +        self.console_wait("NetBSD bootcode")
> +        self.console_wait_send("a: Yes",                   "a\n")
> +        self.console_wait_send("b: Use existing part",     "b\n")
> +        self.console_wait_send("x: Partition sizes ok",    "x\n")
> +        self.console_wait_send("for your NetBSD disk",     "\n")
> +        self.console_wait("Shall we continue?")
> +        self.console_wait_send("b: Yes",                   "b\n")
> +
> +        self.console_wait_send("b: Use serial port com0",  "b\n")
> +        self.console_wait_send("f: Set serial baud rate",  "f\n")
> +        self.console_wait_send("a: 9600",                  "a\n")
> +        self.console_wait_send("x: Exit",                  "x\n")
> +
> +        self.console_wait_send("a: Full installation",     "a\n")
> +        self.console_wait_send("a: CD-ROM",                "a\n")
> +
> +        self.print_step("Installation started now, this will take a wh=
ile")
> +        self.console_wait_send("Hit enter to continue",    "\n")
> +
> +        self.console_wait_send("d: Change root password",  "d\n")
> +        self.console_wait_send("a: Yes",                   "a\n")
> +        self.console_wait("New password:")
> +        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_wait("New password:")
> +        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_wait("Retype new password:")
> +        self.console_send("%s\n" % self.ROOT_PASS)
> +
> +        self.console_wait_send("o: Add a user",            "o\n")
> +        self.console_wait("username")
> +        self.console_send("%s\n" % self.GUEST_USER)
> +        self.console_wait("to group wheel")
> +        self.console_wait_send("a: Yes",                   "a\n")
> +        self.console_wait_send("a: /bin/sh",               "a\n")
> +        self.console_wait("New password:")
> +        self.console_send("%s\n" % self.GUEST_PASS)
> +        self.console_wait("New password:")
> +        self.console_send("%s\n" % self.GUEST_PASS)
> +        self.console_wait("Retype new password:")
> +        self.console_send("%s\n" % self.GUEST_PASS)
> +
> +        self.console_wait_send("a: Configure network",     "a\n")
> +        self.console_wait_send("a: vioif0",                "a\n")
> +        self.console_wait_send("Network media type",       "\n")
> +        self.console_wait("autoconfiguration")
> +        self.console_wait_send("a: Yes",                   "a\n")
> +        self.console_wait_send("DNS domain",               "localnet\n=
")
> +        self.console_wait("Are they OK?")
> +        self.console_wait_send("a: Yes",                   "a\n")
> +        self.console_wait("installed in /etc")
> +        self.console_wait_send("a: Yes",                   "a\n")
> +
> +        self.console_wait_send("e: Enable install",        "e\n")
> +        proxy =3D os.environ.get("http_proxy")
> +        if not proxy is None:
> +            self.console_wait_send("f: Proxy",             "f\n")
> +            self.console_wait("Proxy")
> +            self.console_send("%s\n" % proxy)
> +        self.console_wait_send("x: Install pkgin",         "x\n")
> +        self.console_init(1200)
> +        self.console_wait_send("Hit enter to continue", "\n")
> +        self.console_init()
> +
> +        self.console_wait_send("g: Enable sshd",           "g\n")
> +        self.console_wait_send("x: Finished conf",         "x\n")
> +        self.console_wait_send("Hit enter to continue",    "\n")
> +
> +        self.print_step("Installation finished, rebooting")
> +        self.console_wait_send("d: Reboot the computer",   "d\n")
> +
> +        # setup qemu user
> +        prompt =3D "localhost$"
> +        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS=
)
> +        self.console_wait_send(prompt, "exit\n")
> +
> +        # setup root user
> +        prompt =3D "localhost#"
> +        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
> +        self.console_sshd_config(prompt)
> +
> +        # setup virtio-blk #1 (tarfile)
> +        self.console_wait(prompt)
> +        self.console_send("echo 'chmod 666 /dev/rld1a' >> /etc/rc.loca=
l\n")
> +
> +        # turn off mprotect (conflicts with tcg)
> +        self.console_wait(prompt)
> +        self.console_send("echo security.pax.mprotect.enabled=3D0 >> /=
etc/sysctl.conf\n")
> +
> +        self.print_step("Configuration finished, rebooting")
> +        self.console_wait_send(prompt, "reboot\n")
> +        self.console_wait("login:")
> +        self.wait_ssh()
> +
> +        self.print_step("Installing packages")
> +        self.ssh_root_check("pkgin update\n")
> +        self.ssh_root_check("pkgin -y install %s\n" % " ".join(self.pk=
gs))
> +
> +        # shutdown
> +        self.ssh_root(self.poweroff)
> +        self.console_wait("entering state S5")
> +        self.wait()
> +
> +        if os.path.exists(img):
> +            os.remove(img)
>           os.rename(img_tmp, img)
> +        os.remove(iso)
> +        self.print_step("All done")
>  =20
>   if __name__ =3D=3D "__main__":
>       sys.exit(basevm.main(NetBSDVM))
>=20

