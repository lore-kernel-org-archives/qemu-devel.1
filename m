Received: from eggs.gnu.org ([2001:4830:134:3::10]:34728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dE8GY-0001HL-Vv
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dE8GY-0003YZ-Ae
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:58:27 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dE8GY-0003YL-5B
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:58:26 -0400
Received: by mail-qk0-x242.google.com with SMTP id o85so149594qkh.0
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 22:58:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170524192246.15905-1-rth@twiddle.net>
	<20170524192246.15905-31-rth@twiddle.net>
	<20170525205017.sxbs2jrtvwcwnhbj@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f782e22b-1914-7ed3-d5c1-718727777e9f@twiddle.net>
Date: Thu, 25 May 2017 22:58:20 -0700
MIME-Version: 1.0
In-Reply-To: <20170525205017.sxbs2jrtvwcwnhbj@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 30/33] target/s390x: Fix some helper_ex
 problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On 05/25/2017 01:50 PM, Aurelien Jarno wrote:
> On 2017-05-24 12:22, Richard Henderson wrote:
>> (1) The OR of the low bits or R1 into INSN were not being done
>> consistently; it was forgotten along all but the SVC path.
> 
> It was done for the logical ops assuming the instruction has the
> corresponding byte set to 0, as in that case it matches the length
> and is passed directly as an argument to the helper.

I agree that was the assumption, but it's still technically wrong.


r~
