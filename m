Received: from eggs.gnu.org ([2001:4830:134:3::10]:58802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fSoJ7-0006eU-Qi
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fSoJ4-0004rQ-LL
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:46:17 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:40650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fSoJ4-0004qr-Dr
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:46:14 -0400
Received: from player692.ha.ovh.net (unknown [10.109.105.35])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id D1B1016CD1
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 20:46:12 +0200 (CEST)
Date: Tue, 12 Jun 2018 20:46:03 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180612204603.7bf254cb@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <CAFEAcA8yKyHX-xVx5VPxBOy7-hiKDo+DgztVZ_sD5FxK77Z-9w@mail.gmail.com>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
	<CAFEAcA85qHjDLBYxWW9i4T91m1uTS6TAY_y2A6_840n-_tDZKw@mail.gmail.com>
	<20180612175241.7340be80@bahia.lab.toulouse-stg.fr.ibm.com>
	<CAFEAcA8yKyHX-xVx5VPxBOy7-hiKDo+DgztVZ_sD5FxK77Z-9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/33] ppc-for-3.0 queue 20180612
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>

On Tue, 12 Jun 2018 16:55:08 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 12 June 2018 at 16:52, Greg Kurz <groug@kaod.org> wrote:
> > On Tue, 12 Jun 2018 15:34:22 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  
> >> On 12 June 2018 at 07:44, David Gibson <david@gibson.dropbear.id.au> wrote:  
> >> > ----------------------------------------------------------------
> >> > ppc patch queue 2018-06-12
> >> >
> >> > Here's another batch of ppc patches towards the 3.0 release.  There's
> >> > a fair bit here, because I've been working through my mail backlog
> >> > after a holiday.  There's not much of a central theme, amongst other
> >> > things we have:
> >> >     * ppc440 / sam460ex improvements
> >> >     * logging and error cleanups
> >> >     * 40p (PReP) bugfixes
> >> >     * Macintosh fixes and cleanups
> >> >     * Add emulation of the new POWER9 store-forwarding barrier
> >> >       instruction variant
> >> >     * Hotplug cleanups
> >> >  
> >>
> >> Applied, thanks.  
> 
> > Oh... so we've broken bisect until Cedric's fix is merged.  
> 
> If you want me not to merge a pullreq you need to follow up to
> the cover letter saying "please don't merge this" or something
> similar. Otherwise I will not notice.
> 

Yeah I've only answered to the offending patch, sorry...

Cheers,

--
Greg

> thanks
> -- PMM
