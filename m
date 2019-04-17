Received: from eggs.gnu.org ([209.51.188.92]:54215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGlwR-0006lR-Uw
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGlwQ-0007jr-M2
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:53:39 -0400
Received: from [110.188.70.11] (port=12939 helo=spam1.hygon.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <puwen@hygon.cn>) id 1hGlwO-0007Xc-Mz
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:53:38 -0400
References: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
	<20190416141700.GR18986@antique-laptop>
From: Pu Wen <puwen@hygon.cn>
Message-ID: <e7abd74f-61bb-fc34-0b3a-08c635d9f78c@hygon.cn>
Date: Wed, 17 Apr 2019 22:53:04 +0800
MIME-Version: 1.0
In-Reply-To: <20190416141700.GR18986@antique-laptop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] i386: Add new Hygon 'Dhyana' CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Hrdina <phrdina@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On 2019/4/16 22:17, Pavel Hrdina wrote:
> On Tue, Apr 16, 2019 at 08:06:13PM +0800, Pu Wen wrote:
>> Add a new base CPU model called 'Dhyana' to model processors from Hygon
>> Dhyana(family 18h), which derived from AMD EPYC(family 17h).
>>
>> The following features bits have been removed compare to AMD EPYC:
>> aes, pclmulqdq, sha_ni
>>
>> The Hygon Dhyana support to KVM in Linux is already accepted upstream[1].
>> So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
>> CPU model.
> 
> I have once question that we will have to solve for EPYC CPUs as well.
> The name should not be based on the Product name or Model name as that
> usually doesn't change with introduction of new microarchitecture.
> 
> With EPYC we made a mistake to name the CPU like that, luckily with
> Intel we already use the microarchitecture name, so the EPYC CPU should
> have been named ZEN-Server and for Ryzen CPUs there should be ZEN-Client
> if there is any difference or otherwise we can simply use ZEN.
> 
> The issue here is what happens once the ZEN2 microarchitecture is out
> wihch introduces new features and we will have to come up with a CPU
> name.
> 
> Obviously we cannot change/remove the EPYC models so the question is
> what is the difference between the AMD EPYC CPU and this new Dhyana CPU
> if they are both based on the ZEN microarchitecture?

Right now there's no much difference between Dhyana and EPYC from the 
software's view. Dhyana removed the instructions aes, pclmulqdq, sha_ni 
compared to EPYC, but will have it's own implementation such as for aes 
in future CPU models. Hygon also will implement something different from 
AMD in the future.

> In addition is there any way how we can introduce ZEN-Server &
> ZEN-Client or simply ZEN, if there is no difference, as an alias or a
> new model next to the EPYC?

Also as Eduardo mentioned that there's no CPU model alias or inheritance 
system in x86, so I think it's worthwhile to keep a separate CPU model 
for Hygon.

-- 
Regards,
Pu Wen
