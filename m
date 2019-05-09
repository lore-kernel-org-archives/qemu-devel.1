Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E58BC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027BB2084E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027BB2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53320 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOhkn-0008T8-6k
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 08:02:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOhjT-0007bx-F7
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOhjM-00009I-OG
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:01:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hOhjL-00008H-E0
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:00:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 452CC307B977;
	Thu,  9 May 2019 12:00:53 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-115.ams2.redhat.com [10.36.116.115])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 67E0C665F2;
	Thu,  9 May 2019 12:00:32 +0000 (UTC)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190508085645.11595-1-kraxel@redhat.com>
	<20190508085645.11595-13-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <12c8586d-5f43-f35c-0c43-939e535f93e9@redhat.com>
Date: Thu, 9 May 2019 14:00:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508085645.11595-13-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 09 May 2019 12:00:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 12/13] tests/vm: fedora autoinstall,
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
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
	Ed Maste <emaste@freebsd.org>, David Hildenbrand <david@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/05/2019 10.56, Gerd Hoffmann wrote:
> Download the install iso and prepare the image locally.  Install to
> disk, using the serial console.  Create qemu user, configure ssh login.
> Install packages needed for qemu builds.
>=20
> Yes, we have docker images for fedora.  But for trouble-shooting it
> might be helpful to have a vm too.  When vm builds fail you can use
> it to figure whenever the vm setup or the guest os is the problem.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/vm/basevm.py        |   9 +-
>  tests/vm/Makefile.include |   3 +-
>  tests/vm/fedora           | 187 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 197 insertions(+), 2 deletions(-)
>  create mode 100755 tests/vm/fedora
[...]
> diff --git a/tests/vm/fedora b/tests/vm/fedora
> new file mode 100755
> index 000000000000..d8cb62c803a4
> --- /dev/null
> +++ b/tests/vm/fedora
> @@ -0,0 +1,187 @@
> +#!/usr/bin/env python
> +#
> +# FreeBSD VM image
> +#
> +# Copyright 2017 Red Hat Inc.
> +#
> +# Authors:
> +#  Fam Zheng <famz@redhat.com>

All the above information needs some update, obviously.

