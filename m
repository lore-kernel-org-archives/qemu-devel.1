Received: from eggs.gnu.org ([2001:4830:134:3::10]:59040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dMycF-0005Cx-Iu
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dMycB-0003FT-LX
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:29:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dMycB-0003Ey-F8
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:29:19 -0400
Date: Mon, 19 Jun 2017 16:28:58 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170619152858.GK2640@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170616160658.32290-1-famz@redhat.com>
	<20170619144932.GI2640@redhat.com>
	<CAFEAcA8sFcma8nspaGE7Sx-72VUGGo491JKp+We2XwgDmGX18A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8sFcma8nspaGE7Sx-72VUGGo491JKp+We2XwgDmGX18A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Fix race of image locking
 between src and dst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

On Mon, Jun 19, 2017 at 04:27:53PM +0100, Peter Maydell wrote:
> On 19 June 2017 at 15:49, Daniel P. Berrange <berrange@redhat.com> wrote:
> > IIUC as well as fixing the race condition, you're also improving
> > error reporting by using qemu_file_set_error() which was not done
> > previously. Would be nice to mention that in the commit message
> > too if you respin for any other reason, but that's just a nit-pick
> 
> I've added
>     N.B. This commit includes a minor improvement to the error handling
>     by using qemu_file_set_error().
> 
> to the commit message -- is that OK or do you want to suggest a
> different wording?

That's fine with me.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
