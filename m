Received: from eggs.gnu.org ([2001:4830:134:3::10]:58218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eqRYH-0003v4-NA
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 17:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eqRYE-0006nr-FX
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 17:47:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33240
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eqRYE-0006ne-9U
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 17:47:18 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1QMhthV100705
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 17:47:16 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gcqjf0jfc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 17:47:16 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 26 Feb 2018 15:47:15 -0700
References: <1517264719-18288-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1517264719-18288-2-git-send-email-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 26 Feb 2018 17:47:12 -0500
MIME-Version: 1.0
In-Reply-To: <1517264719-18288-2-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <91e6c534-f97e-3af2-57d3-68a69db3fe3e@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 1/6] tpm: Set the flags of the CMD_INIT
 command to 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, marcandre.lureau@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Michael, can you please apply this patch to stable?

git cherry-pick 302705876

Regards,
    Stefan


> The flags of the CMD_INIT control channel command were not
> initialized properly. Fix this and set to 0.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/tpm/tpm_emulator.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 35c78de..532d3e3 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -320,7 +320,9 @@ static int tpm_emulator_set_buffer_size(TPMBackend =
*tb,
>   static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize=
)
>   {
>       TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
> -    ptm_init init;
> +    ptm_init init =3D {
> +        .u.req.init_flags =3D 0,
> +    };
>       ptm_res res;
>  =20
>       if (buffersize !=3D 0 &&
