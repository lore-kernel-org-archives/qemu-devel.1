Received: from eggs.gnu.org ([2001:4830:134:3::10]:35009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT656-0005HZ-Pa
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT654-0007ie-PT
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:45:00 -0400
Date: Wed, 13 Jun 2018 14:44:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180613134452.GU19901@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1528866321-23886-1-git-send-email-thuth@redhat.com>
	<1528866321-23886-5-git-send-email-thuth@redhat.com>
	<20180613133840.GK24528@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180613133840.GK24528@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] qemu-options: Do not show
 -enable-kvm and -enable-hax in the docs anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, zhang.zhanghailiang@huawei.com, Ben Warren <ben@skyportsystems.com>, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Jun 13, 2018 at 02:38:40PM +0100, Stefan Hajnoczi wrote:
> On Wed, Jun 13, 2018 at 07:05:21AM +0200, Thomas Huth wrote:
> > We've got three ways of enabling an accelerator: -machine accel=xyz,
> > -accel xyz and -enable-xyz. For new QEMU users, this must be very
> > confusing ("Which one do I have to use? Is there a difference between
> > the options?"). While -enable-kvm was useful in the past, there is no
> > real good reason for using it anymore today ("-accel kvm" is even less
> > to type than "-enable-kvm"), so let's decrease the confusing amount of
> > options in our documenation a little bit by removing the -enable-xyz
> > here. Note that the option itself is neither removed nor marked as
> > deprecated - since -enable-kvm is likely used in a lot of scripts and
> > since its code is easy to maintain, we should keep it around to avoid
> > to break old setups.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  PS: I guess Paolo won't like this patch ... let's try it anyway ;-)
> 
> It's widely used and we're removing the documentation for it?!  That is
> likely to cause issues for new users who refer to the man page to
> understand the QEMU command-lines they see online, in scripts, etc.

Agreed, this is a very bad idea. Any option that is accepted by QEMU,
but not documented is a bug that must be fixed. IOW removing docs
is creating bugs.

If we want to help users understand why we have -enable-kvm, just
make the docs say that it is syntactic for '-machine accel=kvm'.
Users can decide for themselves whether they want to switch to
the more verbose way or not

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
