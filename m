Received: from eggs.gnu.org ([2001:4830:134:3::10]:48655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emk6t-0000RV-A7
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emk6o-00014j-EV
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:47:47 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:45020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emk6o-00014b-99
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:47:42 -0500
Received: by mail-qt0-x241.google.com with SMTP id f18so4725780qth.11
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 09:47:42 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180216173111.10270-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c130702e-137c-25d4-2182-3b3ab9ec35c8@amsat.org>
Date: Fri, 16 Feb 2018 14:47:38 -0300
MIME-Version: 1.0
In-Reply-To: <20180216173111.10270-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] cuda.h: Fix multiple typedef
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk

On 02/16/2018 02:31 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> RHEL6's compilers don't like the repeated typedef.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
> 
