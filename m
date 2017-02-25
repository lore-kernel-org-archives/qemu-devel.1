Received: from eggs.gnu.org ([2001:4830:134:3::10]:34887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chV8U-0001AP-TM
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 00:43:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chV8R-0000w4-Sn
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 00:43:14 -0500
References: <cover.1487522123.git.balaton@eik.bme.hu>
	<5077e2a9732e1b9afcb0754e93624b787589ac61.1487522123.git.balaton@eik.bme.hu>
	<CAFEAcA8gde7GfWhyRLyOB5yL_5zrm4b7tj4pH=GTj=RwZO_4wg@mail.gmail.com>
	<alpine.BSF.2.20.1702242148080.76443@zero.eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2a70e96a-3f61-473a-519a-af867a050fad@redhat.com>
Date: Sat, 25 Feb 2017 06:43:07 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.20.1702242148080.76443@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/10] ppc: Add SM501 device in config for
 ppc and ppcemb targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 24.02.2017 21:51, BALATON Zoltan wrote:
> On Fri, 24 Feb 2017, Peter Maydell wrote:
>> On 19 February 2017 at 16:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>> This is not used by default on any emulated machine yet but it is
>>> still useful to have it compiled so it can be added from the command
>>> line for clients that can use it (e.g. MorphOS has no driver for any
>>> other emulated video cards but can output via SM501)
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>
>> If this is a generic PCI device then shouldn't it go into
>> default-configs/pci.mak ?
> 
> This is a multimedia chip usually found on sh4 systems and some ppc
> boards that's why I've only added it to these but I can move it to
> pci.mak if you think it's a better place for it.

If it is not really usable for other boards, then I think it should also
not go into pci.mak. No need to confuse the users of the other boards
with unusable PCI cards here.

 Thomas
