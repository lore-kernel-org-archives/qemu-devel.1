Received: from eggs.gnu.org ([2001:4830:134:3::10]:52835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daj9W-0003ND-2a
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daj9S-00022v-S7
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:48:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170717133010.12784-1-f4bug@amsat.org>
	<CAFEAcA_rhoCup57nYYW4HN6Qsz3sp-cxY-OwsK-x=fYtfJ31aQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b48b8728-7cb3-3d6e-745f-1aee5c2038e6@amsat.org>
Date: Thu, 27 Jul 2017 10:48:26 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_rhoCup57nYYW4HN6Qsz3sp-cxY-OwsK-x=fYtfJ31aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm: use defined type name instead of
 hard-coded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>

On 07/27/2017 09:36 AM, Peter Maydell wrote:
> On 17 July 2017 at 14:30, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>
>> Hi Peter, this patch is waiting the IDE queue to enters since it depends of
>> commit de09efcc7b67ada3593354711b12a03dea23a9d0 to fix AHCI includes.
> 
> There's no commit with that hash in master -- do you have
> a commit subject or something that I can use to find out
> whether it's landed or not?

Oops I guess the IDE queue was rebased between this patch and the merge, 
or I messed my copy/paste :)

The dependent commit is 70e2337030f and has how entered /master, do you 
want me to send an v2 with fixed message? Anyway I delayed this patch 
for 2.11 since this is not a bugfix.

Regards,

Phil.
