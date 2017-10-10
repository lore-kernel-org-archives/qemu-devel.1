Received: from eggs.gnu.org ([2001:4830:134:3::10]:39204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1kUg-000593-UZ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1kUd-0004wl-SC
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:42:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1kUd-0004wK-Is
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:42:03 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9A2fqQ9084894
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 22:41:58 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgm9nkfk4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 22:41:58 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 22:41:57 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-8-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 9 Oct 2017 22:41:54 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d943f45d-a003-e5cc-ac08-9c4ae95a28e1@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/42] tpm: move TPMSizedBuffer to tpm_tis.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com

On 10/09/2017 06:55 PM, Marc-Andr=C3=A9 Lureau wrote:
> Close to where it's being used.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>



> ---
>   hw/tpm/tpm_tis.h             | 5 +++++
>   include/sysemu/tpm_backend.h | 5 -----
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
> index a1df41fa21..31e612a7f4 100644
> --- a/hw/tpm/tpm_tis.h
> +++ b/hw/tpm/tpm_tis.h
> @@ -37,6 +37,11 @@ typedef enum {
>       TPM_TIS_STATE_RECEPTION,
>   } TPMTISState;
>  =20
> +typedef struct TPMSizedBuffer {
> +    uint32_t size;
> +    uint8_t  *buffer;
> +} TPMSizedBuffer;
> +
>   /* locality data  -- all fields are persisted */
>   typedef struct TPMLocality {
>       TPMTISState state;
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index adb6a68076..63093551a1 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -66,11 +66,6 @@ struct TPMBackendClass {
>       void (*handle_request)(TPMBackend *s, TPMBackendCmd cmd);
>   };
>  =20
> -typedef struct TPMSizedBuffer {
> -    uint32_t size;
> -    uint8_t  *buffer;
> -} TPMSizedBuffer;
> -
>   struct TPMDriverOps {
>       enum TpmType type;
>       const QemuOptDesc *opts;
