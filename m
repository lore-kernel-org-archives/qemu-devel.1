Received: from eggs.gnu.org ([2001:4830:134:3::10]:53154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDOFt-0004Sh-Sa
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDOFm-0004Z1-Tx
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:27:29 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:43711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDOFl-0002vY-SU
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:27:22 -0400
Received: by mail-pg1-x532.google.com with SMTP id d8-v6so4106484pgv.10
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 23:26:43 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-3-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1b04b6e6-c5cf-128f-484c-d8f3e579b187@linaro.org>
Date: Thu, 18 Oct 2018 23:26:39 -0700
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-3-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 02/56] cpu: rename cpu->work_mutex to
 cpu->lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 10/18/18 6:05 PM, Emilio G. Cota wrote:
> This lock will soon protect more fields of the struct. Give
> it a more appropriate name.
> 
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h |  5 +++--
>  cpus-common.c     | 14 +++++++-------
>  cpus.c            |  4 ++--
>  qom/cpu.c         |  2 +-
>  4 files changed, 13 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
