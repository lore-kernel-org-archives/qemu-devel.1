Received: from eggs.gnu.org ([2001:4830:134:3::10]:57540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIGbj-0007o8-S8
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIGbf-0006S3-TG
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:41:23 -0400
References: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149676257351.31274.10816877292939465521.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <43823f43-4de4-514d-1e33-75a74b25d33c@redhat.com>
Date: Tue, 6 Jun 2017 17:41:15 +0200
MIME-Version: 1.0
In-Reply-To: <149676257351.31274.10816877292939465521.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] target/ppc: fix memory leak in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 06.06.2017 17:22, Greg Kurz wrote:
> The string returned by object_property_get_str() is dynamically allocated.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  target/ppc/kvm.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 88817620766c..f2f7c531bc7b 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -486,6 +486,7 @@ bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
>  
>      if (mempath) {
>          pagesize = qemu_mempath_getpagesize(mempath);
> +        g_free(mempath);
>      } else {
>          pagesize = getpagesize();
>      }
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
