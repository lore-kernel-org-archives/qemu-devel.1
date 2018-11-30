Received: from eggs.gnu.org ([2001:4830:134:3::10]:34872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSpdb-0000KJ-LN
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSpdW-0007h9-Df
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:43:47 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:38248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSpdW-0007Y0-4D
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:43:42 -0500
Received: by mail-pl1-x629.google.com with SMTP id e5so3354216plb.5
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 12:43:39 -0800 (PST)
References: <20181120212553.8480-1-aaron@os.amperecomputing.com>
	<20181120212553.8480-14-aaron@os.amperecomputing.com>
	<d6fde9c7-b72e-ae9d-817b-71c3d6369dbc@linaro.org>
	<20181130175629.GB24714@quinoa.localdomain>
	<fb2e45b2-463d-aefe-e3d7-f3027f662c12@linaro.org>
	<20181130195742.GC24714@quinoa.localdomain>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <65ffd1f3-2ebd-30bb-b777-c0995e5add54@linaro.org>
Date: Fri, 30 Nov 2018 12:43:34 -0800
MIME-Version: 1.0
In-Reply-To: <20181130195742.GC24714@quinoa.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 13/13] target/arm: Send interrupts on
 PMU counter overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>, SM-Aaron Lindsay <alindsay@os.amperecomputing.com>

On 11/30/18 11:57 AM, Aaron Lindsay wrote:
>> Eh?  But we've set overflow_mask based on PMCR.LC, so what you say here doesn't
>> make sense.
> 
> Sorry, I had an off-by-one-bit think-o I couldn't get past until I
> started typing a concrete example to explain myself. I'll change this
> line to be:
> 
> if (!(env->cp15.c9_pmcr & PMCRLC))
> 	new_pmccntr &= 0xffffffff;

Ah, much better.  Thanks.


r~
