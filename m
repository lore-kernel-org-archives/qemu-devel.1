Received: from eggs.gnu.org ([209.51.188.92]:41294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gliRw-0004pa-PV
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gliRv-0006ti-4G
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:53:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gliRu-0006sJ-Uv
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:53:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so25260506wrt.4
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 14:53:45 -0800 (PST)
References: <20190121171543.32422-1-alex.bennee@linaro.org>
	<20190121171543.32422-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b98226b0-a598-e04c-0d75-67ca2cb6a34d@redhat.com>
Date: Mon, 21 Jan 2019 23:53:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190121171543.32422-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] tests/vm: call make check directly
 for netbsd/freebsd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: kamil@netbsd.org, brad@comstyle.com, Fam Zheng <fam@euphon.net>

On 1/21/19 6:15 PM, Alex Bennée wrote:
> The "make check" target calls check-qtest which has the appropriate
> system binaries as dependencies so we shouldn't need to do two steps
> of make invocation.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/vm/freebsd | 1 -
>  1 file changed, 1 deletion(-)
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
