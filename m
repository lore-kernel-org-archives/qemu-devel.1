Received: from eggs.gnu.org ([2001:4830:134:3::10]:42803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsqVG-0004vu-6x
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsqVC-0004jK-UQ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:17:54 -0400
References: <150548133297.5945.7401220081077343726.stgit@bahia.lan>
	<150548135159.5945.17545667206379508322.stgit@bahia.lan>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <53a49b18-5b56-d931-b6f1-15df77186dfc@redhat.com>
Date: Fri, 15 Sep 2017 15:17:45 +0200
MIME-Version: 1.0
In-Reply-To: <150548135159.5945.17545667206379508322.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] ppc/kvm: drop kvmppc_has_cap_htab_fd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 15.09.2017 15:15, Greg Kurz wrote:
> It never got used since its introduction (commit 7c43bca004af).
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  target/ppc/kvm.c     |    5 -----
>  target/ppc/kvm_ppc.h |    6 ------
>  2 files changed, 11 deletions(-)
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 1deaf106d2b9..00d7029b8d7a 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2448,11 +2448,6 @@ bool kvmppc_has_cap_epr(void)
>      return cap_epr;
>  }
>  
> -bool kvmppc_has_cap_htab_fd(void)
> -{
> -    return cap_htab_fd;
> -}
> -
>  bool kvmppc_has_cap_fixup_hcalls(void)
>  {
>      return cap_fixup_hcalls;
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index f780e6ec7b72..08aab46c5a56 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -51,7 +51,6 @@ uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift);
>  #endif /* !CONFIG_USER_ONLY */
>  bool kvmppc_has_cap_epr(void);
>  int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function);
> -bool kvmppc_has_cap_htab_fd(void);
>  int kvmppc_get_htab_fd(bool write);
>  int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns);
>  int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
> @@ -246,11 +245,6 @@ static inline int kvmppc_define_rtas_kernel_token(uint32_t token,
>      return -1;
>  }
>  
> -static inline bool kvmppc_has_cap_htab_fd(void)
> -{
> -    return false;
> -}
> -
>  static inline int kvmppc_get_htab_fd(bool write)
>  {
>      return -1;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
