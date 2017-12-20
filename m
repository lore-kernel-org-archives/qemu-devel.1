Received: from eggs.gnu.org ([2001:4830:134:3::10]:41331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eReoq-0003Dj-Lv
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eReom-00080j-FA
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:54:00 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:58993)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eReom-0007yF-4B
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:53:56 -0500
References: <20171220121406.24056-1-laurent@vivier.eu>
	<CAAdtpL5QmaXbGN_q5nMiUuoJRtNf4QF2yz1xWUK0-b6ZRo+dng@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e4d9b437-159c-556d-f529-1429f6f14f33@vivier.eu>
Date: Wed, 20 Dec 2017 14:53:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAAdtpL5QmaXbGN_q5nMiUuoJRtNf4QF2yz1xWUK0-b6ZRo+dng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] Split adb.c into adb.c,
 adb-mouse.c and adb-kbd.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Gerd Hoffmann <kraxel@redhat.com>

Le 20/12/2017 à 14:16, Philippe Mathieu-Daudé a écrit :
> On Wed, Dec 20, 2017 at 9:14 AM, Laurent Vivier <laurent@vivier.eu> wrote:
>> It makes the code clearer to separate the bus implementation
>> from the devices one.
>>
>> Replace ADB_DPRINTF() with trace events (and adding new ones in adb-kbd.c).
>> Some minor changes to make checkpatch.pl happy.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>> v2: move internal declarations to adb-internal.h
>>     replace ADB_DPRINTF() with trace event.
>>
>>  hw/input/Makefile.objs  |   2 +-
>>  hw/input/adb-internal.h |  49 ++++
>>  hw/input/adb-kbd.c      | 400 +++++++++++++++++++++++++++++++
>>  hw/input/adb-mouse.c    | 254 ++++++++++++++++++++
>>  hw/input/adb.c          | 622 +-----------------------------------------------
>>  hw/input/trace-events   |   8 +
>>  6 files changed, 714 insertions(+), 621 deletions(-)
>>  create mode 100644 hw/input/adb-internal.h
>>  create mode 100644 hw/input/adb-kbd.c
>>  create mode 100644 hw/input/adb-mouse.c
>>
...
>> diff --git a/hw/input/trace-events b/hw/input/trace-events
>> index 88150ef7a6..a8d46cb766 100644
>> --- a/hw/input/trace-events
>> +++ b/hw/input/trace-events
>> @@ -1,5 +1,13 @@
>>  # See docs/devel/tracing.txt for syntax documentation.
>>
>> +# hw/input/adb-kbd.c
>> +adb_kbd_no_key(void) "Ignoring NO_KEY"
>> +adb_kbd_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
>> +adb_kbd_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
> 
> Minor aesthetical change:
> adb_kbd_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf
> [0x%2.2x, 0x%2.2x]"
> 
> Anyway, regardless this:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
>> +# hw/input/adb-mouse.c
>> +adb_mouse_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
>> +adb_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
> 
> Ditto:
> adb_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf
> [0x%2.2x, 0x%2.2x]"
> 

I will in case of a v3: I don't think it is worth another round only for
that.

Thanks,
Laurent
