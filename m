Received: from eggs.gnu.org ([2001:4830:134:3::10]:38956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d31vD-00023e-4C
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d31v9-0007K6-ES
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:58:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d31v9-0007Jt-8K
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:58:27 -0400
Date: Tue, 25 Apr 2017 15:58:23 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170425145823.GL21129@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA8xJ11azOh-sQhzpsb0b++EGT+hML-fvvKRSkyOirB1PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8xJ11azOh-sQhzpsb0b++EGT+hML-fvvKRSkyOirB1PQ@mail.gmail.com>
Subject: Re: [Qemu-devel] QEMU travis builds: can we move the preseed
 tarball to qemu.org ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Jeff Cody <jcody@redhat.com>

On Tue, Apr 25, 2017 at 03:51:17PM +0100, Peter Maydell wrote:
> Hi; a recent travis build failure made me notice that our .travis.yml
> config references a preseed tarball from here:
> http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz
> 
> I think this is a bit less than ideal -- we should really be hosting
> this on qemu.org. Can we arrange to move it?

I'm curious how much speed difference there is in seeding the git submodules
in this way vs letting git pull down from git.qemu.org directly ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
