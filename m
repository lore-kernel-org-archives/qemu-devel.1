Received: from eggs.gnu.org ([2001:4830:134:3::10]:50410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ejQHH-0002b3-UL
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ejQHB-0003N9-Vg
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:00:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33564 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ejQHB-0003Mo-R2
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:00:41 -0500
Date: Wed, 7 Feb 2018 14:00:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180207140037.GK32061@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180207135642.GA21399@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180207135642.GA21399@aepfle.de>
Subject: Re: [Qemu-devel] sed invocation for keycodemapdb not portable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org

On Wed, Feb 07, 2018 at 02:56:47PM +0100, Olaf Hering wrote:
> With commit 927128222b ("ui: add keycodemapdb repository as a GIT
> submodule") sed is called with -E, which requires a recent sed.
> The version of sed shipped with SLE11 is 4.1.5, which does not
> understand the option '-E'. As a result xen-4.11 will fail to build.
> 
> Is there a way to achive the same result in some other way?

Sorry, I've got a patch queued already that fixes this, but haven't send
a pull request.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
