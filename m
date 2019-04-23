Received: from eggs.gnu.org ([209.51.188.92]:33289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ20B-0005IX-4r
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ20A-0007CJ-4k
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:26:51 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ209-00079I-RV
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:26:50 -0400
Received: by mail-pg1-x541.google.com with SMTP id g8so8183357pgf.2
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 13:26:49 -0700 (PDT)
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<e2359b84-622b-d7ad-c9cf-92121934e123@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6206270f-2994-ae8d-db89-346a06a684f1@linaro.org>
Date: Tue, 23 Apr 2019 13:26:44 -0700
MIME-Version: 1.0
In-Reply-To: <e2359b84-622b-d7ad-c9cf-92121934e123@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/38] tcg vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org

On 4/23/19 12:15 PM, David Hildenbrand wrote:
> On 20.04.19 09:34, Richard Henderson wrote:
>> Based-on: tcg-next, which at present is only tcg_gen_extract2.
>>
>> The dupm patches have been on list before, with a larger context
>> of supporting tcg/ppc.  The rest of the set was written to support
>> David's s390 vector patches.  In particular:
>>
>> (1) Add vector absolute value.
>> (2) Add vector shift by non-constant scalar.
>> (3) Add vector shift by vector.
>> (4) Add vector select.
> 
> Remind me, is this for VECTOR SELECT on s390x where we already added a
> vector variant? At least VECTOR SELECT on s390x works on bit, not
> element granularity.


No, this was more for implementing _vec helpers, where we can
reasonably use element granularity (since that's all x86 has).

I thought about adding a bitsel alongside cmpsel, to work on
bits like this, but haven't yet.


r~
