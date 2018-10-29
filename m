Received: from eggs.gnu.org ([2001:4830:134:3::10]:60719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHFqW-00013a-AE
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 18:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHFqS-00071i-4R
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 18:17:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHFqR-00071B-S7
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 18:17:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id b203-v6so9513401wme.5
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 15:17:11 -0700 (PDT)
References: <1540548409-22560-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8EubWya8ey9VxhaCw4m2U=KA+i2C-R9P-p+P6oEBBLew@mail.gmail.com>
	<7fc49925-36ff-bd9a-0cd7-e5f8d4bb3672@roeck-us.net>
	<CAFEAcA-UF+SyXvcU+NGZsbqBF2qg+s_x4HPU7yvf7B2G-=HPOg@mail.gmail.com>
	<b4f6cbd2-68fe-5b07-e8fb-93b1c4d8a6de@roeck-us.net>
	<2eb2b4ef-725d-cbee-1676-feb6bd800aea@redhat.com>
	<20181029202450.GB24689@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <034785b2-0126-e480-2f3f-2295152b11ae@redhat.com>
Date: Mon, 29 Oct 2018 23:17:06 +0100
MIME-Version: 1.0
In-Reply-To: <20181029202450.GB24689@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 29/10/18 21:24, Guenter Roeck wrote:
> On Mon, Oct 29, 2018 at 04:03:40PM +0100, Philippe Mathieu-Daudé wrote:
>> On 29/10/18 15:09, Guenter Roeck wrote:
>>> On 10/29/18 6:24 AM, Peter Maydell wrote:
>>>> On 27 October 2018 at 12:04, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>> On 10/26/18 3:12 AM, Peter Maydell wrote:
>>>>>> Hi Guenter; there's a proposal here to deprecate (and eventually
>>>>>> remove) the 'collie' board (strongarm) from QEMU. Is that one of
>>>>>> the ones you're currently using in your automated testing of Linux
>>>>>> kernels on QEMU?
>>>>>>
>>>>>
>>>>> Yes. I can run the test with older versions of qemu, so it is ok for me
>>>>> if it is removed (as long as that removal is not backported).

[...]

>>> Though not all of them are supported by upstream qemu. For some of them I
>>> carry local patches,
>>> for others I use out-of-tree versions of qemu (beagle/beaglexm).
>>
>> Are these patches upstream-able?
>>
> 
> Some of the patches (eg to be able to boot a Linux kernel image for mps2-an385
> directly from qemu, or zynq CPU clock rate changes to be able to do the same)
> have been rejected. A few patches were submitted at some point but got lost.
> I don't keep track, so I don't know the exact number. For some patches, such
> as basic BCM283x CPRMAN support (needed to boot raspi2), a better
> implementation was suggested, but didn't go anywhere as far as I know.
> 
> Some machines, such as beagle support, are from Linaro's tree and were never
> upstreamed by Linaro. The Linaro branch is based off qemu 2.3, so applying
> the changes to upstream qemu would be a major effort. I also use the m68k
> branch from github.com:vivier/qemu-m68k.git for m68k tests.
> 
> I carry some 20+ patches locally in my qemu tree. Some may be obsolete or
> not or no longer needed (my understanding of qemu is evolving). Sometimes,
> if and when I find the time, I pick some and try to upstream, but I often
> don't follow up if there is no response or if the requested changes are
> too substantial.
> 
> Please feel free to have a look at https://github.com/groeck/qemu
> (check the <version>-local branches) and let me know what might be
> upstreamable. I'll be happy to (re-)submit the respective patches.
> Note that I won't be able to make any substantial changes, though.
> Time is a scarce commodity nowadays, unfortunately.

Thank you for pointing your work, I'll try to salvage what I can.

Regards,

Phil.
