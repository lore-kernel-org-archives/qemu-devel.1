Received: from eggs.gnu.org ([2001:4830:134:3::10]:50272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSOGO-0001rb-GM
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSOGK-0003Ls-HA
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:53:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dSOGK-0003LR-7H
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:53:08 -0400
Date: Tue, 4 Jul 2017 14:53:01 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170704135301.GB9211@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170704111404.28569-1-berrange@redhat.com>
	<20170704111404.28569-3-berrange@redhat.com>
	<e4f5548d-0da3-ea64-1ffc-fa887b51c947@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4f5548d-0da3-ea64-1ffc-fa887b51c947@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] docs: document deprecated features
 in appendix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Jul 04, 2017 at 02:59:27PM +0200, Thomas Huth wrote:
> On 04.07.2017 13:14, Daniel P. Berrange wrote:
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
> >  qemu-doc.texi | 167 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 167 insertions(+)
> > 
> > diff --git a/qemu-doc.texi b/qemu-doc.texi
> > index 27781e4..ba5170c 100644
> > --- a/qemu-doc.texi
> > +++ b/qemu-doc.texi
> > @@ -39,6 +39,7 @@
> >  * QEMU User space emulator::
> >  * Implementation notes::
> >  * Support lifetime::
> > +* Deprecated features::
> >  * License::
> >  * Index::
> >  @end menu
> > @@ -3054,6 +3055,172 @@ support machine types from many previous versions.
> [...]
> > +@subsection -monitor default=on (since 2.4.0)
> > +
> > +The ``default'' option to the ``-monitor'' argument is
> > +now ignored. When multiple monitors were enabled, it
> > +indicated which monitor would receive log messages
> > +from the audio subsystem.
> 
> The audio subsystem was just the last user. There were other subsystems
> using it before, see e.g. commit 027a79c373954920d5 or commit
> 02d16089802234f.

Ah, right, I'll clarify it.

> [...]
> > +@subsection -net vlan (since 2.9.0)
> > +
> > +The ``-net van=NN'' argument is partially replaced with the
> > +new ``-netdev'' argument. The remaining use cases will no
> > +longer be directly supported in QEMU
> 
> Add a period after the last sentence?

Yes

> 
> > +@subsection -drive if=scsi (since 2.9.0)
> > +
> > +The ``-drive if=scsi'' argument is replaced by the the
> > +``-device BUS-TYPE'' argument combined with ``-drive if=none''.
> > +
> > +@subsection -net dump (since 2.10.0)
> > +
> > +The ``--net dump'' argument is now a synonym for setting the
> > +``-object filter-dump'' argument instead.
> 
> Technically, it's not a synonym, but a replacement ;-)
> ("-net dump" uses the "vlan" concept, while "-object filter-dump" works
> with "-netdev" instead)

Oh, right, I misunderstood that


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
