Received: from eggs.gnu.org ([2001:4830:134:3::10]:55021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eooL0-0004Fo-Fi
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eooKw-0006wR-LM
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:42:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55624 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eooKw-0006w1-Fy
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:42:50 -0500
Date: Thu, 22 Feb 2018 18:42:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180222104235.GI18962@xz-mi>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-11-peterx@redhat.com>
	<20180221161718.GB21436@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180221161718.GB21436@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v7 10/23] qmp: introduce QMPCapability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Feb 21, 2018 at 04:17:18PM +0000, Stefan Hajnoczi wrote:
> On Wed, Jan 24, 2018 at 01:39:44PM +0800, Peter Xu wrote:
> > diff --git a/qapi-schema.json b/qapi-schema.json
> > index 5c06745c79..2490d5188e 100644
> > --- a/qapi-schema.json
> > +++ b/qapi-schema.json
> > @@ -102,21 +102,47 @@
> >  #
> >  # Enable QMP capabilities.
> >  #
> > -# Arguments: None.
> > +# Arguments:
> > +#
> > +# @enable:    List of QMPCapabilities to enable, which is optional.
> > +#             Client must not enable any capability that is not
> > +#             mentioned in QMP greeting message.
> 
> qapi-schema.json uses full sentences so I've added missing articles to
> the text.  I also changed s/QMPCapabilities/QMPCapability values/ to
> avoid confusion about the type name:
> 
>   An optional list of QMPCapability values to enable.  The client must
>   not enable any capability that is not mentioned in the QMP greeting
>   message.
> 
> >  #
> >  # Example:
> >  #
> > -# -> { "execute": "qmp_capabilities" }
> > +# -> { "execute": "qmp_capabilities",
> > +#      "arguments": { "enable": [ "oob" ] } }
> >  # <- { "return": {} }
> >  #
> >  # Notes: This command is valid exactly when first connecting: it must be
> >  # issued before any other command will be accepted, and will fail once the
> >  # monitor is accepting other commands. (see qemu docs/interop/qmp-spec.txt)
> >  #
> > +# QMP client needs to explicitly enable QMP capabilities, otherwise
> 
> s/QMP client/The QMP client/

Thanks;  Fixing them all.

-- 
Peter Xu
