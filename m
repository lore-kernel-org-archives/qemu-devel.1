Received: from eggs.gnu.org ([2001:4830:134:3::10]:45660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffmhf-0007ty-9G
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffmha-0003nA-Ak
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:41:15 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:39732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffmha-0003ms-58
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:41:10 -0400
Received: by mail-ua0-x241.google.com with SMTP id g18-v6so2937000uam.6
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 06:41:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180718093815.8104-1-berrange@redhat.com>
	<20180718093815.8104-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8ff3df41-6915-aa14-8fb2-7d5522f24835@amsat.org>
Date: Wed, 18 Jul 2018 10:41:05 -0300
MIME-Version: 1.0
In-Reply-To: <20180718093815.8104-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 3.0 1/4] tests: call qcrypto_init
 instead of gnutls_global_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

Hi Daniel,

On 07/18/2018 06:38 AM, Daniel P. Berrangé wrote:
> Calling qcrypto_init ensures that all relevant initialization is
> done. In particular this honours the debugging settings and thread
> settings.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/crypto-tls-x509-helpers.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/crypto-tls-x509-helpers.c b/tests/crypto-tls-x509-helpers.c
> index 173d4e28fb..70df68f5df 100644
> --- a/tests/crypto-tls-x509-helpers.c
> +++ b/tests/crypto-tls-x509-helpers.c
> @@ -21,6 +21,8 @@
>  #include "qemu/osdep.h"
>  
>  #include "crypto-tls-x509-helpers.h"
> +#include "crypto/init.h"
> +#include "qapi/error.h"

This include belongs to "crypto/init.h".

>  #include "qemu/sockets.h"
>  
>  #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
> @@ -95,7 +97,7 @@ static gnutls_x509_privkey_t test_tls_load_key(void)
>  
>  void test_tls_init(const char *keyfile)
>  {
> -    gnutls_global_init();
> +    qcrypto_init(&error_abort);
>  
>      if (asn1_array2tree(pkix_asn1_tab, &pkix_asn1, NULL) != ASN1_SUCCESS) {
>          abort();
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
