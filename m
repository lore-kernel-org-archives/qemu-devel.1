Received: from eggs.gnu.org ([2001:4830:134:3::10]:51080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR0f2-0003DE-NH
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR0ex-00014G-1S
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:01:12 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:40720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR0ew-00013A-Qi
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:01:06 -0500
Received: by mail-pl0-x243.google.com with SMTP id 62so3926237pld.7
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 11:01:06 -0800 (PST)
References: <20171217054953.28500-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0d6c2a95-d92b-39a8-a8b7-aad21ac70620@linaro.org>
Date: Mon, 18 Dec 2017 11:01:02 -0800
MIME-Version: 1.0
In-Reply-To: <20171217054953.28500-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-ppc: optimize cmp translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dgibson@redhat.com, qemu-ppc@nongnu.org

On 12/16/2017 09:49 PM, Paolo Bonzini wrote:
> We know that only one bit (in addition to SO) is going to be set in
> the condition register, so do two movconds instead of three setconds,
> three shifts and two ORs.
> 
> For ppc64-linux-user, the code size reduction is around 5% and the
> performance improvement slightly less than 10%.  For softmmu, the
> improvement is around 5%.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/ppc/translate.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
