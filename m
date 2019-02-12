Received: from eggs.gnu.org ([209.51.188.92]:55731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gtWmH-0006ik-M7
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:03:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gtWmG-00049H-Rg
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:03:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44124
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gtWmG-00046S-Ig
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:03:04 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CC0afr103294
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 07:03:03 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qkwpwgctf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 07:03:02 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Tue, 12 Feb 2019 12:03:02 -0000
References: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
	<1549897385-10091-3-git-send-email-liam.merwick@oracle.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Tue, 12 Feb 2019 07:02:57 -0500
MIME-Version: 1.0
In-Reply-To: <1549897385-10091-3-git-send-email-liam.merwick@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
Message-Id: <396d72fd-890d-dd08-d431-93ba1a18297f@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tpm_tis: fix format string
 specifier in tpm_tis_show_buffer()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org

On 2/11/19 10:03 AM, Liam Merwick wrote:
> cppcheck reports:
>
> [hw/tpm/tpm_tis.c:113]: (warning) %d in format string (no. 2) requires 'int' but the argument type is 'unsigned int'
>
> Fix this by using %u instead of %d
>
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   hw/tpm/tpm_tis.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 860c2ace7d99..395500e8a61d 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -110,7 +110,7 @@ static void tpm_tis_show_buffer(const unsigned char *buffer,
>       uint32_t len, i;
>   
>       len = MIN(tpm_cmd_get_size(buffer), buffer_size);
> -    printf("tpm_tis: %s length = %d\n", string, len);
> +    printf("tpm_tis: %s length = %u\n", string, len);
>       for (i = 0; i < len; i++) {
>           if (i && !(i % 16)) {
>               printf("\n");
