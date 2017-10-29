Received: from eggs.gnu.org ([2001:4830:134:3::10]:47355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e8qSV-0007ll-A8
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 12:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e8qSR-0001ha-Fw
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 12:29:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e8qSR-0001hH-9O
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 12:29:07 -0400
Date: Sun, 29 Oct 2017 17:29:02 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171029162902.GA14433@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171027131412.18830-1-berrange@redhat.com>
	<20171027131412.18830-2-berrange@redhat.com>
	<f1716a0f-6c6d-7704-e628-3c4cfc1a6bf2@ozlabs.ru>
	<20171028204505.GA21304@redhat.com>
	<8f0324f3-a0c8-a4b0-357b-8b8ff7e75d08@ozlabs.ru>
	<20171029075727.GA21571@redhat.com>
	<a34b48cd-c112-7812-4e8a-2ba2db1a18e2@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a34b48cd-c112-7812-4e8a-2ba2db1a18e2@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] build: allow setting a custom GIT
 binary for transparent proxying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>

On Mon, Oct 30, 2017 at 01:08:56AM +1100, Alexey Kardashevskiy wrote:
> 
> I run ./scripts/git-submodule.sh on a server (where source directory is
> writeable), them "rm .git-submodule-status", then run "Makefile" on a build
> machine (which has the source directory mounted as read-only). I basically
> recreate the situation where I was when I just discovered this brand new
> ./scripts/git-submodule.sh.

Don't rm the .git-submodule-status. That means 'make' thinks the modules
are out of date.

Just run 'scripts/git-submodules.sh ...mods..' on the writable source
dir, and then run 'make' on the build machine.

> I know that now, all I am asking is an error message to print exact command
> to run...

If you hadn't deleted the .git-submodule-status, it would have worked fine.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
