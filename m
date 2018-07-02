Received: from eggs.gnu.org ([2001:4830:134:3::10]:58870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzzE-00049k-Co
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzz9-0005q7-HG
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:39:28 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:33908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fZzz9-0005pi-AV
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:39:23 -0400
Received: by mail-pl0-x243.google.com with SMTP id z9-v6so8058746plo.1
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 07:39:23 -0700 (PDT)
Date: Mon, 2 Jul 2018 23:39:20 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180702143920.GR24595@lianli.shorne-pla.net>
References: <20180628030330.15615-1-richard.henderson@linaro.org>
	<153049914837.615.12803592704677471272@946cad8fd14e>
	<20180702120119.GP24595@lianli.shorne-pla.net>
	<b6bd1555-1bc3-f7f4-ec3c-e6dfceee6507@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6bd1555-1bc3-f7f4-ec3c-e6dfceee6507@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 00/23] target/openrisc improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, famz@redhat.com

On Mon, Jul 02, 2018 at 07:26:26AM -0700, Richard Henderson wrote:
> On 07/02/2018 05:01 AM, Stafford Horne wrote:
> >> ERROR: spaces required around that '*' (ctx:WxV)
> >> #129: FILE: target/openrisc/disas.c:56:
> >> +    arg_l_##opcode *a, uint32_t insn)                   \
> >>                     ^
> >>
> >> ERROR: spaces required around that '*' (ctx:WxV)
> >> #224: FILE: target/openrisc/disas.c:151:
> >> +    arg_lf_##opcode##_##suffix *a, uint32_t insn)                \
> >>                                 ^
> > 
> > I have fixed these on my branch.
> 
> These should not have been "fixed".
> 
> This is checkpatch being stupid and not realizing that
> the thing on the left is a type and this is a pointer
> declaration, not a multiplication.

Ah, right, and this is me being stupid just following it.

Let me get it fixed again, wait a bit then send a v2 pull.

-Stafford
