Received: from eggs.gnu.org ([2001:4830:134:3::10]:33923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1flUvO-0001Ds-Pg
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 03:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1flUvL-00044w-Jl
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 03:55:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56632 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1flUvL-0003xF-Dq
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 03:54:59 -0400
Date: Fri, 3 Aug 2018 08:54:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180803075449.GA9737@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAB3eZfudS9D3G-JSNcaeZO_vWYBQytSbSLzDSLd+abGU9mLeoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB3eZfudS9D3G-JSNcaeZO_vWYBQytSbSLzDSLd+abGU9mLeoA@mail.gmail.com>
Subject: Re: [Qemu-devel] Can I create img more thant 16TB?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, Aug 03, 2018 at 12:46:19PM +0800, lampahome wrote:
> There's file size maximum in ext4 and it's 16TB
> 
> Can I create qcow2 ex:32TB and write more than 16TB?

You'll need to switch to a more scalable filesystem such as XFS to be
able to write more then 16TB of data.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
