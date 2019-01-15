Received: from eggs.gnu.org ([209.51.188.92]:52790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjWlL-0008UP-Ve
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjWlF-00009v-HQ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:00:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gjWlE-0007bL-Ig
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:00:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so1914168plm.8
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 14:00:31 -0800 (PST)
References: <20190115194754.7670-1-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <88b83a97-aec4-3b9c-c679-e8955f05a207@linaro.org>
Date: Wed, 16 Jan 2019 09:00:24 +1100
MIME-Version: 1.0
In-Reply-To: <20190115194754.7670-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] cpu-exec fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>

On 1/16/19 6:47 AM, Emilio G. Cota wrote:
> Just a couple of small fixes.
> 
> The first adds an assert that we should have added when performing
> the conversion from tb_lock to per-page locks.
> 
> The second adds a missing reset of the BQL after the longjmp in
> cpu_exec_step_atomic returns.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
