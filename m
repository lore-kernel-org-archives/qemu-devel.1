Received: from eggs.gnu.org ([2001:4830:134:3::10]:55085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQuVs-0000Gi-4e
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQuVo-000067-Vn
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:27:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eQuVo-00005h-Pz
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:27:16 -0500
References: <20171218121635.25494-1-cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <deba612d-e6f0-7181-6328-7eec81f68034@redhat.com>
Date: Mon, 18 Dec 2017 13:27:09 +0100
MIME-Version: 1.0
In-Reply-To: <20171218121635.25494-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tpm: add stubs for qdev-prop-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, stefanb@linux.vnet.ibm.com
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org

On 18/12/2017 13:16, Cornelia Huck wrote:
> Building with --disable-tpm yields
> 
> ../hw/core/qdev-properties-system.o: In function `set_tpm':
> /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:274: undefined reference to `qemu_find_tpm_be'
> /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:278: undefined reference to `tpm_backend_init'
> ../hw/core/qdev-properties-system.o: In function `release_tpm':
> /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:291: undefined reference to `tpm_backend_reset'
> 
> Add some proper stubs for those functions.
> 
> Fixes: 493b78303532 ("qdev: add DEFINE_PROP_TPMBE")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Maybe all the new code can be moved from qdev-properties-system.c to
hw/tpm/qdev.c instead?  (Adding stubs should be the last resort,
especially if the stubs are never used outside system emulation).

Thanks,

Paolo

> ---
>  stubs/tpm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/stubs/tpm.c b/stubs/tpm.c
> index c18aac1c73..97457e0646 100644
> --- a/stubs/tpm.c
> +++ b/stubs/tpm.c
> @@ -7,6 +7,7 @@
>  #include "qemu/osdep.h"
>  #include "sysemu/tpm.h"
>  #include "qmp-commands.h"
> +#include "sysemu/tpm_backend.h"
>  
>  int tpm_init(void)
>  {
> @@ -31,3 +32,17 @@ TpmModelList *qmp_query_tpm_models(Error **errp)
>  {
>      return NULL;
>  }
> +
> +TPMBackend *qemu_find_tpm_be(const char *id)
> +{
> +    return NULL;
> +}
> +
> +int tpm_backend_init(TPMBackend *s, TPMIf *tpmif, Error **errp)
> +{
> +    return -1;
> +}
> +
> +void tpm_backend_reset(TPMBackend *s)
> +{
> +}
> 
