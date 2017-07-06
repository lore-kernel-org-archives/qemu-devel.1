Received: from eggs.gnu.org ([2001:4830:134:3::10]:37565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dT2Iy-000824-4r
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dT2It-00088A-7T
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:38:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dT2Is-00087k-Uk
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:38:27 -0400
Date: Thu, 6 Jul 2017 16:38:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170706083820.GA25924@pxdev.xzpeter.org>
References: <1499242883-2184-4-git-send-email-peterx@redhat.com>
	<1499306921-5391-1-git-send-email-peterx@redhat.com>
	<20170706100919.36be6596@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170706100919.36be6596@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2.1 3/4] doc: add item for "-M
 enforce-config-section"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, lvivier@redhat.com, ehabkost@redhat.com, quintela@redhat.com, dgilbert@redhat.com

On Thu, Jul 06, 2017 at 10:09:19AM +0200, Greg Kurz wrote:
> On Thu,  6 Jul 2017 10:08:41 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > It's never documented, and now we have one more parameter for it (which
> > obsoletes this one). Document it properly.
> > 
> > Although now when enforce-config-section is set, it'll override the
> > other "-global" parameter, that is not necessarily a rule. Forbid that
> > usage in the document.
> > 
> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > v2.1:
> > - remove the "undefined behavior" sentence [Markus]
> > 
> >  qemu-options.hx | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 297bd8a..1ce7a37 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -85,6 +85,14 @@ Enables or disables NVDIMM support. The default is off.
> >  @item s390-squash-mcss=on|off
> >  Enables or disables squashing subchannels into the default css.
> >  The default is off.
> > +@item enforce-config-section=on|off
> > +If @option{enforce-config-section} is set to @var{on}, force migration
> > +code to send configuration section even if the machine-type sets the
> > +@option{migration.send-configuration} property to @var{off}.
> > +NOTE: this parameter is deprecated. Please use @option{-global}
> > +@option{migration.send-configuration}=@var{on|off} instead.
> > +@option{enforce-config-section} cannot be used together with
> > +@option{-global} @option{migration.send-configuration}.
> 
> Is this last sentence correct ?
> 
> My understanding is that "enforce-config-section" overrides
> "migration.send-configuration"...

Yes, in the codes it is.

But as mentioned in the commit message, this rule is actually not
really necessary, so it does not really conflict when we declare in
the document that it is not allowed to happen (the code just did
something extra). After all, we want to finally remove
enforce-config-section one day, so before that I would like to avoid
taking more responsibility on this old parameter.

Also, I hope people (especially who read this document) don't use
these two parameters at the same time, or better, use the new one,
rather than still using "enforce-config-section" after he knows that
"anyway, it'll override the global parameter, so this old one is still
better"...

Thanks,

-- 
Peter Xu
