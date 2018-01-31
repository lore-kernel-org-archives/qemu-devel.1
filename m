Received: from eggs.gnu.org ([2001:4830:134:3::10]:58949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1egozF-0002Hu-4n
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1egozA-0005kD-BQ
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:47:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1egozA-0005hZ-4P
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:47:20 -0500
Date: Wed, 31 Jan 2018 09:47:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180131094710.GD3255@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1517253224-14361-1-git-send-email-whois.zihan.yang@gmail.com>
	<1517253224-14361-2-git-send-email-whois.zihan.yang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1517253224-14361-2-git-send-email-whois.zihan.yang@gmail.com>
Subject: Re: [Qemu-devel] [RFC 1/4] qemu-socket: Allow custom socket option
 in socket_listen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, Jan 30, 2018 at 03:13:41AM +0800, Zihan Yang wrote:
> Currently, socket_listen does not allow caller to set custom
> socket options, which is inconvenient when the caller wants
> a non-blocking socket or wants to set TCP_NODELAY. Therefore,
> two new structs are added and an extra parameter is provided
> to socket_listen. Existing functions are unaffected by
> providing a NULL pointer.

You've added all this extra functionality to pass arbitrary
options, but then not used it in any of the later patches.
We've been trying to remove complexity from this code, so
I'm not in favour of adding new functionality that is not
even used.

I'm not seeing the point of adding the support for the O_NONBLOCK
in the listener socket either - that can easily be turned on after
you have the listener socket created.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
