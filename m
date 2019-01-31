Received: from eggs.gnu.org ([209.51.188.92]:51094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpA8I-0002Nf-5Y
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpA8E-0000VT-G7
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:03:44 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpA8B-0000IB-TO
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:03:41 -0500
Received: by mail-wm1-f46.google.com with SMTP id d15so2021595wmb.3
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 03:03:29 -0800 (PST)
References: <20190125140017.6092-1-alex.bennee@linaro.org>
	<20190125140017.6092-12-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b08b2c10-713d-8cea-4409-09b45d937ed8@redhat.com>
Date: Thu, 31 Jan 2019 12:03:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190125140017.6092-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 11/14] tests/vm: call make check
 directly for netbsd/freebsd/ubuntu.i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>

On 1/25/19 3:00 PM, Alex Bennée wrote:
> The "make check" target calls check-qtest which has the appropriate
> system binaries as dependencies so we shouldn't need to do two steps
> of make invocation. Doing it in two steps was a hangover from when our
> make check couldn't run tests in parallel.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/vm/freebsd     | 1 -
>  tests/vm/netbsd      | 1 -
>  tests/vm/ubuntu.i386 | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 19a3729172..a85c866c30 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -25,7 +25,6 @@ class FreeBSDVM(basevm.BaseVM):
>          cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
>          tar -xf /dev/vtbd1;
>          ./configure {configure_opts};
> -        gmake --output-sync -j{jobs} {verbose};
>          gmake --output-sync -j{jobs} check {verbose};
>      """
>  
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index fac6a7ce51..edea113bb5 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -25,7 +25,6 @@ class NetBSDVM(basevm.BaseVM):
>          cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
>          tar -xf /dev/rld1a;
>          ./configure --python=python2.7 {configure_opts};
> -        gmake --output-sync -j{jobs} {verbose};
>          gmake --output-sync -j{jobs} check {verbose};
>      """
>  
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index 1b7e1ab8f0..252e514859 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -26,7 +26,6 @@ class UbuntuX86VM(basevm.BaseVM):
>          sudo chmod a+r /dev/vdb;
>          tar -xf /dev/vdb;
>          ./configure {configure_opts};
> -        make --output-sync -j{jobs};
>          make --output-sync check -j{jobs} {verbose};
>      """
>  
> 
