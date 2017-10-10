Received: from eggs.gnu.org ([2001:4830:134:3::10]:39110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1kUI-0004f8-A2
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1kUF-0004iZ-7o
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1kUE-0004hw-UD
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:39 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9A2dlRe099159
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 22:41:35 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgg5d5xmy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 22:41:34 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 22:41:33 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-7-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 9 Oct 2017 22:41:29 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b67802aa-a765-37cc-df1f-cfd32145fa06@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/42] tpm: remove tpm_register_driver()
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
> No more users of be_drivers[], drop that too.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


> ---
>   include/sysemu/tpm_backend.h | 1 -
>   hw/tpm/tpm_emulator.c        | 1 -
>   hw/tpm/tpm_passthrough.c     | 1 -
>   tpm.c                        | 8 --------
>   4 files changed, 11 deletions(-)
>
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index c6e5637f68..adb6a68076 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -216,6 +216,5 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
>   TPMBackend *qemu_find_tpm(const char *id);
>  =20
>   void tpm_register_model(enum TpmModel model);
> -void tpm_register_driver(const TPMDriverOps *tdo);
>  =20
>   #endif
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 5ddd7238d2..9e24a5f30e 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -581,7 +581,6 @@ static const TypeInfo tpm_emulator_info =3D {
>   static void tpm_emulator_register(void)
>   {
>       type_register_static(&tpm_emulator_info);
> -    tpm_register_driver(&tpm_emulator_driver);
>   }
>  =20
>   type_init(tpm_emulator_register)
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index e6ace28b04..f04eab3e63 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -418,7 +418,6 @@ static const TypeInfo tpm_passthrough_info =3D {
>   static void tpm_passthrough_register(void)
>   {
>       type_register_static(&tpm_passthrough_info);
> -    tpm_register_driver(&tpm_passthrough_driver);
>   }
>  =20
>   type_init(tpm_passthrough_register)
> diff --git a/tpm.c b/tpm.c
> index ad2ed6a0da..75a589b837 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -23,7 +23,6 @@
>   static QLIST_HEAD(, TPMBackend) tpm_backends =3D
>       QLIST_HEAD_INITIALIZER(tpm_backends);
>  =20
> -static TPMDriverOps const *be_drivers[TPM_TYPE__MAX];
>   static bool tpm_models[TPM_MODEL__MAX];
>  =20
>   void tpm_register_model(enum TpmModel model)
> @@ -33,13 +32,6 @@ void tpm_register_model(enum TpmModel model)
>  =20
>   #ifdef CONFIG_TPM
>  =20
> -void tpm_register_driver(const TPMDriverOps *tdo)
> -{
> -    assert(!be_drivers[tdo->type]);
> -
> -    be_drivers[tdo->type] =3D tdo;
> -}
> -
>   static const TPMDriverOps *
>   tpm_driver_find_by_type(enum TpmType type)
>   {
