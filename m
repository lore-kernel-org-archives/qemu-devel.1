Received: from eggs.gnu.org ([209.51.188.92]:57428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpjgW-0006Ig-0V
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 20:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpjgU-0001JZ-1X
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 20:01:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpjgT-0000pT-QH
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 20:01:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so7908815wmd.2
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 17:01:21 -0800 (PST)
References: <20190202005610.24048-1-crosa@redhat.com>
	<20190202005610.24048-11-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aa8cc17e-f67c-2f23-0753-94b8555458d2@redhat.com>
Date: Sat, 2 Feb 2019 02:01:17 +0100
MIME-Version: 1.0
In-Reply-To: <20190202005610.24048-11-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 10/20] Boot Linux Console Test: add
 common kernel command line options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org, Stefan Markovic <smarkovic@wavecomp.com>

On 2/2/19 1:56 AM, Cleber Rosa wrote:
> The 'printk.time=0' option makes it easier to parse the console
> output.  Let's set it as a default, and reusable, kernel command line
> options for this and future similar tests.

Thanks!

> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/acceptance/boot_linux_console.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 35b31162d4..cc5dcd7373 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -23,6 +23,8 @@ class BootLinuxConsole(Test):
>  
>      timeout = 60
>  
> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
> +
>      def test_x86_64_pc(self):
>          """
>          :avocado: tags=arch:x86_64
> @@ -35,7 +37,7 @@ class BootLinuxConsole(Test):
>  
>          self.vm.set_machine('pc')
>          self.vm.set_console()
> -        kernel_command_line = 'console=ttyS0'
> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
>          self.vm.add_args('-kernel', kernel_path,
>                           '-append', kernel_command_line)
>          self.vm.launch()
> 
