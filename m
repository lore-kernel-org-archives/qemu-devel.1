Received: from eggs.gnu.org ([208.118.235.92]:58981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMtr1-0000Cu-BK
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMtqv-0002rh-Af
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:01:07 -0500
References: <1542184999-11145-1-git-send-email-thuth@redhat.com>
	<3ba66e6c-2eeb-2352-252b-75487ad91916@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <93d68204-145c-28ce-e6d0-4a67d3c55b00@redhat.com>
Date: Wed, 14 Nov 2018 13:00:18 +0100
MIME-Version: 1.0
In-Reply-To: <3ba66e6c-2eeb-2352-252b-75487ad91916@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add entries for missing ARM
 boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Jean-Christophe Dubois <jcd@tribudubois.net>

On 2018-11-14 12:57, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 14/11/18 9:43, Thomas Huth wrote:
>> Add entries for the boards "mcimx6ul-evk", "mcimx7d-sabre", "raspi2",
>> "raspi3", "sabrelite", "vexpress-a15", "vexpress-a9" and "virt".
>> While we're at it, also adjust the "i.MX31" section a little bit,
>> so that the wildcards there do not match anymore for unrelated files
>> (e.g. the new hw/misc/imx6ul_ccm.c file).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 MAINTAINERS | 70
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>> =C2=A0 1 file changed, 65 insertions(+), 5 deletions(-)
[...]
>> @@ -604,6 +651,12 @@ L: qemu-arm@nongnu.org
>> =C2=A0 S: Maintained
>> =C2=A0 F: hw/*/stellaris*
>> =C2=A0 +Versatile Express
>> +M: Peter Maydell <peter.maydell@linaro.org>
>> +L: qemu-arm@nongnu.org
>> +S: Maintained
>=20
> Shouldn't this be 'Supported?'
> "Someone is actually paid to look after this."

Not sure whether Peter is paid for looking after the Versatile Express
board??

>> +F: hw/arm/vexpress.c
>> +
>> =C2=A0 Versatile PB
>> =C2=A0 M: Peter Maydell <peter.maydell@linaro.org>
>> =C2=A0 L: qemu-arm@nongnu.org
>> @@ -611,6 +664,13 @@ S: Maintained
>> =C2=A0 F: hw/*/versatile*
>> =C2=A0 F: hw/misc/arm_sysctl.c
>> =C2=A0 +Virt
>> +M: Peter Maydell <peter.maydell@linaro.org>
>> +L: qemu-arm@nongnu.org
>> +S: Maintained
>=20
> This one is certainly 'Supported'.

Maybe ... Peter could you adjust this when picking up the patch?

 Thanks,
  Thomas
