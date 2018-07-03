Received: from eggs.gnu.org ([2001:4830:134:3::10]:57062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Suzuki.Poulose@arm.com>) id 1faLEe-0002cQ-EV
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Suzuki.Poulose@arm.com>) id 1faLEd-0005sI-Ly
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:20:48 -0400
References: <1529500053-21704-1-git-send-email-eric.auger@redhat.com>
	<1529500053-21704-6-git-send-email-eric.auger@redhat.com>
	<20180703115507.nqmyo7c5q5lrevgt@kamzik.brq.redhat.com>
	<31c24e33-8fe8-a3c0-0430-d2f503f10932@redhat.com>
	<20180703124709.sqt5rmjsadnqag2c@kamzik.brq.redhat.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <9e8e72c5-707e-0d50-68af-f69fb1804cf4@arm.com>
Date: Tue, 3 Jul 2018 14:20:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180703124709.sqt5rmjsadnqag2c@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 5/6] hw/arm/virt: support kvm_type property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, Auger Eric <eric.auger@redhat.com>
Cc: wei@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, dgilbert@redhat.com, agraf@suse.de, qemu-arm@nongnu.org, david@gibson.dropbear.id.au, eric.auger.pro@gmail.com

On 03/07/18 13:47, Andrew Jones wrote:
>> This infrastructure already is used in hw/ppc/spapr.c
>>
>> Whould it be better if we would pass something like kvm-type=48bGPA?
>> Otherwise I can decode another virt machine option (min_vm_phys_shift)
>> in kvm_type callback.
> 
> Yes, this is what I'm thinking. I don't believe we have to expose the
> details of the KVM API to the user through the QEMU command line. The
> details are actually more complicated anyway, as the phys-shift is
> only the lower 8-bits of KVM type[*], not the whole value.
> 
> Thanks,
> drew
> 
> [*] Looks like Suzuki's series is missing the Documentation/virtual/kvm/api.txt
>      update needed to specify that.

Thanks for spotting, I will update the documentation.

Suzuki
