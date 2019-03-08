Received: from eggs.gnu.org ([209.51.188.92]:43321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2LwZ-0006og-PV
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2LwY-0006ec-Na
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:18:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2LwY-0006ds-G1
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:18:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so3470095wrw.7
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 12:18:10 -0800 (PST)
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-14-philmd@redhat.com>
	<0e007e09-cf54-312b-9563-59f3994209bf@redhat.com>
	<40319ac6-4545-4e7b-0339-8229727355e3@redhat.com>
	<a3c759a5-73df-f481-ba21-48ece92f1185@redhat.com>
	<9f1cdb48-3262-de5e-a500-1dfb3d6372e5@redhat.com>
	<f4d5a154-0c9d-0e1c-144c-c6855dadafd6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9f2f0884-3be1-7089-d10d-6549081a89a7@redhat.com>
Date: Fri, 8 Mar 2019 21:18:07 +0100
MIME-Version: 1.0
In-Reply-To: <f4d5a154-0c9d-0e1c-144c-c6855dadafd6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/18] hw/nvram/fw_cfg: Add QMP 'info
 fw_cfg' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On 3/8/19 9:00 PM, Laszlo Ersek wrote:
> On 03/08/19 19:07, Philippe Mathieu-Daudé wrote:
>> On 3/8/19 6:31 PM, Eric Blake wrote:
>>> On 3/8/19 5:08 AM, Philippe Mathieu-Daudé wrote:
>>>>>> +##
>>>>>> +# @query-fw_cfg-items:
>>>>>
>>>>> That looks weird to mix - and _. Any reason we can't just go with
>>>>> query-firmware-config?
>>>>
>>>> Way better! I'll use query-firmware-config-items.
>>>
>>> Do we need the -items suffix? Also, is there a chance that we might ever
>>> want to extend the command to return more information that is global to
>>> firmware-config rather than per-item?
>>
>> Laszlo suggested it could be useful to ask for a specific item (with the
>> full data encoded?).
> 
> It's possible I referred to that a long time ago, but most recently, I
> think it has been raised by Dave.

One of your 'random' ideas :)

https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01959.html

  (6) If we want bells and whistles, two optional parameters could be
  considered: one for identifying one specific key to request info about
  (identify by selector? well-known macro name? file pathname?), and
  another param for placing a limit, different from 8, on the individual
  hexdump size.

  Important: these are not "requirements", just random ideas, food for
  thought. I'm fine if you reject any subset of them, after
  consideration.

> 
> Thanks
> Laszlo
