Received: from eggs.gnu.org ([2001:4830:134:3::10]:48283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e20ya-00062o-RK
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e20yX-0004dh-N6
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:18:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e20yX-0004dG-FM
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:18:01 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AKDqQT135798
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:17:57 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dh0pb05ya-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:17:57 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 14:17:56 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-24-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:17:53 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-24-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <debfea58-8bf2-2107-1cad-02a7a3b6f6f3@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 23/42] tpm-tis: no longer expose TPMState
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
> Now that there is an interface instead.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   include/sysemu/tpm.h | 2 --
>   hw/tpm/tpm_tis.c     | 4 ++--
>   2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index c8afa179e5..62b073beeb 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -14,8 +14,6 @@
>
>   #include "qemu/option.h"
>
> -typedef struct TPMState TPMState;
> -
>   int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
>   int tpm_init(void);
>   void tpm_cleanup(void);
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index c24be57136..b3757bfbda 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -72,7 +72,7 @@ typedef struct TPMLocality {
>       TPMSizedBuffer r_buffer;
>   } TPMLocality;
>
> -struct TPMState {
> +typedef struct TPMState {
>       ISADevice busdev;
>       MemoryRegion mmio;
>
> @@ -95,7 +95,7 @@ struct TPMState {
>       char *backend;
>       TPMBackend *be_driver;
>       TPMVersion be_tpm_version;
> -};
> +} TPMState;
>
>   #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
>
