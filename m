Received: from eggs.gnu.org ([2001:4830:134:3::10]:56123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXKi4-000100-U7
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 02:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXKi3-00074m-OO
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 02:10:44 -0400
References: <20180622134036.23182-1-f4bug@amsat.org>
	<20180622134036.23182-10-f4bug@amsat.org>
	<b70145b2-5c24-d525-b23a-aaeb7ab960c5@redhat.com>
	<39def888-734e-f4e6-8104-9534e611fcb1@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <797d336f-bfc6-050e-7f13-d9872049d197@redhat.com>
Date: Mon, 25 Jun 2018 08:10:37 +0200
MIME-Version: 1.0
In-Reply-To: <39def888-734e-f4e6-8104-9534e611fcb1@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/14] hw/arm/omap: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
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

On 22.06.2018 22:13, Philippe Mathieu-Daud=C3=A9 wrote:
> On 06/22/2018 04:44 PM, Thomas Huth wrote:
>> On 22.06.2018 15:40, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  include/hw/arm/omap.h | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
>>> index 39abba753d..3867687b8c 100644
>>> --- a/include/hw/arm/omap.h
>>> +++ b/include/hw/arm/omap.h
>>> @@ -21,6 +21,7 @@
>>>  # define hw_omap_h		"omap.h"
>>>  #include "hw/irq.h"
>>>  #include "target/arm/cpu-qom.h"
>>> +#include "qemu/log.h"
>>> =20
>>>  # define OMAP_EMIFS_BASE	0x00000000
>>>  # define OMAP2_Q0_BASE		0x00000000
>>> @@ -962,8 +963,8 @@ void omap_mpu_wakeup(void *opaque, int irq, int r=
eq);
>>>          fprintf(stderr, "%s: Bad register " OMAP_FMT_plx "\n",	\
>>>                          __func__, paddr)
>>
>> What about that fprintf above?
>=20
> Well there are still many fprintf() in the OMAP codebase.
>=20
> I didn't want to start a fprintf() cleanup, I just cherry-picked the
> patches I used to make sens of the current (ugly) output.
>=20
> With this series the console is 'usable'.

Ok, fair. But I guess you should mention this in the patch description.

 Thomas
