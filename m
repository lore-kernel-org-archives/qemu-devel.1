Received: from eggs.gnu.org ([2001:4830:134:3::10]:41399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cJj1o-0005zz-Fn
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 10:42:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cJj1l-0001AC-CG
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 10:42:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cJj1l-00019w-7I
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 10:42:01 -0500
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
	<70e1f758-6f18-9821-b48e-bdebdfc0befc@redhat.com>
	<20161221131438.GF3808@thinpad.lan.raisama.net>
	<00508a0d-4279-298e-cbe2-217e7d2adab7@redhat.com>
	<20161221141541.GG3808@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <72085b3e-9fe2-965d-fcbb-55f916c2642b@redhat.com>
Date: Wed, 21 Dec 2016 16:41:02 +0100
MIME-Version: 1.0
In-Reply-To: <20161221141541.GG3808@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/7] Move accel, KVM, Xen,
 qtest files to accel/ subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Christoffer Dall <christoffer.dall@linaro.org>, Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xensource.com



On 21/12/2016 15:15, Eduardo Habkost wrote:
>>
>> ifeq ($(CONFIG_SOFTMMU),y)
>> obj-$(CONFIG_KVM) += kvm-all.c
>> obj-$(call lnot, $(CONFIG_KVM)) += kvm-stub.c
>> endif
>>
>> similar to what is done already in Makefile.objs?
> I assume you mean:
> 
>  ifeq ($(CONFIG_SOFTMMU),y)
>  obj-$(CONFIG_KVM) += kvm-all.c
>  endif
>  obj-$(call lnot, $(CONFIG_KVM)) += kvm-stub.c
> 
> Nothing really wrong, we can do that to avoid using libqemustub.
> I was just trying to avoid a more complex rule involving
> ifeq+lnot, and to avoid including accel/ in obj-y on the
> non-softmmu case.

TCG would need accel/ in obj-y in the non-softmmu case, for things such
as cpu-exec.c and translate-all.c.

Paolo
