Received: from eggs.gnu.org ([2001:4830:134:3::10]:55541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSQLS-0003tg-78
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSQEE-0007Ib-Ao
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:35:59 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSQEC-0007Hv-KJ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:35:54 -0500
Received: by mail-pl1-x642.google.com with SMTP id u6so1371894plm.8
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 09:35:52 -0800 (PST)
References: <20181123144558.5048-1-richard.henderson@linaro.org>
	<20181123144558.5048-4-richard.henderson@linaro.org>
	<87zhts2b5e.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <802eb695-0a60-b0c1-de14-3c813abdcb8c@linaro.org>
Date: Thu, 29 Nov 2018 09:35:48 -0800
MIME-Version: 1.0
In-Reply-To: <87zhts2b5e.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 03/37] tcg: Return success from
 patch_reloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

On 11/29/18 6:47 AM, Alex Bennée wrote:
> We also seem to be dropping a bunch of reloc_atomic functions (which are
> no longer used?). Perhaps that should be a separate patch to make the
> series cleaner?

Yes, they're no longer used.

I should do a full cleanup of "atomic" stuff that's no longer required due to
the fact that we no longer re-translate for unwinding.


r~
