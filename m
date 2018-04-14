Received: from eggs.gnu.org ([2001:4830:134:3::10]:57658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f7CAE-0000G8-U1
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 23:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f7CAB-00028u-Ny
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 23:47:46 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:43062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f7CAB-000287-HL
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 23:47:43 -0400
Received: by mail-pf0-x244.google.com with SMTP id j11so916794pff.10
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 20:47:43 -0700 (PDT)
References: <1522980788-1252-1-git-send-email-cota@braap.org>
	<1522980788-1252-14-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <27aed44c-3e3f-ec4c-15b8-60d5146966cc@linaro.org>
Date: Fri, 13 Apr 2018 17:47:38 -1000
MIME-Version: 1.0
In-Reply-To: <1522980788-1252-14-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/17] translate-all: discard TB when
 tb_link_page returns an existing matching TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 04/05/2018 04:13 PM, Emilio G. Cota wrote:
> Use the recently-gained QHT feature of returning the matching TB if it
> already exists. This allows us to get rid of the lookup we perform
> right after acquiring tb_lock.
> 
> Suggested-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  docs/devel/multi-thread-tcg.txt |  3 +++
>  accel/tcg/cpu-exec.c            | 14 ++----------
>  accel/tcg/translate-all.c       | 50 +++++++++++++++++++++++++++++++++--------
>  3 files changed, 46 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
