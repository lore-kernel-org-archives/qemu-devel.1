Received: from eggs.gnu.org ([2001:4830:134:3::10]:48482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHQAG-0007nT-Al
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHQA4-0000pE-OF
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:18:17 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1540548409-22560-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8EubWya8ey9VxhaCw4m2U=KA+i2C-R9P-p+P6oEBBLew@mail.gmail.com>
	<7fc49925-36ff-bd9a-0cd7-e5f8d4bb3672@roeck-us.net>
	<CAFEAcA-UF+SyXvcU+NGZsbqBF2qg+s_x4HPU7yvf7B2G-=HPOg@mail.gmail.com>
	<b4f6cbd2-68fe-5b07-e8fb-93b1c4d8a6de@roeck-us.net>
Date: Tue, 30 Oct 2018 10:17:51 +0100
In-Reply-To: <b4f6cbd2-68fe-5b07-e8fb-93b1c4d8a6de@roeck-us.net> (Guenter
	Roeck's message of "Mon, 29 Oct 2018 07:09:29 -0700")
Message-ID: <87pnvriyio.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/2] Deprecate the "collie" machine and
 Strongarm devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Guenter Roeck <linux@roeck-us.net> writes:

> On 10/29/18 6:24 AM, Peter Maydell wrote:
>> On 27 October 2018 at 12:04, Guenter Roeck <linux@roeck-us.net> wrote:
>>> On 10/26/18 3:12 AM, Peter Maydell wrote:
>>>> Hi Guenter; there's a proposal here to deprecate (and eventually
>>>> remove) the 'collie' board (strongarm) from QEMU. Is that one of
>>>> the ones you're currently using in your automated testing of Linux
>>>> kernels on QEMU?
>>>>
>>>
>>> Yes. I can run the test with older versions of qemu, so it is ok for me
>>> if it is removed (as long as that removal is not backported).
>>
>> Mmm, but if we have an active user who's testing them then they
>> probably shouldn't be in the frontline of boards to remove.
>> Which other boards do you test with mainline QEMU?
>>
>
> For arm:
>
> akita
> ast2500-evb
> beagle
> beaglexm
> borzoi
> collie
> cubieboard
> imx25-pdk
> integratorcp
> kzm
> mainstone
> midway
> mps2-an385
> overo
> palmetto-bmc
> raspi2
> realview-eb
> realview-eb-mpcore
> realview-pb-a8
> realview-pbx-a9
> romulus-bmc
> sabrelite
> smdkc210
> spitz
> terrier
> tosa
> versatileab
> versatilepb
> vexpress-a15
> vexpress-a15-a7
> vexpress-a9
> witherspoon-bmc
> xilinx-zynq-a9
> z2
>
> Though not all of them are supported by upstream qemu. For some of them I carry local patches,
> for others I use out-of-tree versions of qemu (beagle/beaglexm).

Would it be possible to get useful parts of your automated testing into
upstream QEMU's CI?

I'm asking because I think we should require at least a smoke test in CI
for all machine types, and drop the ones that lack it.  Not today, but
in the not-too-distant future.
