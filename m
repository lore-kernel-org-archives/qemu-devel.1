Received: from eggs.gnu.org ([209.51.188.92]:58688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj57P-0006X6-Lp
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj57P-000772-2p
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:29:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gj57O-00070K-Rl
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:29:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so23600405wra.6
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 08:29:28 -0800 (PST)
References: <20190114131015.52967-1-lifei1214@126.com>
	<ac0015a7-5fcf-f5f6-a1a5-6c3846459b8c@redhat.com>
	<20190114105015-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d104b828-c514-7dc8-6d78-edd9e89733b5@redhat.com>
Date: Mon, 14 Jan 2019 17:29:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190114105015-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/misc/edu: add msi_uninit() for
 pci_edu_uninit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Fei Li <lifei1214@126.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Jiri Slaby <jslaby@suse.cz>, qemu-devel@nongnu.org, shirley17fei@gmail.com

On 1/14/19 4:51 PM, Michael S. Tsirkin wrote:
> On Mon, Jan 14, 2019 at 02:28:39PM +0100, Philippe Mathieu-Daudé wrote:
>> Cc'ing qemu-trivial
>>
>> On 1/14/19 2:10 PM, Fei Li wrote:
>>> From: Fei Li <shirley17fei@gmail.com>
>>>
>>> Let's supplement the msi_uninit() when failing to realize
>>> the pci edu device.
>>>
>>> Reported-by: Markus Armbruster <armbru@redhat.com>
>>> Signed-off-by: Fei Li <shirley17fei@gmail.com>
>>> Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>  hw/misc/edu.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
>>> index cdcf550dd7..ceaf688bfb 100644
>>> --- a/hw/misc/edu.c
>>> +++ b/hw/misc/edu.c
>>> @@ -377,6 +377,7 @@ static void pci_edu_uninit(PCIDevice *pdev)
>>>      qemu_mutex_destroy(&edu->thr_mutex);
>>>  
>>>      timer_del(&edu->dma_timer);
>>> +    msi_uninit(pdev);
>>>  }
>>>  
>>>  static void edu_obj_uint64(Object *obj, Visitor *v, const char *name,
>>>
> 
> That's not trivial material IMHO. I put it in my tree for now.

Hmm it is releasing ressources on deinit... Anyway it is better placed
in your tree, no doubt. Thanks!

Phil.
