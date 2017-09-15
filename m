Received: from eggs.gnu.org ([2001:4830:134:3::10]:49924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dssSF-0007NH-RT
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dssSB-0001Az-Tm
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:22:55 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:53441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dssSB-0001A6-MU
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:22:51 -0400
Received: by mail-wr0-x231.google.com with SMTP id l22so2121958wrc.10
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 08:22:51 -0700 (PDT)
References: <20170809202712.6951-1-f4bug@amsat.org>
	<20170809202712.6951-2-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170809202712.6951-2-f4bug@amsat.org>
Date: Fri, 15 Sep 2017 16:22:48 +0100
Message-ID: <87shfo7zqv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 v3 01/16] travis: update
 sudo-enabled Trusty images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> see https://blog.travis-ci.com/2017-06-19-trusty-updates-2017-Q2
> and
> https://blog.travis-ci.com/2017-06-21-trusty-updates-2017-Q2-launch

I guess we drop this now? Either we are working or we are not :-/

>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  .travis.yml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index f583839755..b9cafe3d40 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -98,6 +98,7 @@ matrix:
>        sudo: required
>        addons:
>        dist: trusty
> +      group: deprecated-2017Q2
>        compiler: gcc
>        before_install:
>          - sudo apt-get update -qq
> @@ -109,6 +110,7 @@ matrix:
>        sudo: required
>        addons:
>        dist: trusty
> +      group: deprecated-2017Q2
>        compiler: gcc
>        before_install:
>          - sudo apt-get update -qq
> @@ -119,6 +121,7 @@ matrix:
>      - sudo: required
>        addons:
>        dist: trusty
> +      group: deprecated-2017Q2
>        language: generic
>        compiler: none
>        env:
> @@ -138,6 +141,7 @@ matrix:
>      - sudo: required
>        addons:
>        dist: trusty
> +      group: deprecated-2017Q2
>        language: generic
>        compiler: none
>        env:


--
Alex Bennée
