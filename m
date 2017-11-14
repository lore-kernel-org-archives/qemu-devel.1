Received: from eggs.gnu.org ([2001:4830:134:3::10]:40351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eEkvj-0008Fn-Sj
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eEkvj-0002Yf-3p
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:47:47 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:54752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eEkvi-0002X8-Sv
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:47:47 -0500
Received: by mail-wm0-x242.google.com with SMTP id r68so25407563wmr.3
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 15:47:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510696349-5151-4-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510696349-5151-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510696349-5151-4-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Nov 2017 00:47:44 +0100
Message-ID: <CAJ+F1CLEUxM=BRnxOtni2-VU10Ho7mvzcSAMP3S2MLQtjwSbrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 3/3] tpm_tis: Return 0 for
 every register in case of failure mode
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

Hi

On Tue, Nov 14, 2017 at 10:52 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Rather than returning ~0, return 0 for every register in case of
> failure mode. The '0' is better to indicate that there's no device
> there.

For most registers, 0 makes more sense. However, I wonder if we
shouldn't just fail to start qemu in this case...

Not convincing me this is 2.11 material either. Does this fix a specific bu=
g?

> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_tis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index fec2fc6..42d647d 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -545,7 +545,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwadd=
r addr,
>      uint8_t v;
>
>      if (tpm_backend_had_startup_error(s->be_driver)) {
> -        return val;
> +        return 0;
>      }
>
>      switch (offset) {
> --
> 2.5.5
>



--=20
Marc-Andr=C3=A9 Lureau
