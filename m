Received: from eggs.gnu.org ([2001:4830:134:3::10]:59199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBn1a-0007ng-J5
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBn1X-0002Ld-Fo
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:25:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eBn1X-0002LB-73
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:25:31 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA6JOMlo107850
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 14:25:24 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e2ue6gd6u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 14:25:24 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 6 Nov 2017 12:25:23 -0700
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
	<20171106183925.16747-25-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 6 Nov 2017 14:25:20 -0500
MIME-Version: 1.0
In-Reply-To: <20171106183925.16747-25-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6f4dd612-6749-e95c-5299-16e989fbba83@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 24/28] tpm-tis: check that at most one
 TPM device exists
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
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   hw/tpm/tpm_tis.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 175785b9c4..dccc56ab09 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -1057,6 +1057,11 @@ static void tpm_tis_realizefn(DeviceState *dev, =
Error **errp)
>   {
>       TPMState *s =3D TPM(dev);
>
> +    if (!tpm_find()) {
> +        error_setg(errp, "at most one TPM device is permitted");
> +        return;
> +    }
> +
>       s->be_driver =3D qemu_find_tpm_be(s->backend);
>       if (!s->be_driver) {
>           error_setg(errp, "backend driver with id %s could not be foun=
d",
