Received: from eggs.gnu.org ([2001:4830:134:3::10]:41082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUCUM-0007wo-K5
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUCUL-0005c5-OR
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:19:54 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gUCUL-0005bG-HT
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:19:53 -0500
Received: by mail-wm1-x343.google.com with SMTP id m22so9749130wml.3
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 07:19:53 -0800 (PST)
MIME-Version: 1.0
References: <20181204150427.2459814-1-stefanb@linux.vnet.ibm.com>
	<20181204150427.2459814-3-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20181204150427.2459814-3-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Dec 2018 19:19:39 +0400
Message-ID: <CAJ+F1CLMFMNrs_r5Fk=6JcJsQuEdXR807_D3ENybHr8MCphJ0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/3] tpm: Make sure new locality passed
 to tpm_tis_prep_abort() is valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>, stefanb@linux.ibm.com

On Tue, Dec 4, 2018 at 7:04 PM Stefan Berger <stefanb@linux.vnet.ibm.com> w=
rote:
>
> Make sure that the new locality passed to tpm_tis_prep_abort()
> is valid.
>
> Add a comment to aborting_locty that it may be any locality, including
> TPM_TIS_NO_LOCALITY.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/tpm/tpm_tis.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 176d424ed9..04e4ad9212 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -263,7 +263,9 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t l=
octy, uint8_t newlocty)
>  {
>      uint8_t busy_locty;
>
> -    s->aborting_locty =3D locty;
> +    assert(TPM_TIS_IS_VALID_LOCTY(newlocty));
> +
> +    s->aborting_locty =3D locty; /* may also be TPM_TIS_NO_LOCALITY */
>      s->next_locty =3D newlocty;  /* locality after successful abort */
>
>      /*
> --
> 2.17.1
>


--=20
Marc-Andr=C3=A9 Lureau
