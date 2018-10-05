Received: from eggs.gnu.org ([208.118.235.92]:59392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8SCG-0000vM-TV
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8RyA-0008QJ-07
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:24:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8Ry9-0008Pu-PR
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:24:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1-v6so13962577wrt.10
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:24:44 -0700 (PDT)
References: <20181004151429.7232-1-crosa@redhat.com>
	<20181004151429.7232-2-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <99253a2a-3d78-27dc-405f-039d8896cca6@redhat.com>
Date: Fri, 5 Oct 2018 17:24:42 +0200
MIME-Version: 1.0
In-Reply-To: <20181004151429.7232-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/7] Acceptance Tests: improve docstring on
 pick_default_qemu_bin()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

On 04/10/2018 17:14, Cleber Rosa wrote:
> Making it clear what is returned by this utility function.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/acceptance/avocado_qemu/__init__.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index 1e54fd5932..d8d5b48dac 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -27,6 +27,10 @@ def pick_default_qemu_bin():
>      """
>      Picks the path of a QEMU binary, starting either in the current working
>      directory or in the source tree root directory.
> +
> +    :returns: the path to the default QEMU binary or None if one could not
> +              be found
> +    :rtype: str or None
>      """
>      arch = os.uname()[4]
>      qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
> 
