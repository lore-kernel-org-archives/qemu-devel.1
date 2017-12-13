Received: from eggs.gnu.org ([2001:4830:134:3::10]:35151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eP4FG-0000XP-Oh
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:26:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eP4FC-000468-W4
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:26:34 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:42798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eP4FC-00045M-P9
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:26:30 -0500
Received: by mail-wm0-x236.google.com with SMTP id b199so3988499wme.1
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 02:26:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510371554-29833-3-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510371554-29833-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510371554-29833-3-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 13 Dec 2017 11:26:29 +0100
Message-ID: <CAJ+F1CJA_T0DiA5B5dLpV8QD6cqCEHxLeqkuXc6dWP_TC4PCdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] tpm_tis: Return 0 for every register
 in case of failure mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

Hi Stefan

On Sat, Nov 11, 2017 at 4:39 AM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Rather than returning ~0, return 0 for every register in case of
> failure mode. The '0' is better to indicate that there's no device
> there.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_tis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index eca3374..d0bdd96 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -519,7 +519,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwadd=
r addr,
>      uint8_t v;
>
>      if (tpm_backend_had_startup_error(s->be_driver)) {
> -        return val;
> +        return 0;
>      }

it's not obvious to me why it's better. Could you detail a bit more the rea=
son?

why not change the initialization of val instead?

>
>      switch (offset) {
> --
> 2.5.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
