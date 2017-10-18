Received: from eggs.gnu.org ([2001:4830:134:3::10]:54401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e4jiU-0005Uz-BX
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e4jiR-0008Fs-6P
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e4jiR-0008F8-0R
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:28:39 -0400
Date: Wed, 18 Oct 2017 16:28:36 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171018082836.GD9443@lemon>
References: <20171018073841.30062-1-famz@redhat.com>
	<150831409774.377.7665751901178175493@b58463cdfd5f>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150831409774.377.7665751901178175493@b58463cdfd5f>
Subject: Re: [Qemu-devel] [PATCH] docker: Fix PATH for ccache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, berrange@redhat.com
Cc: alex.bennee@linaro.org, f4bug@amsat.org

On Wed, 10/18 01:08, no-reply@patchew.org wrote:
> Your branch is up-to-date with 'origin/test'.
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-jhpnlaz0/src/docker-src.2017-10-18-04.03.32.32287/qemu.tar.vroot/dtc'...
> fatal: unable to connect to git.qemu-project.org:
> git.qemu-project.org[0: 172.99.69.163]: errno=Connection timed out
> 
> fatal: clone of 'git://git.qemu-project.org/dtc.git' into submodule path '/var/tmp/patchew-tester-tmp-jhpnlaz0/src/docker-src.2017-10-18-04.03.32.32287/qemu.tar.vroot/dtc' failed
> Failed to clone 'dtc'. Retry scheduled
> Cloning into '/var/tmp/patchew-tester-tmp-jhpnlaz0/src/docker-src.2017-10-18-04.03.32.32287/qemu.tar.vroot/dtc'...
> fatal: unable to connect to git.qemu-project.org:
> git.qemu-project.org[0: 172.99.69.163]: errno=Connection timed out
> 
> fatal: clone of 'git://git.qemu-project.org/dtc.git' into submodule path '/var/tmp/patchew-tester-tmp-jhpnlaz0/src/docker-src.2017-10-18-04.03.32.32287/qemu.tar.vroot/dtc' failed
> Failed to clone 'dtc' a second time, aborting
> failed to init submodule dtc

So now patchew is less robust on network hiccups: a number of the same "git
submodule update --init" calls have succeeded above, so this is incidental. Any
idea how to improve that? Maybe if there is a checkout from $QEMU_SRC, clone/cp
from there instead of fetch from submodule remote?

Fam
