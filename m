Received: from eggs.gnu.org ([2001:4830:134:3::10]:50649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJQn-0002aO-7O
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJQj-000227-4u
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:23:21 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:47157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duJQi-00021b-Vq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:23:17 -0400
Received: by mail-wm0-f49.google.com with SMTP id 13so406611wmq.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 07:23:16 -0700 (PDT)
References: <20170918101709.30421-1-aik@ozlabs.ru>
	<20170918101709.30421-2-aik@ozlabs.ru>
	<c01622e7-3e6d-cf90-a28c-aa31b4857887@redhat.com>
	<2debed31-4c28-6dc3-b159-1fdc3fbf87f5@ozlabs.ru>
	<a85cbaf9-d7c7-403b-2dfc-886f9ddc0920@ozlabs.ru>
	<bdd220a9-7773-74c5-f924-112a6134d13b@redhat.com>
	<9c707630-570a-d7a1-76a4-3ddd5ae0f9b6@ozlabs.ru>
	<bb0004db-6e35-0181-552a-62e133eb7f76@redhat.com>
	<2f185edf-3281-e01f-5859-cc43a5df413e@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <89a582f4-e4b8-a8ae-8e8e-2fa83e1fd31d@redhat.com>
Date: Tue, 19 Sep 2017 16:23:13 +0200
MIME-Version: 1.0
In-Reply-To: <2f185edf-3281-e01f-5859-cc43a5df413e@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v3 01/13] memory: Postpone flatview
 and dispatch tree building till all devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 19/09/2017 16:12, Alexey Kardashevskiy wrote:
>>> What is the exact concern about the "[PATCH qemu v3 01/13] memory: Postpone
>>> flatview and dispatch tree building till all devices are added"? Is it that
>>> you missed that modern AS thing in virtio and thought we can do well even
>>> without it?
>> I am afraid that some of the special sysbus devices (not PCI, those go
>> through the bus master DMA region and it's empty on startup) might write
>> to memory during initialization.
> 
> And somehow QEMU guarantees that all RAM MRs are rendered to FlatViews even
> though some might be added via -device (can they btw?)?

I don't know, but as discussed on IRC, I think this is a pretty
different change from the rest of the series---which should have zero
change except for going faster---so I'd prefer to keep it out for now
and see where optimization can get us.

Paolo
