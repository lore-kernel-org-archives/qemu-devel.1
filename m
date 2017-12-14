Received: from eggs.gnu.org ([2001:4830:134:3::10]:56734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePUCh-0000DV-VA
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePUCc-0005RE-9l
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:09:40 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-gEjU+rBWSL8V4d520DOVheZoJZ76p5=9hmkXk3NqeOw@mail.gmail.com>
References: <20171211213007.7353-1-andrew.smirnov@gmail.com>
	<CAFEAcA-gEjU+rBWSL8V4d520DOVheZoJZ76p5=9hmkXk3NqeOw@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 14 Dec 2017 06:09:25 -0800
Message-ID: <CAHQ1cqHqhNKVW_vV5G8wU_d_Cu0+9ThpkKdXQ4-LqEXjL0sc9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/13] i.MX FEC and SD changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Tue, Dec 12, 2017 at 9:40 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 11 December 2017 at 21:29, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>> Hi everyone,
>>
>> This patchset is a spin-off from original i.MX7 support submission
>> found here [1], containing all of the patchest that are more or less
>> agreed upon and are ready (hopefully!) for inclusion.
>>
>> Changes since [1]:
>>
>>         - Rx buffer in FEC was moved from stack to heap to allow
>>           worry-free expansion to 16K limit.
>>
>>         - Added more comments explaining rather convoluted bit-moving
>>           in eSHDC emuation code
>>
>>         - Triple Tx ring DMA "VMState" code was changed to follow
>>           Peter's recommendations (avoiding the need to incrememnt the
>>           version_id)
>>
>>         - FSL_IMX25_FEC_SIZE is used as a size of FEC's register file
>>
>>         - Removed leftover code from "imx_fec: Change queue flushing
>>           heuristics"
>>
>> [1] https://lists.gnu.org/archive/html/qemu-arm/2017-11/msg00045.html
>
> Hi; thanks for sending this set separately. Patch 4 ("Move Tx frame buffer
> away from the stack") seems to have got lost -- it isn't in the mailing
> list archives or my mailbox. Could you try resending that one?
>

My bad, I forgot to add correct Cc tags to that one. I am a bit
surprised it's not in the archive since it did have correct To: info,
but it doesn't matter. I'll make sure this patch is sent out in v2.

> Incidentally we should use the new i.MX SDHCI controller in the
> imx6: coincidentally somebody ran into this bug recently:
> https://stackoverflow.com/questions/47538951/qemu-freescale-i-mx6-duallite-sabre-root-filesystem-does-not-mount/47552596
>
> I'll retest that this patchset works with my imx6 image, and
> send a patch to sit on top of it to switch imx6 over to TYPE_IMX_USDHC.
>

Out of curiosity, I gave emulating SD on i.MX6 a try and it mostly
worked (there were other unrelated to SD problems).  I'll include what
I came up with and we can go from there.

Thanks,
Andrey Smirnov
