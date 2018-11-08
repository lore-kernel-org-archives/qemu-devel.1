Received: from eggs.gnu.org ([2001:4830:134:3::10]:55393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKmdm-0003N1-EX
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKmdk-0004DO-Eg
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:54:42 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKmdj-000451-2Z
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:54:39 -0500
Received: by mail-oi1-x241.google.com with SMTP id 192-v6so16540255oii.6
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 07:54:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fd88527e-5f49-cc0e-8b8d-fd52e7f4edfb@twiddle.net>
References: <20181108125256.30986-1-peter.maydell@linaro.org>
	<fd88527e-5f49-cc0e-8b8d-fd52e7f4edfb@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 15:53:55 +0000
Message-ID: <CAFEAcA_xWDdd_ca8dVNAD221T5Gzsmt5m1A6FnnG_Ss_GR002g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg/tcg-op.h: Add multiple include guard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 8 November 2018 at 13:39, Richard Henderson <rth@twiddle.net> wrote:
> On 11/8/18 1:52 PM, Peter Maydell wrote:
>> The tcg-op.h header was missing the usual guard against multiple
>> inclusion; add it.
>>
>> (Spotted by lgtm.com's static analyzer.)
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  tcg/tcg-op.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> FWIW, while I can queue this, I do not have any other outstanding tcg patches.
>  So maybe just apply it to master directly?

OK, applied to master.

-- PMM
