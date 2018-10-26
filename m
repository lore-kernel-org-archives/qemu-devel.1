Received: from eggs.gnu.org ([2001:4830:134:3::10]:53890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4Qk-0003ib-Sb
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4Qh-0000dh-O7
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:53:46 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:37227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG4Qf-0000bY-LQ
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:53:41 -0400
Received: by mail-wr1-x430.google.com with SMTP id g9-v6so1872768wrq.4
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:53:40 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-60-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <df41cfae-a4ac-2879-7adf-9dab0afaf7e9@linaro.org>
Date: Fri, 26 Oct 2018 16:53:36 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-60-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 60/71] ppc: convert to
 cpu_has_work_with_iothread_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On 10/25/18 3:46 PM, Emilio G. Cota wrote:
> Soon we will call cpu_has_work without the BQL.
> 
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/ppc/translate_init.inc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
