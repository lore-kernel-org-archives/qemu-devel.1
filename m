Received: from eggs.gnu.org ([2001:4830:134:3::10]:55002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dIGUZ-0003Fv-9K
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dIGUU-0002xD-9K
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:33:59 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149676256806.31274.17021734547869850899.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <37f6a7fe-cab7-24c1-0de0-b2387e7495ad@amsat.org>
Date: Tue, 6 Jun 2017 12:33:38 -0300
MIME-Version: 1.0
In-Reply-To: <149676256806.31274.17021734547869850899.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] target/ppc: pass const pointer to
 kvmppc_is_mem_backend_page_size_ok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 06/06/2017 12:22 PM, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/ppc/kvm.c     |    4 ++--
>  target/ppc/kvm_ppc.h |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 51249ce79e55..88817620766c 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -478,7 +478,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>      }
>  }
>
> -bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
> +bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
>  {
>      Object *mem_obj = object_resolve_path(obj_path, NULL);
>      char *mempath = object_property_get_str(mem_obj, "mem-path", NULL);
> @@ -499,7 +499,7 @@ static inline void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>  {
>  }
>
> -bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
> +bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
>  {
>      return true;
>  }
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index f48243d13ffc..fd72d6b05a98 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -64,7 +64,7 @@ int kvmppc_enable_hwrng(void);
>  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
>
> -bool kvmppc_is_mem_backend_page_size_ok(char *obj_path);
> +bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
>
>  #else
>
>
>
