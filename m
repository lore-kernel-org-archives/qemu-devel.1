Received: from eggs.gnu.org ([2001:4830:134:3::10]:58037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDCZi-0001Uq-8a
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDCZh-00088l-If
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:22:22 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:32882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDCZh-00088e-Du
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:22:21 -0400
Received: by mail-qt0-x244.google.com with SMTP id a46so22854115qte.0
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 09:22:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-29-rth@twiddle.net>
	<20170523121123.nkfn6j4rewqk7ynv@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c4e63367-c3e5-e299-6a79-2d931b8eeee4@twiddle.net>
Date: Tue, 23 May 2017 09:22:17 -0700
MIME-Version: 1.0
In-Reply-To: <20170523121123.nkfn6j4rewqk7ynv@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 28/31] target/s390x: Use unwind data for
 helper_lra
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org

On 05/23/2017 05:11 AM, Aurelien Jarno wrote:
> On 2017-05-22 20:03, Richard Henderson wrote:
>> Note that exception_index is not live during a TB,
>> so there is no point saving it around mmu_translate.
> 
> What do you mean by "is not live"? Indeed cpu_loop_exit() is not called
> so the TB is not terminated immediately. That said the while loop in
> cpu_exec() will trigger the exception after the TB.
> 

Ah, yes.  I'll undo that bit.


r~
