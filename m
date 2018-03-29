Received: from eggs.gnu.org ([2001:4830:134:3::10]:55132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f1V2J-0006wV-D5
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f1V2I-0000xt-E2
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:44:03 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f1V2I-0000xf-7X
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:44:02 -0400
Received: by mail-wr0-x244.google.com with SMTP id 80so4973081wrb.2
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 03:44:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522270761-29646-2-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1522270761-29646-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1522270761-29646-2-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 29 Mar 2018 12:44:00 +0200
Message-ID: <CAJ+F1CKekvS8ZRs82szfyJyiBk-VE4cmqFesDvtCPaxFoe=afQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] tpm: CRB: set the Idle flag by default
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

On Wed, Mar 28, 2018 at 10:59 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---

This is also the default state according to the spec.
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>  hw/tpm/tpm_crb.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index ef8b80e..e728b55 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -220,6 +220,8 @@ static void tpm_crb_reset(void *dev)
>
>      ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
>                       tpmRegValidSts, 1);
> +    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> +                     tpmIdle, 1);
>      ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>                       InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
>      ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> --
> 2.5.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
