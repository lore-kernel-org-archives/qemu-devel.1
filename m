Received: from eggs.gnu.org ([2001:4830:134:3::10]:47229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqK1l-0003GM-3O
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqK1h-0005y6-3u
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:13:01 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:43340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dqK1g-0005w0-Si
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:12:57 -0400
Received: by mail-wm0-x229.google.com with SMTP id f145so6382762wme.0
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 07:12:56 -0700 (PDT)
References: <20170905021201.25684-1-famz@redhat.com>
	<20170905021201.25684-2-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170905021201.25684-2-famz@redhat.com>
Date: Fri, 08 Sep 2017 15:12:53 +0100
Message-ID: <87y3ppgty2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 01/12] gitignore: Ignore vm test images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>


Fam Zheng <famz@redhat.com> writes:

> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  .gitignore       | 1 +
>  tests/.gitignore | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index cf65316863..40acfcb9e2 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -52,6 +52,7 @@
>  /vscclient
>  /vhost-user-scsi
>  /fsdev/virtfs-proxy-helper
> +*.tmp

I'm not sure we should be dumping anything in the rootdir, .gitignored
or not.

>  *.[1-9]
>  *.a
>  *.aux
> diff --git a/tests/.gitignore b/tests/.gitignore
> index fed0189a5a..cf6d99c91e 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -95,3 +95,4 @@ test-filter-mirror
>  test-filter-redirector
>  *-test
>  qapi-schema/*.test.*
> +vm/*.img


--
Alex Bennée
