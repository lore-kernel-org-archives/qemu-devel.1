Received: from eggs.gnu.org ([2001:4830:134:3::10]:44781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSj9C-0003ad-0O
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSj9B-0003ur-D8
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:47:58 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSj9A-0003sF-VP
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:47:57 -0500
Received: by mail-oi1-x241.google.com with SMTP id v6so4755959oif.2
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 05:47:56 -0800 (PST)
MIME-Version: 1.0
References: <1542765966-20244-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-2-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-3-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1542765966-20244-3-git-send-email-lizhijian@cn.fujitsu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 13:47:44 +0000
Message-ID: <CAFEAcA8pdUkPBYngX5_UKRf0OkGDtLZA99zMH07RWeRTh=+BvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/5] change load_image() reture type to
 ssize_t
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

On Wed, 21 Nov 2018 at 02:07, Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>
> This patch allow load_iamge to load >=2G file
>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  hw/core/loader.c    | 5 +++--
>  include/hw/loader.h | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index aa0b3fc..0d53229 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -75,9 +75,10 @@ int64_t get_image_size(const char *filename)
>
>  /* return the size or -1 if error */
>  /* deprecated, because caller does not specify buffer size! */
> -int load_image(const char *filename, uint8_t *addr)
> +ssize_t load_image(const char *filename, uint8_t *addr)
>  {
> -    int fd, size;
> +    int fd;
> +    ssize_t size;
>      fd = open(filename, O_RDONLY | O_BINARY);
>      if (fd < 0)
>          return -1;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

As the comment says, we should ideally move all the callers
to load_image_size(), though...

thanks
-- PMM
