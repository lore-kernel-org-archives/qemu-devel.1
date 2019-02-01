Received: from eggs.gnu.org ([209.51.188.92]:54831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gpiKR-0003zg-KN
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gpiKJ-0004mY-Bh
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:34:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gpiKG-0004j3-TE
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:34:26 -0500
References: <20190124203959.30875-1-lersek@redhat.com>
	<d4db23b5-8b6d-999f-d127-466a8acf040c@redhat.com>
	<20190201172251-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a2e1d4b3-ee97-639e-359f-2eb67f588dc7@redhat.com>
Date: Sat, 2 Feb 2019 00:34:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190201172251-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] add the BiosTablesTest UEFI app,
 build it with the new roms/edk2 submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 02/01/19 23:24, Michael S. Tsirkin wrote:
> On Thu, Jan 31, 2019 at 03:23:50PM +0100, Laszlo Ersek wrote:
>> On 01/24/19 21:39, Laszlo Ersek wrote:
>>> Previous version (v1):
>>> http://mid.mail-archive.com/20190118223400.24311-1-lersek@redhat.com
>>>
>>> Updates in v2 have been noted on each patch in the series.
>>
>> ping
> 
> Oh sorry I noticed Philippe reported some failures with this patchset.
> Can you guys pls get to the bottom of it?

Right, we've now got all the info that's needed for me to submit v3.
What's still necessary is a good amount of sleep. :)

> I don't want everyone to suffer.

Thankfully, this Makefile could only cause a handful of maintainers to
suffer, and only if they decided to rebuild the ACPI-test-helper
UEFI-bootable ISO images :) The normal QEMU build (including the test
suite run) doesn't go near this stuff. The usage pattern is the same as
when Gerd manually rebuilds the iPXE oproms.

Thanks,
Laszlo
