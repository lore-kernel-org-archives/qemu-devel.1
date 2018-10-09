Received: from eggs.gnu.org ([2001:4830:134:3::10]:50965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9yps-0001Mq-M3
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9ypn-0005Fu-PT
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:42:32 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9ypk-0005DQ-Av
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:42:26 -0400
Received: by mail-pf1-x441.google.com with SMTP id l81-v6so1447871pfg.3
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 13:42:22 -0700 (PDT)
References: <20181009184017.15675-1-peter.maydell@linaro.org>
	<fd52a068-17f8-5436-1d87-dfe40cd23fe9@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4ab38a61-86b3-1fbb-f116-1aca0a901895@linaro.org>
Date: Tue, 9 Oct 2018 13:42:17 -0700
MIME-Version: 1.0
In-Reply-To: <fd52a068-17f8-5436-1d87-dfe40cd23fe9@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user/sparc/signal.c: Remove
 unnecessary comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, patches@linaro.org

On 10/9/18 12:45 PM, Laurent Vivier wrote:
> Le 09/10/2018 à 20:40, Peter Maydell a écrit :
>> Remove a comment suggesting that we need to call tb_flush()
>> after writing the SPARC signal frame trampoline insns.
>> This isn't necessary in QEMU, because (even if the guest
>> architecture requires explicit icache maintenance) we
>> ensure that memory writes result in invalidation of
>> translated code from that memory.
> 
> By curiosity, where/how is it done?

Guest pages that have had code translated from them are mprotect'd read-only.
The host SIGSEGV handler notices writes to such pages, invalidates the
translated code, and marks the page read-write again.  At which point the guest
program continues.


r~
