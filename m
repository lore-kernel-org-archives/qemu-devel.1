Received: from eggs.gnu.org ([2001:4830:134:3::10]:41961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gC7iQ-0005QT-Pe
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gC7iO-0002GY-00
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:35:42 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gC7iM-0002FV-LE
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:35:39 -0400
Received: by mail-pf1-x444.google.com with SMTP id j23-v6so10115716pfi.4
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:35:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-9-alex.bennee@linaro.org>
	<07e7c534-c9b4-4d07-6f1a-797b2904d9e4@linaro.org>
	<87ftx73whg.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <974684e3-afa7-2834-d26c-a6edabb570cb@twiddle.net>
Date: Mon, 15 Oct 2018 11:35:32 -0700
MIME-Version: 1.0
In-Reply-To: <87ftx73whg.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 08/21] accel/tcg/cputlb: convert
 remaining tlb_debug() to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, cota@braap.org, Pavel.Dovgaluk@ispras.ru, Paolo Bonzini <pbonzini@redhat.com>, vilanova@ac.upc.edu

On 10/15/18 11:17 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 10/5/18 8:48 AM, Alex Bennée wrote:
>>> To avoid overly long lines in trace events I've split the event into
>>> tlb_set_page and tlb_set_page_attrs.
>>
>> I don't think this split is a good idea.  It allows data from different threads
>> to be interleaved.
> 
> Won't we soon have a lock serialising this?

For each individual trace entry, surely.
If you split the trace in two, you leave a race in the middle.

> It was mainly to shut-up checkpatch because the trace-events don't seem
> to do multi-line.

I would just ignore that.


r~
