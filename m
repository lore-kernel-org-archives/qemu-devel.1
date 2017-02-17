Received: from eggs.gnu.org ([2001:4830:134:3::10]:59674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cegbQ-00088Q-2L
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 06:21:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cegbK-0004yf-W7
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 06:21:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cegbK-0004yE-QM
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 06:21:22 -0500
References: <589C099A.9090605@huawei.com>
	<AF60004D-7133-44D1-8A9F-7DB9822D84AF@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B4379@DGGEMA505-MBX.china.huawei.com>
	<105e5774-38c3-0683-ca08-64f6ed53c643@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B6988@DGGEMA505-MBX.china.huawei.com>
	<2127602137.20489688.1486827559449.JavaMail.zimbra@redhat.com>
	<1486980300.17184.28.camel@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1BD1CA@DGGEMA505-MBX.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea1dbe94-7343-ef9e-56e1-9c6d8bcd78d6@redhat.com>
Date: Fri, 17 Feb 2017 12:21:24 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA1BD1CA@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Help] Windows2012 as Guest 64+cores on KVM Halts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Vadim Rozenfeld <vrozenfe@redhat.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, Hangaohuai <hangaohuai@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>



On 16/02/2017 02:31, Gonglei (Arei) wrote:
> And the below patch works for me, I can support max 255 vcpus for WS2012
> with hyper-v enlightenments.
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 27fd050..efe3cbc 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -772,7 +772,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
> 
>          c = &cpuid_data.entries[cpuid_i++];
>          c->function = HYPERV_CPUID_IMPLEMENT_LIMITS;
> -        c->eax = 0x40;
> +        c->eax = -1;
>          c->ebx = 0x40;
> 
>          kvm_base = KVM_CPUID_SIGNATURE_NEXT;

This needs to depend on the machine type, but apart from that I think
you should submit the patch for 2.9.

Thanks,

Paolo
