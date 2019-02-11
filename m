Received: from eggs.gnu.org ([209.51.188.92]:53258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtBQd-0006Oy-C2
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:15:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtBQV-0001IV-94
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:15:13 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtBQQ-0001Ca-8n
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:15:07 -0500
Received: by mail-wr1-f45.google.com with SMTP id l9so4600007wrt.13
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 05:15:02 -0800 (PST)
References: <20190211130507.8710-1-alex.bennee@linaro.org>
	<20190211130507.8710-19-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <886bfe9a-afa8-4c38-e9b7-b0584add7976@redhat.com>
Date: Mon, 11 Feb 2019 14:14:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190211130507.8710-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 18/18] tests/vm: Be verbose while extracting
 compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

On 2/11/19 2:05 PM, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Depending of the host hardware, copying and extracting VM images can
> take up to few minutes. Add verbosity to avoid the user to worry about
> VMs hanging.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

This one had:
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

> Message-Id: <20190129175403.18017-2-philmd@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> diff --git a/tests/vm/centos b/tests/vm/centos
> index daa2dbca03..ba133ea429 100755
> --- a/tests/vm/centos
> +++ b/tests/vm/centos
> @@ -65,8 +65,9 @@ class CentosVM(basevm.BaseVM):
>      def build_image(self, img):
>          cimg = self._download_with_cache("https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
>          img_tmp = img + ".tmp"
> +        sys.stderr.write("Extracting the image...\n")
>          subprocess.check_call(["cp", "-f", cimg, img_tmp + ".xz"])
> -        subprocess.check_call(["xz", "-df", img_tmp + ".xz"])
> +        subprocess.check_call(["xz", "-dvf", img_tmp + ".xz"])
>          subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
>          self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
>          self.wait_ssh()
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 1d64c31b7c..b0066017a6 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -33,8 +33,9 @@ class FreeBSDVM(basevm.BaseVM):
>                  sha256sum='adcb771549b37bc63826c501f05121a206ed3d9f55f49145908f7e1432d65891')
>          img_tmp_xz = img + ".tmp.xz"
>          img_tmp = img + ".tmp"
> +        sys.stderr.write("Extracting the image...\n")
>          subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-df", img_tmp_xz])
> +        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
>          if os.path.exists(img):
>              os.remove(img)
>          os.rename(img_tmp, img)
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index a2c3d13af4..4c6624ea5e 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -33,8 +33,9 @@ class NetBSDVM(basevm.BaseVM):
>                                           sha256sum='b633d565b0eac3d02015cd0c81440bd8a7a8df8512615ac1ee05d318be015732')
>          img_tmp_xz = img + ".tmp.xz"
>          img_tmp = img + ".tmp"
> +        sys.stderr.write("Extracting the image...\n")
>          subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-df", img_tmp_xz])
> +        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
>          if os.path.exists(img):
>              os.remove(img)
>          os.rename(img_tmp, img)
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index cfe0572c59..2105c01a26 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -35,8 +35,9 @@ class OpenBSDVM(basevm.BaseVM):
>                  sha256sum='8c6cedc483e602cfee5e04f0406c64eb99138495e8ca580bc0293bcf0640c1bf')
>          img_tmp_xz = img + ".tmp.xz"
>          img_tmp = img + ".tmp"
> +        sys.stderr.write("Extracting the image...\n")
>          subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-df", img_tmp_xz])
> +        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
>          if os.path.exists(img):
>              os.remove(img)
>          os.rename(img_tmp, img)
> 
