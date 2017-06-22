Received: from eggs.gnu.org ([2001:4830:134:3::10]:41320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNz9k-0003rS-5b
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNz9e-0002jI-23
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:16:08 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:35451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNz9d-0002iy-RI
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:16:01 -0400
Received: by mail-wr0-x234.google.com with SMTP id k67so16658010wrc.2
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 03:16:01 -0700 (PDT)
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-10-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170622033231.19344-10-f4bug@amsat.org>
Date: Thu, 22 Jun 2017 11:16:44 +0100
Message-ID: <87d19wtjhv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/21] travis: enable multiple caching
 features
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

> (this eases git workflow)
>
> see
> https://docs.travis-ci.com/user/caching#enabling-multiple-caching-features

I wonder if we could replace our submodule pre-seed hack with a native
Travis version? And now I see you do that in a later patch ;-)

>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  .travis.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 61394b4764..be28e0642c 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -4,7 +4,8 @@ python:
>    - "2.4"
>  compiler:
>    - gcc
> -cache: ccache
> +cache:
> +  ccache: true
>  addons:
>    apt:
>      packages:


--
Alex Bennée
