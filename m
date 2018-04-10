Received: from eggs.gnu.org ([2001:4830:134:3::10]:55510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f5jyY-0007Yw-DE
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f5jyX-0008FY-Jt
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:29:42 -0400
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:37111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f5jyX-0008Ew-EP
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:29:41 -0400
Received: by mail-yw0-x243.google.com with SMTP id y23so3557992ywy.4
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 20:29:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a59566f6-2423-cd50-9ff4-cf8ec227dbde@linaro.org>
References: <20180410021745.32378-1-jcmvbkbc@gmail.com>
	<20180410021745.32378-2-jcmvbkbc@gmail.com>
	<a59566f6-2423-cd50-9ff4-cf8ec227dbde@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 9 Apr 2018 20:29:40 -0700
Message-ID: <CAMo8Bf+SZd_df4j47VKe+QhCR-tgza=RCL1GKdus+S3+Kv1bTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 1/1] linux-user: fix preadv/pwritev offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On Mon, Apr 9, 2018 at 8:20 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 04/10/2018 12:17 PM, Max Filippov wrote:
>> +    uint64_t off = tlow |
>> +        ((unsigned long long)thigh << TARGET_LONG_BITS / 2) <<
>
> There's a second instance of long long here; needs uint64_t.

Ehh, will fix.
BTW, why is uint64_t here better than unsigned long long? Just
shorter?

-- 
Thanks.
-- Max
