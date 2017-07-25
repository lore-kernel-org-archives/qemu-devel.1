Received: from eggs.gnu.org ([2001:4830:134:3::10]:38704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZxuS-0005SF-JI
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZxuO-0006CE-Lp
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:21:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dZxuO-0006Bz-Fa
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:21:48 -0400
Date: Tue, 25 Jul 2017 12:21:40 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170725112139.GN26394@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170719100802.14094-1-berrange@redhat.com>
	<20170719100802.14094-3-berrange@redhat.com>
	<c54bf8d4-571e-e4b5-0103-e23be3785139@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c54bf8d4-571e-e4b5-0103-e23be3785139@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/2 (for 2.10)] docs: document
 deprecated features in appendix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jul 25, 2017 at 11:35:53AM +0200, Thomas Huth wrote:
> On 19.07.2017 12:08, Daniel P. Berrange wrote:
> > The deprecation of features in QEMU is totally adhoc currently,
> > with no way for the user to get a list of what is deprecated
> > in each release. This adds an appendix to the doc that records
> > when each deprecation was made and provides text explaining
> > what to use instead, if anything.
> > 
> > Since there has been no formal policy around removal of deprecated
> > features in the past, any deprecations prior to 2.10.0 are to be
> > treated as if they had been made at the 2.10.0 release. Thus the
> > earliest that existing deprecations will be deleted is the start
> > of the 2.12.0 cycle.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qemu-doc.texi | 168 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 168 insertions(+)
> [...]
> > +@subsection -monitor default=on (since 2.4.0)
> > +
> > +The ``default'' option to the ``-monitor'' argument is
> > +now ignored. When multiple monitors were enabled, it
> > +indicated which monitor would receive log messages
> > +from the various subsystems. This feature is no longer
> > +required as messages are now only sent to the monitor
> > +in response to explicitly monitor commands.
> 
> BTW, seems like it's the "-mon" option, not the "-monitor" option that
> has this "default" parameter?

Yes, you are right.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
