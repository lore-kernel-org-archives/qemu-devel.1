Received: from eggs.gnu.org ([2001:4830:134:3::10]:57491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1frkIr-0002IT-FJ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1frkHU-0000xo-Rd
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:31:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1frkHU-0000xH-IA
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:31:40 -0400
Date: Mon, 20 Aug 2018 21:31:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180820133137.GH10682@lemon.usersys.redhat.com>
References: <20180820124811.7982-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820124811.7982-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] tests/vm: Clean out old working
 directories on build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org

On Mon, 08/20 13:48, Peter Maydell wrote:
> When we do a build inside one of the BSD VMs, first
> delete any stale old build directories from the VM's
> /var/tmp. This prevents the VM from running out of
> disk space after it has been used for a dozen or
> so builds.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The Ubuntu test VM has a similar issue, but it doesn't
> put its test build directories in /var/tmp/ like the
> BSDs, and I don't use it so I'm not sure what the right
> rm command would be. Somebody else can fix it if they care...
> 
> Disclaimer: not actually tested yet, but obviously it will
> get tested as part of applying it to master, which I'd
> like to do so my pullrequest tests don't keep getting
> tripped up by this bug.

Reviewed-by: Fam Zheng <famz@redhat.com>

Please merge this yourself if it helps your pull request handling workflow.

> 
>  tests/vm/freebsd | 1 +
>  tests/vm/netbsd  | 1 +
>  tests/vm/openbsd | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 0a6ec4614a7..b6983127d09 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -20,6 +20,7 @@ class FreeBSDVM(basevm.BaseVM):
>      name = "freebsd"
>      BUILD_SCRIPT = """
>          set -e;
> +        rm -rf /var/tmp/qemu-test.*
>          cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
>          tar -xf /dev/vtbd1;
>          ./configure {configure_opts};
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 45c9260dc0d..a4e25820d50 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -20,6 +20,7 @@ class NetBSDVM(basevm.BaseVM):
>      name = "netbsd"
>      BUILD_SCRIPT = """
>          set -e;
> +        rm -rf /var/tmp/qemu-test.*
>          cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
>          tar -xf /dev/rld1a;
>          ./configure --python=python2.7 {configure_opts};
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 98edfbca4ba..52500ee52bb 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -20,6 +20,7 @@ class OpenBSDVM(basevm.BaseVM):
>      name = "openbsd"
>      BUILD_SCRIPT = """
>          set -e;
> +        rm -rf /var/tmp/qemu-test.*
>          cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
>          tar -xf /dev/rsd1c;
>          ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 {configure_opts};
> -- 
> 2.18.0
> 
> 
