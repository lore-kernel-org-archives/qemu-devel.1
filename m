Received: from eggs.gnu.org ([2001:4830:134:3::10]:43660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXV3A-00019H-1R
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXV38-0007qZ-T8
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:08:39 -0400
Date: Tue, 18 Jul 2017 17:08:25 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170718160825.GW11927@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1500385286-21142-1-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 00/10] Correct two minor QMP
 interface design flaws
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

On Tue, Jul 18, 2017 at 03:41:16PM +0200, Markus Armbruster wrote:
> blockdev-add and migrate-set-parameters overload empty strings to mean
> something entirely different.  See my memo "qapi: Stop abusing
> "special" values for something entirely different" for details.
> 
>     Message-ID: <87379zhrhn.fsf@dusky.pond.sub.org>
>     https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04526.html
> 
> This series deprecates these usages of "" in favour of JSON null.
> Because we're so close to the 2.10 freeze, the implementation is
> intentionally stupid: rewrite null to "" at first opportunity.  The
> proper way to do it would be rewriting "" to null, but that requires
> fixing up code to work with null.  There are TODO comments for that.
> I'm willing to take care of them in the next development cycle.

I tested the migrate-set-parameters QMP command with this applied and
I can still pass "" as the tls-hostname.

When using query-migrate-parameters we still see "" too.

So from POV of avoiding regressions for existing usage, we look OK
here.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
