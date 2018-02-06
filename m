Received: from eggs.gnu.org ([2001:4830:134:3::10]:55803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1eixnN-0002kb-Hz
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:36:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1eixnK-0000eN-DZ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:36:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:53691)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1eixnK-0000dZ-3g
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:35:58 -0500
References: <20180124232625.30105-1-richard.henderson@linaro.org>
	<20180124232625.30105-43-richard.henderson@linaro.org>
	<a38ff4ee-90a1-64e0-fb8c-4ad2de61c844@amsat.org>
From: Helge Deller <deller@gmx.de>
Message-ID: <2771b4dc-ade8-d1fb-4382-e83da8da9799@gmx.de>
Date: Tue, 6 Feb 2018 08:35:51 +0100
MIME-Version: 1.0
In-Reply-To: <a38ff4ee-90a1-64e0-fb8c-4ad2de61c844@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 42/45] pc-bios: Add hppa-firmware.img
 and git submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 04.02.2018 23:40, Philippe Mathieu-Daudé wrote:
> Hi Helge,

Hi Philippe,

> On 01/24/2018 08:26 PM, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  Makefile                  |   3 ++-
>>  .gitmodules               |   3 +++
>>  pc-bios/hppa-firmware.img | Bin 0 -> 461352 bytes
>>  roms/seabios-hppa         |   1 +
>>  4 files changed, 6 insertions(+), 1 deletion(-)
>>  create mode 100755 pc-bios/hppa-firmware.img
>>  create mode 160000 roms/seabios-hppa

>> diff --git a/.gitmodules b/.gitmodules
>> index 1500579638..7a8282df46 100644
>> --- a/.gitmodules
>> +++ b/.gitmodules
>> @@ -40,3 +40,6 @@
>>  [submodule "capstone"]
>>  	path = capstone
>>  	url = git://git.qemu.org/capstone.git
>> +[submodule "roms/seabios-hppa"]
>> +	path = roms/seabios-hppa
>> +	url = git://github.com/hdeller/seabios-hppa.git
> 
> Do you think it is possible your SeaBIOS work gets merged upstream at
> some time?

Yes, that's my plan.
My changes to the common code base aren't too invasive yet, so
hopefully it's possible.

Helge
