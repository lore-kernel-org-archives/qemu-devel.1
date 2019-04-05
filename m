Received: from eggs.gnu.org ([209.51.188.92]:53594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKls-0008LQ-Ql
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKaD-0004q4-7B
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:52:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCKaC-0004n8-FB
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:52:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so6283441wml.1
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 01:52:20 -0700 (PDT)
References: <155445151931.302073.18436485925081597460.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <942570eb-9057-7424-4cca-5ba4336344c2@redhat.com>
Date: Fri, 5 Apr 2019 10:52:18 +0200
MIME-Version: 1.0
In-Reply-To: <155445151931.302073.18436485925081597460.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] target/ppc/trace-events: Fix trivial
 typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 4/5/19 10:05 AM, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  target/ppc/trace-events |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/trace-events b/target/ppc/trace-events
> index 3858f97dff54..ed4d57c6d9c1 100644
> --- a/target/ppc/trace-events
> +++ b/target/ppc/trace-events
> @@ -1,5 +1,5 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>  
>  # kvm.c
> -kvm_failed_spr_set(int str, const char *msg) "Warning: Unable to set SPR %d to KVM: %s"
> -kvm_failed_spr_get(int str, const char *msg) "Warning: Unable to retrieve SPR %d from KVM: %s"
> +kvm_failed_spr_set(int spr, const char *msg) "Warning: Unable to set SPR %d to KVM: %s"
> +kvm_failed_spr_get(int spr, const char *msg) "Warning: Unable to retrieve SPR %d from KVM: %s"
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
