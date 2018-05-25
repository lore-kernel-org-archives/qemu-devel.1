Received: from eggs.gnu.org ([2001:4830:134:3::10]:43148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fMDT4-0005vJ-8v
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fMDT0-0005us-9o
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:13:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fMDT0-0005sm-4b
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:13:14 -0400
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
	<1527086545-68024-8-git-send-email-mst@redhat.com>
	<CAFEAcA9JwWR29YSBKGS1fmmOE=wrSQY+OeJxQc4kmAEHRXUzWQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <32e62667-7ae6-afad-8ceb-3504dfefba1d@redhat.com>
Date: Fri, 25 May 2018 16:13:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9JwWR29YSBKGS1fmmOE=wrSQY+OeJxQc4kmAEHRXUzWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 07/28] x86/cpu: use
 standard-headers/asm-x86.kvm_para.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm-devel <kvm@vger.kernel.org>

On 25/05/2018 13:06, Peter Maydell wrote:
> --- a/include/standard-headers/asm-x86/kvm_para.h
> +++ b/include/standard-headers/asm-x86/kvm_para.h
> @@ -29,7 +29,7 @@
>  #define KVM_FEATURE_PV_TLB_FLUSH       9
>  #define KVM_FEATURE_ASYNC_PF_VMEXIT    10
> 
> -#define KVM_HINTS_DEDICATED      0
> +#define KVM_HINTS_REALTIME      0
> 
>  /* The last 8 bits are used to indicate how to interpret the flags field
>   * in pvclock structure. If no bits are set, all flags are ignored.
> 
> I'm not sure what's going on here -- commit 633711e8287 in
> the kernel just renames the constant, but doesn't that
> break userspace API ?

No, but only because the constant with the old name was not in any
released version.  It was added in 4.17-rc1.

Thanks,

Paolo
