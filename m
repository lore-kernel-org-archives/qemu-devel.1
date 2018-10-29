Received: from eggs.gnu.org ([2001:4830:134:3::10]:57241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gH95C-0006Mr-5G
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gH958-0000vr-8r
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:03:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gH956-0000qB-9q
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:03:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id l26-v6so8582785wmh.3
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 08:03:44 -0700 (PDT)
References: <1540548409-22560-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8EubWya8ey9VxhaCw4m2U=KA+i2C-R9P-p+P6oEBBLew@mail.gmail.com>
	<7fc49925-36ff-bd9a-0cd7-e5f8d4bb3672@roeck-us.net>
	<CAFEAcA-UF+SyXvcU+NGZsbqBF2qg+s_x4HPU7yvf7B2G-=HPOg@mail.gmail.com>
	<b4f6cbd2-68fe-5b07-e8fb-93b1c4d8a6de@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2eb2b4ef-725d-cbee-1676-feb6bd800aea@redhat.com>
Date: Mon, 29 Oct 2018 16:03:40 +0100
MIME-Version: 1.0
In-Reply-To: <b4f6cbd2-68fe-5b07-e8fb-93b1c4d8a6de@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Guenter Roeck <linux@roeck-us.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

Hi Guenter,

On 29/10/18 15:09, Guenter Roeck wrote:
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
> Though not all of them are supported by upstream qemu. For some of them 
> I carry local patches,
> for others I use out-of-tree versions of qemu (beagle/beaglexm).

Are these patches upstream-able?

If not, what do we need to get them into upstream qemu?

Thanks,

Phil.
