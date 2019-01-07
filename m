Received: from eggs.gnu.org ([209.51.188.92]:42436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggPrm-0005Sy-Uj
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggPrl-0004UT-VP
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:02:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ggPrj-0004Q6-Se
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:02:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so6526416wmf.5
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 00:02:29 -0800 (PST)
References: <20190104175847.6290-1-philmd@redhat.com>
	<20190104175847.6290-9-philmd@redhat.com>
	<fe31012f-9311-1455-a20a-70eb83400e50@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6443e9fa-6fb3-56d8-8568-93608cff0d69@redhat.com>
Date: Mon, 7 Jan 2019 09:02:26 +0100
MIME-Version: 1.0
In-Reply-To: <fe31012f-9311-1455-a20a-70eb83400e50@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/16] MAINTAINERS: Add missing entries for
 the TI touchscreen devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>, Richard Henderson <rth@twiddle.net>, Jan Kiszka <jan.kiszka@web.de>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Rob Herring <robh@kernel.org>

Hi Thomas,

On 1/7/19 8:18 AM, Thomas Huth wrote:
> On 2019-01-04 18:58, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  MAINTAINERS | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f571b29077..03872552ee 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -640,6 +640,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
>>  L: qemu-arm@nongnu.org
>>  S: Odd Fixes
>>  F: hw/arm/nseries.c
>> +F: hw/input/tsc2*.c
>>  F: include/hw/display/blizzard.h
>>  F: include/hw/misc/cbus.h
>>  
>> @@ -649,6 +650,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
>>  L: qemu-arm@nongnu.org
>>  S: Odd Fixes
>>  F: hw/arm/palm.c
>> +F: hw/input/tsc2*.c
> 
> The Palm machine does not seem to use tsc2005, does it? So I think this
> entry here is wrong.

It does use another touchscreen controller, the tsc2102, which in the
next patch are declared in the same header (you suggested "tsc2xxx.h):

$ git grep tsc2.*init hw/arm/
hw/arm/nseries.c:284:    s->ts.chip = tsc2301_init(penirq, kbirq, dav);
hw/arm/nseries.c:306:    s->ts.opaque = tsc2005_init(pintdav);
hw/arm/palm.c:88:    tsc = tsc2102_init(qdev_get_gpio_in(cpu->gpio,
PALMTE_PINTDAV_GPIO));
