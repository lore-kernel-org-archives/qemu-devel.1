Received: from eggs.gnu.org ([2001:4830:134:3::10]:51093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9tKm-000222-7z
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9tKg-0006JI-VU
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:50:03 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:39612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9tKg-0006IK-Kv
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:49:58 -0400
Received: by mail-pg1-x535.google.com with SMTP id r9-v6so931583pgv.6
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 07:49:58 -0700 (PDT)
References: <20181008232756.30704-1-cota@braap.org>
	<20181008232756.30704-4-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cbd29475-5161-b1d6-41dd-c2ce4e66336e@linaro.org>
Date: Tue, 9 Oct 2018 07:49:54 -0700
MIME-Version: 1.0
In-Reply-To: <20181008232756.30704-4-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 3/5] cputlb: do not evict empty entries to
 the vtlb
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

On 10/8/18 4:27 PM, Emilio G. Cota wrote:
> Currently we evict an entry to the victim TLB when it doesn't match
> the current address. But it could be that there's no match because
> the current entry is empty (i.e. all -1's, for instance via tlb_flush).
> Do not evict the entry to the vtlb in that case.
> 
> This change will help us keep track of the TLB's use rate.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/exec/cpu-all.h | 9 +++++++++
>  accel/tcg/cputlb.c     | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
