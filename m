Received: from eggs.gnu.org ([2001:4830:134:3::10]:37843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gK3Ap-0003In-Fc
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gK3Ak-0006pU-G4
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:21:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gK3Ag-0006mT-2U
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:21:39 -0500
References: <20181106151346.2728687-1-stefanb@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5f61727f-ab6e-9c84-5900-9c754da4af0e@redhat.com>
Date: Tue, 6 Nov 2018 16:21:10 +0100
MIME-Version: 1.0
In-Reply-To: <20181106151346.2728687-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: tpm: Use g_test_message rather than
 fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>

On 2018-11-06 16:13, Stefan Berger wrote:
> Display a message during the test using g_test_message rather
> than fprintf.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  tests/tpm-tests.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
> index 93a5beba01..5f217a2d92 100644
> --- a/tests/tpm-tests.c
> +++ b/tests/tpm-tests.c
> @@ -22,7 +22,7 @@ static bool
>  tpm_test_swtpm_skip(void)
>  {
>      if (!tpm_util_swtpm_has_tpm2()) {
> -        fprintf(stderr, "swtpm not in PATH or missing --tpm2 support; ");
> +        g_test_message("swtpm not in PATH or missing --tpm2 support; ");
>          return true;
>      }

I think I'd rather remove the semicolon at the end now. Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
