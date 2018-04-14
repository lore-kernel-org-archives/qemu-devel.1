Received: from eggs.gnu.org ([2001:4830:134:3::10]:40290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f7CRY-0006BT-Rc
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 00:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f7CRU-0004jK-QW
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 00:05:40 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:44132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f7CRU-0004iz-Gd
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 00:05:36 -0400
Received: by mail-pf0-x229.google.com with SMTP id p15so7486091pff.11
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 21:05:36 -0700 (PDT)
References: <1522980788-1252-1-git-send-email-cota@braap.org>
	<1522980788-1252-17-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <156e91fb-0288-5672-6d65-b0c4fb06e52d@linaro.org>
Date: Fri, 13 Apr 2018 18:05:31 -1000
MIME-Version: 1.0
In-Reply-To: <1522980788-1252-17-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 16/17] translate-all: remove tb_lock
 mention from cpu_restore_state_from_tb
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
> tb_lock was needed when the function did retranslation. However,
> since fca8a500d519 ("tcg: Save insn data and use it in
> cpu_restore_state_from_tb") we don't do retranslation.
> 
> Get rid of the comment.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/translate-all.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
