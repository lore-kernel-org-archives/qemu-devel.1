Received: from eggs.gnu.org ([209.51.188.92]:36118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDw0u-0001Pk-Rl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDw0t-00030n-TX
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:02:32 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hDw0t-00030F-Dq
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:02:31 -0400
Received: by mail-pg1-x544.google.com with SMTP id e6so9846764pgc.4
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 12:02:30 -0700 (PDT)
References: <20190307144126.31847-1-richard.henderson@linaro.org>
	<be62e92e-de46-b3a5-9945-a410049d25d5@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d4fc4ba0-bbad-b64a-ad5d-1d964717b749@linaro.org>
Date: Tue, 9 Apr 2019 09:02:24 -1000
MIME-Version: 1.0
In-Reply-To: <be62e92e-de46-b3a5-9945-a410049d25d5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/9] tcg: Add tcg_gen_extract2_{i32,i64}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org

On 4/9/19 8:53 AM, David Hildenbrand wrote:
> On 07.03.19 15:41, Richard Henderson wrote:
>> The primary motivator here is usage within s390x,
>> but (as with any good primitive) the opcode has
>> applications outside that.
> 
> I am planning to send the next big part of vector instruction support
> (Vector Integer Instructions) soon, that would make use of these patches.

I'll be sure to get them into the first pull after 4.1 opens.


r~
