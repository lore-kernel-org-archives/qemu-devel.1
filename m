Received: from eggs.gnu.org ([2001:4830:134:3::10]:37563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNysG-0006es-Mk
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNysC-0004bB-OF
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:58:04 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNysC-0004Yr-Hp
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:58:00 -0400
Received: by mail-wr0-x236.google.com with SMTP id r103so16184308wrb.0
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 02:58:00 -0700 (PDT)
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-8-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170622033231.19344-8-f4bug@amsat.org>
Date: Thu, 22 Jun 2017 10:58:43 +0100
Message-ID: <87efuctkbw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/21] travis: update sudo-enabled
 Trusty images
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

> see https://blog.travis-ci.com/2017-06-19-trusty-updates-2017-Q2
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

The way I read that blog post is group: edge is for testing things still
work but you probably don't want to merge that into your master branch.
Otherwise we'll automatically be running the bleeding edge.

> ---
>  .travis.yml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 29c9ef72a4..e60a5cd8e6 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -128,6 +128,7 @@ matrix:
>      - sudo: required
>        addons:
>        dist: trusty
> +      group: edge
>        language: generic
>        compiler: none
>        env:
> @@ -147,6 +148,7 @@ matrix:
>      - sudo: required
>        addons:
>        dist: trusty
> +      group: edge
>        language: generic
>        compiler: none
>        env:
> @@ -230,6 +232,7 @@ matrix:
>      # We run on the trusty Travis hosts so that there's a wider set of
>      # dependencies satisfied to improve coverage.
>      - dist: trusty
> +      group: edge
>        env:
>          - COVERITY=1
>          - COVERITY_BUILD_CMD="make -j3"


--
Alex Bennée
