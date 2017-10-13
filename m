Received: from eggs.gnu.org ([2001:4830:134:3::10]:40627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1e36Ce-0007UY-DQ
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1e36Cb-0000LZ-95
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:05:04 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:52595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1e36Cb-0000Ih-2x
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:05:01 -0400
Received: by mail-pg0-x243.google.com with SMTP id a192so580529pge.9
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 13:04:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171013181913.7556-1-Andrew.Baumann@microsoft.com>
	<MWHPR21MB0159D916DDC23B9C44DE2CB19E480@MWHPR21MB0159.namprd21.prod.outlook.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4a51f729-4632-43c1-18e3-f26b37b5df02@twiddle.net>
Date: Fri, 13 Oct 2017 13:04:55 -0700
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB0159D916DDC23B9C44DE2CB19E480@MWHPR21MB0159.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] notdirty_mem_write: implement 8-byte
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 10/13/2017 11:27 AM, Andrew Baumann wrote:
>> From: Andrew Baumann
>> Sent: Friday, 13 October 2017 11:19
>>
>> Aligned 8-byte memory writes by a 64-bit target on a 64-bit host should
>> always turn into atomic 8-byte writes on the host, however if we missed
>> in the softmmu, and the TLB line was marked as not dirty, then we
>> would end up tearing the 8-byte write into two 4-byte writes in
>> access_with_adjusted_size().
>>
>> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
>> ---
>> This manifested as a race in lock-free synchronisation with an aarch64
>> Windows guest on an x86-64 host (with multithreaded TCG).
>>
>>  exec.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
> 
> By the way, I noticed that watch_mem_ops are also 4-byte only. I suspect the
> same fix may be needed there?
Yep.


r~
