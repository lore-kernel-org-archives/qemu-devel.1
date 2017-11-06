Received: from eggs.gnu.org ([2001:4830:134:3::10]:58903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBn15-0007Tz-MI
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBn12-00023o-Jp
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:25:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46362
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eBn12-00023J-ET
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:25:00 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA6JOUvn062234
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 14:24:53 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e2udr00bn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 14:24:53 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 6 Nov 2017 12:24:51 -0700
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
	<20171106183925.16747-24-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 6 Nov 2017 14:24:48 -0500
MIME-Version: 1.0
In-Reply-To: <20171106183925.16747-24-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b365e955-b005-03c3-267e-a95185e863e8@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 23/28] tpm-tis: remove redundant
 'tpm_tis:' in error messages
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

On 11/06/2017 01:39 PM, Marc-Andr=C3=A9 Lureau wrote:
> The reported error message is already prefixed with the -device
> name & arguments.
>
> Before:
> qemu-system-x86_64: -device tpm-tis,id=3Dfoo,tpmdev=3Dfoo,irq=3D21: tpm=
_tis: IRQ 21 is outside valid range of 0 to 15
>
> After:
> qemu-system-x86_64: -device tpm-tis,id=3Dfoo,tpmdev=3Dfoo,irq=3D21: IRQ=
 21 is outside valid range of 0 to 15
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   hw/tpm/tpm_tis.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index d313347144..175785b9c4 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -1059,8 +1059,8 @@ static void tpm_tis_realizefn(DeviceState *dev, E=
rror **errp)
>
>       s->be_driver =3D qemu_find_tpm_be(s->backend);
>       if (!s->be_driver) {
> -        error_setg(errp, "tpm_tis: backend driver with id %s could not=
 be "
> -                   "found", s->backend);
> +        error_setg(errp, "backend driver with id %s could not be found=
",
> +                   s->backend);
>           return;
>       }
>
> @@ -1069,8 +1069,8 @@ static void tpm_tis_realizefn(DeviceState *dev, E=
rror **errp)
>       }
>
>       if (s->irq_num > 15) {
> -        error_setg(errp, "tpm_tis: IRQ %d for TPM TIS is outside valid=
 range "
> -                   "of 0 to 15", s->irq_num);
> +        error_setg(errp, "IRQ %d is outside valid range of 0 to 15",
> +                   s->irq_num);
>           return;
>       }
>
