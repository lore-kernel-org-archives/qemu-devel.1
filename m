Received: from eggs.gnu.org ([209.51.188.92]:57628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glgAX-0006pk-GH
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glgAW-0004ol-Bh
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:27:41 -0500
Date: Mon, 21 Jan 2019 18:27:13 -0200
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20190121202712.GH17671@localhost.localdomain>
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-10-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117185628.21862-10-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/18] Boot Linux Console Test: update the
 x86_64 kernel
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

On Thu, Jan 17, 2019 at 01:56:19PM -0500, Cleber Rosa wrote:
> To the stock Fedora 29 kernel, from the Fedora 28.  New tests will be
> added using the 29 kernel, so for consistency, let's also update it
> here.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Caio Carrara <ccarrara@redhat.com>

> ---
>  tests/acceptance/boot_linux_console.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 89df7f6e4f..35b31162d4 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -28,9 +28,9 @@ class BootLinuxConsole(Test):
>          :avocado: tags=arch:x86_64
>          :avocado: tags=machine:pc
>          """
> -        kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
> +        kernel_url = ('https://mirrors.kernel.org/fedora/releases/29/'
>                        'Everything/x86_64/os/images/pxeboot/vmlinuz')
> -        kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
> +        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
>          kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>  
>          self.vm.set_machine('pc')
> -- 
> 2.20.1
> 

-- 
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
