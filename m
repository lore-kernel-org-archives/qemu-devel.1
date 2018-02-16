Received: from eggs.gnu.org ([2001:4830:134:3::10]:32881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emkuh-0002Xe-8Y
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 13:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emkug-0004XH-HZ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 13:39:15 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emkug-0004X5-Ba
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 13:39:14 -0500
Received: by mail-oi0-x241.google.com with SMTP id a22so2984741oia.4
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 10:39:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180216173111.10270-1-dgilbert@redhat.com>
References: <20180216173111.10270-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2018 18:38:53 +0000
Message-ID: <CAFEAcA_0PBYwP_vCTT6dOYVoEwo0XGkGc_-ah5K+JSmewDpFOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] cuda.h: Fix multiple typedef
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 16 February 2018 at 17:31, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> RHEL6's compilers don't like the repeated typedef.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  include/hw/misc/macio/cuda.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/misc/macio/cuda.h b/include/hw/misc/macio/cuda.h
> index 6afbdd13ee..494b709579 100644
> --- a/include/hw/misc/macio/cuda.h
> +++ b/include/hw/misc/macio/cuda.h
> @@ -93,12 +93,12 @@ typedef struct CUDAState {
>  } CUDAState;
>
>  /* MOS6522 CUDA */
> -typedef struct MOS6522CUDAState {
> +struct MOS6522CUDAState {
>      /*< private >*/
>      MOS6522State parent_obj;
>
>      CUDAState *cuda;
> -} MOS6522CUDAState;
> +};
>
>  #define TYPE_MOS6522_CUDA "mos6522-cuda"
>  #define MOS6522_CUDA(obj) OBJECT_CHECK(MOS6522CUDAState, (obj), \
> --

Thanks; applied to master as a  buildfix.

-- PMM
