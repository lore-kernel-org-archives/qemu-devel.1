Received: from eggs.gnu.org ([209.51.188.92]:36677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggdIB-0008TM-To
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 17:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggdIB-000754-Ag
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 17:22:43 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggdIB-00074J-2e
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 17:22:43 -0500
Received: by mail-pg1-x544.google.com with SMTP id s198so770811pgs.2
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 14:22:42 -0800 (PST)
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-20-richard.henderson@linaro.org>
	<CAFEAcA-GHkNshsMRvMFLiN2rb837D0YEU6ds0Ns5JR8ABo_n6A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0a1eb55f-b569-8996-bf8a-55a9a711157e@linaro.org>
Date: Tue, 8 Jan 2019 08:22:35 +1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-GHkNshsMRvMFLiN2rb837D0YEU6ds0Ns5JR8ABo_n6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 19/27] target/arm: Export
 aa64_va_parameters to internals.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1/7/19 9:45 PM, Peter Maydell wrote:
> I assume 48 bits is what the kernel sets up for userspace ?

Yep.  There's been some discussion about what to do with 52-bit addressing, but
it hasn't landed upstream yet.


r~
