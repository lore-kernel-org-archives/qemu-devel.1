Received: from eggs.gnu.org ([2001:4830:134:3::10]:57665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5ge8-0000gx-Mr
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5ge5-0000rQ-G2
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:51:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d5ge5-0000rF-9w
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:51:49 -0400
Date: Tue, 2 May 2017 19:51:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170502225146.GJ3482@thinpad.lan.raisama.net>
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<20170502203115.22233-5-ehabkost@redhat.com>
	<27580102-61c1-63e2-bf97-1e86cb1aaf25@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27580102-61c1-63e2-bf97-1e86cb1aaf25@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] x86: Support feature=force on the
 command-line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, May 02, 2017 at 04:42:02PM -0500, Eric Blake wrote:
[...]
> > -    if (value) {
> > -        cpu->env.features[fp->w] |= fp->mask;
> > -    } else {
> > -        cpu->env.features[fp->w] &= ~fp->mask;
> > +    switch (value->type) {
> > +    case QTYPE_QBOOL:
> > +        if (value->u.q_bool) {
> > +            cpu->env.features[fp->w] |= fp->mask;
> > +        } else {
> > +            cpu->env.features[fp->w] &= ~fp->mask;
> > +        }
> > +        cpu->env.forced_features[fp->w] &= ~fp->mask;
> > +        cpu->env.user_features[fp->w] |= fp->mask;
> > +    break;
> 
> Isn't the break supposed to be indented four more spaces?
> 
[...]

I will fix it in v2. Thanks!

-- 
Eduardo
