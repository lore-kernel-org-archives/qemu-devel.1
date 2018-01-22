Received: from eggs.gnu.org ([2001:4830:134:3::10]:37232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1edkul-0000ro-5n
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 17:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1edkuk-0003K5-DY
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 17:50:07 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:43214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1edkuk-0003Jo-71
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 17:50:06 -0500
Received: by mail-wm0-x244.google.com with SMTP id g1so19249463wmg.2
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 14:50:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516656818-31834-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1516656818-31834-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 Jan 2018 23:50:04 +0100
Message-ID: <CAJ+F1C+YEPQqLTM7Q375USd9bEkCJBRoQyi+2R0Kz0zBPOpXbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tpm: Set the flags of the CMD_INIT command
 to 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Mon, Jan 22, 2018 at 10:33 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> The flags of the CMD_INIT control channel command were not
> initialized properly. Fix this and set to 0.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/tpm/tpm_emulator.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 35c78de..532d3e3 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -320,7 +320,9 @@ static int tpm_emulator_set_buffer_size(TPMBackend *t=
b,
>  static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
>  {
>      TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
> -    ptm_init init;
> +    ptm_init init =3D {
> +        .u.req.init_flags =3D 0,
> +    };
>      ptm_res res;
>
>      if (buffersize !=3D 0 &&
> --
> 2.5.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
