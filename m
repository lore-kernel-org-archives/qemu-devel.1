Received: from eggs.gnu.org ([2001:4830:134:3::10]:57279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6YJH-0003Kq-4Q
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6YJD-0008FD-6M
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:42:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e6YJD-0008Ew-0F
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:42:07 -0400
Date: Mon, 23 Oct 2017 09:42:01 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171023084201.GC16472@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171020141027.17010-1-berrange@redhat.com>
	<d2200140-bdeb-1746-20a2-15b1fb283c28@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2200140-bdeb-1746-20a2-15b1fb283c28@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] build: allow setting a custom GIT binary
 for transparent proxying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Chen, Farrah" <farrah.chen@intel.com>

On Fri, Oct 20, 2017 at 03:06:58PM -0500, Eric Blake wrote:
> On 10/20/2017 09:10 AM, Daniel P. Berrange wrote:
> > Some users can't run a bare 'git' command, due to need for a transparent
> > proxying solution such as 'tsocks'. This adds an argument to configure to
> > let users specify such a thing:
> > 
> >   ./configure --with-git="tsocks git"
> > 
> > The submodule script is also updated to give the user a hint about using this
> > flag, if we fail to checkout modules.
> 
> Does my hint about using 'git config url.XYZ.insteadof git://...' do the
> trick without needing this patch?

IIUC, that only works if the developer can't access 'git://' URLs but
can access 'https://' URLs. So supporting tunnelling via a tsocks like
program looks like a more generalized solution to me.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
