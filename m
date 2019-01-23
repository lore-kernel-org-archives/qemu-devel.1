Received: from eggs.gnu.org ([209.51.188.92]:42138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmJa8-0005QB-MI
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmJPg-00041f-H8
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:21:57 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gmJPg-0003zq-7L
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:21:56 -0500
Received: by mail-wr1-x442.google.com with SMTP id q18so2644007wrx.9
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 06:21:56 -0800 (PST)
References: <20190123122935.6431-1-berrange@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190123122935.6431-1-berrange@redhat.com>
Date: Wed, 23 Jan 2019 14:21:54 +0000
Message-ID: <87y37bzc71.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] travis: stop requesting libffi & gettext
 from homebrew
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The default package set installed on macOS builders from Travis already
> includes libffi and gettext as shown by log messages:
>
>   Skipping install of libffi formula. It is already up-to-date.
>   Using libffi
>   Skipping install of gettext formula. It is already up-to-date.
>   Using gettext
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Queued to testing/next, thanks.
> ---
>  .travis.yml | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 87d9fa971c..beea941408 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -40,8 +40,6 @@ addons:
>        - gcovr
>    homebrew:
>      packages:
> -      - libffi
> -      - gettext
>        - glib
>        - pixman


--
Alex Benn=C3=A9e
