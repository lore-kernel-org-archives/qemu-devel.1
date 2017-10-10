Received: from eggs.gnu.org ([2001:4830:134:3::10]:42864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1wVC-0004BU-Oe
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1wV7-00051a-0M
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:31:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1wV6-00051D-Kr
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:31:20 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AFUrtP131748
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 11:31:15 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgxvtqfxy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 11:31:15 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 09:31:14 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-11-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 11:31:11 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0eb7e5ad-9f6e-9aa8-d0f7-0cc3d70a3d3e@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/42] tpm: remove configure_tpm() hop
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
>   tpm.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/tpm.c b/tpm.c
> index 4882501bd7..45520f555d 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -86,7 +86,7 @@ TPMBackend *qemu_find_tpm(const char *id)
>       return NULL;
>   }
>  =20
> -static int configure_tpm(QemuOpts *opts)
> +static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
>   {
>       const char *value;
>       const char *id;
> @@ -145,11 +145,6 @@ static int configure_tpm(QemuOpts *opts)
>       return 0;
>   }
>  =20
> -static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
> -{
> -    return configure_tpm(opts);
> -}
> -
>   /*
>    * Walk the list of TPM backend drivers that are in use and call thei=
r
>    * destroy function to have them cleaned up.
