Received: from eggs.gnu.org ([2001:4830:134:3::10]:41567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNzAa-0004GF-BQ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNzAX-00033f-2q
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:17:00 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNzAW-000339-Sb
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:16:57 -0400
Received: by mail-wr0-x22d.google.com with SMTP id k67so16689036wrc.2
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 03:16:56 -0700 (PDT)
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-11-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170622033231.19344-11-f4bug@amsat.org>
Date: Thu, 22 Jun 2017 11:17:39 +0100
Message-ID: <87bmpgtjgc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 10/21] travis: increase S3 cache timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  .travis.yml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index be28e0642c..62b9dfd2ae 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -6,6 +6,7 @@ compiler:
>    - gcc
>  cache:
>    ccache: true
> +  timeout: 1200 # https://docs.travis-ci.com/user/caching#setting-the-timeout
>  addons:
>    apt:
>      packages:


--
Alex Bennée
