Received: from eggs.gnu.org ([2001:4830:134:3::10]:49712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ddiBn-0002Wm-Mf
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 15:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ddiBj-0007lI-QJ
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 15:23:15 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:38301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ddiBj-0007kv-Ki
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 15:23:11 -0400
Received: by mail-pg0-x231.google.com with SMTP id l64so11395223pge.5
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 12:23:11 -0700 (PDT)
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-5-git-send-email-peter.maydell@linaro.org>
	<50d6ba4d-cfa3-5b5f-5da1-dca2326d4f5d@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c38728a0-da49-635e-2954-1030b223e3c9@linaro.org>
Date: Fri, 4 Aug 2017 12:23:07 -0700
MIME-Version: 1.0
In-Reply-To: <50d6ba4d-cfa3-5b5f-5da1-dca2326d4f5d@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/8] boards.h: Define new flag
 ignore_memory_transaction_failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 08/04/2017 11:09 AM, Philippe Mathieu-Daudé wrote:
> Since create_unimplemented_device() register overlapped with low priority, why
> not register it as default device directly, over the whole address space?

That's a good suggestion.  It makes more sense to me than adding a flag on the
MachineClass.


r~
