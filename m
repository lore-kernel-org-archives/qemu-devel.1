Received: from eggs.gnu.org ([2001:4830:134:3::10]:51351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fD9tE-00055e-Tf
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fD9tB-00071i-3W
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:34:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43980 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fD9tA-000711-UE
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:34:49 -0400
Date: Mon, 30 Apr 2018 15:34:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180430143442.GM3249@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430162359.5c963c50@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180430162359.5c963c50@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Mon, Apr 30, 2018 at 04:23:59PM +0200, Greg Kurz wrote:
> On Fri, 27 Apr 2018 16:51:03 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > Hi; I usually let people forget about releases for a month or
> > so before bringing this topic up, but:
> > 
> > (1) do we want to call the next release 2.13, or something else?
> > There's no particular reason to bump to 3.0 except some combination of
> >  * if we keep going like this we'll get up to 2.42, which starts to
> >    get silly
> >  * Linus-style "avoid being too predictable"
> >  * triskaidekaphobia
> > but maybe we should anyway?
> > 
> 
> Do we care for machine versions to stick to QEMU versions ? I ask,
> because we've already added a pseries-2.13 machine type (in master
> since David's latest pull req). No big deal though if we have to
> turn it into pseries-3.0 I guess...

We don't promise machine ABI compat for git master snapshots, so renaming
is fine provided it is done before release.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
