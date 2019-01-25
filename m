Received: from eggs.gnu.org ([209.51.188.92]:55258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn4b8-0005Fc-Dt
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn4b7-0006mV-Ik
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:44:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gn4b7-0006l9-D6
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:44:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so10953479wrr.12
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 08:44:52 -0800 (PST)
References: <20190125151440.13794-1-sourav.jb1988@gmail.com>
	<f9288ca3-1f07-3409-ac16-ce4dc958940e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cc09d469-56bc-9438-acc0-0d4ccf67e6a5@redhat.com>
Date: Fri, 25 Jan 2019 17:44:50 +0100
MIME-Version: 1.0
In-Reply-To: <f9288ca3-1f07-3409-ac16-ce4dc958940e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw: input: set category of the i8042 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, kumar sourav <sourav.jb1988@gmail.com>, qemu-trivial@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On 1/25/19 4:24 PM, Thomas Huth wrote:
> On 2019-01-25 16:14, kumar sourav wrote:
>> Sets the category of i8042 device as DEVICE_CATEGORY_INPUT
>> Devices should be assigned to one of DEVICE_CATEGORY_XXXX.
>>
>> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
>> ---
>>  hw/input/pckbd.c | 1 +

It seems we have other potential cases:

$ git grep -L 'set_bit(DEVICE_CATEGORY_INPUT' hw/input/*c
hw/input/adb.c
hw/input/hid.c
hw/input/lm832x.c
hw/input/milkymist-softusb.c
hw/input/pckbd.c
hw/input/pl050.c
hw/input/ps2.c
hw/input/pxa2xx_keypad.c
hw/input/stellaris_input.c
hw/input/tsc2005.c
hw/input/tsc210x.c
hw/input/virtio-input-hid.c
hw/input/virtio-input-host.c

>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
>> index 3e66713b47..72e7d5f6cc 100644
>> --- a/hw/input/pckbd.c
>> +++ b/hw/input/pckbd.c
>> @@ -574,6 +574,7 @@ static void i8042_class_initfn(ObjectClass *klass, void *data)
>>  
>>      dc->realize = i8042_realizefn;
>>      dc->vmsd = &vmstate_kbd_isa;
>> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>>  }
>>  
>>  static const TypeInfo i8042_info = {
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
