Received: from eggs.gnu.org ([2001:4830:134:3::10]:58402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9GN7-0004Gx-LF
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9GN4-0001sy-IW
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:41:37 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:46118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9GN4-0001qE-C4
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:41:34 -0400
Received: by mail-pg0-x242.google.com with SMTP id t12so3033438pgp.13
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 13:41:34 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e35eeb70-4bbc-a0fe-2903-6cf58d1729fe@linaro.org>
Date: Thu, 19 Apr 2018 10:41:28 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 03/43] configure: add support for
 --cross-cc-FOO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/19/2018 03:58 AM, Alex Bennée wrote:
> +  --cross-cc-*) cc_arch=${opt#--cross-cc-}
> +                eval "cross_cc_${cc_arch}=\$optarg"

This doesn't work as intended.

Given e.g. --cross-cc-aarch64=aarch64-linux-gcc

+ cc_arch=aarch64=aarch64-linux-gcc
+ eval 'cross_cc_aarch64=aarch64-linux-gcc=$optarg'
++ cross_cc_aarch64=aarch64-linux-gcc=aarch64-linux-gcc

Which sets the variable "cross_cc_aarch64"
to "aarch64-linux-gcc=aarch64-linux-gcc".
Which of course won't exist to execute.


r~
