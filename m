Received: from eggs.gnu.org ([2001:4830:134:3::10]:55773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXKfl-00080I-7M
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 02:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXKfk-0005hJ-49
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 02:08:21 -0400
References: <20180622134036.23182-1-f4bug@amsat.org>
	<20180622134036.23182-8-f4bug@amsat.org>
	<e98bac2c-ce0b-e226-3d96-004e46478f2f@redhat.com>
	<8256c2d4-722c-299f-e8e3-42c1a7f68e1d@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0bf443e6-fd49-9aaf-43fb-f171edf5fd38@redhat.com>
Date: Mon, 25 Jun 2018 08:08:08 +0200
MIME-Version: 1.0
In-Reply-To: <8256c2d4-722c-299f-e8e3-42c1a7f68e1d@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/14] hw/i2c/omap_i2c: Use
 qemu_log_mask(UNIMP) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

On 22.06.2018 22:10, Philippe Mathieu-Daud=C3=A9 wrote:
> On 06/22/2018 04:38 PM, Thomas Huth wrote:
>> On 22.06.2018 15:40, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  hw/i2c/omap_i2c.c | 20 ++++++++++++--------
>>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
>>> index 26e3e5ebf6..690876e43e 100644
>>> --- a/hw/i2c/omap_i2c.c
>>> +++ b/hw/i2c/omap_i2c.c
>>> @@ -17,6 +17,7 @@
>>>   * with this program; if not, see <http://www.gnu.org/licenses/>.
>>>   */
>>>  #include "qemu/osdep.h"
>>> +#include "qemu/log.h"
>>>  #include "hw/hw.h"
>>>  #include "hw/i2c/i2c.h"
>>>  #include "hw/arm/omap.h"
>>> @@ -339,14 +340,15 @@ static void omap_i2c_write(void *opaque, hwaddr=
 addr,
>>>              }
>>>              break;
>>>          }
>>> -        if ((value & (1 << 15)) && !(value & (1 << 10))) {	/* MST */
>>> -            fprintf(stderr, "%s: I^2C slave mode not supported\n",
>>> -                            __func__);
>>> +        if ((value & (1 << 15)) && !(value & (1 << 10))) { /* MST */
>>
>> Please keep the white spaces before the comment if you don't change
>> anything else.
>=20
> This is a <tab> and checkpatch complains...
>=20
> I can use 4 spaces for this tab. I tried to align with other tab-aligne=
d
> comments I didn't modify, but the result is messier. Thus a simple spac=
e.

Oh, sorry, I didn't notice that you've replaced a TAB here. I guess it's
ok then. But why does checkpatch complain if it is just in the context
of your modification? That's weird.

 Thomas
