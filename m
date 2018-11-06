Received: from eggs.gnu.org ([2001:4830:134:3::10]:51515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gK2JA-0002s4-SM
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gK2J6-0008Fu-IC
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:26:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gK2J2-00086L-N1
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:26:14 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA6EK7xE054579
	for <qemu-devel@nongnu.org>; Tue, 6 Nov 2018 09:26:07 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nk9xd07xq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 09:26:06 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Tue, 6 Nov 2018 14:26:05 -0000
References: <20181106052144.31841-1-ppandit@redhat.com>
	<20181106052144.31841-2-ppandit@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Tue, 6 Nov 2018 09:26:02 -0500
MIME-Version: 1.0
In-Reply-To: <20181106052144.31841-2-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
Message-Id: <7ef2e233-8413-8055-4282-4e6c46b2fa36@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] tpm: use loop iterator to set sts data
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On 11/6/18 12:21 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> When TIS request is done, set 'sts' data field across all localities.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   hw/tpm/tpm_tis.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 20126dd838..58d90645bc 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -299,7 +299,7 @@ static void tpm_tis_request_completed(TPMIf *ti, int ret)
>
>       if (s->cmd.selftest_done) {
>           for (l = 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
> -            s->loc[locty].sts |= TPM_TIS_STS_SELFTEST_DONE;
> +            s->loc[l].sts |= TPM_TIS_STS_SELFTEST_DONE;
>           }
>       }
>
