Received: from eggs.gnu.org ([2001:4830:134:3::10]:55641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtICv-00068P-8P
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 14:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtICu-0001Jk-Fo
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 14:52:49 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:55669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dtICu-0001JO-8o
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 14:52:48 -0400
Received: by mail-wr0-x22e.google.com with SMTP id l39so3726580wrl.12
	for <qemu-devel@nongnu.org>; Sat, 16 Sep 2017 11:52:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170914183516.19537-5-richard.henderson@linaro.org>
References: <20170914183516.19537-1-richard.henderson@linaro.org>
	<20170914183516.19537-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Sep 2017 19:52:26 +0100
Message-ID: <CAFEAcA96FiPCxwSRNWhpE3hp2HC_+j0hV8piu-rj1Gvtm0Z51Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/10] disas: Support the Capstone
 disassembler library
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 September 2017 at 19:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> +    /* ??? Capstone requires that we copy the data into a host-addressable
> +       buffer first and has no call-back to read more.  Therefore we need
> +       an estimate of buffer size.  This will work for most RISC, but we'll
> +       need to figure out something else for variable-length ISAs.  */
> +    if (s.info.cap_arch >= 0 && cap_disas(&s.info, pc, 4 * nb_insn)) {
> +        return;
> +    }

Can we do something with gradually adding more to our host buffer
until capstone says it's managed to disassemble the right number
of instructions?

thanks
-- PMM
