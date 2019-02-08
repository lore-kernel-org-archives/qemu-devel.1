Received: from eggs.gnu.org ([209.51.188.92]:45128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gs9UF-0000Dh-JN
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gs9U2-0007ma-Je
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:58:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gs9U2-0007ln-B5
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:58:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id c8so4339610wrs.4
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 08:58:32 -0800 (PST)
References: <20190208035551.3036-1-richard.henderson@linaro.org>
	<9fb2cbe0-40ae-5734-56af-99765a59d0ec@redhat.com>
	<cc2d9846-354d-aa86-a245-6cd9f6e5aa56@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <94aeaec0-4632-a59d-4236-9d61101ebad0@redhat.com>
Date: Fri, 8 Feb 2019 17:58:24 +0100
MIME-Version: 1.0
In-Reply-To: <cc2d9846-354d-aa86-a245-6cd9f6e5aa56@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Diagnose referenced labels that have
 not been emitted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On 2/8/19 5:52 PM, Richard Henderson wrote:
> On 2/8/19 2:41 AM, Philippe Mathieu-Daudé wrote:
>> Not related to this patch content, but I'm wondering why, TCGLabels
>> never get freed?
> 
> They are allocated with tcg_malloc, which is a pool allocator.  The entire pool
> is freed after each TB is compiled.

Got it now, thanks!

Phil.
