Received: from eggs.gnu.org ([2001:4830:134:3::10]:49397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5N1q-000726-VA
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 22:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5N1m-0005RT-SK
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 22:27:18 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:56035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5N1m-0005Q5-MF
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 22:27:14 -0400
Received: by mail-pf0-x236.google.com with SMTP id 17so8818461pfn.12
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 19:27:14 -0700 (PDT)
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-26-richard.henderson@linaro.org>
	<20171018043106.GD13959@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7a6a8080-613f-6144-aff1-85f1e8a834ca@linaro.org>
Date: Thu, 19 Oct 2017 19:27:10 -0700
MIME-Version: 1.0
In-Reply-To: <20171018043106.GD13959@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 25/50] tcg: Include CF_COUNT_MASK in
 CF_HASH_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 10/17/2017 09:31 PM, Emilio G. Cota wrote:
> On Mon, Oct 16, 2017 at 10:25:44 -0700, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Does this patch work with icount for you? On my end, aarch64
> stops booting with -icount 1.

Found it -- cpu_io_recompile needs the same sort of fix as in patch 24.  I'll
post a v7 shortly.


r~
