Received: from eggs.gnu.org ([2001:4830:134:3::10]:46763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9Hd7-0006FP-BI
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9Hd6-00046e-Mw
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:02:13 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:36014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9Hd6-000466-GY
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:02:12 -0400
Received: by mail-pg0-x22c.google.com with SMTP id i6so3125862pgv.3
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 15:02:12 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-43-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1296d11c-5b11-cdca-cf01-09940334f127@linaro.org>
Date: Thu, 19 Apr 2018 12:02:01 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-43-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 42/43] tests/tcg: disable fp-test for 32
 bit (HACK!)
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

On 04/19/2018 03:59 AM, Alex Bennée wrote:
> +ifneq (,$(findstring 64,$(TARGET_NAME)))

You're only considering aarch64, x86_64, ppc64 and the like.
This fails for alpha, s390x and the like.


r~
