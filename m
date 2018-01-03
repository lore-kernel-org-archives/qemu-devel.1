Received: from eggs.gnu.org ([2001:4830:134:3::10]:35979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWrGY-0000Xq-RR
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWrGX-0002g5-Ra
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:12:06 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:42326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eWrGX-0002fQ-Me
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:12:05 -0500
Received: by mail-ot0-x22b.google.com with SMTP id 14so2460494oth.9
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 14:12:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c6604226-cab3-6b6b-7a2b-79ae4d071174@linaro.org>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-5-git-send-email-mjc@sifive.com>
	<c6604226-cab3-6b6b-7a2b-79ae4d071174@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Thu, 4 Jan 2018 11:12:04 +1300
Message-ID: <CAHNT7Ns3pT6pPPFEmB0z8YKi2xctRa5qghBOu2vv6+=6PX51-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 04/21] RISC-V Disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Wed, Jan 3, 2018 at 6:30 PM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 01/02/2018 04:44 PM, Michael Clark wrote:
> > +static const char *rv_ireg_name_sym[] = {
> > +    "zero", "ra",   "sp",   "gp",   "tp",   "t0",   "t1",   "t2",
> > +    "s0",   "s1",   "a0",   "a1",   "a2",   "a3",   "a4",   "a5",
> > +    "a6",   "a7",   "s2",   "s3",   "s4",   "s5",   "s6",   "s7",
> > +    "s8",   "s9",   "s10",  "s11",  "t3",   "t4",   "t5",   "t6",
> > +    NULL
> > +};
>
> static const char * const
>

OK.


> But maybe even better as
>
> static const char rv_ireg_name_sym[32][4]
>

Got it, but it would need to be [32][5] to make room for the NULL
terminator on zero.


> and without the useless NULL.
>

Yes. they are redundant.


> Otherwise,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>

Thanks.

These changes will be in the next spin of the patchset.
