Received: from eggs.gnu.org ([2001:4830:134:3::10]:52622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dk7CB-0008Ay-3h
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dk7C7-0003Ng-Uo
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:18:07 -0400
Date: Tue, 22 Aug 2017 13:18:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20170822023521.GZ12356@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1708221310280.67133@zero.eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<5e493fd14e60d92d4fd80492ceff5ba13eb7b558.1502643878.git.balaton@eik.bme.hu>
	<20170818061028.GU5509@umbus.fritz.box>
	<alpine.BSF.2.21.1708181436550.19483@zero.eik.bme.hu>
	<20170822023521.GZ12356@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 12/12] ppc: Add aCube Sam460ex board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>

On Tue, 22 Aug 2017, David Gibson wrote:
> On Fri, Aug 18, 2017 at 02:46:42PM +0200, BALATON Zoltan wrote:
>> On Fri, 18 Aug 2017, David Gibson wrote:
>>> On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
>>>> Add emulation of aCube Sam460ex board based on AMCC 460EX embedded S=
oC.
>>>> This is not a full implementation yet with a lot of components still
>>>> missing but enough to start a Linux kernel and the U-Boot firmware.
>>>>
>>>> Signed-off-by: Fran=E7ois Revol <revol@free.fr>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>
>>> There are a *lot* of devices defined here.  Most of them look like
>>> they belong to the SoC, not the board (since they use DCRs), so it
>>> doesn't really make sense to define them in a board file.  It would
>>> also make it easier to review if they were split up into separate
>>> patches.
>>
>> I thought it's simpler to review a series with 12 reasonably sized pat=
ches
>> than one with twice as many which only modify a few lines here and the=
re
>> each. Also adding a lot of code scattered in hw directories is probabl=
y less
>> clear than having them all at one place. But of course each approach c=
an be
>> reasoned. I thought this might have to be split up but I've left it on=
e
>> place for now for first review to get some advice on what's preferred.
>
> Well, it depends on the content of the patches.  If splitting it up
> means a lot of looking between patches to make sense of what's going
> on then that's certainly not good.  But if the small patches are
> independent of each other and can be assessed on their own merits,
> then that usually makes it easier.
>
> In this case the various new 440 devices should be pretty much
> independent of each other, so I think splitting is the better option.
>
>> Maybe I should put things that belong to the SoC in ppc440_uc.c (simil=
ar to
>> ppc405uc.c we already have) and move common devices used by both to
>> ppc4xx_devs.c (which already seems to serve that purpose). If more cle=
anup
>> is needed that could be done separately afterwards, I don't think it's=
 a
>> good idea to mix in too much cleanup now to keep patches relatively si=
mple.
>> (I already have some moving around included as clean up patches but I'=
d like
>> to focus on actual functions than clean up at this point).
>>
>> Does putting these devices from board code to ppc440_uc.c sound
>> acceptable?
>
> That'd be ok - though again, I'd prefer to see each device as a
> separate patch.  It would probably be preferable to put each device in
> a separate file as well though, unless they're _really_ tiny.  Nothing
> inherently wrong with small .c files, if they're still more or less
> self contained.

Since most of these are just stubs for now and not really full emulation=20
of the device I'd leave them in one file similar to ppc405 for now. They=20
both could be cleaned up later if it's found necessary or devices that ar=
e=20
deemed ready and big enough to be moved out could be split off (like I di=
d=20
with i2c and pcix). If you insist, I can split it now but I think it's=20
more difficult to work with a lot of small files scattered in hw instead=20
of everything related to ppc440 in one place until there's still missing=20
fucntionality. I consider splitting it up cleanup which could be done=20
later separately unless it's a requirement to get this series in.
