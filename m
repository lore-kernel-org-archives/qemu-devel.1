Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E351C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 19:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3452089E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 19:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TAEuCf13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3452089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42900 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOSI0-0003ou-Rq
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 15:31:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39051)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1hOSGk-0002as-KC
	for qemu-devel@nongnu.org; Wed, 08 May 2019 15:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1hOSGi-00027e-Sg
	for qemu-devel@nongnu.org; Wed, 08 May 2019 15:30:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:56559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1hOSGi-00027A-Ha
	for qemu-devel@nongnu.org; Wed, 08 May 2019 15:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1557343804;
	bh=5zYqrS28eRxsfvvoNuSqw9h331xB53aEWFRw6dzNKK0=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=TAEuCf1342o0b9dsEm867UhBYiNo79XQgQViZV4s6DBMn2VwoIYGRXnb6yfMujvmF
	eaX45Moq11qLDpGLBkzRV8LPxBrH/PUxxUoCE09cduHJE3D8iDAieZG3SizFSsi1oP
	Et4/9ix29eucUZqSn8HpLtAtHtCmJJmMSJ4/8Da8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx105
	[212.227.17.174]) with ESMTPSA (Nemesis) id 1M1ps8-1hQe7V20jo-002GxF;
	Wed, 08 May 2019 21:30:04 +0200
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190508085645.11595-1-kraxel@redhat.com>
	<20190508085645.11595-12-kraxel@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <461b0a0f-2843-afc3-6289-db08d6415771@gmx.com>
Date: Wed, 8 May 2019 21:30:18 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190508085645.11595-12-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CV82An4uCpMv5m8lfgLKLPxJKTX9IpFs9"
X-Provags-ID: V03:K1:efhxpYCoofwmGFdB7JmnKLtqodNiAy7OIEuz5J6H4e5jDCYYuVh
	/XA/tsGlxvzN7IspVF+HxiCOFOaw2oUH1DvtqSpG1KOK1JVmBk9jOQkbrW3t7aeGQzJU8YW
	DgNtYKg6UB7wuizW+vv58r2SKnrnC/4ZDATFqP1ge21ovobuRPyny96Qu3AzQPGMsxwhDij
	tTw16RtJm72NeGqUmT+XQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ppSIXEwDh6g=:A2PEH522fYVDEllw/QwXyl
	ClhctFQLf+kF+4kg4LcNRAhbf+xi0ISB2+PUpmNTwAxiOp6ttr5cONi5+3Rc/Bv1thdbP/QZB
	YI+yLxquPqnQ6bs0Oi3WNCDxGBjHsZR85m63MfKcjIJKM8utDszzmKhlI7frSAAGpKfpUqqD8
	tnDsvYG8d1idQl6RK1HV4D4Rs52T5PHhu9BWQSzBDymPt1FcvPInbPL9blwMnv6ZX9sRlcZZO
	mRu2dtT8hjzznmAbHYwXnMWd4nfWuyLrOATrql2vRHc/PM3CcDqnCKOYfjAmAUXXz9j1TiCoB
	C+H1/AJg+Q+ZmBMoWQvpqdaye0WoPufTuPVm30Y09LMH2PZw97XEkNg7Mku505G/2oJIpq+AI
	LsDZkvsBWzdjtUENMgCXsnYAw+3mSrgmzoVgpgco+KaWD3GQbvD/jL1fsZAi4tidezq94UFfy
	26keja5bKGxvr3BSiS6MpqckDgUV3hXBgtTc0pfRvFUkrACPke1/pLU0XRl6TiVQncjQZsjsW
	ZEsNJchRy6wYhxWvy1pPvaTOExF6QMTYS30P8dCNKPKd2eEhSS/aq8iX6sD/FDXmSeRByQu/M
	j1A5XWO/w99jMBcCDEyrV4jbqFJ8EfBhh4s3GmOd4LJ/esRPEOxbf58R7L4kXQMkAke5GUTDh
	QUYuj2pjTxDfa6dbsJ1DSykofigouBP1wEadnxMGhI+8mRowccK1bpTiVxWDgk5WQkxzKZNRZ
	EMMkuMu6SK/kWvddYEB4NhwPHgP9x0t8m+XxCp2BRV3TlcLnhMsn4Hvm//2cdVV9ZUvQS/0Re
	9bTJNLTX1bv0ednD7z3UpqmgTO0c5Evup6uaFL+uSG7psjgsVOyGuiUeITuQAyk0Ipnn213yR
	lfTEsSlI8mAxedL0fW/GtPbPPrF+CTUDjClCfUzeE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.20
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 11/13] tests/vm: netbsd autoinstall,
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
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CV82An4uCpMv5m8lfgLKLPxJKTX9IpFs9
From: Kamil Rytarowski <n54@gmx.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Message-ID: <461b0a0f-2843-afc3-6289-db08d6415771@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 11/13] tests/vm: netbsd autoinstall, using
 serial console
