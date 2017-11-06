Received: from eggs.gnu.org ([2001:4830:134:3::10]:47393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBmaL-0005Sk-F5
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBmaH-0006e6-JI
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:57:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eBmaH-0006dn-BE
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:57:21 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA6IsYNY006594
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 13:57:11 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e2ue6f1su-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 13:57:11 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 6 Nov 2017 13:57:10 -0500
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
	<20171106183925.16747-2-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 6 Nov 2017 13:57:07 -0500
MIME-Version: 1.0
In-Reply-To: <20171106183925.16747-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c1cdf8b0-0c60-1e57-0c8f-cfd9cf94d507@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/28] tpm-tis: remove unused
 locty_number
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

On 11/06/2017 01:38 PM, Marc-Andr=C3=A9 Lureau wrote:
> This field slipped in commit 5086bf9784.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   hw/tpm/tpm_tis.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 7402528b25..c5c534d7f2 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -89,7 +89,6 @@ struct TPMState {
>       qemu_irq irq;
>       uint32_t irq_num;
>
> -    uint8_t     locty_number;
>       TPMBackendCmd cmd;
>
>       char *backend;
