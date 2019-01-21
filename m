Received: from eggs.gnu.org ([209.51.188.92]:57401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glg9Y-00064e-MP
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:26:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glg9X-0004L0-KU
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:26:40 -0500
Date: Mon, 21 Jan 2019 18:26:10 -0200
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20190121202610.GG17671@localhost.localdomain>
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-9-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117185628.21862-9-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/18] Boot Linux Console Test: rename the
 x86_64 after the arch and machine
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

On Thu, Jan 17, 2019 at 01:56:18PM -0500, Cleber Rosa wrote:
> Given that the test is specific to x86_64 and pc, and new tests are
> going to be added to the same class, let's rename it accordingly.
> Also, let's make the class documentation not architecture specific.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Caio Carrara <ccarrara@redhat.com>

> ---
>  tests/acceptance/boot_linux_console.py | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 46b20bdfe2..89df7f6e4f 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -15,16 +15,19 @@ from avocado_qemu import Test
>  
>  class BootLinuxConsole(Test):
>      """
> -    Boots a x86_64 Linux kernel and checks that the console is operational
> -    and the kernel command line is properly passed from QEMU to the kernel
> +    Boots a Linux kernel and checks that the console is operational and the
> +    kernel command line is properly passed from QEMU to the kernel
>  
>      :avocado: enable
> -    :avocado: tags=arch:x86_64
>      """
>  
>      timeout = 60
>  
> -    def test(self):
> +    def test_x86_64_pc(self):
> +        """
> +        :avocado: tags=arch:x86_64
> +        :avocado: tags=machine:pc
> +        """
>          kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
>                        'Everything/x86_64/os/images/pxeboot/vmlinuz')
>          kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
> -- 
> 2.20.1
> 

-- 
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
