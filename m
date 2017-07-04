Received: from eggs.gnu.org ([2001:4830:134:3::10]:56558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSDQQ-0003PJ-KF
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 22:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSDQM-0002PB-ME
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 22:18:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dSDQM-0002OA-Cg
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 22:18:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20DD880F95
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 02:18:45 +0000 (UTC)
Date: Tue, 4 Jul 2017 10:18:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170704021845.GC32003@pxdev.xzpeter.org>
References: <1499049848-18012-1-git-send-email-peterx@redhat.com>
	<1499049848-18012-4-git-send-email-peterx@redhat.com>
	<20170703170712.GO12152@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170703170712.GO12152@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jul 03, 2017 at 02:07:12PM -0300, Eduardo Habkost wrote:
> On Mon, Jul 03, 2017 at 10:44:07AM +0800, Peter Xu wrote:
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
> > +explicitly disable it.
> [...]
> 
> Wait, isn't it off by default?
> 
> This seems to imply that "-machine enforce-config-section=on" would have
> no effect at all, as the option would be already on by default.  This is
> not the case.
> 
> I suggest rewriting this as:
> 
>   If set to "on, force migration code to send configuration section even
>   if the machine-type sets the "migration.send-configuration" property
>   to "off".
>   Note: this parameter is obsolete, please use "-global
>   migration.send-configuration=on|off" instead.
>   Behavior is undefined if "enforce-config-section" and "-global
>   migration.send-configuration" are used together.
> 
> (Note: we probably should use proper markup (@option/@var/@samp?)
> instead of quotes above, to format the option names properly in the
> generated documentation.)

Yes, you are right.  How's this one? (markup used this time)

If @option{enforce-config-section} is set to @var{on}, force migration
code to send configuration section even if the machine-type sets the
@option{migration.send-configuration} property to @var{off}.
@option{enforce-config-section} cannot be used together with
@option{-global} @option{migration.send-configuration}. Behavior is
undefined if @option{enforce-config-section} and @option{-global}
@option{migration.send-configuration} are used together.

NOTE: this parameter is obsolete. Please use @option{-global}
@option{migration.send-configuration}=@var{on|off} instead.

Thanks,

-- 
Peter Xu
