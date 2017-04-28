Received: from eggs.gnu.org ([2001:4830:134:3::10]:43932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d435E-0006ak-BP
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d435B-0007sX-1n
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:25:04 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d435A-0007sO-Rc
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:25:00 -0400
Received: by mail-wm0-x236.google.com with SMTP id m123so42439077wma.0
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 03:25:00 -0700 (PDT)
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-4-rth@twiddle.net>
	<874lx996hh.fsf@linaro.org>
	<30d66407-ad33-bc8c-55c6-0a5d7009bed4@twiddle.net>
	<871ssd7z46.fsf@linaro.org>
	<ee54957c-4a65-424a-72dc-0d6f742608cf@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <ee54957c-4a65-424a-72dc-0d6f742608cf@twiddle.net>
Date: Fri, 28 Apr 2017 11:25:30 +0100
Message-ID: <87y3uk7rs5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 03/19] qemu/atomic: Loosen restrictions
 for 64-bit ILP32 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org


Richard Henderson <rth@twiddle.net> writes:

> On 04/28/2017 09:47 AM, Alex Bennée wrote:
>> So maybe the comment should be clearer for ATOMIC_REG_SIZE that it
>> should match TCG_TARGET_REG_BITS (and therefore sync with
>> TCG_OVERSIZED_GUEST) in the atomic.h comment.
>
> How about
>
>  * That said, we have a problem on 64-bit ILP32 hosts in that in order to
>  * sync with TCG_OVERSIZED_GUEST, this must match TCG_TARGET_REG_BITS.
>  * We'd prefer not want to pull in everything else TCG related, so handle
>  * those few cases by hand.
>
> ?

Sounds good to me.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
