Received: from eggs.gnu.org ([2001:4830:134:3::10]:34248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQqp2-00029R-CX
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQqox-0004bq-Tc
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:58:36 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dQqox-0004ZB-Pt
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:58:31 -0400
Received: by mail-qk0-x241.google.com with SMTP id p21so14562597qke.0
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 00:58:29 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
	<1498768109-4092-6-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <69a55d7f-d17a-ef5b-73cb-9dae13d558f1@twiddle.net>
Date: Fri, 30 Jun 2017 00:58:25 -0700
MIME-Version: 1.0
In-Reply-To: <1498768109-4092-6-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 5/7] tcg: take tb_ctx out of TCGContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 06/29/2017 01:28 PM, Emilio G. Cota wrote:
> Before TCGContext is made thread-local.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   include/exec/tb-context.h |  2 ++
>   tcg/tcg.h                 |  2 --
>   accel/tcg/cpu-exec.c      |  2 +-
>   accel/tcg/translate-all.c | 57 ++++++++++++++++++++++++-----------------------
>   linux-user/main.c         |  6 ++---
>   5 files changed, 35 insertions(+), 34 deletions(-)

There's a bit more of TCGContext that shouldn't be thread-local.  But I guess 
this is the one that absolutely must be shared.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
