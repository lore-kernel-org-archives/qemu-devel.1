Received: from eggs.gnu.org ([2001:4830:134:3::10]:48153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvm3Z-0006jR-Ha
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvm3V-0000eU-Nf
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:37:09 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cvm3V-0000eC-Go
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:37:05 -0400
Received: by mail-wr0-x231.google.com with SMTP id k6so17454785wre.2
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 07:37:05 -0700 (PDT)
References: <20170405132503.32125-1-alex.bennee@linaro.org>
	<20170405132503.32125-13-alex.bennee@linaro.org>
	<001001d2ae11$386f9700$a94ec500$@ru>
	<668f1ffc-ebc4-21cf-4355-52761c0737c3@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <668f1ffc-ebc4-21cf-4355-52761c0737c3@redhat.com>
Date: Wed, 05 Apr 2017 15:37:05 +0100
Message-ID: <87r316apke.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/12] replay: assert time only goes
 forward
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, rth@twiddle.net, peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 05/04/2017 15:33, Pavel Dovgalyuk wrote:
>>> +
>>> +        /* Time can only go forward */
>>> +        assert(diff >= 0);
>>> +
>>>          if (diff > 0) {
>> This "if" is useless then.
>>
>
> It isn't, "diff == 0" can happen.

In my previous patchset I actually output-ed a EVENT_INSTRUCTION with a
zero diff for the negative case although it does seem redundant to
output that if we can avoid it?

--
Alex Bennée
