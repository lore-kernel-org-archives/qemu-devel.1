Received: from eggs.gnu.org ([209.51.188.92]:39628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glX17-00076x-FS
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glWzC-000087-EO
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:39:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glWzC-0008WM-46
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:39:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so22736453wrb.2
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 02:39:15 -0800 (PST)
References: <20190118185402.3065-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <906bafd8-2a2a-9cae-142e-c7045edaa9d0@redhat.com>
Date: Mon, 21 Jan 2019 11:39:13 +0100
MIME-Version: 1.0
In-Reply-To: <20190118185402.3065-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests: Disable ipmi-bt-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Corey Minyard <cminyard@mvista.com>
Cc: patches@linaro.org, Thomas Huth <thuth@redhat.com>

Cc'ing Corey, the tests author.

On 1/18/19 7:54 PM, Peter Maydell wrote:
> The ipmi-bt-test fails intermittently, especially on the NetBSD VM.
> The frequency of this failure has recently gone up sharply to the
> point that I'm having to retry the NetBSD build multiple times
> to get a pass when merging pull requests.
> 
> Disable the test until we can figure out why it's failing.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> Fed up with this failing all the time so let's just turn it off.
> Feel free to investigate what's actually going wrong with it...
> 
>  tests/Makefile.include | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index eaa81ee1d07..5e6b2c7058d 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -186,7 +186,8 @@ check-qtest-i386-$(CONFIG_SGA) += tests/boot-serial-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
>  check-qtest-i386-y += tests/rtc-test$(EXESUF)
>  check-qtest-i386-y += tests/ipmi-kcs-test$(EXESUF)
> -check-qtest-i386-y += tests/ipmi-bt-test$(EXESUF)
> +# Disabled temporarily as it fails intermittently especially under NetBSD VM
> +# check-qtest-i386-y += tests/ipmi-bt-test$(EXESUF)
>  check-qtest-i386-y += tests/i440fx-test$(EXESUF)
>  check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
>  check-qtest-i386-y += tests/drive_del-test$(EXESUF)
> 
