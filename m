Received: from eggs.gnu.org ([2001:4830:134:3::10]:56441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9HAB-0006ca-F7
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9HA7-0003Gi-Im
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:32:19 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:37721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9HA7-0003DW-DA
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:32:15 -0400
Received: by mail-pf0-x22a.google.com with SMTP id p6so3251203pfn.4
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:32:15 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-27-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3765e085-c4e5-44a4-5986-41b233be4d22@linaro.org>
Date: Thu, 19 Apr 2018 11:32:10 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-27-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 26/43] tests/tcg/arm: fix up
 test-arm-iwmmxt test
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
> +test-arm-iwmmxt: CFLAGS+=-marm -march=iwmmxt -mabi=aapcs
> +test-arm-iwmmxt: test-arm-iwmmxt.S

This appears to be insufficient.
If I begin with armv7l-linux-gnueabihf-gcc, then I get

  CROSS-BUILD arm guest-tests with armv7l-linux-gnueabihf-gcc
cc1: error: iWMMXt and NEON are incompatible



r~
