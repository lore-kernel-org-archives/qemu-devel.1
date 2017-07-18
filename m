Received: from eggs.gnu.org ([2001:4830:134:3::10]:54583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXSTD-00050P-Vv
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXSTD-0006og-7Y
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:23:24 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <045101d2ffaf$ef4b60e0$cde222a0$@d-silva.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-8-f4bug@amsat.org>
	<045101d2ffaf$ef4b60e0$cde222a0$@d-silva.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 10:23:19 -0300
Message-ID: <CAAdtpL7MibpdNtmc-vJAGhjVh-FKpy0RzQkL=DCHr+WSnXqF7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 07/29] ds1338: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alastair D'Silva <alastair@d-silva.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>

On Tue, Jul 18, 2017 at 7:23 AM, Alastair D'Silva <alastair@d-silva.org> wrote:
> I'm not sure this makes sense - we're dealing with time here.

Indeed, thanks for your review!

>> --- a/hw/timer/ds1338.c
>> +++ b/hw/timer/ds1338.c
>> @@ -65,7 +65,7 @@ static void capture_current_time(DS1338State *s)
>>      s->nvram[1] = to_bcd(now.tm_min);
>>      if (s->nvram[2] & HOURS_12) {
>>          int tmp = now.tm_hour;
>> -        if (tmp % 12 == 0) {
>> +        if (QEMU_IS_ALIGNED(tmp, 12)) {
>>              tmp += 12;
>>          }
>>          if (tmp <= 12) {
>> @@ -154,7 +154,7 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
>>                  if (data & HOURS_PM) {
>>                      tmp += 12;
>>                  }
>> -                if (tmp % 12 == 0) {
>> +                if (QEMU_IS_ALIGNED(tmp, 12)) {
>>                      tmp -= 12;
>>                  }
>>                  now.tm_hour = tmp;
