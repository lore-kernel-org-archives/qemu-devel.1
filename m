Received: from eggs.gnu.org ([209.51.188.92]:56818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJJkl-00047e-P0
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 11:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJJkk-0004PS-II
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 11:24:07 -0400
Date: Wed, 24 Apr 2019 16:23:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190424152352.GL31388@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-4-thuth@redhat.com>
	<167b6b7c-3fef-47e8-d30d-09abfe1e50ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <167b6b7c-3fef-47e8-d30d-09abfe1e50ba@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] tests/qemu-iotests: Do not hard-code
 the path to bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Max Reitz <mreitz@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>

On Wed, Apr 24, 2019 at 09:14:29AM -0500, Eric Blake wrote:
> On 4/24/19 5:37 AM, Thomas Huth wrote:
> > bash is installed in a different directory on non-Linux systems like
> > FreeBSD. Do not hard-code /bin/bash here so that the tests can run
> > there, too.
> 
> These tests were obviously copy-and-pasted from a fork point prior to
> commit 11a82d14.

Is this a candidate for a checkpatch addition to reject any use
of /bin/bash in scripts ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
