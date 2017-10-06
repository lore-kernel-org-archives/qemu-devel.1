Received: from eggs.gnu.org ([2001:4830:134:3::10]:50293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0S02-0005UQ-KZ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0S01-0004gV-Qw
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:45:06 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:46018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0S01-0004fs-Le
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:45:05 -0400
Received: by mail-qt0-x230.google.com with SMTP id k1so20125418qti.2
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 05:45:05 -0700 (PDT)
References: <20171006054014.17282-1-sandipan@linux.vnet.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e0da7019-5914-5c42-9e21-a9f6e110bfe4@linaro.org>
Date: Fri, 6 Oct 2017 08:45:02 -0400
MIME-Version: 1.0
In-Reply-To: <20171006054014.17282-1-sandipan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] target/ppc: Fix carry flag setting for
 shift algebraic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>, david@gibson.dropbear.id.au
Cc: nikunj@linux.vnet.ibm.com, agraf@suse.de, qemu-devel@nongnu.org

On 10/06/2017 01:40 AM, Sandipan Das wrote:
> For POWER ISA v3.0, the XER bit CA32 needs to be set by the shift
> right algebraic instructions whenever the CA bit is to be set. This
> change affects the following instructions:
>   * Shift Right Algebraic Word (sraw[.])
>   * Shift Right Algebraic Word Immediate (srawi[.])
>   * Shift Right Algebraic Doubleword (srad[.])
>   * Shift Right Algebraic Doubleword Immediate (sradi[.])
> 
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> ---
> v2: Add tcg_temp_free() required in gen_sraw() and gen_srad()
> 
> v3: Remove explicit checking for ISA v3.0 when setting CA32
> 
> v4: Set CA32 only when CA is being modified (as Richard suggested)
>     Set CA32 after checking for ISA300 in gen_* functions (as David suggested)
> ---
>  target/ppc/int_helper.c | 16 ++++++++--------
>  target/ppc/translate.c  | 12 ++++++++++++
>  2 files changed, 20 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
