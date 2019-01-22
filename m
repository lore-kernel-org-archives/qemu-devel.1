Received: from eggs.gnu.org ([209.51.188.92]:34316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glsf4-0006FX-HV
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glsf3-0000bx-9x
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:48:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glsf1-0000Xv-AZ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:48:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so26486246wrx.9
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 01:47:58 -0800 (PST)
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-2-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7126eeb9-7dd5-3b33-a952-54271cee5fa9@redhat.com>
Date: Tue, 22 Jan 2019 10:47:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190117185628.21862-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

On 1/17/19 7:56 PM, Cleber Rosa wrote:
> Even when the launch of QEMU succeeds, it's useful to have the command
> line recorded.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
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

Useful!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>          self._popen = subprocess.Popen(self._qemu_full_args,
>                                         stdin=devnull,
>                                         stdout=self._qemu_log_file,
> 
