Received: from eggs.gnu.org ([2001:4830:134:3::10]:57821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cJbJn-0006oa-3y
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cJbJj-0000FK-WE
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:28:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cJbJj-0000FE-RB
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:28:03 -0500
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
	<1482255793-19057-5-git-send-email-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <584d77b6-f7dc-4a96-d7ee-fe8cba9cedea@redhat.com>
Date: Wed, 21 Dec 2016 08:27:59 +0100
MIME-Version: 1.0
In-Reply-To: <1482255793-19057-5-git-send-email-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 4/7] kvm: Include kvm-stub.o only on
 CONFIG_SOFTMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org

On 20.12.2016 18:43, Eduardo Habkost wrote:
> Now the stubs required by *-user are inside stubs/kvm.c, so
> kvm-stub.c is needed only by CONFIG_SOFTMMU.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: kvm@vger.kernel.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  Makefile.target | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile.target b/Makefile.target
> index 0b2ad86..5e78bb0 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -96,7 +96,6 @@ obj-y += target-$(TARGET_BASE_ARCH)/
>  obj-y += disas.o
>  obj-y += tcg-runtime.o
>  obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
> -obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
>  
>  obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decContext.o
>  obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decNumber.o
> @@ -138,6 +137,7 @@ obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
>  obj-y += qtest.o bootdevice.o
>  obj-y += hw/
>  obj-$(CONFIG_KVM) += kvm-all.o
> +obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
>  obj-y += memory.o cputlb.o
>  obj-y += memory_mapping.o
>  obj-y += dump.o

<bikeshedding>
IMHO you could also squash this change into the next patch (and just
mention it in the commit description).
</bikeshedding>

 Thomas
