Received: from eggs.gnu.org ([2001:4830:134:3::10]:36399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cWOH1-0003ku-G8
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cWOGw-0004cS-MN
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:10:07 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cWOGw-0004bs-E1
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:10:02 -0500
Received: by mail-wm0-x22b.google.com with SMTP id c85so28026370wmi.1
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 06:10:02 -0800 (PST)
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-17-alex.bennee@linaro.org>
	<119e5de6-388c-3b02-8797-fa8eb07ca8ad@twiddle.net>
	<87lgu09p3q.fsf@linaro.org>
	<1b3899b0-36de-782b-2759-c3f40be801d6@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1b3899b0-36de-782b-2759-c3f40be801d6@twiddle.net>
Date: Wed, 25 Jan 2017 14:09:59 +0000
Message-ID: <87inp39qo8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 16/27] cputlb: add tlb_flush_by_mmuidx
 async routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, peter.maydell@linaro.org, claudio.fontana@huawei.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, jan.kiszka@siemens.com, mark.burton@greensocs.com, serge.fdrv@gmail.com, pbonzini@redhat.com, bamvor.zhangjian@linaro.org


Richard Henderson <rth@twiddle.net> writes:

> On 01/24/2017 12:31 PM, Alex Bennée wrote:
>>> Why don't we just pass in this bitmap in the first place?  It's much better
>>> than having to use varargs in tlb_flush_by_mmuidx...
>>
>> We could. By not messing with the API it leaves the door open to having
>> other non-MTTCG architectures that have lots of MMU indexes versus a
>> hard limit based on page-size. That said I think the number of indexes
>> also affects the size of the TLB so I guess the current design is
>> limited for arbitrarily large sets if indexes?
>
> We hard-limit at 12 indices, though even that is arguably too high.
> I hope we never see more than PPC's current 8.

Hmm there is quite a lot of churn in the ARM code to move from an index
to a bitmap. It should be mostly mechanical but we'll see.

--
Alex Bennée
