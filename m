Received: from eggs.gnu.org ([2001:4830:134:3::10]:37929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOThb-00068y-45
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOThY-0002Sf-2N
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:57:39 -0400
Received: from 9.mo3.mail-out.ovh.net ([87.98.184.141]:39974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fOThX-0002Rd-RU
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:57:36 -0400
Received: from player756.ha.ovh.net (unknown [10.109.108.58])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 5D9111BAA5E
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 21:57:34 +0200 (CEST)
Date: Thu, 31 May 2018 21:57:31 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180531215731.1215577f@bahia.lan>
In-Reply-To: <CABV8kRxgK7wV6ZS4pwp6VGUo0AbncciwduUjPHC3t0B6xDQ0qw@mail.gmail.com>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<f7e1cd54774642aec19dd2c547a5e560050ab9cd.1527310210.git.keno@alumni.harvard.edu>
	<20180528145945.05e22d0f@bahia.lan>
	<CABV8kRxgK7wV6ZS4pwp6VGUo0AbncciwduUjPHC3t0B6xDQ0qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/13] 9p: darwin: configure: Allow VirtFS
 on Darwin
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

On Thu, 31 May 2018 13:46:29 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> >> +    elif test "$darwin" = yes; then
> >>        virtfs=yes
> >> -      tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"  
> >
> > So, no proxy helper on Darwin ? Why ? The limitation should be mentioned in
> > the changelog at least.  
> 
> I just had no use for it. I'll try to build it and see what happens.

Please do.