> +class FedoraVM(basevm.BaseVM):
> +    name =3D "fedora"
> +    arch =3D "x86_64"
> +
> +    base =3D "http://dl.fedoraproject.org/pub/fedora/linux/releases/30=
/"
> +    link =3D base + "Server/x86_64/iso/Fedora-Server-netinst-x86_64-30=
-1.2.iso"
> +    repo =3D base + "Server/x86_64/os/"
> +    full =3D base + "Everything/x86_64/os/"
> +    csum =3D "5e4eac4566d8c572bfb3bcf54b7d6c82006ec3c6c882a2c9235c6d34=
94d7b100"
> +    size =3D "20G"
> +    pkgs =3D [
> +        # tools
> +        'git',
> +        'flex', 'bison',
> +        'gcc', 'binutils', 'make',
> +
> +        # perl
> +        'perl-Test-Harness',
> +
> +        # libs: usb
> +        '"pkgconfig(libusb-1.0)"',
> +        '"pkgconfig(libusbredirparser-0.5)"',
> +
> +        # libs: crypto
> +        '"pkgconfig(gnutls)"',
> +
> +        # libs: ui
> +        '"pkgconfig(sdl2)"',
> +        '"pkgconfig(gtk+-3.0)"',
> +        '"pkgconfig(ncursesw)"',
> +
> +        # libs: audio
> +        '"pkgconfig(libpulse)"',
> +        '"pkgconfig(alsa)"',
> +    ]
> +
> +    BUILD_SCRIPT =3D """
> +        set -e;
> +        rm -rf /home/qemu/qemu-test.*
> +        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
> +        mkdir src build; cd src;
> +        tar -xf /dev/vdb;
> +        cd ../build
> +        ../src/configure --python=3Dpython3 {configure_opts};
> +        gmake --output-sync -j{jobs} {target} {verbose};
> +    """
> +
> +    def build_image(self, img):
> +        self.print_step("Downloading install iso")
> +        cimg =3D self._download_with_cache(self.link, sha256sum=3Dself=
.csum)
> +        img_tmp =3D img + ".tmp"
> +        iso =3D img + ".install.iso"
> +
> +        self.print_step("Preparing iso and disk image")
> +        subprocess.check_call(["cp", "-f", cimg, iso])
> +        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
> +                               img_tmp, self.size])
> +
> +        self.print_step("Booting installer")
> +        self.boot(img_tmp, extra_args =3D [
> +            "-machine", "graphics=3Doff",
> +            "-cdrom", iso
> +        ])
> +        self.console_init(300)
> +        self.console_wait("installation process.")
> +        time.sleep(0.3)
> +        self.console_send("\t")
> +        time.sleep(0.3)
> +        self.console_send(" console=3DttyS0")
> +        proxy =3D os.environ.get("http_proxy")
> +        if not proxy is None:
> +            self.console_send(" proxy=3D%s" % proxy)
> +        self.console_send(" inst.repo=3D%s" % self.repo)
> +        self.console_send("\n")
> +
> +        self.console_wait_send("2) Use text mode",         "2\n")
> +
> +        self.console_wait_send("5) [!] Installation Dest", "5\n")
> +        self.console_wait_send("1) [x]",                   "c\n")
> +        self.console_wait_send("2) [ ] Use All Space",     "2\n")
> +        self.console_wait_send("2) [x] Use All Space",     "c\n")
> +        self.console_wait_send("1) [ ] Standard Part",     "1\n")
> +        self.console_wait_send("1) [x] Standard Part",     "c\n")
> +
> +        self.console_wait_send("7) [!] Root password",     "7\n")
> +        self.console_wait("Password:")
> +        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_wait("Password (confirm):")
> +        self.console_send("%s\n" % self.ROOT_PASS)
> +
> +        self.console_wait_send("8) [ ] User creation",     "8\n")
> +        self.console_wait_send("1) [ ] Create user",       "1\n")
> +        self.console_wait_send("3) User name",             "3\n")
> +        self.console_wait_send("ENTER:", "%s\n" % self.GUEST_USER)
> +        self.console_wait_send("4) [ ] Use password",      "4\n")
> +        self.console_wait_send("5) Password",              "5\n")
> +        self.console_wait("Password:")
> +        self.console_send("%s\n" % self.GUEST_PASS)
> +        self.console_wait("Password (confirm):")
> +        self.console_send("%s\n" % self.GUEST_PASS)
> +        self.console_wait_send("7) Groups",                "c\n")
> +
> +        while True:
> +            good =3D self.console_wait("3) [x] Installation",
> +                                     "3) [!] Installation")
> +            self.console_send("r\n")
> +            if good:
> +                break
> +            time.sleep(10)
> +
> +        while True:
> +            good =3D self.console_wait("4) [x] Software",
> +                                     "4) [!] Software")
> +            self.console_send("r\n")
> +            if good:
> +                break
> +            time.sleep(10)
> +            self.console_send("r\n" % self.GUEST_PASS)
> +
> +        self.console_wait_send("'b' to begin install",     "b\n")
> +
> +        self.print_step("Installation started now, this will take a wh=
ile")
> +
> +        self.console_wait_send("Installation complete",    "\n")
> +        self.print_step("Installation finished, rebooting")
> +
> +        # setup qemu user
> +        prompt =3D " ~]$"
> +        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS=
)
> +        self.console_wait_send(prompt, "exit\n")
> +
> +        # setup root user
> +        prompt =3D " ~]#"
> +        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
> +        self.console_sshd_config(prompt)
> +
> +        # setup virtio-blk #1 (tarfile)
> +        self.console_wait(prompt)
> +        self.console_send("echo 'KERNEL=3D=3D\"vdb\" MODE=3D\"666\"' >=
> %s\n" %
> +                          "/etc/udev/rules.d/99-qemu.rules")
> +
> +        self.print_step("Configuration finished, rebooting")
> +        self.console_wait_send(prompt, "reboot\n")
> +        self.console_wait("login:")
> +        self.wait_ssh()
> +
> +        self.print_step("Installing packages")
> +        self.ssh_root_check("rm -vf /etc/yum.repos.d/fedora*.repo\n")
> +        self.ssh_root_check("echo '[fedora]' >> /etc/yum.repos.d/qemu.=
repo\n")
> +        self.ssh_root_check("echo 'baseurl=3D%s' >> /etc/yum.repos.d/q=
emu.repo\n" % self.full)
> +        self.ssh_root_check("echo 'gpgcheck=3D0' >> /etc/yum.repos.d/q=
emu.repo\n")
> +        self.ssh_root_check("dnf install -y %s\n" % " ".join(self.pkgs=
))
> +
> +        # shutdown
> +        self.ssh_root("poweroff")
> +        self.console_wait("sleep state S5")
> +        self.wait()
> +
> +        if os.path.exists(img):
> +            os.remove(img)
> +        os.rename(img_tmp, img)
> +        os.remove(iso)
> +        self.print_step("All done")
> +
> +if __name__ =3D=3D "__main__":
> +    sys.exit(basevm.main(FedoraVM))
>=20

Maybe you could also do a kickstart installation instead?

 Thomas

