Received: from eggs.gnu.org ([2001:4830:134:3::10]:32928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1foNEI-0002A5-5n
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 02:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1foNEH-0005sT-98
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 02:18:26 -0400
References: <20180810224645.10659-1-hpoussin@reactos.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ff0d75af-553f-3e08-92e2-f434025204ea@ilande.co.uk>
Date: Sat, 11 Aug 2018 07:17:57 +0100
MIME-Version: 1.0
In-Reply-To: <20180810224645.10659-1-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: mark ppc/prep machine as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 10/08/18 23:46, Hervé Poussineau wrote:

> 40p machine type should be used instead.
> 
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>  qemu-deprecated.texi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 9920a85adc..9c7ff3fe2d 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -218,6 +218,12 @@ support page sizes < 4096 any longer.
>  These machine types are very old and likely can not be used for live migration
>  from old QEMU versions anymore. A newer machine type should be used instead.
>  
> +@subsection prep (PowerPC) (since 3.1)
> +
> +This machine type uses an unmaintained firmware, broken in lots of ways,
> +and unable to start post-2004 operating systems. 40p machine type should be
> +used instead.
> +
>  @section Device options
>  
>  @subsection Block device options

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
