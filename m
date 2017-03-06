Received: from eggs.gnu.org ([2001:4830:134:3::10]:36070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ckxT5-0006yr-FG
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ckxT1-0002Od-Fj
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:34:47 -0500
Date: Mon, 6 Mar 2017 19:34:40 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA8oWmN8tE66XsviXnBxtP5w+WLijXxsGk+6RwRquRo9Gw@mail.gmail.com>
Message-ID: <alpine.BSF.2.20.1703061913040.39075@zero.eik.bme.hu>
References: <cover.1488504063.git.balaton@eik.bme.hu>
	<cc6a20fc4a2748f24920c03ce64ae34af0f61799.1488504063.git.balaton@eik.bme.hu>
	<d5475df8-290b-07d4-d177-979d78850615@redhat.com>
	<CAFEAcA90FRxghG0ZdH7H9y2bDk2U9XO1TUJgx0MN+N=7LzO5pQ@mail.gmail.com>
	<4a30ecb4-77d0-795f-bf61-378546a8b034@redhat.com>
	<CAFEAcA8oWmN8tE66XsviXnBxtP5w+WLijXxsGk+6RwRquRo9Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v3 13/13] ppc: Add SM501 device in config
 for ppc and ppcemb targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On Mon, 6 Mar 2017, Peter Maydell wrote:
> On 6 March 2017 at 09:52, Thomas Huth <thuth@redhat.com> wrote:
>> I guess we could do something like that on ppc, too (and ppc-softmmu.mak
>> should likely include ppcemb-softmmu.mak), but
>> that's something for QEMU 2.10 / 3.0 / whichever version will be next.
>
> Yeah, definitely 2.10 material (so is this whole series, but
> let's not tangle it up with an unrelated cleanup).

Thanks for all the comments investigations and reviews, which were really 
helpful. I'll test your suggestions and send another version if found to 
be needed but I don't have access to real hardware to test on, so I can't 
confirm this other than using images that are known to work on real 
hardware and I only have those for PPC. So I cannot test LE guest more 
than using the Linux images available on the net but can't guarantee those 
are not buggy. The current version (however unlikely) does work for both 
the more or less known good PPC images and the SH images I could find so 
this is the most likely correct combination given the test cases. I'm 
fairly sure the big endian case is correct and the SH LE case works better 
with the images available so unless there's another image that is known to 
work on SH, this is the best I could do.

If there is no chance to get this in for 2.9 (considering it changes a 
relatively unmaintained and unused part, so the risk of breaking something 
important is very low) then let's get back to this about a month from now 
because no point to spend time on it if it just gets forgotten until the 
next chance to get it merged. Unless you can take it during the freeze 
I'll pick this up later when the window opens again. (By the way, the 
planning link on the wiki still points to 2.8.)

Regards,
BALATON Zoltan
