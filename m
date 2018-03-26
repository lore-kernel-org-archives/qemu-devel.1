Received: from eggs.gnu.org ([2001:4830:134:3::10]:43976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f0Nz9-0004rW-Mx
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f0Nz3-0001HR-Ie
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:00:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37222 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f0Nz3-0001GO-Cw
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:00:05 -0400
Date: Mon, 26 Mar 2018 16:59:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180326085955.GC31422@lemon.usersys.redhat.com>
References: <152192928550.363.5497859547477813786@71c20359a636>
	<cca001a1-5fca-10d2-54d4-4cf07b69d8a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cca001a1-5fca-10d2-54d4-4cf07b69d8a9@redhat.com>
Subject: Re: [Qemu-devel] Patchew failure ? (was: Re: [PATCH 00/14]
 Generalize Dallas/Maxim I2C RTC devices v2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, mdavidsaver@gmail.com

On Mon, 03/26 10:34, Thomas Huth wrote:
> On 24.03.2018 23:08, no-reply@patchew.org wrote:
> > Hi,
> > 
> > This series failed docker-build@min-glib build test. Please find the testing commands and
> > their output below. If you have Docker installed, you can probably reproduce it
> > locally.
> > 
> > Type: series
> > Message-id: 20180324192455.12254-1-mdavidsaver@gmail.com
> > Subject: [Qemu-devel] [PATCH 00/14] Generalize Dallas/Maxim I2C RTC devices v2
> [...]
> > === OUTPUT BEGIN ===
> > Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> > Cloning into '/var/tmp/patchew-tester-tmp-8pwvp3st/src/dtc'...
> > Submodule path 'dtc': checked out 'e54388015af1fb4bf04d0bca99caba1074d9cc42'
> >   BUILD   min-glib
> > make[1]: Entering directory '/var/tmp/patchew-tester-tmp-8pwvp3st/src'
> >   GEN     /var/tmp/patchew-tester-tmp-8pwvp3st/src/docker-src.2018-03-24-18.07.16.7723/qemu.tar
> > Cloning into '/var/tmp/patchew-tester-tmp-8pwvp3st/src/docker-src.2018-03-24-18.07.16.7723/qemu.tar.vroot'...
> > done.
> > Your branch is up-to-date with 'origin/test'.
> > Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> > Cloning into '/var/tmp/patchew-tester-tmp-8pwvp3st/src/docker-src.2018-03-24-18.07.16.7723/qemu.tar.vroot/dtc'...
> > Submodule path 'dtc': checked out 'e54388015af1fb4bf04d0bca99caba1074d9cc42'
> > Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git) registered for path 'ui/keycodemapdb'
> > Cloning into '/var/tmp/patchew-tester-tmp-8pwvp3st/src/docker-src.2018-03-24-18.07.16.7723/qemu.tar.vroot/ui/keycodemapdb'...
> > Submodule path 'ui/keycodemapdb': checked out '6b3d716e2b6472eb7189d3220552280ef3d832ce'
> > tar: /var/tmp/patchew-tester-tmp-8pwvp3st/src/docker-src.2018-03-24-18.07.16.7723/qemu.tar: Wrote only 4096 of 10240 bytes
> > tar: Error is not recoverable: exiting now
> > failed to create tar file
> >   COPY    RUNNER
> >     RUN test-build in qemu:min-glib 
> > tar: Unexpected EOF in archive
> > tar: Unexpected EOF in archive
> > tar: Error is not recoverable: exiting now
> > /var/tmp/qemu/run: line 32: prep_fail: command not found
> > Environment variables:
> > HOSTNAME=2ad891f2b17f
> > MAKEFLAGS= -j8
> > J=8
> > CCACHE_DIR=/var/tmp/ccache
> > EXTRA_CONFIGURE_OPTS=
> > V=
> > SHOW_ENV=1
> > PATH=/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
> > PWD=/
> > TARGET_LIST=
> > SHLVL=1
> > HOME=/root
> > TEST_DIR=/tmp/qemu-test
> > FEATURES= dtc
> > DEBUG=
> > _=/usr/bin/env
> > 
> > Configure options:
> > --enable-werror --target-list=x86_64-softmmu,aarch64-softmmu --prefix=/tmp/qemu-test/install
> > 
> > ERROR: DTC (libfdt) version >= 1.4.2 not present.
> >        Please install the DTC (libfdt) devel package

Thanks for reporting!

The image only has 1.4.0 so we need the submodule.. However, the real issue here
is -ENOSPC, and tests/docker/run has a "prep_fail" bug as above. I'll look into
those.

Fam

> 
>  Hi Fam,
> 
> sounds like there is currently something broken with patchew? Could you
> please have a look why it fails to use libfdt?
> 
>  Thomas
