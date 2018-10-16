Received: from eggs.gnu.org ([2001:4830:134:3::10]:49578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCSu8-0006sJ-MA
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCSu3-00072X-9A
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:13:12 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:47010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCSu2-000727-Js
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:13:07 -0400
Received: by mail-pl1-x62d.google.com with SMTP id v5-v6so11312988plz.13
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:13:06 -0700 (PDT)
References: <20181016153840.25877-1-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e8dea159-f72c-a3b9-503e-ed9349ed8dc6@linaro.org>
Date: Tue, 16 Oct 2018 10:13:01 -0700
MIME-Version: 1.0
In-Reply-To: <20181016153840.25877-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH tcg-next] cputlb: read
 CPUTLBEntry.addr_write atomically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/16/18 8:38 AM, Emilio G. Cota wrote:
> Updates can come from other threads, so readers that do not
> take tlb_lock must use atomic_read to avoid undefined
> behaviour (UB).
> 
> This completes the conversion to tlb_lock. This conversion results
> on average in no performance loss, as the following experiments
> (run on an Intel i7-6700K CPU @ 4.00GHz) show.

Thanks for the quick turn-around.  Queued.


r~
