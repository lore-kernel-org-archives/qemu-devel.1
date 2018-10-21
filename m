Received: from eggs.gnu.org ([2001:4830:134:3::10]:43041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDcV-0008UQ-Lw
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDcU-0008GV-Kx
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:18:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDcT-0008BL-LA
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:18:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id t10-v6so432302wrn.10
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:18:12 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-27-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9f30b78a-1a34-d310-445c-e8a52bd5a71c@linaro.org>
Date: Sun, 21 Oct 2018 14:18:07 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-27-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 26/56] i386: use cpu_reset_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/i386/hax-all.c    |  4 ++--
>  target/i386/hvf/x86hvf.c |  8 ++++----
>  target/i386/kvm.c        | 14 +++++++-------
>  target/i386/seg_helper.c | 13 ++++++-------
>  target/i386/svm_helper.c |  2 +-
>  target/i386/whpx-all.c   | 10 +++++-----
>  6 files changed, 25 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
