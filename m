Received: from eggs.gnu.org ([2001:4830:134:3::10]:51413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAFO0-00058O-Ja
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAFNx-0004kl-F5
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:22:52 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAFNw-0004jt-VA
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:22:49 -0400
Received: by mail-pf1-x444.google.com with SMTP id c25-v6so2722497pfe.6
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 07:22:48 -0700 (PDT)
References: <20181009183314.13416-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dbf26e80-0b67-0904-a9c7-5e61905f9cc8@linaro.org>
Date: Wed, 10 Oct 2018 07:22:43 -0700
MIME-Version: 1.0
In-Reply-To: <20181009183314.13416-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: Remove #ifdeffed-out icebp
 debugging hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 10/9/18 11:33 AM, Peter Maydell wrote:
> Remove a debugging hack which could be used to cause the
> undocumented 'icebp' instruction to enable QEMU internal
> debug logging. This code has always been #ifdeffed out
> since it was introduced in commit aba9d61e34b9 in 2005;
> judging by the rest of that commit (which is entirely
> unrelated) it may have even been committed by accident.
> 
> (Note that WANT_ICEBP is not defined by default anyway.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Mostly I wanted to get rid of the weird call to tb_flush(),
> which is a bit unexpected to find in target frontend code.
> 
>  target/i386/translate.c | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
