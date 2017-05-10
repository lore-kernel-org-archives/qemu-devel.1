Received: from eggs.gnu.org ([2001:4830:134:3::10]:41674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8Rog-0002Zf-B7
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8Rod-0001pO-7B
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8Rod-0001pH-0f
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:38:07 -0400
Date: Wed, 10 May 2017 10:38:02 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170510133802.GC3482@thinpad.lan.raisama.net>
References: <20170505201128.12099-1-ehabkost@redhat.com>
	<20170505201128.12099-3-ehabkost@redhat.com>
	<87a86k25tv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a86k25tv.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qapi: Add enum_table[] parameter to
 start_alternate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Wed, May 10, 2017 at 03:34:52PM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > The new parameter will be used by the string input visitor to detect
> > alternate types that can't be parsed unambiguously.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
[...]
> > diff --git a/qapi/trace-events b/qapi/trace-events
> > index b15a55b797..384c251814 100644
> > --- a/qapi/trace-events
> > +++ b/qapi/trace-events
> > @@ -11,7 +11,7 @@ visit_next_list(void *v, void *tail, size_t size) "v=%p tail=%p size=%zu"
> >  visit_check_list(void *v) "v=%p"
> >  visit_end_list(void *v, void *obj) "v=%p obj=%p"
> >  
> > -visit_start_alternate(void *v, const char *name, void *obj, size_t size, uint32_t supported_qtypes) "v=%p name=%s obj=%p size=%zu supported_qtypes=0x%x"
> > +visit_start_alternate(void *v, const char *name, void *obj, size_t size, uint32_t supported_qtypes, void *enum_table) "v=%p name=%s obj=%p size=%zu supported_qtypes=0x%x enum_table=%p"
> >  visit_end_alternate(void *v, void *obj) "v=%p obj=%p"
> >  
> >  visit_optional(void *v, const char *name, bool *present) "v=%p name=%s present=%p"
> 
> Not yet sure we need this, but if we do, clarify the function comment,
> and you may add
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks.

The only reason for this patch is to allow code in patch 3/3 to
detect ambiguous enums at runtime. I don't think the runtime
detection solution looked good, though, so I will probably drop
this patch.

-- 
Eduardo
