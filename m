Received: from eggs.gnu.org ([2001:4830:134:3::10]:35587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dTSBl-00062S-S7
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dTSBg-0004FZ-T2
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:16:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dTSBg-0004F9-Mt
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:16:44 -0400
Date: Fri, 7 Jul 2017 13:16:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170707121636.GF2451@work-vm>
References: <20170706183014.GH12152@localhost.localdomain>
	<1499396048-21657-1-git-send-email-peterx@redhat.com>
	<20170707121214.GS12152@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707121214.GS12152@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2.2 3/4] doc: add item for "-M
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
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, lvivier@redhat.com, quintela@redhat.com, groug@kaod.org

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> On Fri, Jul 07, 2017 at 10:54:08AM +0800, Peter Xu wrote:
> > It's never documented, and now we have one more parameter for it (which
> > obsoletes this one). Document it properly.
> > 
> > Although now when enforce-config-section is set, it'll override the
> > other "-global" parameter, that is not necessarily a rule. Forbid that
> > usage in the document.
> 
> This paragraph looks obsolete now, as now the documentation
> doesn't explicitly forbid mixing the two options.  If it gets
> removed:
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Juan, will you queue it through your tree?

Juan's on PTO, I'll take it.

Dave

> Thanks!
> 
> > 
> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > v2.1 -> v2.2
> > - remove the last two lines of document [Eduardo]
> > 
> >  qemu-options.hx | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 297bd8a..cd95516 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -85,6 +85,12 @@ Enables or disables NVDIMM support. The default is off.
> >  @item s390-squash-mcss=on|off
> >  Enables or disables squashing subchannels into the default css.
> >  The default is off.
> > +@item enforce-config-section=on|off
> > +If @option{enforce-config-section} is set to @var{on}, force migration
> > +code to send configuration section even if the machine-type sets the
> > +@option{migration.send-configuration} property to @var{off}.
> > +NOTE: this parameter is deprecated. Please use @option{-global}
> > +@option{migration.send-configuration}=@var{on|off} instead.
> 
> -- 
> Eduardo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
