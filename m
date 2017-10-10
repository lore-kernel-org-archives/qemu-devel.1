Received: from eggs.gnu.org ([2001:4830:134:3::10]:36830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1kPM-0000mN-Fz
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1kPJ-00006a-CC
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:36:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1kPJ-00005i-3E
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:36:33 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9A2Xc7o064400
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 22:36:29 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgk5jx4tg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 22:36:29 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 22:36:28 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-4-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 9 Oct 2017 22:36:26 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <81140f79-6e0e-f456-f4b8-4ae411ce97b7@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/42] tpm: make tpm_get_backend_driver()
 static
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
> No need to export the function.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


> ---
>   include/sysemu/tpm_backend.h | 1 -
>   tpm.c                        | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index 2c798a1eb4..c6e5637f68 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -215,7 +215,6 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
>
>   TPMBackend *qemu_find_tpm(const char *id);
>
> -const TPMDriverOps *tpm_get_backend_driver(const char *type);
>   void tpm_register_model(enum TpmModel model);
>   void tpm_register_driver(const TPMDriverOps *tdo);
>
> diff --git a/tpm.c b/tpm.c
> index 3122227156..bc7d7470a8 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -31,7 +31,7 @@ void tpm_register_model(enum TpmModel model)
>       tpm_models[model] =3D true;
>   }
>
> -const TPMDriverOps *tpm_get_backend_driver(const char *type)
> +static const TPMDriverOps *tpm_get_backend_driver(const char *type)
>   {
>       int i =3D qapi_enum_parse(&TpmType_lookup, type, -1, NULL);
>
