Received: from eggs.gnu.org ([2001:4830:134:3::10]:44932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPT2M-00022e-D4
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPT2L-0006wA-Ni
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:59:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gPT2L-0006w0-GY
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:59:25 -0500
References: <1235.1542559249@dschgrazlin2.units.it>
	<jpgefbgag1q.fsf@linux.bootlegged.copy>
	<20181119230054.GI3807@habkost.net>
	<824b8c1e-ee32-411b-53b3-68cd76fe0641@redhat.com>
	<20181120184845.GQ4755@habkost.net>
	<04d022e0-2408-0a2f-b2ef-171d1d9017d7@redhat.com>
	<jpgo9aj3wji.fsf@linux.bootlegged.copy>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9115bcb-deec-2382-2cc2-48c166029f53@redhat.com>
Date: Wed, 21 Nov 2018 14:59:15 +0100
MIME-Version: 1.0
In-Reply-To: <jpgo9aj3wji.fsf@linux.bootlegged.copy>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] 3.1.0-rc{0,1} doesn't start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>, balducci@units.it, qemu-devel@nongnu.org

On 21/11/18 05:05, Bandan Das wrote:
>> Oh, wait.  I didn't understand that.  Then yeah, fixing QEMU is enough.
>>  KVM is not reporting the MSR in the list on AMD, but it should (and it
>> should implement the MSR, of course!).
>>
> Until AMD implements somethinig, on the KVM side, shouldn't we let
> kvm_x86_ops->get_msr_feature(msr)) handle MSR_IA32_ARCH_CAPABILITIES ?
> 

Either is okay.  But the MSR is not really vendor dependent, and can be
added even to older models.  So it may make sense to move it to generic
code.

Paolo
