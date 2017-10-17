Received: from eggs.gnu.org ([2001:4830:134:3::10]:50789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4PlF-0002PY-Ua
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4PlA-00071V-So
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:10:13 -0400
References: <20171017001209.32276-1-f4bug@amsat.org>
	<20171017001209.32276-31-f4bug@amsat.org>
	<44b57d76-6d10-84c8-3a13-cdac7331c5d9@redhat.com>
	<47c7b41d-23ff-3dd1-9c07-69bd5df08685@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d1f23a08-364b-b9c3-fec1-495ce9ce9e47@redhat.com>
Date: Tue, 17 Oct 2017 13:09:54 +0200
MIME-Version: 1.0
In-Reply-To: <47c7b41d-23ff-3dd1-9c07-69bd5df08685@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 30/39] hw/display/vga: remove the old
 i386/pc dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 17.10.2017 12:49, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
>>> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
>>> index ad34a1f048..fe23b81442 100644
>>> --- a/hw/display/vga_int.h
>>> +++ b/hw/display/vga_int.h
>>> @@ -25,8 +25,9 @@
>>>  #ifndef HW_VGA_INT_H
>>>  #define HW_VGA_INT_H
>>> =20
>>> -#include "hw/hw.h"
>>> +#include "exec/ioport.h"
>>>  #include "exec/memory.h"
>>> +#include "ui/console.h"
>>
>> So vga_int.h now includes console.h (is it really necessary?) ...
>=20
> The VGACommonState struct has a GraphicHwOps *hw_ops member.

Ok, thanks, I just wanted to confirm that this is needed here.

[...]
> Do you suggest me do declare GraphicHwOps opaque in "qemu/typedefs.h"?

No, I think it's fine if you keep the #include in vga_int.h, I just
wanted to make sure that it is really needed there. So please just
remove the #includes from the .c files instead.

 Thomas
