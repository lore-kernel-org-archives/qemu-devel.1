Received: from eggs.gnu.org ([2001:4830:134:3::10]:51438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jreiser@bitwagon.com>) id 1dunFL-0006hS-MH
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 18:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jreiser@bitwagon.com>) id 1dunFH-0002GC-2A
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 18:13:31 -0400
Received: from bitwagon.com ([2001:470:0:e6::4a52:27af]:43399)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jreiser@bitwagon.com>)
	id 1dunFG-0002CU-K9
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 18:13:26 -0400
Received: from f25e64.local ([24.21.156.164]) by bitwagon.com
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 15:13:17 -0700
References: <4d10cdd2-233c-46ac-926b-d4254b017c78@bitwagon.com>
	<CAFEAcA82LzXcT6BoAoAuD3XtmO6+hehwWd=Jno1DXZd5qEuYcw@mail.gmail.com>
	<CAFEAcA85ZRSgbpSQSFXO+u_jyZrv_4XHcpviP1W1TzYnGcYpUQ@mail.gmail.com>
	<cf804325-c982-c07d-b88c-5d069252f76f@bitwagon.com>
	<CAFEAcA8XU004=Tiv2mTgxVFoToZYL_UshmJjbeJ9v2dP7V0rMw@mail.gmail.com>
	<ef3336f8-6eee-c775-3f1e-472e2cae735d@suse.de>
From: John Reiser <jreiser@bitwagon.com>
Message-ID: <3d82d0c3-b109-3996-be93-d2e6b5ec5031@bitwagon.com>
Date: Wed, 20 Sep 2017 15:13:17 -0700
MIME-Version: 1.0
In-Reply-To: <ef3336f8-6eee-c775-3f1e-472e2cae735d@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-arm SIGSEGV for self-modifying code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

>> I don't really know why we use 0xf7000000 as our
>> reserved_va value here, though. Alex, you added that
>> years ago, can you remember why you used that value?
> 
> IIRC I wanted to map the full 32 bits of address space possibly in use by a 32bit application, but leave some room for something, but I don't remember what that something was :)

Now that I know the nature of the conflict, then I will spend a handful of instructions
to avoid [0xf7000000, +), and also the stack if it gets placed immediately below that.

Thank you, Peter and Alex.

-- 
John
