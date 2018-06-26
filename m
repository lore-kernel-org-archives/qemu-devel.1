Received: from eggs.gnu.org ([2001:4830:134:3::10]:48453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXpIn-0005ND-KY
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXpIj-0005ss-OD
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:50:41 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:46359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXpIj-0005sY-Fw
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:50:37 -0400
Received: by mail-pg0-x22a.google.com with SMTP id q14-v6so3963869pgt.13
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 07:50:37 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-19-richard.henderson@linaro.org>
	<CAFEAcA-9uU1GNZoq2N5-Mn3zSccL59ygaQq_RWQjqpaX0imeiQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <48a5c708-b989-a030-e5a2-da5b5fe1cd2d@linaro.org>
Date: Tue, 26 Jun 2018 07:50:33 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-9uU1GNZoq2N5-Mn3zSccL59ygaQq_RWQjqpaX0imeiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 18/35] target/arm: Implement SVE
 Floating Point Multiply Indexed Group
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

On 06/25/2018 10:47 AM, Peter Maydell wrote:
>> +                           status, vsz, vsz, a->index * 2 + a->sub,
> Why are we multiplying the index by 2 here? Are we just encoding
> (index, sub) into a constant to pull out again the other side?
> If so, comment might help. (Also I find shifts and ors make it
> clearer that we're just shifting values around; multiplication
> and addition to me implies that we're really doing arithmetic.)
> 

Yes, this is just encoding.
I sometimes use multiply and add to avoid needing extra parenthesis.


r~
