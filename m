Received: from eggs.gnu.org ([2001:4830:134:3::10]:41644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX1vL-00066n-08
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX1vK-0003Pg-7R
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:02:39 -0400
Date: Mon, 17 Jul 2017 10:02:28 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170717090228.GE3640@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <87379zhrhn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87379zhrhn.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] qapi: Stop abusing "special" values for something
 entirely different
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Fri, Jul 14, 2017 at 07:12:52PM +0200, Markus Armbruster wrote:
> Here's what I propose to do:
> 
> 1. Stop abusing values the schema accepts, but are invalid to mean "do
> something else entirely".
> 
> 2. Add a first class null type to QAPI.
> 
> 3. Turn MigrationParameters members tls-creds and tls-hostname into
> alternate of str and null.  Deprecate "".
> 
> 4. Add a null member to alternate BlockdefRef.  Deprecate "".
> 
> I got patches for 2., and I intend to work on 3. and 4.
> 
> Since this is "only" about "less than general and ugly", we may decide
> to leave things as they are if my patches turn out even uglier.
> 
> Meanwhile, opinions?

That sounds ok in principle to me, so worth at least proposing the patches
so we can see how it works out in practice.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
