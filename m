Received: from eggs.gnu.org ([2001:4830:134:3::10]:48399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fD9j0-0000uj-GV
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fD9ix-0008Ub-Ay
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:24:18 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:41067)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fD9ix-0008P0-3Z
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:24:15 -0400
Received: from player770.ha.ovh.net (unknown [10.109.108.101])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 01D3812CF9E
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 16:24:06 +0200 (CEST)
Date: Mon, 30 Apr 2018 16:23:59 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180430162359.5c963c50@bahia.lan>
In-Reply-To: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 27 Apr 2018 16:51:03 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> Hi; I usually let people forget about releases for a month or
> so before bringing this topic up, but:
> 
> (1) do we want to call the next release 2.13, or something else?
> There's no particular reason to bump to 3.0 except some combination of
>  * if we keep going like this we'll get up to 2.42, which starts to
>    get silly
>  * Linus-style "avoid being too predictable"
>  * triskaidekaphobia
> but maybe we should anyway?
> 

Do we care for machine versions to stick to QEMU versions ? I ask,
because we've already added a pseries-2.13 machine type (in master
since David's latest pull req). No big deal though if we have to
turn it into pseries-3.0 I guess...

> (2) release timing:
>  * usual schedule would give us a next release mid-to-late August
>  * unless I can persuade Stefan to do the release management this
>    cycle we might need to wind that in by a couple of weeks so
>    it's definitely done by the middle of August, to avoid a clash
>    with a personal commitment
>  * so probably hardfreeze 10th July, softfreeze 3rd July
> 
> (3) retrospective, lessons learned &c
>  * please remember that if every single submaintainer submits
>    a pull request on the morning of an RC, it is physically
>    not possible for me to process all those pulls in time to
>    tag the RC that day. We had several RCs which got delayed
>    by a day because of this; please try to submit earlier
>    rather than later...
>  * provide your opinions here ?
> 
> thanks
> -- PMM
> 
