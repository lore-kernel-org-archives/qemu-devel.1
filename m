Received: from eggs.gnu.org ([2001:4830:134:3::10]:37652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eowgS-0001LB-IG
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:37:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eowgO-0004u1-KG
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:37:36 -0500
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:40454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eowgO-0004te-Do
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:37:32 -0500
Received: by mail-pf0-x22b.google.com with SMTP id m5so2489257pff.7
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 11:37:32 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-8-richard.henderson@linaro.org>
	<CAFEAcA-PzKt-gZe2FjvqZuJqFmgoziNKaDLyen9o+hToMboQWw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <739b0a8d-eea3-c934-8f38-6fe609056c07@linaro.org>
Date: Thu, 22 Feb 2018 11:37:28 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-PzKt-gZe2FjvqZuJqFmgoziNKaDLyen9o+hToMboQWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 07/67] target/arm: Implement
 SVE Predicate Logical Operations Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 02/22/2018 10:55 AM, Peter Maydell wrote:
>> +# Three prediate operand, with governing predicate, flag setting
> 
> Three what?

Feh, typo for predicate.  But more verbosely,

Three operands that are predicates, plus another predicate operand which
"governs" the operation (I believe that's the language from the ARM), plus an
"s" bit that controls whether the flags are set.


r~
