Received: from eggs.gnu.org ([209.51.188.92]:38228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpisy-0002mK-Gz
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpisx-0004Nf-I2
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:10:16 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:40814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gpisv-0004AL-8d
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:10:13 -0500
Received: by mail-pg1-x531.google.com with SMTP id z10so3678580pgp.7
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 16:10:01 -0800 (PST)
References: <ae28cefe-84fb-6c4e-0452-55b717726b2b@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c0ebd2ff-3787-0f83-ad55-86baa3bcc8b0@linaro.org>
Date: Fri, 1 Feb 2019 16:09:57 -0800
MIME-Version: 1.0
In-Reply-To: <ae28cefe-84fb-6c4e-0452-55b717726b2b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] 2x-3x tcg performance regression on ppc64 (maybe
 others)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-ppc@nongnu.org

On 2/1/19 1:53 PM, Cleber Rosa wrote:
> Getting straight to the point, this is the ppc64 "boot linux console"
> test, running 10 times, on top my latest rebase (e8977901b, that
> includes f7b78602f).
> 
>  (01/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
> (63.07 s)
...
> Then, with f7b78602f reverted:
> 
>  (01/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
> (20.54 s)

This suggests that the cluster id added in that patch is perhaps uninitialized
or set incorrectly, so that we are spending much more time in code generation
than we should.


r~
