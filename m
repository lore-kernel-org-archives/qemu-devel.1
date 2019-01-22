Received: from eggs.gnu.org ([209.51.188.92]:36995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glsnU-0004tr-N1
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glsnT-0000ei-MA
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:56:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glsnT-0000UQ-GE
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:56:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so13463695wml.2
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 01:56:29 -0800 (PST)
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-9-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2867a169-462b-f354-db39-7967c94ae785@redhat.com>
Date: Tue, 22 Jan 2019 10:56:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190117185628.21862-9-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

On 1/17/19 7:56 PM, Cleber Rosa wrote:
> Given that the test is specific to x86_64 and pc, and new tests are
> going to be added to the same class, let's rename it accordingly.
> Also, let's make the class documentation not architecture specific.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
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
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
