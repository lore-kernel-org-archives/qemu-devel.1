Received: from eggs.gnu.org ([2001:4830:134:3::10]:42814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1wUv-00044p-5x
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1wUp-0004wS-L9
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:31:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51534
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1wUp-0004wB-GP
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:31:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AFQFE8048545
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 11:30:59 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dgwp7mdr0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 11:30:58 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 09:30:57 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-10-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 11:30:54 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <792b870a-38ab-c32b-f36e-bc9117ea64e4@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/42] tpm: remove init() class method
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
> No backend use it.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   include/sysemu/tpm_backend.h | 2 --
>   backends/tpm.c               | 4 +---
>   2 files changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index a4288df038..b08f985500 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -66,8 +66,6 @@ struct TPMBackendClass {
>  =20
>       TPMBackend *(*create)(QemuOpts *opts, const char *id);
>  =20
> -    /* initialize the backend */
> -    int (*init)(TPMBackend *t);
>       /* start up the TPM on the backend */
>       int (*startup_tpm)(TPMBackend *t);
>  =20
> diff --git a/backends/tpm.c b/backends/tpm.c
> index ca3a78eea8..dc750d48c9 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -47,13 +47,11 @@ enum TpmType tpm_backend_get_type(TPMBackend *s)
>   int tpm_backend_init(TPMBackend *s, TPMState *state,
>                        TPMRecvDataCB *datacb)
>   {
> -    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
> -
>       s->tpm_state =3D state;
>       s->recv_data_callback =3D datacb;
>       s->had_startup_error =3D false;
>  =20
> -    return k->init ? k->init(s) : 0;
> +    return 0;
>   }
>  =20
>   int tpm_backend_startup_tpm(TPMBackend *s)
