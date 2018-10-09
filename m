Received: from eggs.gnu.org ([2001:4830:134:3::10]:52523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9ywe-00030r-Dv
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9ywa-0005tC-0V
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:49:32 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:43297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9ywZ-0005sk-Qq
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:49:27 -0400
Received: by mail-pf1-x42a.google.com with SMTP id p24-v6so1440281pff.10
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 13:49:27 -0700 (PDT)
References: <20181009174557.16125-1-cota@braap.org>
	<20181009174557.16125-4-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8edd1d59-f617-9bba-9dff-eb6836ec8415@linaro.org>
Date: Tue, 9 Oct 2018 13:49:24 -0700
MIME-Version: 1.0
In-Reply-To: <20181009174557.16125-4-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 3/6] exec: introduce tlb_init
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

On 10/9/18 10:45 AM, Emilio G. Cota wrote:
> Paves the way for the addition of a per-TLB lock.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/exec/exec-all.h | 8 ++++++++
>  accel/tcg/cputlb.c      | 4 ++++
>  exec.c                  | 1 +
>  3 files changed, 13 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
