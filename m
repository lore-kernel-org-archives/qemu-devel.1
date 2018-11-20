Received: from eggs.gnu.org ([2001:4830:134:3::10]:60974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPCMG-0000GN-Aj
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPCMD-0007Yo-2e
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:10:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPCMC-0007VM-Pr
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:10:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so3338510wmc.1
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 12:10:48 -0800 (PST)
References: <20181120182721.227114-1-stefanb@linux.vnet.ibm.com>
	<20181120182721.227114-2-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <33969753-1937-307c-44e3-db27129f0035@redhat.com>
Date: Tue, 20 Nov 2018 21:10:45 +0100
MIME-Version: 1.0
In-Reply-To: <20181120182721.227114-2-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] tpm: Remove unused locty parameter
 from tpm_tis_abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, marcandre.lureau@gmail.com, ppandit@redhat.com

On 20/11/18 19:27, Stefan Berger wrote:
> Remove the unused locty parameter from tpm_tis_abort() function.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/tpm/tpm_tis.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index d9322692ee..176d424ed9 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -233,7 +233,7 @@ static void tpm_tis_new_active_locality(TPMState *s, uint8_t new_active_locty)
>   }
>   
>   /* abort -- this function switches the locality */
> -static void tpm_tis_abort(TPMState *s, uint8_t locty)
> +static void tpm_tis_abort(TPMState *s)
>   {
>       s->rw_offset = 0;
>   
> @@ -281,7 +281,7 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t locty, uint8_t newlocty)
>           }
>       }
>   
> -    tpm_tis_abort(s, locty);
> +    tpm_tis_abort(s);
>   }
>   
>   /*
> @@ -311,7 +311,7 @@ static void tpm_tis_request_completed(TPMIf *ti, int ret)
>       }
>   
>       if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
> -        tpm_tis_abort(s, locty);
> +        tpm_tis_abort(s);
>       }
>   
>       tpm_tis_raise_irq(s, locty,
> 
