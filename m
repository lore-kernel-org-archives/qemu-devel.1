Received: from eggs.gnu.org ([209.51.188.92]:55916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghEAE-0001Ss-9v
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghEAC-0004wh-EL
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:44:58 -0500
Date: Wed, 9 Jan 2019 13:44:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190109134448.GO3998@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190109132302.22634-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109132302.22634-1-rjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] qemu-io: Add generic function for
 reinitializing optind.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: eblake@redhat.com, kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On Wed, Jan 09, 2019 at 01:23:01PM +0000, Richard W.M. Jones wrote:
> How about this one?  Add a generic osdep function for reinitializing
> optind, which does optreset on FreeBSD (but is identical on all other
> OSes).  Use it from qemu-io and qemu-img.
> 
> I have tested this on Linux, FreeBSD and OpenBSD.
> 
> checkpatch complains:
> 
> WARNING: Block comments use a leading /* on a separate line
> #69: FILE: include/qemu/osdep.h:591:
> +/**

I think it just doesn't like your '/**' and wants '/*' instead.

> WARNING: architecture specific defines should be avoided
> #78: FILE: include/qemu/osdep.h:600:
> +#ifdef __FreeBSD__

Normally we'd suggest doing a configure test to for the platform
feature and then using a feature based ifdef test. In this case
though that would be difficult and/or overly complex.

This does make me wonder about the other *BSDs, OS-X and Mingw
though ?  Should they all be using the #else codepath, or should
the other BSDs / OS-X use the __FreeBSD__ codepath.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
