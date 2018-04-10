Received: from eggs.gnu.org ([2001:4830:134:3::10]:44890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kX0-0000W8-Bt
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kWz-0005ih-Iq
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:05:18 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5kWz-0005iJ-Dj
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:05:17 -0400
Received: by mail-pf0-x243.google.com with SMTP id g14so7151710pfh.3
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 21:05:17 -0700 (PDT)
References: <20180410021745.32378-1-jcmvbkbc@gmail.com>
	<20180410021745.32378-2-jcmvbkbc@gmail.com>
	<a59566f6-2423-cd50-9ff4-cf8ec227dbde@linaro.org>
	<CAMo8Bf+SZd_df4j47VKe+QhCR-tgza=RCL1GKdus+S3+Kv1bTg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3a28ef7f-72b1-65c5-ba90-d2fe7cd112dc@linaro.org>
Date: Tue, 10 Apr 2018 14:05:10 +1000
MIME-Version: 1.0
In-Reply-To: <CAMo8Bf+SZd_df4j47VKe+QhCR-tgza=RCL1GKdus+S3+Kv1bTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/1] linux-user: fix preadv/pwritev offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 04/10/2018 01:29 PM, Max Filippov wrote:
> On Mon, Apr 9, 2018 at 8:20 PM, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 04/10/2018 12:17 PM, Max Filippov wrote:
>>> +    uint64_t off = tlow |
>>> +        ((unsigned long long)thigh << TARGET_LONG_BITS / 2) <<
>>
>> There's a second instance of long long here; needs uint64_t.
> 
> Ehh, will fix.
> BTW, why is uint64_t here better than unsigned long long? Just
> shorter?

Because it's more explicit about the number of bits we're talking about.


r~
