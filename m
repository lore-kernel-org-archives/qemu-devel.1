Received: from eggs.gnu.org ([2001:4830:134:3::10]:48534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0MiT-0003k7-4v
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 03:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0MiQ-00016r-0e
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 03:38:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39504 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f0MiP-00016d-Rw
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 03:38:49 -0400
References: <1521193892-15552-1-git-send-email-thuth@redhat.com>
	<1ef42117-6b16-b22f-29fe-f4910361aa2a@redhat.com>
	<d40e6299-9c4f-26f3-41e0-21116da4d8f4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a78b536c-ceba-1a2e-e74e-7e487689a267@redhat.com>
Date: Mon, 26 Mar 2018 09:38:32 +0200
MIME-Version: 1.0
In-Reply-To: <d40e6299-9c4f-26f3-41e0-21116da4d8f4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] Fix crashes with CAN bus and
 ISA DMA devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>

On 23/03/2018 19:20, John Snow wrote:
> 
> 
> On 03/16/2018 06:15 AM, Paolo Bonzini wrote:
>> On 16/03/2018 10:51, Thomas Huth wrote:
>>> The new CAN bus devices and some older ISA devices that use DMA can be
>>> used to crash QEMU. These patches introduce some proper checks so that
>>> the users get a proper error message instead.
>>>
>>> Alexey Kardashevskiy (1):
>>>   fdc: Exit if ISA controller does not support DMA
>>>
>>> Thomas Huth (3):
>>>   hw/net/can: Fix segfaults when using the devices without bus
>>>   hw/audio: Fix crashes when devices are used on ISA bus without DMA
>>>   scripts/device-crash-test: Remove fixed isapc-with-iommu entry
>>>
>>>  hw/audio/cs4231a.c        | 8 +++++++-
>>>  hw/audio/gus.c            | 7 ++++++-
>>>  hw/audio/sb16.c           | 9 +++++++--
>>>  hw/block/fdc.c            | 5 ++++-
>>>  hw/net/can/can_sja1000.c  | 4 ++++
>>>  scripts/device-crash-test | 8 --------
>>>  6 files changed, 28 insertions(+), 13 deletions(-)
>>>
>>
>> Queued, thanks.
>>
>> Paolo
>>
> 
> Did you not actually send a PR for this?

No, today. :)

Paolo
