Received: from eggs.gnu.org ([2001:4830:134:3::10]:49284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjpbI-0001HY-5d
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjpbH-0006vC-B7
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:58:36 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjpbH-0006uq-4U
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:58:35 -0500
Received: by mail-wr0-x236.google.com with SMTP id u48so76627141wrc.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 07:58:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
	<8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
	<20170303164426.42472535@bahia.lan>
	<AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 15:58:13 +0000
Message-ID: <CAFEAcA-_p_N8c+4tu98MgvQsCP3SV9RD9mLP-+kj9FypqCeuJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: Greg Kurz <groug@kaod.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 3 March 2017 at 15:55, G 3 <programmingkidx@gmail.com> wrote:
> Here is the patch. I think we should let Mark or some else test it to see if
> it does fix the problem before a real patch is submitted.
>
> ---
>  hw/9pfs/9p-util.h | 4 ++++
>  1 file changed, 4 insertions(+)

We can't take any patch without a Signed-off-by: line, not
even a three line one.

>
> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> index 091f3ce..254d2a9 100644
> --- a/hw/9pfs/9p-util.h
> +++ b/hw/9pfs/9p-util.h
> @@ -13,6 +13,10 @@
>  #ifndef QEMU_9P_UTIL_H
>  #define QEMU_9P_UTIL_H
>
> +#ifndef O_PATH
> +    #define O_PATH 0
> +#endif

Could use a comment explaining why it's OK to define it in
a way that means it's a no-op on hosts without it.

> +
>  static inline void close_preserve_errno(int fd)
>  {
>      int serrno = errno;
> --
> 2.10.2

thanks
-- PMM
