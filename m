Received: from eggs.gnu.org ([2001:4830:134:3::10]:43810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3LKS-0005UI-6J
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3LKN-0007Ic-BD
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:41:52 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d3LKN-0007IU-4k
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:41:47 -0400
Received: by mail-wm0-x244.google.com with SMTP id u65so325537wmu.3
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 04:41:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170425104338.31984-1-rth@twiddle.net>
	<87a87468d5.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<4f7766e0-4935-9b2e-8388-ff8f04a43aaf@twiddle.net>
	<87k267myv1.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<87fugvmoyq.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <54cf73d4-b175-4c68-a881-c7f3a8acd758@twiddle.net>
Date: Wed, 26 Apr 2017 13:41:43 +0200
MIME-Version: 1.0
In-Reply-To: <87fugvmoyq.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Initialize return value after
 exit_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>

On 04/26/2017 12:40 PM, Nikunj A Dadhania wrote:
>                           -> cc->cpu_exec_enter() = ppc_cpu_exec_enter()
>                              Sets env->reserve_addr = -1;

This is the bug.  We should be doing this in powerpc_excp instead.

I'm quite frankly surprised that we don't see this same failure with 
-singlestep, but I guess we usually stay in the cpu loop long enough.


r~
