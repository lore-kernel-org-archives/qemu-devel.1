Received: from eggs.gnu.org ([2001:4830:134:3::10]:45061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOQB0-00085X-Tt
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOQAx-0000vy-N3
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:11:46 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOQAx-0000vs-Ii
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:11:43 -0400
Received: by mail-qt0-x243.google.com with SMTP id e8-v6so28530473qth.0
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 09:11:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180530110655.22022-1-alex.bennee@linaro.org>
	<20180530110655.22022-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <be606542-a4e9-514d-23c6-4439fd52005e@amsat.org>
Date: Thu, 31 May 2018 13:11:35 -0300
MIME-Version: 1.0
In-Reply-To: <20180530110655.22022-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 7/8] .travis.yml: update GCC sanitizer
 build to GCC 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org

On 05/30/2018 08:06 AM, Alex Bennée wrote:
> GCC has moved on and so should we. We also enable apt update to ensure
> we get the latest build from the toolchain PPA.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  .travis.yml | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index e99af6f357..ecc4367036 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -111,13 +111,14 @@ matrix:
>      # Using newer GCC with sanitizers
>      - addons:
>          apt:
> +          update: true
>            sources:
>              # PPAs for newer toolchains
>              - ubuntu-toolchain-r-test
>            packages:
>              # Extra toolchains
> -            - gcc-5
> -            - g++-5
> +            - gcc-7
> +            - g++-7
>              # Build dependencies
>              - libaio-dev
>              - libattr1-dev
> @@ -146,8 +147,8 @@ matrix:
>        language: generic
>        compiler: none
>        env:
> -        - COMPILER_NAME=gcc CXX=g++-5 CC=gcc-5
> -        - CONFIG="--cc=gcc-5 --cxx=g++-5 --disable-pie --disable-linux-user"
> +        - COMPILER_NAME=gcc CXX=g++-7 CC=gcc-7
> +        - CONFIG="--cc=gcc-7 --cxx=g++-7 --disable-pie --disable-linux-user"
>          - TEST_CMD=""
>        before_script:
>          - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || cat config.log
> 
