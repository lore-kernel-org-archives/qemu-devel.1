Received: from eggs.gnu.org ([2001:4830:134:3::10]:59622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejIn0-00025m-N5
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 01:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejImx-0007b5-Jn
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 01:01:02 -0500
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:32961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejImx-0007aV-E7
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 01:00:59 -0500
Received: by mail-it0-x22e.google.com with SMTP id u12-v6so14344672ite.0
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 22:00:57 -0800 (PST)
References: <20180122172643.29742-1-ard.biesheuvel@linaro.org>
	<20180122172643.29742-2-ard.biesheuvel@linaro.org>
	<CAFEAcA9zA=PTmxQH1W1ht8sj9HFMVKSb12dsm-jX6FQEmQR+FA@mail.gmail.com>
	<CAKv+Gu80ngyOewT-J3sKVV2pn8e7SVspF8py_yiuQzY1KEEE-w@mail.gmail.com>
	<CAKv+Gu8ZnyorvLnSackEyHCd7dRjN-Uh1Ywv_nj7iZwE=8z1og@mail.gmail.com>
	<CAFEAcA_Kkg5HUqK8hT_6JMD9AMrBgD46tHODT8rM9Fp7o8PWBw@mail.gmail.com>
	<CAFEAcA8nStZMnTkOSTdPU2vHVGZegY0tpLv9T+w5BPUUuwzUQQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <31e8af24-413d-20a3-f472-6df071aeb41a@linaro.org>
Date: Tue, 6 Feb 2018 22:00:53 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8nStZMnTkOSTdPU2vHVGZegY0tpLv9T+w5BPUUuwzUQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/4] target/arm: implement SHA-512
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 02/06/2018 11:15 AM, Peter Maydell wrote:
> My test setup doesn't capture register values from
> before the insn executes...

I have patches for RISU to dump each record written
to the trace file, which does allow one to go back
and examine previous register values.


r~
