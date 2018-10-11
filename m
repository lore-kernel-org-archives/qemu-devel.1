Received: from eggs.gnu.org ([2001:4830:134:3::10]:41786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAbmY-00039b-0O
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAbmR-0007MR-A0
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:17:41 -0400
Date: Thu, 11 Oct 2018 16:17:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181011161707.3be6ae43.cohuck@redhat.com>
In-Reply-To: <1539264723-741-1-git-send-email-thuth@redhat.com>
References: <1539264723-741-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x: Include the tod-qemu also for
 builds with --disable-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, 11 Oct 2018 15:32:03 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The device is required for running qtests, see hw/s390x/tod.c:
> 
> void s390_init_tod(void)
> {
>     Object *obj;
> 
>     if (kvm_enabled()) {
>         obj = object_new(TYPE_KVM_S390_TOD);
>     } else {
>         obj = object_new(TYPE_QEMU_S390_TOD);
>     }
>     [...]
>   }
> 
> During qtests, we're running without kvm, so TYPE_QEMU_S390_TOD is
> required to avoid that QEMU aborts here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Fixes: 8046f374a6 ("s390x/tod: factor out TOD into separate device")

> ---
>  hw/s390x/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index 5dbc00c..0efc64c 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -26,8 +26,8 @@ obj-$(call lnot,$(CONFIG_PCI)) += s390-pci-stub.o
>  obj-y += s390-skeys.o
>  obj-y += s390-stattrib.o
>  obj-y += tod.o
> +obj-y += tod-qemu.o
>  obj-$(CONFIG_KVM) += tod-kvm.o
> -obj-$(CONFIG_TCG) += tod-qemu.o
>  obj-$(CONFIG_KVM) += s390-skeys-kvm.o
>  obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
>  obj-y += s390-ccw.o

Thanks, applied.
