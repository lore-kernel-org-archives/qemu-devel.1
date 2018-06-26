Received: from eggs.gnu.org ([2001:4830:134:3::10]:60107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXjjD-0001zj-Jb
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXjjC-0005ps-L9
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:53:35 -0400
Date: Tue, 26 Jun 2018 09:53:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180626085324.GB32319@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180625164239.13794-1-kwolf@redhat.com>
	<87h8lqkkrp.fsf@dusky.pond.sub.org>
	<424bb91d-a202-5c3b-1264-254cad0709d0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <424bb91d-a202-5c3b-1264-254cad0709d0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] usb-storage: Add rerror/werror properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On Tue, Jun 26, 2018 at 10:48:10AM +0200, Paolo Bonzini wrote:
> On 26/06/2018 10:35, Markus Armbruster wrote:
> > We also want to deprecate usb-storage, but
> > I guess we're still not ready for that (it's a complicated story).
> > 
> > To deprecate -drive without also deprecating usb-storage, we need to
> > preserve features.
> 
> Patch looks good to me too, but indeed why can't we deprecate
> usb-storage in favor of usb-bot + scsi-disk?

Presumably the migration state of usb-storage is different from the
migration state of usb-bot + scsi-disk, so not a case where libvirt
could silently switch from one to the other. It would need to be an
explicit config change by apps/users.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
