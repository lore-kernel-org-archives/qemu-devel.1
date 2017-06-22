Received: from eggs.gnu.org ([2001:4830:134:3::10]:43175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNzGp-0007GW-Uj
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNzGm-00068F-PP
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:23:27 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNzGm-00066V-Is
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:23:24 -0400
Received: by mail-wr0-x231.google.com with SMTP id c11so16946138wrc.3
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 03:23:24 -0700 (PDT)
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-16-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170622033231.19344-16-f4bug@amsat.org>
Date: Thu, 22 Jun 2017 11:24:07 +0100
Message-ID: <874lv8tj5k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 15/21] travis: retry when git submodules
 initialization fails
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

> example of failure: https://travis-ci.org/philmd/qemu/jobs/245612939
>
>   $ git submodule update --init --recursive
>   [...]
>   Submodule 'pixman' (git://anongit.freedesktop.org/pixman) registered for path 'pixman'
>   Cloning into 'pixman'...
>   fatal: unable to connect to anongit.freedesktop.org:
>   anongit.freedesktop.org[0: 131.252.210.161]: errno=Connection timed out
>   anongit.freedesktop.org[1: 2610:10:20:722:a800:ff:fe24:61cf]: errno=Network is unreachable
>   Clone of 'git://anongit.freedesktop.org/pixman' into submodule path 'pixman' failed
>   The command "git submodule update --init --recursive" failed and exited with 1 during .
>   Your build has been stopped.
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index bac5bea744..34391722a2 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -85,7 +85,7 @@ git:
>  before_install:
>    - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew update ; fi
>    - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ccache ; fi
> -  - git submodule update --init --recursive
> +  - travis_retry git submodule update --init --recursive
>  before_script:
>    # https://docs.travis-ci.com/user/caching#ccache-on-os-x
>    - if [ "$TRAVIS_OS_NAME" == "osx" ]; then export PATH=/usr/local/opt/ccache/libexec:$PATH ; fi


--
Alex Bennée
