Received: from eggs.gnu.org ([2001:4830:134:3::10]:37393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVxOA-0004KZ-OX
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVxO6-0005bi-PH
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:27:42 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1484927639-3841-1-git-send-email-thuth@redhat.com>
	<0c562336-31a8-5347-1123-810543563fd5@msgid.tls.msk.ru>
	<15b9c04d-23e3-2166-c2e0-7b5a963350c1@redhat.com>
Date: Tue, 24 Jan 2017 10:27:35 +0100
In-Reply-To: <15b9c04d-23e3-2166-c2e0-7b5a963350c1@redhat.com> (Thomas Huth's
	message of "Tue, 24 Jan 2017 08:48:37 +0100")
Message-ID: <87r33su7so.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hw/isa/isa-bus: Set category of the
 "isabus-bridge" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> On 24.01.2017 08:42, Michael Tokarev wrote:
>> 20.01.2017 18:53, Thomas Huth wrote:
>>> It has "bridge" in its name, so it should be in the category
>>> DEVICE_CATEGORY_BRIDGE.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  hw/isa/isa-bus.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
>>> index 9d07b11..0ffbc8d 100644
>>> --- a/hw/isa/isa-bus.c
>>> +++ b/hw/isa/isa-bus.c
>>> @@ -219,6 +219,7 @@ static void isabus_bridge_class_init(ObjectClass *klass, void *data)
>>>  {
>>>      DeviceClass *dc = DEVICE_CLASS(klass);
>>>  
>>> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>>>      dc->fw_name = "isa";
>>>  }
>> 
>> Does it have any effect on the guest?
>> ISA is an old thing...
>
> No, as far as I know, this is just used in qdev_print_devinfos() to
> print out the devices in nice categories when you start QEMU with
> "-device ?". Devices that do not have a category bit set show up in the
> "Uncategorized" section - which tends to get overcrowded if the devices
> are not sorted into proper categories.

It's definitely the only effect of dc->categories.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
