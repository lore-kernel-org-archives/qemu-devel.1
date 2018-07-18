Received: from eggs.gnu.org ([2001:4830:134:3::10]:32828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fftNp-0007rn-Lo
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 16:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fftNl-0000fC-2b
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 16:49:13 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:44668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fftNk-0000eh-QD
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 16:49:08 -0400
Received: by mail-ed1-x544.google.com with SMTP id f23-v6so5352105edr.11
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 13:49:08 -0700 (PDT)
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-3-e.emanuelegiuseppe@gmail.com>
	<20180711144920.GN31228@stefanha-x1.localdomain>
	<494e6b18-a5e9-0521-4ace-dca2160ea191@redhat.com>
	<20180718142927.GN21825@stefanha-x1.localdomain>
	<2d822611-d227-1e9e-bfb4-d119f78a0282@gmail.com>
	<645dd61a-b309-4a54-3e59-2dce23244045@redhat.com>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <928e71ec-1a1d-ed63-310b-83910e10e51f@gmail.com>
Date: Wed, 18 Jul 2018 22:49:05 +0200
MIME-Version: 1.0
In-Reply-To: <645dd61a-b309-4a54-3e59-2dce23244045@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/7] tests/qgraph: pci-pc driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org



On 07/18/2018 09:33 PM, Paolo Bonzini wrote:
> On 18/07/2018 20:29, Emanuele wrote:
>> I had to put this patch here because it also introduces
>> qpci_device_init, used by sdhci (patch 3).
>>
>> For the next version I plan to have a patch X where I rename all
>> occurrences of qpci_init_pc in qpci_pc_new, and a patch X+1 that
>> introduces qpci_init_pc (was qpci_set_pc) and the other changes.
>>
>> Should I only introduce qpci_device_init in patch 3 and the remaining
>> things in patch 5?
>>
>> I think the general problem here is that in some patches I create
>> functions that are planned to only be used only in next patches (of the
>> current series).
> I think it's okay this way, however you should justify the changes you
> make to "qgraph-ify" each component.
>
> For patch 1, let's wait for Stefan's reply.  Because patch 1 is
> introducing the infrastructure, I think it is acceptable that some
> definitions are introduced early as long as they have doc comments; it
> would make little sense to introduce get_device in patch 4 just because
> there are no "contains" edges until then.
>
> However, introducing the qos-test directly at the beginning is also a
> possibility.
>
> In either case, we need better doc comments for the function pointers in
> QOSGraphObject.
What would you suggest as better doc comments? For version 2 I have 
written a little introduction like in qom/object.h, essentially pasting 
the cover letter and a working example.
> Paolo
