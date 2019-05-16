Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0944AC04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 05:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B792420818
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 05:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UE0FAhK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B792420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48749 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR8lN-0005c5-RY
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 01:17:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32991)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1hR8kW-0005Iu-6f
	for qemu-devel@nongnu.org; Thu, 16 May 2019 01:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1hR8kU-0004Aj-Cz
	for qemu-devel@nongnu.org; Thu, 16 May 2019 01:16:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:33173)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1hR8kU-00048k-0T
	for qemu-devel@nongnu.org; Thu, 16 May 2019 01:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1557983726;
	bh=bYthgUVTksZFZmBoDeKKZ42JMPO/2Sttj+6b7IRg+ko=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=UE0FAhK+FG5Nd27YcMZBfy8MSdbSTjonixiqzJ5PvpixGvr6H/4O+eLIimY1cNM7l
	itoj4JCHpvJ6NNK7DXLigXDKpYz5qCjfQZoohl1/6ONM/jFihYee/JdNYl82AJcbwM
	D3SvaZyPADX3shtrJj/YulnP6NsZv03FfLxbyAp0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.11.224.157] ([72.138.110.50]) by mail.gmx.com (mrgmx102
	[212.227.17.174]) with ESMTPSA (Nemesis) id 0MM0bQ-1hJR6P2Czs-007pPx;
	Thu, 16 May 2019 07:15:25 +0200
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190510104633.9428-1-kraxel@redhat.com>
	<20190510104633.9428-12-kraxel@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
	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
	4XSbcg==
Message-ID: <f0759724-7938-5159-03f0-396eb81a6be4@gmx.com>
Date: Thu, 16 May 2019 07:16:08 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190510104633.9428-12-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nFcTqIabEELJ5BXOTR74uclRegBYCxwJX"
X-Provags-ID: V03:K1:veSWZQQgLCFoJIUhgfPonGeZvp9BZs3+Dft78nVpYoL8Hrc0D8k
	rp1I/vzEmpk4M8HllRDk4HQoNjTtx1UcfZshla4E3e1CwPGMX7xb+kPUEFAlJpTDLkmw59T
	ndMJbssMWs/caTL36I6iiaVVFWaXxdCldl/UHQU12UPwFkhRHqOG6342BVWOjFMU6zuKkEg
	AbmVXfu7+/Kbc0CbhVbCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rjyiHI85pqs=:CzdY0wp0Bt7tOukdA2DnQu
	Ortbdsb1CYG+nNBb/pB/Bc3rYL7ch+rFhVovVm+U9pVHN/62JffX1OhuUpQrYR5RcttoVbpcp
	Bs1kVNBV7JEPjccvTZaIWUTyX0wVHSXa5tr3+XQsp9GW0IafeKCSuEw0tqMveUSIS1+utsdEV
	KHdNeoFmIu/ug8R8BstfvBhoMzdRPaSBiThVEQulFXefkp6LYlXSTb7FCnLl8bEnAyxsWC6Oa
	9uduiO4JdGS7v9Z8coAbURsPHCougraUBN3EYRD3vWvFUq5520AYW5m0MgKM3cZlwLGEujcmg
	LxhdqZFQuufCXLcFFNdtnaMUvL88XAneQ6fMwgAUSQ4btSBtnaUZS72SMjFqGYmDvKCOMJxFs
	dZnZMILkeItj5EtsOIm46XkblUn+wxwS96A5TiLj4gTAv3luJpS1O7OrOv8KOJ5osr7OxNxyZ
	lxFpglm9ng1WKQY8q1ZWd9V0hwanTkJ4u056y6IgjJ5AjI3eY2frco7mYMt3xdXb9+8wK9+jU
	5HJGGQUGXyZe7MKwFVw44X5mqZHw1k4wav5PVZrU8f42+wk+4IqkuD7LZM2cxTXb8sugKSN1V
	fxw+bq3fYy5yWYKz2vcHpliCH7aE4WHOnIgQxj4IvRXevLeLIHdwdo429P7NXEXGDU8KuSN99
	iXx0wcfiDUebKRbCwKEKLNyYwdgZGsKkB5p0ZQSpQ/eKQuyYPnva5J582p9hNwIN7UvvJpK0F
	fKYfbo+oavtgrG+M9LqcvJDymXXVyJ3+JA8Sb4TKSpIw2mOxt/wSUWuLEHxP63skk4iE+EYwq
	ZVuiF1tcnfs/SwMSj3hF3lGZEWyDOsjFWTmCAWkoKUCrrj48xlPu6r9bhTzqHWp4ddof3rZDd
	xqwXQeZPlAcK/hTdTvFm1/58nhSUMWm/xtKfbRyIpG6xwXvd1OSSTTXfCB3EBEvUaA5LLJeQN
	fJO0q0ZOFLg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.20
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 11/13] tests/vm: netbsd autoinstall,
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
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nFcTqIabEELJ5BXOTR74uclRegBYCxwJX
From: Kamil Rytarowski <n54@gmx.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Li-Wen Hsu <lwhsu@freebsd.org>, Fam Zheng <fam@euphon.net>,
 Ed Maste <emaste@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <f0759724-7938-5159-03f0-396eb81a6be4@gmx.com>
