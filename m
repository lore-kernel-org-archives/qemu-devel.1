Received: from eggs.gnu.org ([2001:4830:134:3::10]:49661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e2esd-0007fI-K7
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e2esc-0006MZ-TA
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:54:35 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:47863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1e2esc-0006MF-Nu
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:54:34 -0400
Received: by mail-oi0-x230.google.com with SMTP id h200so8907092oib.4
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 07:54:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507757851-12580-2-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507757851-12580-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1507757851-12580-2-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 12 Oct 2017 16:54:33 +0200
Message-ID: <CAJ+F1C+vz=frOoGAN2CpK+yOaewYey9y8zV1XBKHGvwKBj9U3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/4] tpm: print buffers received from
 TPM when debugging
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

On Wed, Oct 11, 2017 at 11:37 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/tpm/tpm_tis.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index d5118e7..9bf0bce 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -373,6 +373,8 @@ static void tpm_tis_receive_bh(void *opaque)
>      tis->loc[locty].r_offset =3D 0;
>      tis->loc[locty].w_offset =3D 0;
>
> +    tpm_tis_show_buffer(&tis->loc[locty].r_buffer, "tpm_tis: From TPM");
> +
>      if (TPM_TIS_IS_VALID_LOCTY(tis->next_locty)) {
>          tpm_tis_abort(s, locty);
>      }
> --
> 2.5.5
>



--=20
Marc-Andr=C3=A9 Lureau
