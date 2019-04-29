Received: from eggs.gnu.org ([209.51.188.92]:47107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL8nb-0006iX-LQ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL8nX-00007j-JJ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:06:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL8nX-00007A-Bm
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:06:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id a9so16880029wrp.6
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:06:31 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-17-thuth@redhat.com>
	<98855a34-ff5a-896f-7959-480b89d62833@redhat.com>
	<b78d5517-5f23-6028-6726-b60f916f22fd@redhat.com>
	<CAFEAcA8xWTwbU6RSBbQkF2j5OfozEq9g3Pq83KyYG_J1CqGM-A@mail.gmail.com>
	<3f8cad24-3eb9-4c05-063e-196e27184f90@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <399a3be9-332e-fe3a-570b-4c1e43cbe2d9@redhat.com>
Date: Mon, 29 Apr 2019 18:06:27 +0200
MIME-Version: 1.0
In-Reply-To: <3f8cad24-3eb9-4c05-063e-196e27184f90@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 16/29] hw/arm: Express
 dependencies of the virt machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Yang Zhong <yang.zhong@intel.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Rob Herring <robh@kernel.org>, Qemu-block <qemu-block@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>

On 4/29/19 6:02 PM, Thomas Huth wrote:
> On 29/04/2019 17.53, Peter Maydell wrote:
>> On Mon, 29 Apr 2019 at 16:34, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> On 25/04/2019 17.53, Philippe Mathieu-Daudé wrote:
>>>> Hi Thomas,
>>>>
>>>> On 4/18/19 8:00 PM, Thomas Huth wrote:
>>>>> Dependencies have been determined by looking at hw/arm/virt.c
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  default-configs/arm-softmmu.mak | 11 +----------
>>>>>  hw/arm/Kconfig                  | 19 +++++++++++++++++++
>>>>>  hw/arm/Makefile.objs            |  3 ++-
>>>>>  3 files changed, 22 insertions(+), 11 deletions(-)
>>
>>>> Without -nodefaults I get:
>>>> qemu-system-aarch64: Unsupported NIC model: virtio-net-pci
>>>> This is expected.
>>>
>>> Yes, it should still work with "-nic none" or "-nodefaults".
>>
>> Er, if you need either -nic none or -nodefaults after this
>> patch then this would be a change in behaviour, which seems
>> wrong to me.
> 
> No worry, this only applies to compiling builds where you run "configure
>  --without-default-devices". For normal builds, virtio-net should still
> be included fine. ... at least I hope this is what Philippe was talking
> about ... but for me it's working fine when I run "configure" normally.

Yes, I tested both cases, without --without-default-devices it works as
expected (no behaviour change). With --without-default-devices (this is
a new configure switch) it is probably required to run QEMU with
-nodefaults.
