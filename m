Received: from eggs.gnu.org ([2001:4830:134:3::10]:47949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWHNF-00030M-78
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWHNE-0006WT-AM
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:24:53 -0400
References: <20180621180224.8312-1-f4bug@amsat.org>
	<20180621180224.8312-5-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cbfadf4b-e3ef-e7bc-921b-2926c270f51f@redhat.com>
Date: Fri, 22 Jun 2018 10:24:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180621180224.8312-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/11] hw/dma/omap_dma: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 21.06.2018 20:02, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/dma/omap_dma.c | 66 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 24 deletions(-)
[...]
>      case 0x78:	/* DMA4_GCR */
>          s->gcr =3D value & 0x00ff00ff;
> -	if ((value & 0xff) =3D=3D 0x00)		/* MAX_CHANNEL_FIFO_DEPTH */
> -            fprintf(stderr, "%s: wrong FIFO depth in GCR\n", __func__)=
;
> +        if ((value & 0xff) =3D=3D 0x00) {
> +            /* MAX_CHANNEL_FIFO_DEPTH */
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: wrong FIFO depth in GC=
R\n",
> +                          __func__);
> +        }
>          return;

Not sure, but doesn't that MAX_CHANNEL_FIFO_DEPTH comment rather belong
to the if-statement than to the print statement? If so, could you please
leave it at the end of the line?

 Thomas
