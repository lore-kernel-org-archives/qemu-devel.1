Received: from eggs.gnu.org ([209.51.188.92]:55195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1hKkZn-000776-Gk
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1hKkZl-00085i-N5
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:14:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1hKkZj-00084X-JG
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:14:41 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3SE3nw1124981
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 10:14:36 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s5421dbcb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 10:14:36 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Sun, 28 Apr 2019 15:14:35 +0100
References: <20190424094557.28404-1-thuth@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Sun, 28 Apr 2019 10:14:31 -0400
MIME-Version: 1.0
In-Reply-To: <20190424094557.28404-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
Message-Id: <1cc6c6b6-df8f-3278-8996-ee67d2f620b9@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] tests/tpm-tests: Use g_test_skip() to mark
 skipped tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lvivier@redhat.com

On 4/24/19 5:45 AM, Thomas Huth wrote:
> Since we do not use gtester anymore (which had a bug here),
> we can now use g_test_skip() to mark skipped tests.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   tests/tpm-tests.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
> index 582ec0cfd4..e640777aa9 100644
> --- a/tests/tpm-tests.c
> +++ b/tests/tpm-tests.c
> @@ -22,7 +22,7 @@ static bool
>   tpm_test_swtpm_skip(void)
>   {
>       if (!tpm_util_swtpm_has_tpm2()) {
> -        g_test_message("swtpm not in PATH or missing --tpm2 support");
> +        g_test_skip("swtpm not in PATH or missing --tpm2 support");
>           return true;
>       }
>   
