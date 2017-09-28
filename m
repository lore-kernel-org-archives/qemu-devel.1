Received: from eggs.gnu.org ([2001:4830:134:3::10]:55112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxc4Q-0004Wy-ET
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxc4M-00047H-O4
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:53:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxc4M-000471-HQ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:53:50 -0400
Date: Thu, 28 Sep 2017 17:53:33 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170928165333.GP12919@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <mailman.4614.1506600439.14748.qemu-devel@nongnu.org>
	<D2C519DD-C9FE-42FC-9418-CD13BC48238D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D2C519DD-C9FE-42FC-9418-CD13BC48238D@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/6] Initial support for keycodemapdb
 GIT submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Sep 28, 2017 at 12:47:51PM -0400, Programmingkid wrote:
> 
> > This patch series is an update to:
> > 
> >  v1: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02047.html
> >  v2: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02471.html
> >  v3: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02517.html
> >  v4: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02708.html
> >  v5: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02950.html
> >  v6: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg07673.html
> 
> <snip>
> 
> These error messages appears when compiling version 7 of this patch series:
> 
> /bin/sh: ./scripts/git-submodule.sh: Permission denied

The git diff sets execute permission:

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
new file mode 100755
index 0000000000..f8e7d44ce6
--- /dev/null
+++ b/scripts/git-submodule.sh

did you use "git am" to apply this series or just plain 'patch', because
the latter won't deal with permissions correctly and so would cause that
error message above.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
