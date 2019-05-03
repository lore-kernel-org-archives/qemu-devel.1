Received: from eggs.gnu.org ([209.51.188.92]:51304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMd5s-0004ZP-Ik
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMd5r-00086S-ME
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:39:36 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMd5r-00085Z-Gh
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:39:35 -0400
Received: by mail-pf1-x442.google.com with SMTP id u17so3292480pfn.7
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 11:39:35 -0700 (PDT)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-13-ysato@users.sourceforge.jp>
	<87muk34kym.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3d73dc0e-dd08-9900-481c-232ad303a6f0@linaro.org>
Date: Fri, 3 May 2019 11:39:30 -0700
MIME-Version: 1.0
In-Reply-To: <87muk34kym.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH RFC v8 12/12] hw/registerfields.h: Add 8bit
 and 16bit register macros.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>

On 5/3/19 8:27 AM, Alex Bennée wrote:
> 
> Yoshinori Sato <ysato@users.sourceforge.jp> writes:
> 
>> Some RX peripheral using 8bit and 16bit registers.
>> Added 8bit and 16bit APIs.
> 
> Doesn't this mean the build breaks at some point? Features used by other
> patches should be introduced first so the build remains bisectable.

The only bug I would fix in the ordering is to make the change to configure
last, so that the target/rx is not enabled while the patches are staging.


r~
