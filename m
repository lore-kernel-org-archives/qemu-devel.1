Received: from eggs.gnu.org ([2001:4830:134:3::10]:51752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZa0X-0005im-DZ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 06:27:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZZqu-0000fo-MQ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 06:17:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gZZqs-0000a1-M0
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 06:17:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 856BE81DED
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 11:17:19 +0000 (UTC)
Date: Wed, 19 Dec 2018 11:17:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181219111712.GI20465@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180222070513.8740-1-kraxel@redhat.com>
	<20180222070513.8740-6-kraxel@redhat.com>
	<20181218184532.GA18660@redhat.com>
	<20181219075510.ci3yypwj3f2plcnv@sirius.home.kraxel.org>
	<20181219094213.lqh244w35unsbejc@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181219094213.lqh244w35unsbejc@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] keymap: consider modifier state
 when picking a mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Adam Williamson <awilliam@redhat.com>

On Wed, Dec 19, 2018 at 10:42:14AM +0100, Gerd Hoffmann wrote:
>   Hi,
>  
> > > This is quite horrible though. I'm more inclined
> > > to revert this patch and find another way to fix the original problem
> > > which won't require the UI frontends to track modifier state.
> > 
> > The UIs track modifier state anyway.
> > 
> > I fact I have some WIP patches to add a generic keyboard state tracker,
> > so the UIs can use common code instead of having their own state
> > tracking code each.  Also to make UI hotkeys configurable, consistent
> > across all UIs we have.  Guess I should undust them, at least the state
> > tracking part of it.
> > 
> > With that in place we can easily pass the full keyboard state to the
> > keymap code.
> 
> Tried that:
>   https://git.kraxel.org/cgit/qemu/log/?h=sirius/kbd-state

I've had a look & think that code makes sense & ought to be able to
solve this problem.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
