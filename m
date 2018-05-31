Received: from eggs.gnu.org ([2001:4830:134:3::10]:36473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOTa2-0000mk-UE
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOTZz-0004rr-0d
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:49:50 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:42627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fOTZy-0004qG-Pz
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:49:46 -0400
Received: from player711.ha.ovh.net (unknown [10.109.122.103])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 26B3518F56
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 21:49:45 +0200 (CEST)
Date: Thu, 31 May 2018 21:49:40 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180531214940.54c766cf@bahia.lan>
In-Reply-To: <CABV8kRxdxBtsNdwLLL4BeNLck88L=SuaydSsStMgip6SbN2H5g@mail.gmail.com>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<17b8b06c00e359d1cb71b883371ad8c677a0e477.1527310210.git.keno@alumni.harvard.edu>
	<20180529230951.27a41574@bahia.lan>
	<CABV8kRydQ1wiRm9T-wet64i3n7KpqA7pCJrbZMWFfVz1WRQupw@mail.gmail.com>
	<20180531212249.34cd85d2@bahia.lan>
	<CABV8kRxdxBtsNdwLLL4BeNLck88L=SuaydSsStMgip6SbN2H5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/13] 9p: darwin: Address minor differences
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

On Thu, 31 May 2018 15:23:45 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> Well, I do have the patch already to switch this and the other patterns,
> so let me know if you want it or not ;).
> 

Post it then and we'll see if people are happy with that :)

> On Thu, May 31, 2018 at 3:22 PM, Greg Kurz <groug@kaod.org> wrote:
> > On Thu, 31 May 2018 12:27:35 -0400
> > Keno Fischer <keno@juliacomputing.com> wrote:
> >  
> >> >> --- a/hw/9pfs/9p-local.c
> >> >> +++ b/hw/9pfs/9p-local.c
> >> >> @@ -67,7 +67,10 @@ int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
> >> >>          assert(*path != '/');
> >> >>
> >> >>          head = g_strdup(path);
> >> >> -        c = strchrnul(path, '/');
> >> >> +        /* equivalent to strchrnul(), but that is not available on Darwin */  
> >> >
> >> > Please make a qemu_strchrnul() helper with a separate implementation for Darwin
> >> > then. I guess you can put it in this file since there aren't any other users in
> >> > the QEMU code base.  
> >>
> >> There actually are, but they also use this pattern. Could you
> >> suggest the best place to put this utility? I can submit a patch
> >> to switch all instances of this pattern over.  
> >
> > Oh if the pattern is already used in other places, it's probably not
> > worth the pain... so please forget this :)  
