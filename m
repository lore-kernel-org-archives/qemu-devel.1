Received: from eggs.gnu.org ([2001:4830:134:3::10]:50031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3QgO-00073B-1M
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 13:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3QgK-0004rk-UU
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 13:57:08 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36772
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e3QgK-0004qj-Nb
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 13:57:04 -0400
References: <1507583223-14819-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<CACXAS8CO9K4967T_BdShaNGpznSDXWCYdsBa43mwdvBHh=KZng@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <8fe7a20d-b525-9495-6f36-3f11764a43f3@ilande.co.uk>
Date: Sat, 14 Oct 2017 18:56:42 +0100
MIME-Version: 1.0
In-Reply-To: <CACXAS8CO9K4967T_BdShaNGpznSDXWCYdsBa43mwdvBHh=KZng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/8] sun4m : sparc32_dma tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 10/10/17 09:21, Artyom Tarasenko wrote:

> On Mon, Oct 9, 2017 at 11:06 PM, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> This patchset aims to tidy-up the sparc32_dma code by improving the
>> modelling of the espdma/ledma devices using both QOM and the memory
>> API which didn't exist when the code was first written.
>>
>> The result is that it is now possible to remove both the iommu_opaque
>> and is_ledma workarounds from the code.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

With some further experimentation I've found that making the esp/le
devices children of their respective espdma/ledma devices makes things a
lot cleaner.

I've also got another related patch to update the espdma/ledma
tracepoints to log the DMA transaction length, so I'll submit a v2 of
this with the additional changes shortly.


ATB,

Mark.
