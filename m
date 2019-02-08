Received: from eggs.gnu.org ([209.51.188.92]:52953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gsA1S-0005eT-Jg
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:33:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gsA1O-0007Ng-Vb
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:33:04 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gsA1M-0007Ky-MM
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:33:02 -0500
Received: by mail-wm1-x341.google.com with SMTP id d15so4344467wmb.3
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 09:32:59 -0800 (PST)
References: <20190207184346.6840-1-muriloo@linux.ibm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190207184346.6840-1-muriloo@linux.ibm.com>
Date: Fri, 08 Feb 2019 17:32:57 +0000
Message-ID: <87va1ukwxi.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs/devel/testing: Add -a option to
 usermod command on docker setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: qemu-devel@nongnu.org, mopsfelder@gmail.com, Philippe =?utf-8?Q?Mathie?= =?utf-8?Q?u-Daud=C3=A9?= <philmd@redhat.com>, Fam Zheng <famz@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org


Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:

> The option -G of usermod command will remove user from other groups
> not listed, i.e.: $USER will belong only to group 'docker' after
> following the documentation as is.
>
> From usermod(8) manual page:
>
>     If the user is currently a member of a group which is not listed,
>     the user will be removed from the group. This behaviour can be
>     changed via the -a option, which appends the user to the current
>     supplementary group list.
>
> This patch improves the situation by adding the -a option to the
> usermod command, which will just append user to the supplementary
> group list.
>
> Cc: qemu-trivial@nongnu.org
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Queued to testing/next, thanks.

> ---
>  docs/devel/testing.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 18e2c0868a..135743a2bf 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -301,7 +301,7 @@ An alternative method to set up permissions is by add=
ing the current user to
>  .. code::
>
>    $ sudo groupadd docker
> -  $ sudo usermod $USER -G docker
> +  $ sudo usermod $USER -a -G docker
>    $ sudo chown :docker /var/run/docker.sock
>
>  Note that any one of above configurations makes it possible for the user=
 to


--
Alex Benn=C3=A9e
