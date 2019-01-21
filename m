Received: from eggs.gnu.org ([209.51.188.92]:57927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glgBl-0007uD-LQ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glgBk-0005d8-Sk
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:28:57 -0500
Date: Mon, 21 Jan 2019 18:19:17 -0200
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20190121201916.GA17671@localhost.localdomain>
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-2-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117185628.21862-2-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/18] scripts/qemu.py: log QEMU launch
 command line
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

On Thu, Jan 17, 2019 at 01:56:11PM -0500, Cleber Rosa wrote:
> Even when the launch of QEMU succeeds, it's useful to have the command
> line recorded.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Caio Carrara <ccarrara@redhat.com>

> ---
>  scripts/qemu.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 6e3b0e6771..ec3567d4e2 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -312,6 +312,7 @@ class QEMUMachine(object):
>          self._pre_launch()
>          self._qemu_full_args = (self._wrapper + [self._binary] +
>                                  self._base_args() + self._args)
> +        LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
>          self._popen = subprocess.Popen(self._qemu_full_args,
>                                         stdin=devnull,
>                                         stdout=self._qemu_log_file,
> -- 
> 2.20.1
> 

-- 
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
