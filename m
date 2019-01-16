Received: from eggs.gnu.org ([209.51.188.92]:37665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjpre-0008Lf-Hh
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjprd-00081v-Gi
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:24:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gjprb-0007sy-Cl
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:24:33 -0500
References: <20190116173527.27741-1-anthony.perard@citrix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dd82518e-02e8-ba40-55da-156cb1a9798f@redhat.com>
Date: Wed, 16 Jan 2019 19:14:40 +0100
MIME-Version: 1.0
In-Reply-To: <20190116173527.27741-1-anthony.perard@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] accel: Allow to build QEMU without TCG or
 KVM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

On 16/01/19 18:35, Anthony PERARD wrote:
> Instead of deny build of QEMU without a default accelerator, simply
> report an error when the user haven't passed -accel or -machine accel=
> and TCG and KVM isn't builtin.
> 
> ./configure already check that at least one accelerator is available.
> 
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>  accel/accel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/accel.c b/accel/accel.c
> index 68b6d56323..0d5b370dfd 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -91,7 +91,9 @@ void configure_accelerator(MachineState *ms, const char *progname)
>  #elif defined(CONFIG_KVM)
>              accel = "kvm";
>  #else
> -#error "No default accelerator available"
> +            error_report("No accelerator selected and"
> +                         " no default accelerator available");
> +            exit(1);
>  #endif
>          }
>      }
> 

Queued, thanks.

Paolo
