Received: from eggs.gnu.org ([2001:4830:134:3::10]:59896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dssx8-0006Jr-Gv
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dssx4-0004Df-Gh
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:54:50 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:46101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dssx4-0004DV-AF
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:54:46 -0400
Received: by mail-wm0-x231.google.com with SMTP id i189so9484739wmf.1
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 08:54:46 -0700 (PDT)
References: <20170809202712.6951-1-f4bug@amsat.org>
	<20170809202712.6951-16-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170809202712.6951-16-f4bug@amsat.org>
Date: Fri, 15 Sep 2017 16:54:43 +0100
Message-ID: <87mv5w7y9o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for-2.11 v3 15/16] travis/osx: build
 using more Xcode versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> currently default builder is based on Xcode 7.3.1:
>     OS X 10.11 (darwin14.5.0)
>     Apple LLVM version 7.3.0
>
> add the oldest available Xcode (6.4):
>     OS X 10.10 (darwin14.5.0)
>     Apple LLVM 6.1.0 (based on LLVM 3.6.0svn)
>
> and the newer available Xcode (8.3.3):
>     OS X 10.12 (darwin16.6.0)
>     Apple LLVM version 8.1.0

I reckon oldest stable and newest stable is enough for coverage.

>
> see https://docs.travis-ci.com/user/reference/osx/#OS-X-Version
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  .travis.yml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 7c93a10c5f..cd59570062 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -117,6 +117,18 @@ matrix:
>        compiler: gcc
>      - env: CONFIG=""
>        os: osx
> +      # older available: OS X 10.10
> +      osx_image: xcode6.4
> +      compiler: clang
> +    - env: CONFIG=""
> +      os: osx
> +      # default: OS X 10.11.6
> +      osx_image: xcode7.3
> +      compiler: clang
> +    - env: CONFIG=""
> +      os: osx
> +      # newer stable available, OS X 10.12
> +      osx_image: xcode8.3
>        compiler: clang
>      # Plain Trusty System Build
>      - env: CONFIG="--disable-linux-user"


--
Alex Bennée
