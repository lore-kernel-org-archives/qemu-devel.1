Received: from eggs.gnu.org ([2001:4830:134:3::10]:39030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDAZe-00021w-2W
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDAZY-0004By-Us
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:50:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDAZY-0004Bg-N2
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:50:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so777689wma.4
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 08:50:52 -0700 (PDT)
References: <20181018153134.8493-1-crosa@redhat.com>
	<20181018153134.8493-4-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4a7e872c-0d3a-363b-85e5-ff4cc4825e76@redhat.com>
Date: Thu, 18 Oct 2018 17:50:50 +0200
MIME-Version: 1.0
In-Reply-To: <20181018153134.8493-4-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 3/3] Travis support for the acceptance
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 18/10/2018 17:31, Cleber Rosa wrote:
> This enables the execution of the acceptance tests on Travis.
> 
> Because the Travis environment is based on Ubuntu Trusty, it requires
> the python3-pip and python3.4-venv packages.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Caio Carrara <ccarrara@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  .travis.yml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 95be6ec59f..aa49c7b114 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -117,6 +117,14 @@ matrix:
>      - env: CONFIG="--target-list=x86_64-softmmu"
>        python:
>          - "3.6"
> +    # Acceptance (Functional) tests
> +    - env: CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu"
> +           TEST_CMD="make AVOCADO_SHOW=app check-acceptance"
> +      addons:
> +        apt:
> +          packages:
> +            - python3-pip
> +            - python3.4-venv
>      # Using newer GCC with sanitizers
>      - addons:
>          apt:
> 
