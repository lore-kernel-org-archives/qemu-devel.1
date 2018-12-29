Received: from eggs.gnu.org ([208.118.235.92]:53952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdN2P-00058d-MR
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:25:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdMyC-0004JS-Rl
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:20:40 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gdMyC-0004AY-GS
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:20:36 -0500
Received: by mail-pl1-x641.google.com with SMTP id e5so11382155plb.5
	for <qemu-devel@nongnu.org>; Sat, 29 Dec 2018 14:20:30 -0800 (PST)
References: <CAFyWVaai=5K7j8w+Abpk9jxGyKuo4v9w2BgmDbY=_29+Q++Jyw@mail.gmail.com>
	<20181228220731.4753-1-jimw@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bcf78767-a96e-8ba4-52da-97b34b3cb3ba@linaro.org>
Date: Sun, 30 Dec 2018 09:20:24 +1100
MIME-Version: 1.0
In-Reply-To: <20181228220731.4753-1-jimw@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5 v2] RISC-V: Add 32-bit gdb xml files.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jim Wilson <jimw@sifive.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org

On 12/29/18 9:07 AM, Jim Wilson wrote:
> Signed-off-by: Jim Wilson <jimw@sifive.com>
> ---
>  configure                   |   1 +
>  gdb-xml/riscv-32bit-cpu.xml |  43 ++++++++
>  gdb-xml/riscv-32bit-csr.xml | 250 ++++++++++++++++++++++++++++++++++++++++++++
>  gdb-xml/riscv-32bit-fpu.xml |  46 ++++++++
>  4 files changed, 340 insertions(+)
>  create mode 100644 gdb-xml/riscv-32bit-cpu.xml
>  create mode 100644 gdb-xml/riscv-32bit-csr.xml
>  create mode 100644 gdb-xml/riscv-32bit-fpu.xml

Don't the csr's vary between priv-1.9.1 and priv-1.10?

I wonder if it would be better to auto-generate these, via the
gdb_get_dynamic_xml hook.  That way you don't need near identical copies for
32-bit vs 64-bit.


r~
