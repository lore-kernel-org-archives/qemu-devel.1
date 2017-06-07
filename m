Received: from eggs.gnu.org ([2001:4830:134:3::10]:49752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1dIgb6-0007Hn-EA
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1dIgb5-0001e3-Ox
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:26:28 -0400
MIME-Version: 1.0
In-Reply-To: <cdeaf0b3-e304-3518-9d71-95a30e85a8a1@twiddle.net>
References: <1496481564-20545-1-git-send-email-jcmvbkbc@gmail.com>
	<cdeaf0b3-e304-3518-9d71-95a30e85a8a1@twiddle.net>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 7 Jun 2017 12:26:25 -0700
Message-ID: <CAMo8BfK_X_uzUOOYmdT3Hty3GcE80vJMxmrqDA0RsFTeFxWmkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: handle unknown registers in
 gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On Tue, Jun 6, 2017 at 5:55 PM, Richard Henderson <rth@twiddle.net> wrote:
> On 06/03/2017 02:19 AM, Max Filippov wrote:
>>
>> +        memset(mem_buf, 0, reg->size);
>> +        return reg->size;
>>           return 0;
>
> Leaving a dead return.

Meh ): Thanks for the review. Will send a fix.

-- 
Thanks.
-- Max
