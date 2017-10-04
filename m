Received: from eggs.gnu.org ([2001:4830:134:3::10]:49757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dzjnU-0001WE-3M
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dzjnP-0001O4-6M
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:33:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33620
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dzjnP-0001Ne-0I
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:33:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94DWGHZ089465
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 09:33:02 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dcukvhjp2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 09:33:01 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 07:33:01 -0600
References: <1506683421-27004-1-git-send-email-amarnath.valluri@intel.com>
	<1506683421-27004-10-git-send-email-amarnath.valluri@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 4 Oct 2017 09:32:57 -0400
MIME-Version: 1.0
In-Reply-To: <1506683421-27004-10-git-send-email-amarnath.valluri@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <93ea456a-09f4-cbf8-1cfe-b80664872c34@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v10 9/9] tpm: Move tpm_cleanup() to right
 place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, Paolo Bonzini <pbonzini@redhat.com>

On 09/29/2017 07:10 AM, Amarnath Valluri wrote:
> As Emulator TPM backend uses chardev, tpm cleanup should happen before chardev
> similar to other vhost-users.
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   tpm.c | 1 -
>   vl.c  | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tpm.c b/tpm.c
> index 3b8c7ed..3122227 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -172,7 +172,6 @@ int tpm_init(void)
>           return -1;
>       }
>
> -    atexit(tpm_cleanup);
>       return 0;
>   }
>
> diff --git a/vl.c b/vl.c
> index 9bb5058..ed86209 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4893,6 +4893,7 @@ int main(int argc, char **argv, char **envp)
>       res_free();
>
>       /* vhost-user must be cleaned up before chardevs.  */
> +    tpm_cleanup();
>       net_cleanup();
>       audio_cleanup();
>       monitor_cleanup();
