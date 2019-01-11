Received: from eggs.gnu.org ([209.51.188.92]:39393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghtYj-0002AD-1s
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghtYi-0008Ej-98
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:57:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghtYi-0008ES-3f
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:57:00 -0500
Date: Fri, 11 Jan 2019 09:56:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190111095654.GH18491@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190107103426.2669-1-ppandit@redhat.com>
	<nycvar.YSQ.7.76.1901111453590.12783@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1901111453590.12783@xnncv>
Subject: Re: [Qemu-devel] [PATCH] qga: check length of command-line &
 environment variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, niuguoxiang <niuguoxiang@huawei.com>

On Fri, Jan 11, 2019 at 03:22:51PM +0530, P J P wrote:
> +-- On Mon, 7 Jan 2019, P J P wrote --+
> | Qemu guest agent while executing user commands does not seem to
> | check length of argument list and/or environment variables passed.
> | It may lead to integer overflow or infinite loop issues. Add check
> | to avoid it.
> | 
> | -    size_t str_size = 1;
> | +    size_t str_size = 1, args_max;
> |  
> | +    args_max = sysconf(_SC_ARG_MAX);
> 
> Looks like sysconf()/_SC_ARG_MAX declarations aren't available. Is it okay to 
> include header <unistd.h> ?

qga/commands.c already includes qemu/osdep.h which includs unistd.h.

The build problem patchew reported was from *mingw* builds where
sysconf does not exist.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
