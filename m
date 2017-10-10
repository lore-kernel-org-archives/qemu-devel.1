Received: from eggs.gnu.org ([2001:4830:134:3::10]:43035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1wVj-0004Td-AZ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1wVf-0005Lg-DF
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:31:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59002
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1wVf-0005LV-7l
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:31:55 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AFVRne067453
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 11:31:54 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dgwp7mf7b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 11:31:54 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 09:31:53 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-13-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 11:31:50 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-13-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <cfe08e95-5bce-d2fe-8633-d0d6ddccf7e8@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/42] tpm: remove needless cast
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
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>   hw/tpm/tpm_passthrough.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 5cd988e8a4..fed3d69799 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -96,7 +96,7 @@ static int tpm_passthrough_unix_tx_bufs(TPMPassthruSt=
ate *tpm_pt,
>  =20
>       is_selftest =3D tpm_util_is_selftest(in, in_len);
>  =20
> -    ret =3D qemu_write_full(tpm_pt->tpm_fd, (const void *)in, (size_t)=
in_len);
> +    ret =3D qemu_write_full(tpm_pt->tpm_fd, in, in_len);
>       if (ret !=3D in_len) {
>           if (!tpm_pt->tpm_op_canceled || errno !=3D ECANCELED) {
>               error_report("tpm_passthrough: error while transmitting d=
ata "
