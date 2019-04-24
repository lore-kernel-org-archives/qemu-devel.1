Received: from eggs.gnu.org ([209.51.188.92]:33166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJEwp-00073a-9V
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJEwo-0004JO-7D
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:16:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJEwn-0004HG-W1
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:16:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so3845018wmj.3
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 03:16:13 -0700 (PDT)
References: <20190424094557.28404-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <042ac170-3fe9-61d5-6fdb-0a43e58b9b4c@redhat.com>
Date: Wed, 24 Apr 2019 12:16:11 +0200
MIME-Version: 1.0
In-Reply-To: <20190424094557.28404-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>
Cc: lvivier@redhat.com, pbonzini@redhat.com

On 4/24/19 11:45 AM, Thomas Huth wrote:
> Since we do not use gtester anymore (which had a bug here),
> we can now use g_test_skip() to mark skipped tests.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/tpm-tests.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
> index 582ec0cfd4..e640777aa9 100644
> --- a/tests/tpm-tests.c
> +++ b/tests/tpm-tests.c
> @@ -22,7 +22,7 @@ static bool
>  tpm_test_swtpm_skip(void)
>  {
>      if (!tpm_util_swtpm_has_tpm2()) {
> -        g_test_message("swtpm not in PATH or missing --tpm2 support");
> +        g_test_skip("swtpm not in PATH or missing --tpm2 support");
>          return true;
>      }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
