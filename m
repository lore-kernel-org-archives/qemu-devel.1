Received: from eggs.gnu.org ([209.51.188.92]:57790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@csgraf.de>) id 1h0l2e-0001TW-RL
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:41:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@csgraf.de>) id 1h0l2d-0001mp-U7
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:41:52 -0500
Received: from zulu616.server4you.de ([188.138.100.120]:46938)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@csgraf.de>) id 1h0l2d-0001mV-KV
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:41:51 -0500
References: <CAFEAcA_-wNGz_ftDziARUwzL2Lc+1kkoMTo0OxV4UVwbTr8EaQ@mail.gmail.com>
	<9b211327-06a8-9739-e984-4b05557c12b4@suse.de>
	<20190104050301.GB2801@umbus.fritz.box>
	<CAFEAcA9fyHiKOA7bDr8c_05C6rX_CYdj8nP+xFFSH_4uWbokhQ@mail.gmail.com>
	<20190304083806.GA12893@umbus.fritz.box>
From: Alexander Graf <agraf@csgraf.de>
Message-ID: <2909f1ff-4714-50f5-64c6-2a0712510837@csgraf.de>
Date: Mon, 4 Mar 2019 11:41:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190304083806.GA12893@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] can we update QEMU's version of u-boot.e500 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 04.03.19 09:38, David Gibson wrote:
> On Thu, Feb 28, 2019 at 01:23:38PM +0000, Peter Maydell wrote:
>> On Fri, 4 Jan 2019 at 05:22, David Gibson <david@gibson.dropbear.id.au> wrote:
>>>
>>> On Fri, Jan 04, 2019 at 12:44:59AM +0100, Alexander Graf wrote:
>>>>
>>>>
>>>> On 03.01.19 18:38, Peter Maydell wrote:
>>>>> Hi; currently we ship with a u-boot.e500 which is from u-boot
>>>>> v2017.07. It would be nice to move that forward, specifically
>>>>> to at least v2017.11, which contains upstream u-boot's part of the
>>>>> fix for https://bugs.launchpad.net/qemu/+bug/1714750 .
>>>>> (There are more recent releases than that; it's just the first
>>>>> that contains the fix.)
>>>>>
>>>>> Then we could remove the workaround in scripts/make-release and
>>>>> close out the bug.
>>>>>
>>>>> I've cc'd David as the current maintainer of pc-bios/u-boot.e500
>>>>> and Alex as the last person who did an update.
>>>>
>>>> I think it's a great idea to update it.
>>>>
>>>> David, do you want to do that or rather have me send a patch?
>>>
>>> Please send a patch.
>>>
>>> I'm maintainer of all the ppc boards by default, but I really don't
>>> know anything much about e500 or u-boot.
>>
>> Hi -- any progress on this ? It would be nice to update the u-boot
>> blob before QEMU hits softfreeze for the next release in a
>> couple of weeks...
> 
> It would.  If there's been another patch, I haven't seen it though.

I wanted to build that on a PPC machine, but then realized I'd first
have to set up a PPC VM to actually build on (as the host is LE), and
that then somehow never happened.

Either way, I set myself up with a local cross compilation setup now, so
you should ideally have a patch that bumps U-Boot on e500 to 2019.01.


Alex
