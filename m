Received: from eggs.gnu.org ([2001:4830:134:3::10]:59244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gJwZt-00028l-EF
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gJwUw-0008He-4V
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:14:06 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gJwUv-0008Gi-UJ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:14:06 -0500
Received: by mail-wm1-x344.google.com with SMTP id w7-v6so10666305wmc.1
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 00:14:05 -0800 (PST)
MIME-Version: 1.0
References: <20181106052144.31841-1-ppandit@redhat.com>
	<20181106052144.31841-2-ppandit@redhat.com>
In-Reply-To: <20181106052144.31841-2-ppandit@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Nov 2018 12:13:52 +0400
Message-ID: <CAJ+F1C+EdebPX5jo0k7hh4nw1vL2hT9TOec3_b6AvizNQyfZ0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] tpm: use loop iterator to set sts data
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

Hi

On Tue, Nov 6, 2018 at 9:24 AM P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> When TIS request is done, set 'sts' data field across all localities.

The code certainly meant to set the field across all localities.
However I don't see in the "TCG PC Client Specific TPM Interface
Specification (TIS)" where it states that the field should be set
across all localities. Could you quote the relevant part?

thanks

> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/tpm/tpm_tis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 20126dd838..58d90645bc 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -299,7 +299,7 @@ static void tpm_tis_request_completed(TPMIf *ti, int =
ret)
>
>      if (s->cmd.selftest_done) {
>          for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
> -            s->loc[locty].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
> +            s->loc[l].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
>          }
>      }
>
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau
