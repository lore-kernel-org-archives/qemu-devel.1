Received: from eggs.gnu.org ([209.51.188.92]:59036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0CQH-0001Hw-71
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 16:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0CQG-0002cZ-E7
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 16:43:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0CQG-0002V3-6l
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 16:43:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id c13so1277046wmb.0
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 13:43:55 -0800 (PST)
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-12-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e459358e-6d37-49b4-26a1-ace252c33248@redhat.com>
Date: Sat, 2 Mar 2019 22:43:52 +0100
MIME-Version: 1.0
In-Reply-To: <20190221005753.27955-12-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 11/20] Boot Linux Console Test: increase
 timeout
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
> When running on very low powered environments, some tests may time out
> causing false negatives.  As a conservative change, and for
> considering that human time (investigating false negatives) is worth
> more than some extra machine cycles (and time), let's increase the
> overall timeout.

However this is annoying when a test is stuck and you work on battery...

> 
> CC: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index cc5dcd7373..fa721a7355 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -21,7 +21,7 @@ class BootLinuxConsole(Test):
>      :avocado: enable
>      """
>  
> -    timeout = 60
> +    timeout = 90
>  
>      KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
>  
> 
