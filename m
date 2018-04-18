Received: from eggs.gnu.org ([2001:4830:134:3::10]:55254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8q3B-0008FC-99
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8q3A-0008JM-9m
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:35:17 -0400
Date: Wed, 18 Apr 2018 17:34:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180418163458.GB27579@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180405170619.20480-1-kwolf@redhat.com>
	<87d0ywv9j0.fsf@dusky.pond.sub.org>
	<20180418162823.GH4971@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180418162823.GH4971@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC][BROKEN] rbd: Allow configuration of
 authentication scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, jdurgin@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, jcody@redhat.com

On Wed, Apr 18, 2018 at 06:28:23PM +0200, Kevin Wolf wrote:
> Am 18.04.2018 um 17:06 hat Markus Armbruster geschrieben:

> >     Note that users can still configure authentication methods with a
> >     configuration file.  They probably do that anyway if they use Ceph
> >     outside QEMU as well.
> 
> This solution that we originally intended to offer was dismissed by
> libvirt as unpractical: libvirt allows the user to specify both a config
> file and a key, and if it wanted to use a config file to pass the key,
> it would have to create a merged config file and keep it sync with the
> user config file at all times. Understandable that they want to avoid
> this.

Even if the config file does have auth info setup, we can't assume that
the QEMU VMs are supposed to use the same auth info. In fact to properly
protect against compromised QEMU, ideally every QEMU would use a completely
separate RBD user+password, so that compromised QEMU can't then access
RBD disks belonging to a different user.

So from libvirt POV we want to pretend the config file does not exist at
all and explicitly pass everything that is needed via normal per-disk
setup for blockdev.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
