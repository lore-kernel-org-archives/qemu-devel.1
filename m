Received: from eggs.gnu.org ([2001:4830:134:3::10]:54011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e21Iw-0006II-K9
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e21Ir-0005uU-N8
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:39:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e21Ir-0005u8-Ev
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:39:01 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AKYe3f009937
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:38:57 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgyvnbkmd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:38:57 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 14:38:57 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-37-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:38:53 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-37-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <404ec545-bc2a-2895-51a3-d09ab5f0d485@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 36/42] tpm: rename qemu_find_tpm() ->
 qemu_find_tpm_be()
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

On 10/09/2017 06:56 PM, Marc-Andr=C3=A9 Lureau wrote:
> find_tpm() will be introduced to lookup the TPM device.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


> ---
>   include/sysemu/tpm_backend.h | 2 +-
>   hw/tpm/tpm_tis.c             | 2 +-
>   tpm.c                        | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index 881be97ee3..d02067e631 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -193,7 +193,7 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *=
s);
>    */
>   TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
>
> -TPMBackend *qemu_find_tpm(const char *id);
> +TPMBackend *qemu_find_tpm_be(const char *id);
>
>   void tpm_register_model(enum TpmModel model);
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index e7e8b112e8..954b7b0e5d 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -1055,7 +1055,7 @@ static void tpm_tis_realizefn(DeviceState *dev, E=
rror **errp)
>   {
>       TPMState *s =3D TPM(dev);
>
> -    s->be_driver =3D qemu_find_tpm(s->backend);
> +    s->be_driver =3D qemu_find_tpm_be(s->backend);
>       if (!s->be_driver) {
>           error_setg(errp, "tpm_tis: backend driver with id %s could no=
t be "
>                      "found", s->backend);
> diff --git a/tpm.c b/tpm.c
> index 37298f3f03..4d6c45a4f2 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -71,7 +71,7 @@ static void tpm_display_backend_drivers(void)
>   /*
>    * Find the TPM with the given Id
>    */
> -TPMBackend *qemu_find_tpm(const char *id)
> +TPMBackend *qemu_find_tpm_be(const char *id)
>   {
>       TPMBackend *drv;
>
