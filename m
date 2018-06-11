Received: from eggs.gnu.org ([2001:4830:134:3::10]:39205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSOXr-0005AW-97
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSOXm-0000ga-JE
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:15:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180601144328.23817-1-peter.maydell@linaro.org>
	<CAFEAcA__A1a3xwdP+_6vzraNafTu3NPY+mj=5vhEAJpEcAY=3Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <29b8e247-acdd-5569-dc11-7d17883684fe@amsat.org>
Date: Mon, 11 Jun 2018 12:15:37 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA__A1a3xwdP+_6vzraNafTu3NPY+mj=5vhEAJpEcAY=3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/2] armv7m: Remove
 armv7m_init() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>, "patches@linaro.org" <patches@linaro.org>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>

On 06/11/2018 11:04 AM, Peter Maydell wrote:
> Ping for code review?
> 
> thanks
> -- PMM
> 
> On 1 June 2018 at 15:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>> The armv7m_init() function is a legacy from before we properly QOMified
>> ARMv7M, and it has some flaws:
>>
>>  * it combines work that needs to be done by an SoC object (creating
>>    and initializing the TYPE_ARMV7M object) with work that needs to
>>    be done by the board model (setting the system up to load the ELF
>>    file specified with -kernel)
>>  * TYPE_ARMV7M creation failure is fatal, but an SoC object wants to
>>    arrange to propagate the failure outward
>>  * it uses allocate-and-create via qdev_create() whereas the current
>>    preferred style for SoC objects is to do creation in-place
>>
>> This patchset fixes the only current caller (the stellaris board)
>> to not use it, and then removes the function.

Good cleanup.

>>
>> New board and SoC models should do the two jobs this function
>> was doing themselves, in the right places and with whatever their
>> preferred style/error handling is.
>>
>> (I've cc'd the people working on the nRF51 SoC model, as a heads-up
>> that they'll need to update their code so it compiles once this
>> hits master.)
>>
>> thanks
>> -- PMM
>>
>> Peter Maydell (2):
>>   stellaris: Stop using armv7m_init()
>>   hw/arm/armv7m: Remove unused armv7m_init() function
>>
>>  include/hw/arm/arm.h |  8 ++------
>>  hw/arm/armv7m.c      | 21 ---------------------
>>  hw/arm/stellaris.c   | 12 ++++++++++--
>>  3 files changed, 12 insertions(+), 29 deletions(-)
> 

Series:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
