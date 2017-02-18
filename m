Received: from eggs.gnu.org ([2001:4830:134:3::10]:47861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfDhc-00079r-E6
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 17:42:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfDhb-0005HC-O5
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 17:42:04 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cfDhb-0005Fn-HR
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 17:42:03 -0500
Received: by mail-wm0-x233.google.com with SMTP id v77so30638067wmv.0
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 14:42:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1478452528-13684-8-git-send-email-joserz@linux.vnet.ibm.com>
References: <1478452528-13684-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1478452528-13684-8-git-send-email-joserz@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Feb 2017 22:41:41 +0000
Message-ID: <CAFEAcA9HTc9QH51w5yhNoMjLk3jB4aM+Zp2MWBDN+xGnqf-cOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH Risu v2 7/9] Add PPC64 in risu build system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 November 2016 at 17:15, Jose Ricardo Ziviani
<joserz@linux.vnet.ibm.com> wrote:
> Recognizes PPC64 as a valid architecture and setup the environment
> variables to compile code for that.
>
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  configure | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 748b48a..f81bdb5 100755
> --- a/configure
> +++ b/configure
> @@ -22,6 +22,12 @@ guess_arch() {
>          ARCH="arm"
>      elif check_define __aarch64__ ; then
>          ARCH="aarch64"
> +    elif check_define __powerpc64__ ; then
> +        if check_define __BIG_ENDIAN__; then
> +            ARCH="ppc64"
> +        else
> +            ARCH="ppc64le"
> +        fi

Does the BE ppc64 risu build work for you? I tried
installing the cross-compiler, but the build fails
because there's no risu_ppc64.c. (ppc64le works fine.)
If we don't support the big-endian variant yet maybe
we should drop it from the configure file.

thanks
-- PMM
