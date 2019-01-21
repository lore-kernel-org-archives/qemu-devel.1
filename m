Received: from eggs.gnu.org ([209.51.188.92]:56178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glg4z-0002as-Lv
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:21:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glg4u-0001dH-O8
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:21:54 -0500
Date: Mon, 21 Jan 2019 18:21:35 -0200
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20190121202134.GD17671@localhost.localdomain>
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-5-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117185628.21862-5-crosa@redhat.com>
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
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

On Thu, Jan 17, 2019 at 01:56:14PM -0500, Cleber Rosa wrote:
> The "this directory" reference is misleading and confusing, it's a
> leftover from when this text was proposed in a README file inside
> the "tests/acceptance/avocado_qemu" directory.
> 
> When that text was moved to the top level docs directory, the
> reference was not updated.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Caio Carrara <ccarrara@redhat.com>

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
> -- 
> 2.20.1
> 

-- 
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
