Received: from eggs.gnu.org ([2001:4830:134:3::10]:47515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5BSl-0002fe-GA
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5BSi-00014H-88
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:06:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52402
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5BSi-00012n-2y
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:06:16 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JE45wL083162
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 10:06:10 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dpusq7frt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 10:06:10 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 08:06:08 -0600
References: <20171019075031.25507-1-rjones@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 10:06:04 -0400
MIME-Version: 1.0
In-Reply-To: <20171019075031.25507-1-rjones@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <3edd9a86-24b4-c236-0153-899704336dde@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] tpm: Don't call tpm_cleanup unless
 CONFIG_TPM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, amarnath.valluri@intel.com, marcandre.lureau@gmail.com

On 10/19/2017 03:50 AM, Richard W.M. Jones wrote:
> When compiling with --disable-tpm:
>
>    ../vl.o: In function `main':
>    /home/rjones/d/qemu/vl.c:4908: undefined reference to `tpm_cleanup'
>
> This appears to have been introduced in commit c37cacabf228
> ("tpm: Move tpm_cleanup() to right place").
>
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


> ---
>   vl.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/vl.c b/vl.c
> index 0723835bbf..dbfd06d4bc 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4905,7 +4905,9 @@ int main(int argc, char **argv, char **envp)
>       res_free();
>
>       /* vhost-user must be cleaned up before chardevs.  */
> +#ifdef CONFIG_TPM
>       tpm_cleanup();
> +#endif
>       net_cleanup();
>       audio_cleanup();
>       monitor_cleanup();
