Received: from eggs.gnu.org ([2001:4830:134:3::10]:35027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eowWT-0004VT-EK
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:27:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eowWP-0007a8-Gv
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:27:17 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:44435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eowWP-0007YZ-97
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:27:13 -0500
Received: by mail-pg0-x244.google.com with SMTP id l4so2380253pgp.11
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 11:27:12 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-2-richard.henderson@linaro.org>
	<CAFEAcA-00jCXJzwSgGmC0gg=vWpmVFs0qUbrzEQ_THSzw74O9g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b5915514-fcb9-3545-f79a-b83303a31ae2@linaro.org>
Date: Thu, 22 Feb 2018 11:27:08 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-00jCXJzwSgGmC0gg=vWpmVFs0qUbrzEQ_THSzw74O9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 01/67] target/arm: Enable SVE
 for aarch64-linux-user
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

On 02/22/2018 09:28 AM, Peter Maydell wrote:
> On 17 February 2018 at 18:22, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Enable ARM_FEATURE_SVE for the generic "any" cpu.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/cpu.c   | 7 +++++++
>>  target/arm/cpu64.c | 1 +
>>  2 files changed, 8 insertions(+)
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> though this should probably go at the end of the patchseries rather
> than the beginning?

Yes, but of course I need it at the beginning for testing.
I'll sort it to the end for the final version.


r~
