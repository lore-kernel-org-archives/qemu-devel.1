Received: from eggs.gnu.org ([2001:4830:134:3::10]:50078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f3ddr-0004AI-Nv
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f3ddo-0007HY-KE
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:19:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57170 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f3ddo-0007Cn-E9
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:19:36 -0400
Date: Wed, 4 Apr 2018 09:19:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180404081919.GC3186@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180404025201.11921-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180404025201.11921-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] Add a CentOS test image to run docker
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Wed, Apr 04, 2018 at 10:51:58AM +0800, Fam Zheng wrote:
> Docker testing on patchew has long suffered from 'make check' hangings. The
> cleanness of VM testing is the cure. Now let's add a CentOS 7 image to run the
> tests.  It's purely ad-hoc, but hopefully still easy to understand and use for
> everyone.

If our automated tests are hanging, then developers could hit those hangs
to, and depending on where the problem is, end users could hit the hangs
in production deployment.

IOW, hangs in the testing aren't something we should just hide away by
changing the way we run tests - we need to identify & fix the hangs.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
