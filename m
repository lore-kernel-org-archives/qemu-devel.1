Received: from eggs.gnu.org ([209.51.188.92]:58688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0COh-0000LN-0M
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 16:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0COf-0002eg-Tm
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 16:42:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0COf-0002Qt-4H
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 16:42:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id r5so1452664wrg.9
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 13:42:16 -0800 (PST)
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-10-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <540075f0-5217-db8e-e4b0-36849bb7738d@redhat.com>
Date: Sat, 2 Mar 2019 22:42:13 +0100
MIME-Version: 1.0
In-Reply-To: <20190221005753.27955-10-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 09/20] Boot Linux Console Test: update
 the x86_64 kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>

On 2/21/19 1:57 AM, Cleber Rosa wrote:
> To the stock Fedora 29 kernel, from the Fedora 28.  New tests will be

[Update] to ... ?

> added using the 29 kernel, so for consistency, let's also update it
> here.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Caio Carrara <ccarrara@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
> 
