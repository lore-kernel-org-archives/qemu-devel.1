Received: from eggs.gnu.org ([2001:4830:134:3::10]:38947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzpdX-0007Mb-GQ
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzpdQ-0003cR-Jl
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:51:50 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fzpdM-0003R5-E2
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:51:41 -0400
Received: by mail-pl1-x642.google.com with SMTP id j8-v6so11871792pll.12
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 13:51:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180911202823.21657-1-cota@braap.org>
	<20180911202823.21657-6-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6bb8acfd-2e08-9bd8-7b3d-5e23ee439387@twiddle.net>
Date: Tue, 11 Sep 2018 13:51:21 -0700
MIME-Version: 1.0
In-Reply-To: <20180911202823.21657-6-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/13] target/i386: move cpu_tmp0 to
 DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 09/11/2018 01:28 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/i386/translate.c | 282 ++++++++++++++++++++--------------------
>  1 file changed, 144 insertions(+), 138 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I will note that these tmpN variables ought to be eliminated
completely, in favor of totally local temporary allocation.

But that should be done separately, because while they *ought*
to be local, in some cases it may be hard to see that they are.


r~
