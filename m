Received: from eggs.gnu.org ([209.51.188.92]:60522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyuZd-0000Mm-Ly
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyuZc-0007pk-T3
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:28:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gyuZc-0007p3-JR
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:28:16 -0500
References: <1550847320-25110-1-git-send-email-jasowang@redhat.com>
	<1550847320-25110-10-git-send-email-jasowang@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <954908bc-c5fd-9073-e137-dd4057c792ea@redhat.com>
Date: Wed, 27 Feb 2019 09:28:08 +0100
MIME-Version: 1.0
In-Reply-To: <1550847320-25110-10-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 09/13] hmp: Add hmp_announce_self
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Vladislav Yasevich <vyasevic@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 22/02/2019 15.55, Jason Wang wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Add an HMP command to trigger self annocements.
> Unlike the QMP command (which takes a set of parameters), the HMP
> command reuses the set of parameters used for migration.
> 
> Signend-off-by: Vladislav Yasevich <vyasevic@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hmp-commands.hx  | 14 ++++++++++++++
>  hmp.c            |  5 +++++
>  hmp.h            |  1 +
>  tests/test-hmp.c |  1 +
>  4 files changed, 21 insertions(+)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index ba71558..9f812bc 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -931,6 +931,20 @@ stops because the size limit is reached.
>  ETEXI
>  
>      {
> +        .name       = "announce_self",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "Trigger GARP/RARP announcements",
> +        .cmd        = hmp_announce_self,
> +    },
> +
> +STEXI
> +@item announce_self
> +@findex announce_self
> +Trigger GARP/RARP announcements.
> +ETEXI

The help text is incredibly sparse. I doubt that the average user
manages to find out the meaning of this command just by looking at this
short information. Also, shouldn't you mention here that the parameters
used for migration are re-used here, like in the patch description?
Thus, could you please send a follow-up patch to increase that
information here a little bit, please?

 Thanks,
  Thomas
