Received: from eggs.gnu.org ([209.51.188.92]:46088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1glXR2-0004y2-R9
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1glXQx-0007fX-0P
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:08:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1glXQw-0007e3-Qv
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:08:02 -0500
Date: Mon, 21 Jan 2019 11:01:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190121110101.GA3683@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190118185402.3065-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118185402.3065-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] tests: Disable ipmi-bt-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, patches@linaro.org

On Fri, Jan 18, 2019 at 06:54:02PM +0000, Peter Maydell wrote:
> The ipmi-bt-test fails intermittently, especially on the NetBSD VM.
> The frequency of this failure has recently gone up sharply to the
> point that I'm having to retry the NetBSD build multiple times
> to get a pass when merging pull requests.
> 
> Disable the test until we can figure out why it's failing.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Fed up with this failing all the time so let's just turn it off.
> Feel free to investigate what's actually going wrong with it...

I wonder if we should keep a wiki page list all tests we've disabled
for being buggy, or file launchpad bugs for each & track those.

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
> -- 
> 2.20.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
