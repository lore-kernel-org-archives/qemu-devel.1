Received: from eggs.gnu.org ([2001:4830:134:3::10]:50530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOnfm-0007Ia-0E
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOnfi-0004Gn-0I
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:17:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33302 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fOnfh-0004GO-S1
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:17:01 -0400
Date: Fri, 1 Jun 2018 18:16:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180601171657.GP3458@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAGO-sgOsRvJbjdDH4dbRJPgVu=oYqvEZdFmzSprDkcn-A6rc5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGO-sgOsRvJbjdDH4dbRJPgVu=oYqvEZdFmzSprDkcn-A6rc5Q@mail.gmail.com>
Subject: Re: [Qemu-devel] Mistake on man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvaps <kvapss@gmail.com>
Cc: qemu-devel@nongnu.org

On Fri, Jun 01, 2018 at 04:47:55PM +0200, kvaps wrote:
> Hi, here is mistake in man page for qemu-nbd:
> 
> --- a/qemu-nbd.texi
> +++ b/qemu-nbd.texi
> @@ -1,2 +1,2 @@
> --- a/qemu-nbd.texi
> -Don't exit on the last connection
> +++ b/qemu-nbd.texi
> +Don't exit on the lost connection

It isn't a mistake actually. qemu-nbd can allow multiple concurrent
client connections, and will exit once the last client closes.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
