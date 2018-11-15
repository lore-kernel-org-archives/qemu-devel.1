Received: from eggs.gnu.org ([2001:4830:134:3::10]:49491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNJQc-0005dS-11
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNJQa-0004Di-UZ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:19:33 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNJQY-0004BC-WE
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:19:31 -0500
Received: by mail-oi1-x244.google.com with SMTP id x202so5608776oif.13
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 07:19:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <93d68204-145c-28ce-e6d0-4a67d3c55b00@redhat.com>
References: <1542184999-11145-1-git-send-email-thuth@redhat.com>
	<3ba66e6c-2eeb-2352-252b-75487ad91916@redhat.com>
	<93d68204-145c-28ce-e6d0-4a67d3c55b00@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 15:19:07 +0000
Message-ID: <CAFEAcA9+jNE2sSFMpkbAvTPqEggYi+++FuJ1OQUFB+b+jcNtWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Jean-Christophe Dubois <jcd@tribudubois.net>

On 14 November 2018 at 12:00, Thomas Huth <thuth@redhat.com> wrote:
> On 2018-11-14 12:57, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Thomas,
>>
>> On 14/11/18 9:43, Thomas Huth wrote:
>>> Add entries for the boards "mcimx6ul-evk", "mcimx7d-sabre", "raspi2",
>>> "raspi3", "sabrelite", "vexpress-a15", "vexpress-a9" and "virt".
>>> While we're at it, also adjust the "i.MX31" section a little bit,
>>> so that the wildcards there do not match anymore for unrelated files
>>> (e.g. the new hw/misc/imx6ul_ccm.c file).
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   MAINTAINERS | 70
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>>>   1 file changed, 65 insertions(+), 5 deletions(-)
> [...]
>>> @@ -604,6 +651,12 @@ L: qemu-arm@nongnu.org
>>>   S: Maintained
>>>   F: hw/*/stellaris*
>>>   +Versatile Express
>>> +M: Peter Maydell <peter.maydell@linaro.org>
>>> +L: qemu-arm@nongnu.org
>>> +S: Maintained
>>
>> Shouldn't this be 'Supported?'
>> "Someone is actually paid to look after this."
>
> Not sure whether Peter is paid for looking after the
> Versatile Express board??

It's in the same boat as most of these older boards:
I'll review patches and investigate bug reports, but
I'm not actively working on it.

>>> +F: hw/arm/vexpress.c
>>> +
>>>   Versatile PB
>>>   M: Peter Maydell <peter.maydell@linaro.org>
>>>   L: qemu-arm@nongnu.org
>>> @@ -611,6 +664,13 @@ S: Maintained
>>>   F: hw/*/versatile*
>>>   F: hw/misc/arm_sysctl.c
>>>   +Virt
>>> +M: Peter Maydell <peter.maydell@linaro.org>
>>> +L: qemu-arm@nongnu.org
>>> +S: Maintained
>>
>> This one is certainly 'Supported'.
>
> Maybe ... Peter could you adjust this when picking up the patch?

I don't list myself as Supported for target/arm either,
so it seems a bit odd to use Supported here...

Applied to target-arm.next, thanks.

thanks
-- PMM
