Received: from eggs.gnu.org ([2001:4830:134:3::10]:60108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cspme-0001uZ-8q
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cspmd-0006bi-3n
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:59:32 -0400
References: <CACJhumejPG6s_dewyHH=e5=QLcOUCzvzhakA7oSqm2Ms5cQvRA@mail.gmail.com>
	<CAFEAcA-kKvS_6OZE1mKbFYgCzm4wPK2XJi_A03nFxu+K3ZA4hQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <43d097e6-a74a-ed22-0b28-3f151d3e51fb@redhat.com>
Date: Tue, 28 Mar 2017 13:59:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-kKvS_6OZE1mKbFYgCzm4wPK2XJi_A03nFxu+K3ZA4hQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Aarch64: Qemu master or 2.9.0-rc1 breaks
 compatibility with 4.10 kernel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Prakash B <bjsprakash.linux@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, bprakash@caviumnetworks.com, QEMU Developers <qemu-devel@nongnu.org>, "Kumar, Vijaya" <Vijaya.Kumar@cavium.com>, qemu-arm <qemu-arm@nongnu.org>, sgoutham@cavium.com, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, Christoffer Dall <christoffer.dall@linaro.org>

Hi Peter,

On 28/03/2017 13:29, Peter Maydell wrote:
> On 28 March 2017 at 12:22, Prakash B <bjsprakash.linux@gmail.com> wrote:
>> Qemu master or v2.9.0-rc1 doesn't launch guest  when host kernel
>> version 4.10 or  lower on Aarch64 (cavium ThunderX), its failing with
>> abort  "qemu-system-aarch64: KVM_GET_DEVICE_ATTR failed: No such
>> device or address"
>>
>> "GICv3 live migration support"  patch breaks the  compatibility b/w
>> kernel and qemu.
>>
>> Is this expected behaviour,  can we provide a fix without  breaking
>> compatibility b/w kernel and qemu .
> 
> This is indeed not supposed to happen. Eric, can you take a look?

Yes I start the investigations.

Thanks

Eric
> 
> thanks
> -- PMM
> 
