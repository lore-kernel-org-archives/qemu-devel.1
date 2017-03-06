Received: from eggs.gnu.org ([2001:4830:134:3::10]:55594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ckzsS-0004wp-Br
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ckzsR-00005Z-Di
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:09:08 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ckzsR-00005R-8l
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:09:07 -0500
Received: by mail-qk0-x241.google.com with SMTP id v125so9443891qkh.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 13:09:07 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170306205609.6525-1-rth@twiddle.net>
	<387705521.29181055.1488834011451.JavaMail.zimbra@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5c02d7b4-6b8d-2fa5-b4f9-ce0e7fddaa73@twiddle.net>
Date: Tue, 7 Mar 2017 08:09:01 +1100
MIME-Version: 1.0
In-Reply-To: <387705521.29181055.1488834011451.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/alpha: Take BQL around clock
 manipulations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: alex bennee <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 03/07/2017 08:00 AM, Paolo Bonzini wrote:
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>> This is similar to the patch that I saw go by for MIPS.
>>
>> I hadn't noticed any problems caused by this lack of locking.  This may
>> be because interrupts cannot be delivered while in PALmode while these
>> registers are being manipulated.  However, it's always better to obey
>> the rules, right?
>
> This should not be necessary, clocks and timers are thread-safe.  Time
> to make a list of the few things that are, I guess.
>
> There are issues if data is accessed by device models and CPU out of
> the lock, but everything seems fine for typhoon_alarm_timer.

This isn't typhoon_alarm_timer, but the move-to-special-register instruction on 
the cpu side.

But I guess I misunderstood the problem that was happening for MIPS.
If nothing needs changing for Alpha, that's great.


r~
