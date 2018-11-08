Received: from eggs.gnu.org ([2001:4830:134:3::10]:53008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKi79-0003Bw-M6
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKi75-0007ID-Sm
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:04:41 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKi72-0007DC-3d
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:04:38 -0500
Received: by mail-ot1-x344.google.com with SMTP id g27so17732141oth.6
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 03:04:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1541674784-25936-3-git-send-email-lizhijian@cn.fujitsu.com>
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-3-git-send-email-lizhijian@cn.fujitsu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 11:04:10 +0000
Message-ID: <CAFEAcA8XBa2BSfWkSMyd-iQO_=RRcZ1atpUS3QnnoSoLHERkqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 2/3] change size type from int to
 int64_t on load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Philip Li <philip.li@intel.com>, zhijianx.li@intel.com

On 8 November 2018 at 10:59, Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
> allow load_image to load >= 2G file
>
> CC: Philip Li <philip.li@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  hw/core/loader.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index aa0b3fc..8fbc4bd 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -77,7 +77,8 @@ int64_t get_image_size(const char *filename)
>  /* deprecated, because caller does not specify buffer size! */
>  int load_image(const char *filename, uint8_t *addr)
>  {
> -    int fd, size;
> +    int fd;
> +    int64_t size;
>      fd = open(filename, O_RDONLY | O_BINARY);
>      if (fd < 0)
>          return -1;

This function returns "size", so changing the type of "size"
without also changing its return type looks wrong.

load_image_size() uses ssize_t here, which may be what we want.

thanks
-- PMM
