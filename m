Received: from eggs.gnu.org ([2001:4830:134:3::10]:48944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEE0Y-0001z4-KT
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEE0U-0004lD-Gq
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:43:06 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEE0U-0004ka-8R
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:43:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id o17-v6so6986608wmh.0
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:43:02 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-49-cota@braap.org>
	<b76f9b0e-16f6-e51b-250b-4a0f3b71552c@redhat.com>
	<20181020163105.GA1734@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8b562da6-e0ee-8f8a-ff23-0f1ad35d82bf@linaro.org>
Date: Sun, 21 Oct 2018 14:42:57 +0100
MIME-Version: 1.0
In-Reply-To: <20181020163105.GA1734@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 48/56] ppc: acquire the BQL in cpu_has_work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 10/20/18 5:31 PM, Emilio G. Cota wrote:
> I like this. How does the appended look?
> 
> Thanks,
> 
> 		Emilio
> ---8<---
> 
> [PATCH] cpu: introduce cpu_has_work_with_iothread_lock

I might just inline cpu_has_work_bql into the one caller.
You could even share has_cpu_lock with the code there.


r~
