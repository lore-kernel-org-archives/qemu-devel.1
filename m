Received: from eggs.gnu.org ([2001:4830:134:3::10]:35271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1digfn-00071j-HW
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 08:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1digfk-000846-7r
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 08:46:47 -0400
Date: Fri, 18 Aug 2017 14:46:42 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20170818061028.GU5509@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1708181436550.19483@zero.eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<5e493fd14e60d92d4fd80492ceff5ba13eb7b558.1502643878.git.balaton@eik.bme.hu>
	<20170818061028.GU5509@umbus.fritz.box>
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

On Fri, 18 Aug 2017, David Gibson wrote:
> On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
>> Add emulation of aCube Sam460ex board based on AMCC 460EX embedded SoC=
.
>> This is not a full implementation yet with a lot of components still
>> missing but enough to start a Linux kernel and the U-Boot firmware.
>>
>> Signed-off-by: Fran=E7ois Revol <revol@free.fr>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> There are a *lot* of devices defined here.  Most of them look like
> they belong to the SoC, not the board (since they use DCRs), so it
> doesn't really make sense to define them in a board file.  It would
> also make it easier to review if they were split up into separate
> patches.

I thought it's simpler to review a series with 12 reasonably sized patche=
s=20
than one with twice as many which only modify a few lines here and there=20
each. Also adding a lot of code scattered in hw directories is probably=20
less clear than having them all at one place. But of course each approach=
=20
can be reasoned. I thought this might have to be split up but I've left i=
t=20
one place for now for first review to get some advice on what's preferred=
.

Maybe I should put things that belong to the SoC in ppc440_uc.c (similar=20
to ppc405uc.c we already have) and move common devices used by both to=20
ppc4xx_devs.c (which already seems to serve that purpose). If more cleanu=
p=20
is needed that could be done separately afterwards, I don't think it's a=20
good idea to mix in too much cleanup now to keep patches relatively=20
simple. (I already have some moving around included as clean up patches=20
but I'd like to focus on actual functions than clean up at this point).

Does putting these devices from board code to ppc440_uc.c sound=20
acceptable?

Regards,
BALATON Zoltan
