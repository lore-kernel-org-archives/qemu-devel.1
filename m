Received: from eggs.gnu.org ([209.51.188.92]:55106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1hKkZB-0006xB-2W
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1hKkZ9-0007tQ-4L
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:14:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57104
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1hKkZ7-0007rL-5r
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:14:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3SE3m0M108135
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 10:13:57 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s54cgvq9f-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 10:13:57 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Sun, 28 Apr 2019 15:13:56 +0100
References: <20190427131857.11600-1-philmd@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Sun, 28 Apr 2019 10:13:51 -0400
MIME-Version: 1.0
In-Reply-To: <20190427131857.11600-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <719d89b9-c206-7a55-6230-2a2a65d69007@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/tpm: Only build tpm_ppi.o if any of
 TPM_TIS/TPM_CRB is built
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 4/27/19 9:18 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> The TPM Physical Presence Interface routines are only used
> by the CRB/TIS interfaces. Do not compile this file if any
> of them is built.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
> Marc-Andr=C3=A9:
>    You might want to add yourself as reviewer/maintainer of TPM ;)
> ---
>   hw/tpm/Makefile.objs | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> index 700c8786228..de0b85d02ae 100644
> --- a/hw/tpm/Makefile.objs
> +++ b/hw/tpm/Makefile.objs
> @@ -1,5 +1,5 @@
> -common-obj-y +=3D tpm_util.o
> -obj-y +=3D tpm_ppi.o
> +common-obj-$(CONFIG_TPM) +=3D tpm_util.o
> +obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) +=3D tpm_ppi.o
>   common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
>   common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
>   common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
