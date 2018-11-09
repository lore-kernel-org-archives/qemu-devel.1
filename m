Received: from eggs.gnu.org ([2001:4830:134:3::10]:52991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gL95e-0003GD-Cp
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gL95b-0006oj-6v
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:52:58 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gL95Z-0006nO-BC
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:52:53 -0500
Received: by mail-wr1-x441.google.com with SMTP id j26-v6so2411157wre.1
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 07:52:52 -0800 (PST)
References: <20181109150710.31085-1-crosa@redhat.com>
	<20181109150710.31085-4-crosa@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181109150710.31085-4-crosa@redhat.com>
Date: Fri, 09 Nov 2018 15:52:49 +0000
Message-ID: <87efbu5ju6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] Travis CI: make specified Python
 versions usable on jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>


Cleber Rosa <crosa@redhat.com> writes:

> For the two Python jobs, which seem to have the goal of making sure
> QEMU builds successfully on the 3.0-3.6 spectrum of Python 3 versions,
> the specified version is only applicable if a Python virtual
> environment is used.  To do that, it's necessary to define the
> (primary?) language of the job to be Python.
>
> Also, Travis doesn't have a 3.0 Python installation available for the
> chosen distro, 3.2 being the lower version available.
>
> Reference: https://docs.travis-ci.com/user/languages/python/#specifying-p=
ython-versions
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Do you want me to take this via my tree or keep it with the other patches?

> ---
>  .travis.yml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index aa49c7b114..5c18d3e268 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -112,9 +112,11 @@ matrix:
>        compiler: clang
>      # Python builds
>      - env: CONFIG=3D"--target-list=3Dx86_64-softmmu"
> +      language: python
>        python:
> -        - "3.0"
> +        - "3.2"
>      - env: CONFIG=3D"--target-list=3Dx86_64-softmmu"
> +      language: python
>        python:
>          - "3.6"
>      # Acceptance (Functional) tests


--
Alex Benn=C3=A9e
