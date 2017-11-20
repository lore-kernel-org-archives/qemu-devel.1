Received: from eggs.gnu.org ([2001:4830:134:3::10]:37706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eGn51-00053w-HV
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eGn4y-0004H9-C3
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:29:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eGn4y-0004Gn-5H
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:29:44 -0500
Date: Mon, 20 Nov 2017 14:29:36 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171120142936.GM31943@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171120142248.16432-1-stefanha@redhat.com>
	<20171120142248.16432-2-stefanha@redhat.com>
	<CAFEAcA-A4T_q5+AMuAmEAGCHA+BXaXXUqLiu2tvK6MOCiniZBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-A4T_q5+AMuAmEAGCHA+BXaXXUqLiu2tvK6MOCiniZBQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] Use qemu.org domain name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Nov 20, 2017 at 02:26:15PM +0000, Peter Maydell wrote:
> On 20 November 2017 at 14:22, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > The owner of qemu.org has delegated authority to modify DNS records to
> > the QEMU Project.  This has allowed us to use the domain name without
> > worries about IP address changes or technical issues disrupting service.
> > The issues described in commit 859389810910f232188675d2f10b15f1aad77660
> > ("Use qemu-project.org domain name") have therefore been mitigated.
> >
> > This patch switches back to consistently using qemu.org instead of
> > qemu-project.org.
> >
> > Note that git-submodule(1) does not detect URL changes.  The following
> > commands clean up all submodules to ensure you will use the latest URLs:
> >
> >   $ git submodule deinit . # you'll be warned if you have local changes
> >   $ rm -rf .git/modules    # also clear cached .git/ directories
> 
> Are we really sure we want to do this in the middle of
> a release? I'd be rather happier if we fixed the documentation
> now and saved messing around with .gitmodules until afterwards...

We can probably also put a workaround in scripts/git-submodules.sh to
automatically change the git origin of all currently checked out
submodules, so that the change doesn't affect devs at all.

IOW, I'd suggest respinning this series without the submodule
changes, as that's a functional change, and the rest of this
is all non-functional changes.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
