Received: from eggs.gnu.org ([209.51.188.92]:42616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggPsA-0005cY-17
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggPs9-00050U-5m
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:02:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ggPs9-0004zt-09
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:02:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so42170852wrt.11
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 00:02:56 -0800 (PST)
References: <20190104175847.6290-1-philmd@redhat.com>
	<20190104175847.6290-10-philmd@redhat.com>
	<4821a853-bd25-7972-66dd-95092d216868@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8f7d5445-e138-6208-3381-5c70d49db28e@redhat.com>
Date: Mon, 7 Jan 2019 09:02:53 +0100
MIME-Version: 1.0
In-Reply-To: <4821a853-bd25-7972-66dd-95092d216868@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/16] hw/devices: Move TI touchscreen
 declarations into a new header
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

On 1/7/19 8:22 AM, Thomas Huth wrote:
> On 2019-01-04 18:58, Philippe Mathieu-Daudé wrote:
>> Since uWireSlave is only used in this new header, there is no
>> need to expose it via "qemu/typedefs.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  MAINTAINERS                     |  2 ++
>>  hw/arm/nseries.c                |  2 +-
>>  hw/arm/palm.c                   |  2 +-
>>  hw/input/tsc2005.c              |  2 +-
>>  hw/input/tsc210x.c              |  4 ++--
>>  include/hw/arm/omap.h           |  6 +-----
>>  include/hw/devices.h            | 14 --------------
>>  include/hw/input/ti_uwire_tsc.h | 28 ++++++++++++++++++++++++++++
> 
> I'd maybe rather name the new file "tsc2xxx.h" instead, so that it
> resembles the names of the .c files. Just my 0.02 €.

Good idea :)
