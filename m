Received: from eggs.gnu.org ([209.51.188.92]:50250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjW8k-0001t2-5X
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjW8i-0005LA-4i
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:20:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gjW8h-0005Gg-Mo
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:20:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so1865204plm.12
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 13:20:49 -0800 (PST)
References: <20190114115637.6335-1-peter.maydell@linaro.org>
	<20190114115637.6335-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3ad15f62-ed82-0789-2366-cb4233179e6d@linaro.org>
Date: Wed, 16 Jan 2019 08:20:40 +1100
MIME-Version: 1.0
In-Reply-To: <20190114115637.6335-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] accel/tcg: Add cluster number to
 TCG TB hash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Emilio G . Cota" <cota@braap.org>, Aleksandar Markovic <aleksandar.m.mail@gmail.com>

On 1/14/19 10:56 PM, Peter Maydell wrote:
> Include the cluster number in the hash we use to look
> up TBs. This is important because a TB that is valid
> for one cluster at a given physical address and set
> of CPU flags is not necessarily valid for another:
> the two clusters may have different views of physical
> memory, or may have different CPU features (eg FPU
> present or absent).
> 
> We put the cluster number in the high 8 bits of the
> TB cflags. This gives us up to 256 clusters, which should
> be enough for anybody. If we ever need more, or need
> more bits in cflags for other purposes, we could make
> tb_hash_func() take more data (and expand qemu_xxhash7()
> to qemu_xxhash8()).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: move the setting of the cluster index in
> cf_mask in tb_htable_lookup() up to before we
> set desc.cf_mask from it...
> ---
>  include/exec/exec-all.h   | 4 +++-
>  accel/tcg/cpu-exec.c      | 3 +++
>  accel/tcg/translate-all.c | 3 +++
>  3 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
