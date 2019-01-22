Received: from eggs.gnu.org ([209.51.188.92]:35549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glsin-0000qg-3w
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glsil-0004Xu-7N
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:51:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glsij-0004Az-AM
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:51:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so13435696wmb.3
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 01:51:24 -0800 (PST)
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-5-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8afeccf9-f093-e55d-f207-5592424ad6b2@redhat.com>
Date: Tue, 22 Jan 2019 10:51:22 +0100
MIME-Version: 1.0
In-Reply-To: <20190117185628.21862-5-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/18] Acceptance tests: fix doc reference
 to avocado_qemu directory
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
> The "this directory" reference is misleading and confusing, it's a
> leftover from when this text was proposed in a README file inside
> the "tests/acceptance/avocado_qemu" directory.
> 
> When that text was moved to the top level docs directory, the
> reference was not updated.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  docs/devel/testing.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 18e2c0868a..44c9b3ae74 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -590,8 +590,9 @@ Alternatively, follow the instructions on this link:
>  Overview
>  --------
>  
> -This directory provides the ``avocado_qemu`` Python module, containing
> -the ``avocado_qemu.Test`` class.  Here's a simple usage example:
> +The ``tests/acceptance/avocado_qemu`` directory provides the
> +``avocado_qemu`` Python module, containing the ``avocado_qemu.Test``
> +class.  Here's a simple usage example:
>  
>  .. code::
>  
> 
