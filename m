Received: from eggs.gnu.org ([209.51.188.92]:56813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glg7e-0004RF-79
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:24:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glg7W-0002pO-Bs
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:24:36 -0500
Date: Mon, 21 Jan 2019 18:24:09 -0200
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20190121202408.GE17671@localhost.localdomain>
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-7-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117185628.21862-7-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/18] Acceptance tests: use "arch:" tag to
 filter target specific tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

On Thu, Jan 17, 2019 at 01:56:16PM -0500, Cleber Rosa wrote:
> Currently, the only test that contains some target architecture
> information is "boot_linux_console.py" which test contains a "x86_64"
> tag.  But that tag is not respected in the default execution, that is,
> "make check-acceptance" doesn't do anything with it.
> 
> That said, even the target architecture handling currently present in
> the "avocado_qemu.Test" class, class is pretty limited.  For instance,
> by default, it chooses a target based on the host architecture.
> 
> Because the original implementation of the tags feature in Avocado did
> not include any time of namespace or "key:val" mechanism, no tag has
> relation to another tag.  The new implementation of the tags feature
> from version 67.0 onwards, allows "key:val" tags, and because of that,
> a test can be classified with a tag in a given key.  For instance, the
> new proposed version of the "boot_linux_console.py" test, which
> downloads and attempts to run a x86_64 kernel, is now tagged as:
> 
>   :avocado: tags=arch:x86_64
> 
> This means that it can be filtered (out) when no x86_64 target is
> available.  At the same time, tests that don't have a "arch:" tag,
> will not be filtered out.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Caio Carrara <ccarrara@redhat.com>

> ---
>  tests/Makefile.include                 | 3 +++
>  tests/acceptance/boot_linux_console.py | 2 +-
>  tests/requirements.txt                 | 2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
{...}
> 

-- 
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
