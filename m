Received: from eggs.gnu.org ([209.51.188.92]:50987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqRx-00048d-Do
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqRl-0007lz-Gr
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:27:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gvqRe-0007iX-Aj
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:27:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15so479152wmi.5
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:27:21 -0800 (PST)
References: <20190218173723.26120-1-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <92f444aa-8b6d-581e-0a07-ddde6b10e720@redhat.com>
Date: Mon, 18 Feb 2019 22:27:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190218173723.26120-1-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: drop usage of ":avocado:
 enable"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On 2/18/19 6:37 PM, Cleber Rosa wrote:
> The Avocado test runner attemps to find its INSTRUMENTED (that is,
> Python based tests) in a manner that is as safe as possible to the
> user.  Different from plain Python unittest, it won't load or
> execute test code on an operation such as:
> 
>  $ avocado list tests/acceptance/
> 
> Before version 68.0, the logic implemented to identify INSTRUMENTED
> tests would require either the ":avocado: enable" or ":avocado:
> recursive" statement as a flag for tests that would not inherit
> directly from "avocado.Test".  This is not necessary anymore,
> and because of that the boiler plate statements can now be removed.

Yay \o/

> 
> Reference: https://avocado-framework.readthedocs.io/en/68.0/release_notes/68_0.html#users-test-writers
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  docs/devel/testing.rst                 | 1 -
>  tests/acceptance/boot_linux_console.py | 1 -
>  tests/acceptance/linux_initrd.py       | 1 -
>  tests/acceptance/version.py            | 1 -
>  tests/acceptance/virtio_version.py     | 1 -
>  tests/acceptance/vnc.py                | 1 -
>  tests/requirements.txt                 | 2 +-
>  7 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 135743a2bf..3ce171829d 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -600,7 +600,6 @@ the ``avocado_qemu.Test`` class.  Here's a simple usage example:
>  
>    class Version(Test):
>        """
> -      :avocado: enable
>        :avocado: tags=quick
>        """
>        def test_qmp_human_info_version(self):
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 98324f7591..beeb1e59e8 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -18,7 +18,6 @@ class BootLinuxConsole(Test):
>      Boots a x86_64 Linux kernel and checks that the console is operational
>      and the kernel command line is properly passed from QEMU to the kernel
>  
> -    :avocado: enable
>      :avocado: tags=x86_64
>      """
>  
> diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_initrd.py
> index 737355c2ef..5a15fc4347 100644
> --- a/tests/acceptance/linux_initrd.py
> +++ b/tests/acceptance/linux_initrd.py
> @@ -18,7 +18,6 @@ class LinuxInitrd(Test):
>      """
>      Checks QEMU evaluates correctly the initrd file passed as -initrd option.
>  
> -    :avocado: enable
>      :avocado: tags=x86_64
>      """
>  
> diff --git a/tests/acceptance/version.py b/tests/acceptance/version.py
> index 13b0a7440d..67c2192c93 100644
> --- a/tests/acceptance/version.py
> +++ b/tests/acceptance/version.py
> @@ -14,7 +14,6 @@ from avocado_qemu import Test
>  
>  class Version(Test):
>      """
> -    :avocado: enable
>      :avocado: tags=quick
>      """
>      def test_qmp_human_info_version(self):
> diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio_version.py
> index ce990250d8..464d75aa4e 100644
> --- a/tests/acceptance/virtio_version.py
> +++ b/tests/acceptance/virtio_version.py
> @@ -61,7 +61,6 @@ class VirtioVersionCheck(Test):
>      same device tree created by `disable-modern` and
>      `disable-legacy`.
>  
> -    :avocado: enable
>      :avocado: tags=x86_64
>      """
>  
> diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
> index b1ef9d71b1..064ceabcc1 100644
> --- a/tests/acceptance/vnc.py
> +++ b/tests/acceptance/vnc.py
> @@ -13,7 +13,6 @@ from avocado_qemu import Test
>  
>  class Vnc(Test):
>      """
> -    :avocado: enable
>      :avocado: tags=vnc,quick
>      """
>      def test_no_vnc(self):
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> index 64c6e27a94..002ded6a22 100644
> --- a/tests/requirements.txt
> +++ b/tests/requirements.txt
> @@ -1,4 +1,4 @@
>  # Add Python module requirements, one per line, to be installed
>  # in the tests/venv Python virtual environment. For more info,
>  # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> -avocado-framework==65.0
> +avocado-framework==68.0
> 
