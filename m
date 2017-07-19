Received: from eggs.gnu.org ([2001:4830:134:3::10]:34561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXwty-0002Ar-MR
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 17:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXwtu-0004zg-PA
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 17:53:02 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXwtu-0004zU-LA
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 17:52:58 -0400
Received: by mail-qt0-x243.google.com with SMTP id l55so1616105qtl.3
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 14:52:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170719044522.21114-1-rth@twiddle.net>
	<CAFEAcA_rx1UyVBrS1WaE6FZMvQPsb=RJJCZgnfS2AjWR+hsFsg@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e590ae65-f18f-7ced-c141-8833a3df38ca@twiddle.net>
Date: Wed, 19 Jul 2017 11:52:51 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_rx1UyVBrS1WaE6FZMvQPsb=RJJCZgnfS2AjWR+hsFsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/8] target/alpha cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 07/19/2017 06:57 AM, Peter Maydell wrote:
> On 19 July 2017 at 05:45, Richard Henderson <rth@twiddle.net> wrote:
>> The new title holder for perf top is helper_lookup_tb_ptr.
>> Those targets that have a complicated cpu_get_tb_cpu_state
>> function are going to regret that.
> 
> Yeah, Paolo's pointed out (and had some patches for)
> ARM's rather complicated cpu_get_tb_cpu_state(). My
> issue with his suggested fixes was that they were
> pretty fragile in terms of not having any guarantee
> that the change always produced the right tb cpu
> state flags answer...

Oh?  I must have missed seeing this one.
A quick patchwork search doesn't pull it up;
do either of you have a link?


r~
