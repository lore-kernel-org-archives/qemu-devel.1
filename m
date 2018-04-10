Received: from eggs.gnu.org ([2001:4830:134:3::10]:36786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f5ice-0006sp-Kx
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 22:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f5icd-0002h6-Tk
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 22:03:00 -0400
Received: from mail-yb0-x231.google.com ([2607:f8b0:4002:c09::231]:33705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f5icd-0002gn-Oq
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 22:02:59 -0400
Received: by mail-yb0-x231.google.com with SMTP id f5-v6so3759258ybg.0
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 19:02:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e48b259d-09b6-cd51-65cb-ded45ecae6c3@linaro.org>
References: <20180406013628.25900-1-jcmvbkbc@gmail.com>
	<e48b259d-09b6-cd51-65cb-ded45ecae6c3@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 9 Apr 2018 19:02:58 -0700
Message-ID: <CAMo8BfJ0gdX+D4vpAkEscqpkSZAev+qiTP3QoCXbnzhQrBMQzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4] linux-user: fix preadv/pwritev offsets
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

On Mon, Apr 9, 2018 at 5:23 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 04/06/2018 11:36 AM, Max Filippov wrote:
>> +static void target_to_host_low_high(abi_ulong tlow,
>> +                                    abi_ulong thigh,
>> +                                    unsigned long *hlow,
>> +                                    unsigned long *hhigh)
>> +{
>> +    unsigned long long off = tlow |
>> +        ((unsigned long long)thigh << TARGET_LONG_BITS / 2) <<
>> +        TARGET_LONG_BITS / 2;
>
> Use uint64_t instead of unsigned long long.

Ok.

>> +
>> +    *hlow = (unsigned long)off;
>> +    *hhigh = (unsigned long)((off >> HOST_LONG_BITS / 2) >>
>> +                             HOST_LONG_BITS / 2);
>
> The casts here are unnecessary and are implied by the assignment.

Did that to avoid value truncation warning. Will drop.

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

-- 
Thanks.
-- Max
