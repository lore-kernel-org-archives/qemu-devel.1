Received: from eggs.gnu.org ([2001:4830:134:3::10]:55198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dpHwQ-0005xk-So
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dpHwM-0005vS-5z
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:47:14 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dpHwL-0005uq-V0
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:47:10 -0400
Received: by mail-wm0-x243.google.com with SMTP id u26so3495548wma.5
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 10:47:09 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170901205207.GA1522@jhogan-linux.le.imgtec.org>
References: <cover.1504228916.git.alistair.francis@xilinx.com>
	<d64777dcf9079a8f997416b148b9cffbc14e0c49.1504228916.git.alistair.francis@xilinx.com>
	<20170901205207.GA1522@jhogan-linux.le.imgtec.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 5 Sep 2017 10:46:38 -0700
Message-ID: <CAKmqyKPuT6K7=K9Lp+CkQ2KNGTUyQKzVF3+y86vxByhedBT2bA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 3/7] Convert single line fprintf(.../n)
 to warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hogan <james.hogan@imgtec.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Sep 1, 2017 at 1:52 PM, James Hogan <james.hogan@imgtec.com> wrote:
> On Fri, Sep 01, 2017 at 09:51:15AM -0700, Alistair Francis wrote:
>> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
>> index 3317905e71..a23aa438d2 100644
>> --- a/target/mips/kvm.c
>> +++ b/target/mips/kvm.c
>> @@ -95,11 +95,11 @@ void kvm_mips_reset_vcpu(MIPSCPU *cpu)
>>      CPUMIPSState *env = &cpu->env;
>>
>>      if (!kvm_mips_fpu_cap && env->CP0_Config1 & (1 << CP0C1_FP)) {
>> -        fprintf(stderr, "Warning: KVM does not support FPU, disabling\n");
>> +        warn_report("KVM does not support FPU, disabling");
>>          env->CP0_Config1 &= ~(1 << CP0C1_FP);
>>      }
>>      if (!kvm_mips_msa_cap && env->CP0_Config3 & (1 << CP0C3_MSAP)) {
>> -        fprintf(stderr, "Warning: KVM does not support MSA, disabling\n");
>> +        warn_report("KVM does not support MSA, disabling");
>>          env->CP0_Config3 &= ~(1 << CP0C3_MSAP);
>>      }
>
> That looks sensible.
> Reviewed-by: James Hogan <james.hogan@imgtec.com> [mips]

Thanks

>
> The 3 fprintfs in kvm_mips_update_state() are also pretty much non-fatal
> warnings too (though only because old kernels v3.10-v3.15 didn't
> implement the timer saving API). Feel free to convert those too if you
> like, otherwise I'll submit along with some other changes.

Ok, I'll add an extra patch to this series which converts those.

Thanks,
Alistair

>
> Cheers
> James