References: <20190508085645.11595-1-kraxel@redhat.com>
 <20190508085645.11595-12-kraxel@redhat.com>
In-Reply-To: <20190508085645.11595-12-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.2019 10:56, Gerd Hoffmann wrote:
> Instead of fetching the prebuilt image from patchew download the instal=
l
> iso and prepare the image locally.  Install to disk, using the serial
> console.  Create qemu user, configure ssh login.  Install packages
> needed for qemu builds.
>=20

I recommend to add one extra step into generated image:

echo security.pax.mprotect.enabled=3D0 >> /etc/sysctl.conf

Alternatively (and preferably) enhance qemu to handle RWX allocation for
JIT on NetBSD.

Example in libffi.

https://github.com/libffi/libffi/commit/2bfcd29955c02b67fa10a68cc4200f683=
8181e0f

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/vm/netbsd | 178 +++++++++++++++++++++++++++++++++++++++++++++---=

>  1 file changed, 169 insertions(+), 9 deletions(-)
>=20
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 4c6624ea5ed5..eaf0ae21db42 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -13,32 +13,192 @@
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
> +        "git",
> +        "pkgconf",
> +        "bzip2", "xz",
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
> +        ../src/configure --python=3Dpython2.7 --disable-opengl {config=
ure_opts};
>          gmake --output-sync -j{jobs} {target} {verbose};
>      """
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
> +        self.ssh_root("/sbin/poweroff")
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



--CV82An4uCpMv5m8lfgLKLPxJKTX9IpFs9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlzTLkoMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZstb4P+QEBuJFRzOls6RMZ0E5tXuq6yhEC685vOoLaUAIm
Tl/xfORlYIi6vRmHla4JW04qx8YpQmBgkjRJQwHQMhfgLrSRwgt1QJ4xN4Q0CFAJ
gmU+VENDLaDBehJoSprxroNJzjacmukNjttXJgN4uqVMk8e2dPYaKMxoTNqOTx2n
rdEpvOAiLIs3YuZGIPOvZ1mgJ+NAPzDV8qOrQ7YrhJ/BLegfz2RfYlO9HFAp+eet
hRpSVXTzTClYa1j5Cbb99lkzZ5HxxIPsc9ZqbZ2aVTQP2D75K/yA53OXRXZi/uPh
sNWmJ3R3zHyzYXRX3kTXy5M36+MEq9+GGzNB6Y4PPJsdh/ZMCmVPUxrLaAwVdIGH
RcQdtNS/pFOe7lvnq2FXJ5fWWvlhJHcnMzz9LaahjhEUtvw+nxF7ptcLKEMVLmTm
/AWuuxLhBfEiqHHJWqqFAB6zdsjbLSIvsGNvW760+KzqhQQ2f6oRGw3s0CkQcuHU
P2DuGsEDjBMSpSmmpNucRzW2CLNQUh8jVMI2/IA5Xiihu18y6QbDjd0OimAyp8mW
/dSxz41lEpc3msY11Qn6MM5nQ15LQKdgxyMpzUlNhFJ5lxqDm/e8khaFtWwXFVmf
lrP/VpYDVQstMNbwBc6Z9hOW944Pq7g8A1vCDTQKTxICduKGtT2q3NnwGpY3WdLq
lZau
=jm/4
-----END PGP SIGNATURE-----

--CV82An4uCpMv5m8lfgLKLPxJKTX9IpFs9--

