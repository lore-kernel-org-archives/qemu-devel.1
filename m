Received: from eggs.gnu.org ([208.118.235.92]:59231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejEHC-0004rz-Hk
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 20:13:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejECx-0005oP-6B
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 20:11:54 -0500
Received: from mail-sn1nam02on0085.outbound.protection.outlook.com
	([104.47.36.85]:38008
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ejECw-0005mp-EM
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 20:07:30 -0500
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<5A79CF18020000480006831E@prv-mh.provo.novell.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <314f8f96-5d92-0d2a-39ec-c7665ef2b738@amd.com>
Date: Tue, 6 Feb 2018 19:07:20 -0600
MIME-Version: 1.0
In-Reply-To: <5A79CF18020000480006831E@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v6 00/23] x86: Secure Encrypted
 Virtualization (AMD)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, Thomas.Lendacky@amd.com, Stefan Hajnoczi <stefanha@gmail.com>, peter.maydell@linaro.org, richard.henderson@linaro.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, edgar.iglesias@xilinx.com



On 2/6/18 9:51 AM, Bruce Rogers wrote:
>>>> On 1/29/2018 at 10:41 AM, <brijesh.singh@amd.com> wrote:
>> This patch series provides support for AMD's new Secure Encrypted=20
>> Virtualization (SEV) feature.
>>
>> SEV is an extension to the AMD=E2=80=91V architecture which supports run=
ning
>> multiple VMs under the control of a hypervisor. The SEV feature allows
>> the memory contents of a virtual machine (VM) to be transparently encryp=
ted
>> with a key unique to the guest VM. The memory controller contains a
>> high performance encryption engine which can be programmed with multiple
>> keys for use by a different VMs in the system. The programming and
>> management of these keys is handled by the AMD Secure Processor firmware
>> which exposes a commands for these tasks.
>>
>> The KVM SEV patch series introduced a new ioctl (KVM_MEMORY_ENCRYPTION_O=
P)
>> which is used by qemu to issue the SEV commands to assist performing
>> common hypervisor activities such as a launching, running, snapshooting,
>> migration and debugging guests.
>>
> As for the reported failure to build on non-x86 hosts, eg:
> ...
>   LINK    i386-softmmu/qemu-system-i386
> target/i386/helper.o: In function `get_me_mask':
> /var/tmp/patchew-tester-tmp-hek3vjny/src/target/i386/helper.c:735: undefi=
ned reference to `kvm_arch_get_supported_cpuid'
> target/i386/monitor.o: In function `get_me_mask':
> /var/tmp/patchew-tester-tmp-hek3vjny/src/target/i386/monitor.c:71: undefi=
ned reference to `kvm_arch_get_supported_cpuid'
>
> ... I've looked at that a bit and find that in target/i386/kvm-stub.c, if=
 we get rid of
> the #ifndef __OPTIMIZE__ it then builds ok. I'm not sure if the guarding =
done there
> with the check for  __OPTIMIZE__ is a relic that no longer applies given =
how qemu
> currently builds, but at least it's something to look at.

Thanks for looking Bruce.

I have reworked code a bit and that should fix this build error. I will
be posting patches soon for review.

> Bruce
>
