Received: from eggs.gnu.org ([2001:4830:134:3::10]:33366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWuFC-00064u-In
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 21:27:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWuF8-000233-Me
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 21:27:26 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:38231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWuF5-00020u-0O
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 21:27:20 -0500
Received: by mail-oi1-x235.google.com with SMTP id a77so13813635oii.5
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 18:27:18 -0800 (PST)
References: <cover.1544229872.git.alistair.francis@wdc.com>
	<ae344632ba0e63f0e80ef4dfe76d224c915796a3.1544229872.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <915b8ec4-5c47-791d-2197-fdd7de438991@linaro.org>
Date: Tue, 11 Dec 2018 20:27:12 -0600
MIME-Version: 1.0
In-Reply-To: <ae344632ba0e63f0e80ef4dfe76d224c915796a3.1544229872.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 08/24] riscv: tcg-target: Add support for
 the constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 12/7/18 6:47 PM, Alistair Francis wrote:
> +    if ((ct & TCG_CT_CONST_N12) && val == sextreg(-val, 0, 12)) {

 -val == sextreg(-val, 0, 12)

What's here will of course always fail.


r~