Subject: Re: [PATCH v2 11/13] tests/vm: netbsd autoinstall, using serial
 console
References: <20190510104633.9428-1-kraxel@redhat.com>
 <20190510104633.9428-12-kraxel@redhat.com>
In-Reply-To: <20190510104633.9428-12-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.05.2019 12:46, Gerd Hoffmann wrote:
> Instead of fetching the prebuilt image from patchew download the instal=
l
> iso and prepare the image locally.  Install to disk, using the serial
> console.  Create qemu user, configure ssh login.  Install packages
> needed for qemu builds.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Kamil Rytarowski <n54@gmx.com>

> ---
>  tests/vm/netbsd | 187 +++++++++++++++++++++++++++++++++++++++++++++---=

>  1 file changed, 177 insertions(+), 10 deletions(-)
>=20
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 4c6624ea5ed5..6dbfc1b0fbe3 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -2,10 +2,11 @@
>  #
>  # NetBSD VM image
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
> @@ -13,32 +14,198 @@
> =20
>  import os
>  import sys
> +import time
>  import subprocess
>  import basevm
> =20
>  class NetBSDVM(basevm.BaseVM):
>      name =3D "netbsd"
>      arch =3D "x86_64"
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
>      BUILD_SCRIPT =3D """
>          set -e;
> -        rm -rf /var/tmp/qemu-test.*
> -        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> +        rm -rf /home/qemu/qemu-test.*
> +        cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
> +        mkdir src build; cd src;
>          tar -xf /dev/rld1a;
> -        ./configure --python=3Dpython2.7 {configure_opts};
> +        cd ../build
> +        ../src/configure --python=3Dpython3.7 --disable-opengl {config=
ure_opts};
>          gmake --output-sync -j{jobs} {target} {verbose};
>      """
> +    poweroff =3D "/sbin/poweroff"
> =20
>      def build_image(self, img):
> -        cimg =3D self._download_with_cache("http://download.patchew.or=
g/netbsd-7.1-amd64.img.xz",
> -                                         sha256sum=3D'b633d565b0eac3d0=
2015cd0c81440bd8a7a8df8512615ac1ee05d318be015732')
> -        img_tmp_xz =3D img + ".tmp.xz"
> +        cimg =3D self._download_with_cache(self.link)
>          img_tmp =3D img + ".tmp"
> -        sys.stderr.write("Extracting the image...\n")
> -        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
> +        iso =3D img + ".install.iso"
> +
> +        self.print_step("Preparing iso and disk image")
> +        subprocess.check_call(["cp", "-f", cimg, iso])
> +        subprocess.check_call(["qemu-img", "create", "-f", "qcow2",
> +                               img_tmp, self.size])
> +
> +        self.print_step("Booting installer")
> +        self.boot(img_tmp, extra_args =3D [
> +            "-device", "VGA",
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
>          if os.path.exists(img):
>              os.remove(img)
>          os.rename(img_tmp, img)
> +        os.remove(iso)
> +        self.print_step("All done")
> =20
>  if __name__ =3D=3D "__main__":
>      sys.exit(basevm.main(NetBSDVM))
>=20



--nFcTqIabEELJ5BXOTR74uclRegBYCxwJX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlzc8hgACgkQS7MI6bAu
dmzDjg//TSjbAhCrE9vUToTeS+tNFQxp/Lz5c8gdapKCU19hgng/4D1/AwN54Qi+
dH5srztIahZDnOczSVsykaflpcWi3eYtQzB0Mk48eaXbryxm6l4puXu5RYroGbyq
wiAgOiUffmA3QOpW3BXxlgkIQJGU2MrEyFp+vsNhTgGGFDIRVF4eE/n1H6r6vTs2
Qu6+G0vlev9IPN4moylaiwjaiOsEddXe+LJ79VhfCEqh+G4Ww3k9Smbs4Z8ZZ8Ah
T0KhgPw+v1ldNw5jHdTIbt9OEpHXZjfzCe9c19NC7pow3HVl5B3Bxz9Mvto+oHyj
1TOySs7B0FbJAWo+T8ETOn+FdAEWLhdvYtQusc3df6rxj8ZaKL4SBAQ2KRyM5tr4
meEysp7PE17ONbhrWg9+VL/mV/DR9NNfKJiKEm+KZftX0GUGERmLxq5+D5HTwX+e
uC5CqYfCaeTUnAj7Rqp3LLbjzMDH7hvcwDfPElJtba/XdDxOIvmCvXVSIUOJiIib
6hn6v9XhKzM0CBKe5MnInbsxp+Q3UmCYdAYCqqwKQV/sI2U93euV8knra1JVCinl
eDcwxDeaaFFfnW2Z5ealaQciiiRAMk+h5sjili8A1nAts5tAZxfQjijV4TwGWT6B
9zfQBXbhLSLjVmr93rR4fKv0IpeEYkO2rwghihZjUpSuip0fVXw=
=ARW5
-----END PGP SIGNATURE-----

--nFcTqIabEELJ5BXOTR74uclRegBYCxwJX--

