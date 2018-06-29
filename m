Received: from eggs.gnu.org ([2001:4830:134:3::10]:34406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYunH-00082r-9H
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYunC-00080K-B2
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:39 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:44819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYunC-0007xy-5A
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:34 -0400
Received: by mail-pl0-x243.google.com with SMTP id m16-v6so4581020pls.11
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:54:33 -0700 (PDT)
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-7-richard.henderson@linaro.org>
	<CAFEAcA9JkC_9niGrEoVf8FKzT+k6yn0WS0Mjbwz8WpLpzJhszQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eb78a151-b5e4-87c6-89d6-a527904c0961@linaro.org>
Date: Fri, 29 Jun 2018 07:54:30 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9JkC_9niGrEoVf8FKzT+k6yn0WS0Mjbwz8WpLpzJhszQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] target/arm: Set ISAR bits for -cpu max
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

On 06/29/2018 01:42 AM, Peter Maydell wrote:
> On 29 June 2018 at 01:15, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> For the supported extensions, fill in the appropriate bits in
>> ID_ISAR5, ID_ISAR6, ID_AA64ISAR0, ID_AA64ISAR1.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> 
> This makes sense, but I'd rather have a bit of time to think
> about how exactly we want to handle feature bits vs ID
> register values (the current codebase is not entirely
> coherent on the topic), so I'd rather not put this in
> for softfreeze unless there's a strong reason we should...

Fair.

I was wondering if we'd post-process the feature bits to initialize the id
registers, so that we don't have different places with the same knowledge.

The clearing of EL3 bits from id_pfr1 is an example of that already.


r~
