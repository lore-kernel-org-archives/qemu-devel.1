Received: from eggs.gnu.org ([209.51.188.92]:54319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGlx5-00073y-GS
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGlx4-0007yQ-5u
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:54:19 -0400
Received: from [110.188.70.11] (port=22963 helo=spam2.hygon.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <puwen@hygon.cn>) id 1hGlx0-0007sg-A0
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:54:16 -0400
References: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
	<20190416180251.GI32317@habkost.net>
From: Pu Wen <puwen@hygon.cn>
Message-ID: <24bd7696-78ff-1720-e871-b742a95f4706@hygon.cn>
Date: Wed, 17 Apr 2019 22:53:31 +0800
MIME-Version: 1.0
In-Reply-To: <20190416180251.GI32317@habkost.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "berrange@redhat.com" <berrange@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>

On 2019/4/17 2:03, Eduardo Habkost wrote:
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
>>
>> Reference:
>> [1] https://git.kernel.org/tip/fec98069fb72fb656304a3e52265e0c2fc9adf87
>>
>> Signed-off-by: Pu Wen <puwen@hygon.cn>
> 
> Queued for 4.1, thanks!

Thanks a lot!

-- 
Regards,
Pu Wen
