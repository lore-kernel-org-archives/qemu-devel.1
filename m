Received: from eggs.gnu.org ([2001:4830:134:3::10]:46163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFfjy-0007xe-1O
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFfjx-0006GQ-7c
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:55:10 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFfjx-0006F4-0e
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:55:09 -0400
Received: by mail-wm0-x22a.google.com with SMTP id d127so94730499wmf.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 04:55:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170524091315.20284-1-drjones@redhat.com>
References: <20170524091315.20284-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 12:54:45 +0100
Message-ID: <CAFEAcA9dZecVJFBEvU5D9Qm3E7irn4s-v+Ma7jPiR5bNJ2nMUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] load_uboot_image: don't assume a full
 header read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 24 May 2017 at 10:13, Andrew Jones <drjones@redhat.com> wrote:
> Don't allow load_uboot_image() to proceed when less bytes than
> header-size was read.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/core/loader.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index bf17b42cbec2..f72930ca4a41 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -611,8 +611,9 @@ static int load_uboot_image(const char *filename, hwaddr *ep, hwaddr *loadaddr,
>          return -1;
>
>      size = read(fd, hdr, sizeof(uboot_image_header_t));
> -    if (size < 0)
> +    if (size < sizeof(uboot_image_header_t)) {
>          goto out;
> +    }
>
>      bswap_uboot_header(hdr);
>



Applied to target-arm.next, thanks.

-- PMM
