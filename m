Received: from eggs.gnu.org ([2001:4830:134:3::10]:53465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMZLf-0008Nh-77
	for qemu-devel@nongnu.org; Sat, 26 May 2018 09:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMZLe-0000Lu-Em
	for qemu-devel@nongnu.org; Sat, 26 May 2018 09:35:07 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fMZLe-0000Lj-9d
	for qemu-devel@nongnu.org; Sat, 26 May 2018 09:35:06 -0400
Received: by mail-oi0-x241.google.com with SMTP id a6-v6so6906235oia.2
	for <qemu-devel@nongnu.org>; Sat, 26 May 2018 06:35:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <305501d80a62cc12e0d82a2ffd656819badd0d4d.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<305501d80a62cc12e0d82a2ffd656819badd0d4d.1527310210.git.keno@alumni.harvard.edu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 26 May 2018 14:34:45 +0100
Message-ID: <CAFEAcA-dL_6vAWmo8kyVJWHLhH-oChmHO0zpcqz3tfSCiZAW5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 09/13] 9p: darwin: Provide a compatibility
 definition for XATTR_SIZE_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keno@juliacomputing.com
Cc: QEMU Developers <qemu-devel@nongnu.org>, Keno Fischer <keno@alumni.harvard.edu>, Greg Kurz <groug@kaod.org>

On 26 May 2018 at 06:23,  <keno@juliacomputing.com> wrote:
> From: Keno Fischer <keno@alumni.harvard.edu>
>
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  hw/9pfs/9p.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index f5f00aa..4ae4da6 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -3351,6 +3351,13 @@ out_nofid:
>      v9fs_string_free(&name);
>  }
>
> +#if defined(CONFIG_DARWIN) && !defined(XATTR_SIZE_MAX)
> +/* Darwin doesn't seem to define a maximum xattr size in its user
> +   user space header, but looking at the kernel source, HFS supports
> +   up to INT32_MAX, so use that as the maximum.
> +*/
> +#define XATTR_SIZE_MAX INT32_MAX
> +#endif

Do we really need the CONFIG_DARWIN part of this check?

thanks
-- PMM
