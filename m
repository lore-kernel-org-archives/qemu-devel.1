Received: from eggs.gnu.org ([2001:4830:134:3::10]:38391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flGF7-0005ZP-TJ
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 12:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flGF7-000298-1T
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 12:14:25 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180802144430.13870-1-peter.maydell@linaro.org>
	<20180802144430.13870-2-peter.maydell@linaro.org>
	<511b7c57-b182-43a0-44ce-e0e95cbbf5ca@amsat.org>
	<CAFEAcA-8rZisuN7fzop8VWsX0CLn5Q6wz86=stE78JDBPGU+hg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <53e81984-17d5-a55d-e421-e893bfe00def@amsat.org>
Date: Thu, 2 Aug 2018 13:14:10 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-8rZisuN7fzop8VWsX0CLn5Q6wz86=stE78JDBPGU+hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/ppc/prep: Remove ifdeffed-out stub
 of XCSR code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>, Alexander Graf <agraf@suse.de>, "patches@linaro.org" <patches@linaro.org>

On 08/02/2018 12:54 PM, Peter Maydell wrote:
> On 2 August 2018 at 16:45, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> While not directly use the harmless UnimplementedDevice?
>>
>>        create_unimplemented_device("ppc-xcsr", 0xfeff0000, 0x1000);
> 
> I preferred not to change the current behaviour for this
> API conversion. If the PPC/prep maintainers would like to
> use unimplemented-device they can easily do so as a a
> different patch...

Now I remember there is a behaviour change in using this device:
currently an access to this address space triggers
cpu::do_transaction_failed();
using UnimplementedDevice doesn't.

So better to do this change in a different patch indeed :)
