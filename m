Received: from eggs.gnu.org ([209.51.188.92]:60452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1glu3s-00028D-Fp
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1glu3r-0001p3-Mc
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:17:44 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1glu3r-0001mb-Gj
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:17:43 -0500
Received: by mail-wm1-x343.google.com with SMTP id g67so13745378wmd.2
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 03:17:42 -0800 (PST)
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-2-crosa@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190117185628.21862-2-crosa@redhat.com>
Date: Tue, 22 Jan 2019 11:17:39 +0000
Message-ID: <875zuh0wmk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>


Cleber Rosa <crosa@redhat.com> writes:

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
>          self._qemu_full_args =3D (self._wrapper + [self._binary] +
>                                  self._base_args() + self._args)
> +        LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args=
))
>          self._popen =3D subprocess.Popen(self._qemu_full_args,
>                                         stdin=3Ddevnull,
>                                         stdout=3Dself._qemu_log_file,


Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
