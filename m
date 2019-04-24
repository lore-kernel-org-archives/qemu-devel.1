Received: from eggs.gnu.org ([209.51.188.92]:48455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJNDl-0000fs-9d
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJNDj-0008Ca-FR
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:06:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hJNDj-00088T-1q
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:06:15 -0400
References: <20190423171520.4511-1-lersek@redhat.com>
	<CAFEAcA9B-FpTySXUKTxYaw=8V=to0VTjCAvCAMGF-x=yQY3G9A@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4cd50d7f-867d-8e90-7331-400d0548f4f5@redhat.com>
Date: Wed, 24 Apr 2019 21:06:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9B-FpTySXUKTxYaw=8V=to0VTjCAvCAMGF-x=yQY3G9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/12] bundle edk2 platform firmware with
 QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michal Privoznik <mprivozn@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 04/24/19 15:47, Peter Maydell wrote:
> On Tue, 23 Apr 2019 at 18:15, Laszlo Ersek <lersek@redhat.com> wrote:
>>
>> Picked up the new feedback tags from the v4 thread, which had been
>> posted at:
>> - https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01549.html
>> - http://mid.mail-archive.com/20190409230022.6462-1-lersek@redhat.com
>>
>> The following changes since commit eeba63fc7fface36f438bcbc0d3b02e7dcb59983:
>>
>>   Update version for v4.0.0-rc4 release (2019-04-16 21:53:00 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/lersek/qemu.git tags/edk2-pull-2019-04-22
>>
>> for you to fetch changes up to 6739df3fafaa3e2ec37af23fd77d2119869f4a4f:
>>
>>   MAINTAINERS: add the "EDK2 Firmware" subsystem (2019-04-17 15:38:35 +0200)
>>
>> ----------------------------------------------------------------
>> Advance the roms/edk2 submodule to the "edk2-stable201903" release, and
>> build and capture platform firmware binaries from that release. The
>> binaries are meant to be used by both end-users and by the "BIOS tables"
>> unit tests in qtest ("make check").
>>
>> ----------------------------------------------------------------
>> Laszlo Ersek (12):
>>       roms: lift "edk2-funcs.sh" from "tests/uefi-test-tools/build.sh"
>>       roms/edk2-funcs.sh: require gcc-4.8+ for building i386 and x86_64
>>       tests/uefi-test-tools/build.sh: work around TianoCore#1607
>>       roms/edk2: advance to tag edk2-stable201903
>>       roms/edk2-funcs.sh: add the qemu_edk2_get_thread_count() function
>>       roms/Makefile: replace the $(EDK2_EFIROM) target with "edk2-basetools"
>>       roms: build edk2 firmware binaries and variable store templates
>>       pc-bios: add edk2 firmware binaries and variable store templates
>>       pc-bios: document the edk2 firmware images; add firmware descriptors
>>       tests: add missing dependency to build QTEST_QEMU_BINARY, round 2
>>       Makefile: install the edk2 firmware images and their descriptors
>>       MAINTAINERS: add the "EDK2 Firmware" subsystem
> 
> 
> 
> Applied, thanks.

Awesome, thanks!

I'll soon get to work on <https://bugs.launchpad.net/qemu/+bug/1821884>.

> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
> for any user-visible changes.

Done, at <https://wiki.qemu.org/ChangeLog/4.1#Miscellaneous>.

Thanks!
Laszlo
