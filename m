Received: from eggs.gnu.org ([2001:4830:134:3::10]:38286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1feVAO-0004sg-EI
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 20:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1feVAL-0005IC-BR
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 20:45:36 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:40309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1feVAK-0005HH-Fl
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 20:45:32 -0400
Received: by mail-io0-x243.google.com with SMTP id l14-v6so24600249iob.7
	for <qemu-devel@nongnu.org>; Sat, 14 Jul 2018 17:45:31 -0700 (PDT)
References: <20180714193553.30846-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b9abeab1-bd7b-e33e-9ec5-22f2ce56762a@linaro.org>
Date: Sat, 14 Jul 2018 19:45:25 -0500
MIME-Version: 1.0
In-Reply-To: <20180714193553.30846-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: fix mmap_find_vma_reserved()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 07/14/2018 02:35 PM, Laurent Vivier wrote:
> The value given by mmap_find_vma_reserved() is used with mmap(),
> so it is needed to be aligned with the host page size.
> 
> Since commit 18e80c55bb, reserved_va is only aligned to TARGET_PAGE_SIZE,
> and it works well if this size is greater or equal to the host page size.
> 
> But ppc64 hosts have 64kB page size and when we start a 4kiB page size
> guest (like i386), it fails when it tries to mmap the stack:
> 
>     mmap stack: Invalid argument
> 
> Fixes: 18e80c55bb (linux-user: Tidy and enforce reserved_va initialization)
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     v3:
>       move initialization of reserved_va to main()
>     
>     v2:
>       fix typo s/has/as/
> 
>  linux-user/main.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
