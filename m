Received: from eggs.gnu.org ([209.51.188.92]:58201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ghHQy-0003K5-Ic
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:14:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ghHQm-0006zp-If
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:14:23 -0500
References: <20190109152430.32359-1-agraf@suse.de>
	<CAFEAcA9zugZiWirk9QjqmAO9QKhLdCAWuG1PX5z7Nxm4O69aTg@mail.gmail.com>
	<CAFEAcA8Xzi8GjzUtzxbFzxdCS4kn0Cps+_bF70ZS0KnH0W8SvQ@mail.gmail.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <92dba7da-f3fc-b7dc-6896-cf8d58cc7f17@suse.de>
Date: Wed, 9 Jan 2019 18:14:10 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Xzi8GjzUtzxbFzxdCS4kn0Cps+_bF70ZS0KnH0W8SvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] target/arm: Allow to switch from MON->HYP
 on AArch32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Stephen Warren <swarren@wwwdotorg.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 01/09/2019 05:59 PM, Peter Maydell wrote:
> On Wed, 9 Jan 2019 at 16:52, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On Wed, 9 Jan 2019 at 15:26, Alexander Graf <agraf@suse.de> wrote:
>>> In U-boot, we switch from S-SVC -> MON -> HYP when we want to enter
>>> HYP mode. This dance seems to work ok (hence it's there in the code
>>> base), but breaks with current QEMU.
> PS: it would be helpful if the commit message said how u-boot
> is trying to go from Mon to Hyp -- some ways to try to do
> this are OK, and some are not, so whether it's supposed to
> work or not depends on what u-boot is actually doing...

I don't fully understand all of it to be honest :). But the code is here:

http://git.denx.de/?p=u-boot.git;a=blob;f=arch/arm/cpu/armv7/nonsec_virt.S

What I managed to understand so far is that it goes to MON using the smc 
#0 call and then changes SPSR so that on return (movs pc) the mode will 
be different.

But please double check whether this is supposed to work - I don't find 
mode switching on ARM terribly intuitive ;).


Alex
