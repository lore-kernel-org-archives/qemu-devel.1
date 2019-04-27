Received: from eggs.gnu.org ([209.51.188.92]:54779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hKPZt-0004cl-Sd
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 11:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hKPZs-0005TF-KM
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 11:49:25 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hKPZq-0005Ow-NC
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 11:49:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id k9so2251794oig.9
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 08:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190427131857.11600-1-philmd@redhat.com>
In-Reply-To: <20190427131857.11600-1-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 27 Apr 2019 17:49:07 +0200
Message-ID: <CAMxuvayZ-woUZPxnav8EXSVGGADxeJjhDs1bgzPAzNLMGFgTsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/tpm: Only build tpm_ppi.o if any of
 TPM_TIS/TPM_CRB is built
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.ibm.com>

Hi

On Sat, Apr 27, 2019 at 3:19 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The TPM Physical Presence Interface routines are only used
> by the CRB/TIS interfaces. Do not compile this file if any
> of them is built.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Marc-Andr=C3=A9:
>   You might want to add yourself as reviewer/maintainer of TPM ;)

yes, I suppose Stefan wouldn't mind having me as R: :)

> ---
>  hw/tpm/Makefile.objs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> index 700c8786228..de0b85d02ae 100644
> --- a/hw/tpm/Makefile.objs
> +++ b/hw/tpm/Makefile.objs
> @@ -1,5 +1,5 @@
> -common-obj-y +=3D tpm_util.o
> -obj-y +=3D tpm_ppi.o
> +common-obj-$(CONFIG_TPM) +=3D tpm_util.o
> +obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) +=3D tpm_ppi.o
>  common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
>  common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
>  common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
> --
> 2.20.1
>
