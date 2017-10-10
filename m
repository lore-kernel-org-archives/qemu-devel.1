Received: from eggs.gnu.org ([2001:4830:134:3::10]:51469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e219o-0002xc-Be
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e219l-0001QW-7z
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:29:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e219k-0001Q4-VW
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:29:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AKTanr031254
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:29:36 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dh2s6r6xc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:29:35 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 16:29:34 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-31-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:29:30 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-31-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <bbf22711-efa3-75d6-83a1-284f368ff209@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 30/42] tpm-passthrough: pass
 TPMPassthruState to handle_device_opts
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
> It doesn't need TPMBackend. Also reorder arguments for consistency.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   hw/tpm/tpm_passthrough.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 048edb1a1a..9326cbfdc9 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -239,9 +239,9 @@ static int tpm_passthrough_open_sysfs_cancel(TPMPas=
sthruState *tpm_pt)
>       return fd;
>   }
>
> -static int tpm_passthrough_handle_device_opts(QemuOpts *opts, TPMBacke=
nd *tb)
> +static int
> +tpm_passthrough_handle_device_opts(TPMPassthruState *tpm_pt, QemuOpts =
*opts)
>   {
> -    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
>       const char *value;
>
>       value =3D qemu_opt_get(opts, "cancel-path");
> @@ -292,7 +292,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts =
*opts, const char *id)
>
>       tb->id =3D g_strdup(id);
>
> -    if (tpm_passthrough_handle_device_opts(opts, tb)) {
> +    if (tpm_passthrough_handle_device_opts(tpm_pt, opts)) {
>           goto err_exit;
>       }
>
