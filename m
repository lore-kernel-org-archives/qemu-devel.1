Received: from eggs.gnu.org ([2001:4830:134:3::10]:55395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSLGA-0000Q3-6d
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 06:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSLG6-0007rA-WE
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 06:40:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dSLG6-0007qU-M6
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 06:40:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34DC9796E9
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 10:40:41 +0000 (UTC)
Date: Tue, 4 Jul 2017 18:40:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170704104036.GA5347@pxdev.xzpeter.org>
References: <1499049848-18012-1-git-send-email-peterx@redhat.com>
	<1499049848-18012-4-git-send-email-peterx@redhat.com>
	<874lussk0x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874lussk0x.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 3/4] doc: add item for "-M
 enforce-config-section"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Tue, Jul 04, 2017 at 10:06:54AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > It's never documented, and now we have one more parameter for it (which
> > means this one can be obsolete in the future). Document it properly.
> >
> > Although now when enforce-config-section is set, it'll override the
> > other "-global" parameter, that is not necessarily a rule. Forbid that
> > usage in the document.
> >
> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  qemu-options.hx | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 297bd8a..927c51f 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -85,6 +85,14 @@ Enables or disables NVDIMM support. The default is off.
> >  @item s390-squash-mcss=on|off
> >  Enables or disables squashing subchannels into the default css.
> >  The default is off.
> > +@item enforce-config-section=on|off
> > +Decides whether we will send the configuration section when doing
> > +migration. By default, it is turned on. We can set this to off to
> > +explicitly disable it. Note: this parameter will be obsolete soon,
> > +please use "-global migration.send-configuration=on|off" instead.
> 
> Please say "... is deprecated, please use ...", to make it visible in
> "git-grep -i deprecat".

Both "obsolete" and "deprecated" are used in QEMU for such an usage,
but I see indeed "deprecated" is used more often at least in
qemu-options.hx (used six times) than "obsolete" (one time only). Let
me switch then. :)

> 
> > +"enforce-config-section" cannot be used together with "-global
> > +migration.send-configuration". If it happens, the behavior is
> > +undefined.
> 
> Nasty.  Could we catch and reject such invalid usage?

Agree. However, looks like we cannot capture it easily on either of
the parameters (or, can we?). Since we defined it as "undefined", it
should be okay then, right?

After all, iiuc enforce-config-section is already very rarely used
(only on some special compat machines), and it'll be even more rare to
use the new one without removing the old.  Thanks,

-- 
Peter Xu
