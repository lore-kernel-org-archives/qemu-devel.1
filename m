Received: from eggs.gnu.org ([209.51.188.92]:44618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghBc6-000126-GN
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghBbo-00034Z-6V
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:01:29 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:43473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ghBbn-00033q-BQ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:01:16 -0500
Received: by mail-pf1-x42e.google.com with SMTP id w73so3485909pfk.10
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 03:01:14 -0800 (PST)
References: <20190108223129.5570-1-richard.henderson@linaro.org>
	<20190108223129.5570-15-richard.henderson@linaro.org>
	<CAFEAcA9HxjHZgT9zAnHLZH+zSdM4q3LcTit=r5_=iRcQZ3f+4A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fddb1c15-8880-8952-338d-597640491019@linaro.org>
Date: Wed, 9 Jan 2019 21:01:07 +1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9HxjHZgT9zAnHLZH+zSdM4q3LcTit=r5_=iRcQZ3f+4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 14/31] target/arm: Decode Load/store
 register (pac)
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

On 1/9/19 9:34 AM, Peter Maydell wrote:
>> v3: Use do_gpr_ld; fix sextend typo; iss_valid only for !wback.
> What was the sextend typo ?

Operands to the sextract were reversed -- pos 10+x, len 0.


r~
