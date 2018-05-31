Received: from eggs.gnu.org ([2001:4830:134:3::10]:35563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOTUm-0007cK-Jg
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOTUi-0000El-NB
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:44:24 -0400
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:44383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fOTUi-0000DK-G6
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:44:20 -0400
Received: from player729.ha.ovh.net (unknown [10.109.105.15])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id B10AF187DD
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 21:44:18 +0200 (CEST)
Date: Thu, 31 May 2018 21:44:15 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180531214415.6ee272df@bahia.lan>
In-Reply-To: <CABV8kRz7GiQS3HFxoBJoTfz_TCdwHUX+14ZgaL=m=fVu86OR4g@mail.gmail.com>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<cd4661a5e122b1dcd848ff5cdf202e728a0359a8.1527310210.git.keno@alumni.harvard.edu>
	<20180529224311.79e0c201@bahia.lan>
	<CABV8kRz7GiQS3HFxoBJoTfz_TCdwHUX+14ZgaL=m=fVu86OR4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/13] 9p: darwin: Properly translate
 AT_REMOVEDIR flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Keno Fischer <keno@alumni.harvard.edu>

On Thu, 31 May 2018 12:25:49 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> >> +        errno = EINVAL;
> >> +        return -1;  
> >
> > ... I'm more concerned about this new error path. How can this happen ?
> >  
> 
> As far as I can tell, the flags come from the client without any
> intermediate error
> checking. 

Indeed :-\

> Since the Darwin constants do not match the Linux constants (which
> have the same numerical values as the 9p constants), we need to perform this
> checking/translation somewhere to ensure correct behavior.
> Is there a more appropriate place to put this check?

The right thing to do would be to check and translate the flag from
P9_DOTL_AT_REMOVEDIR to AT_REMOVEDIR in the core 9p server code.
