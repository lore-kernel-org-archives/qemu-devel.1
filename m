Received: from eggs.gnu.org ([2001:4830:134:3::10]:42751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWcGZ-0003OR-Mh
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 02:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWcGY-0000vz-Os
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 02:43:23 -0400
References: <20180622103528.28598-1-david@gibson.dropbear.id.au>
	<CAFEAcA8-jSMy-9R69d7zQoEL593iiR5xitaPh17JwNzo-2U=1g@mail.gmail.com>
	<e56f27b2-63da-a8ae-4473-e75f341ef275@ilande.co.uk>
	<20180623004105.GL612@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <16faa15d-1351-265b-2b1f-3b7f0b1d5034@ilande.co.uk>
Date: Sat, 23 Jun 2018 07:43:04 +0100
MIME-Version: 1.0
In-Reply-To: <20180623004105.GL612@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/25] ppc-for-3.0 queue
 2018-06-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 23/06/18 01:41, David Gibson wrote:

> On Fri, Jun 22, 2018 at 04:16:10PM +0100, Mark Cave-Ayland wrote:
> 11;rgb:ffff/ffff/ffff> On 22/06/18 16:03, Peter Maydell wrote:
>>
>>> On 22 June 2018 at 11:35, David Gibson <david@gibson.dropbear.id.au> wrote:
>>>> The following changes since commit 46012db666990ff2eed1d3dc199ab8006439a93b:
>>>>
>>>>     Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180619' into staging (2018-06-20 09:51:30 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>     git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180622
>>>>
>>>> for you to fetch changes up to e5ca28ecab5c69b7578e22391a66c97c3979ffd8:
>>>>
>>>>     spapr: Don't rewrite mmu capabilities in KVM mode (2018-06-22 14:19:07 +1000)
>>>>
>>>> ----------------------------------------------------------------
>>>> ppc patch queue 2018-06-22
>>>>
>>>> Another assorted patch of patches for ppc and spapr.
>>>>       * Rework of guest pagesize handling for ppc, which avoids guest
>>>>         visibly different behaviour between accelerators
>>>>       * A number of Pnv cleanups, working towards more complete POWER9
>>>>         support
>>>>       * Migration of VPA data, a significant bugfix
>>>
>>> Applied, thanks.
>>>
>>> -- PMM
>>
>> Looks like this is missing the 2 Mac commits I submitted that David added to
>> the PR this morning?
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg06540.html
>> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg06536.html
>>
>> David, did you forget to re-push the updated tag?
> 
> They just missed the window, sorry.  I merged them after I'd already
> tagged and tested the pull request.

Okay, as long as you didn't forget them :)

My confusion came from the fact that the emails you sent for the PR 
yesterday contained my patches as patches 24 and 25, although they 
aren't included in the cover letter or the github tag.


ATB,

Mark.
