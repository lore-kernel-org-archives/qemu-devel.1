Received: from eggs.gnu.org ([2001:4830:134:3::10]:52757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMEBq-0002IF-DZ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMEBm-0000Mr-U4
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:59:34 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fMEBm-0000M0-QJ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:59:30 -0400
Received: by mail-ot0-x244.google.com with SMTP id 77-v6so6378800otd.4
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:59:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d37b2ff8-bb7e-bc2a-c9b8-133854c05d99@linaro.org>
References: <20180525132755.21839-1-peter.maydell@linaro.org>
	<20180525132755.21839-3-peter.maydell@linaro.org>
	<d37b2ff8-bb7e-bc2a-c9b8-133854c05d99@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 15:59:09 +0100
Message-ID: <CAFEAcA9fyzgwm0Ng0N7XypHU2DtiSG4t9tN+dXmOe0Q3Eau2bQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/6] scripts/update-linux-headers: Handle
 __aligned_u64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 25 May 2018 at 15:55, Richard Henderson <richard.henderson@linaro.org> wrote:
> On 05/25/2018 06:27 AM, Peter Maydell wrote:
>> We'll currently replace any 'u64' with a 'uint64_t' including when
>> it's embedded in an '__aligned_u64', creating a '__aligned_uint64_t'
>> which doesn't exist. We need to instead expand out the kernel's
>> definition of __aligned_u64:
>>    #define __aligned_u64 __u64 __attribute__((aligned(8)))
>> before we convert the __u64 to uint64_t.
>
> Wow.  I did not believe that would work.  I expected that you'd need to define
> a typedef, or somehow sort the attribute after the identifier to which it applies.

In the kernel it's a #define, not a typedef, so logically if the
kernel compiles then doing the textual-substitution here with sed
must also work...

thanks
-- PMM
