Received: from eggs.gnu.org ([209.51.188.92]:60178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqgBx-0003Uw-Sp
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqgBx-0005ID-1w
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:29:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gqgBw-0005Fv-Ro
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:29:48 -0500
Date: Mon, 4 Feb 2019 15:29:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190204152921.GQ1905@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
	<20190204142638.27021-16-mst@redhat.com>
	<20190204150748.GP1905@redhat.com>
	<20190204101130-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190204101130-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PULL 15/25] contrib: compile vhost-user-blk tool
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Changpeng Liu <changpeng.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

On Mon, Feb 04, 2019 at 10:19:42AM -0500, Michael S. Tsirkin wrote:
> Hmm I do think we want to build the contrib tools,
> otherwise they bitrot too quickly, witness follow-up
> patches that fix the compilation.
> 
> And I think we need tests that actually use them.
> 
> However I agree adding them to tools and installing
> is probably rushing things, e.g. there's no
> manpage even.

Yes, if we build, but do not install, the binary that would be ok


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
