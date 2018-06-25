Received: from eggs.gnu.org ([2001:4830:134:3::10]:59738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXPjl-0005cn-6K
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXPji-0005aA-1C
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:32:49 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:38577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXPjh-0005Xe-TJ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:32:45 -0400
Received: by mail-qt0-x242.google.com with SMTP id c5-v6so774487qth.5
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 04:32:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180625111935.26108-1-alex.bennee@linaro.org>
	<20180625111935.26108-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ee81a86b-7022-8066-da79-66d51711da0c@amsat.org>
Date: Mon, 25 Jun 2018 08:32:39 -0300
MIME-Version: 1.0
In-Reply-To: <20180625111935.26108-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 05/10] docker: add gcovr to travis image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 06/25/2018 08:19 AM, Alex Bennée wrote:
> Useful for debugging if nothing else as the gcovr on the Travis images
> are a little old.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/travis.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
> index c5ad39b533..03ebfb0ef2 100644
> --- a/tests/docker/dockerfiles/travis.docker
> +++ b/tests/docker/dockerfiles/travis.docker
> @@ -5,7 +5,7 @@ ENV LC_ALL en_US.UTF-8
>  RUN cat /etc/apt/sources.list | sed "s/# deb-src/deb-src/" >> /etc/apt/sources.list
>  RUN apt-get update
>  RUN apt-get -y build-dep qemu
> -RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools
> +RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools gcovr

I suggest we follow
https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#sort-multi-line-arguments

Sort multi-line arguments:

Whenever possible, ease later changes by sorting multi-line arguments
alphanumerically. This helps to avoid duplication of packages and make
the list much easier to update. This also makes PRs a lot easier to read
and review. Adding a space before a backslash (\) helps as well.

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  # Travis tools require PhantomJS / Neo4j / Maven accessible
>  # in their PATH (QEMU build won't access them).
>  ENV PATH /usr/local/phantomjs/bin:/usr/local/phantomjs:/usr/local/neo4j-3.2.7/bin:/usr/local/maven-3.5.2/bin:/usr/local/cmake-3.9.2/bin:/usr/local/clang-5.0.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
> 
