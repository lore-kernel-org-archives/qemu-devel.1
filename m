Received: from eggs.gnu.org ([2001:4830:134:3::10]:41245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUCUr-0008D1-FE
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:20:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUCUq-0005uc-6b
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:20:25 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gUCUq-0005uO-0n
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:20:24 -0500
Received: by mail-wm1-x341.google.com with SMTP id s14so10044516wmh.1
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 07:20:23 -0800 (PST)
MIME-Version: 1.0
References: <20181204150427.2459814-1-stefanb@linux.vnet.ibm.com>
	<20181204150427.2459814-4-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20181204150427.2459814-4-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Dec 2018 19:20:10 +0400
Message-ID: <CAJ+F1CJWe256jdxg9R_Td8U-UxgPQ_3dxkz3auJu7Z54FaxQoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] tpm: Make sure the locality
 received from backend is valid
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
> Make sure that the locality passed from the backend to
> tpm_tis_request_completed() is valid.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/tpm/tpm_tis.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 04e4ad9212..2563d7501f 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -295,6 +295,8 @@ static void tpm_tis_request_completed(TPMIf *ti, int =
ret)
>      uint8_t locty =3D s->cmd.locty;
>      uint8_t l;
>
> +    assert(TPM_TIS_IS_VALID_LOCTY(locty));
> +
>      if (s->cmd.selftest_done) {
>          for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
>              s->loc[l].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
> --
> 2.17.1
>


--=20
Marc-Andr=C3=A9 Lureau
