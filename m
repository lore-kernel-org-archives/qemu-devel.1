Received: from eggs.gnu.org ([2001:4830:134:3::10]:48163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceeAw-0002NL-6Y
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceeAv-0004pg-De
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:45:58 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3bbe3e92-7352-43c3-702a-690c72171cec@redhat.com>
Date: Fri, 17 Feb 2017 09:45:55 +0100
MIME-Version: 1.0
In-Reply-To: <bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Chad Joan <chadjoan@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org



On 16/02/2017 18:23, Laszlo Ersek wrote:
>> Hi,
>>
>> can you explain exactly which function is missing without
>> -D_XOPEN_SOURCE=500?  If it is curses' wide-char functions, why does it
>> fail with musl but not with glibc?  Is _XOPEN_SOURCE always defined by
>> glibc if you have _D_GNU_SOURCE?
> It is not necessarily auto-defined, but the effect is "as if".
> 
> It is documented in the libc info:
> 
> https://www.gnu.org/software/libc/manual/html_node/Feature-Test-Macros.html#index-_005fXOPEN_005fSOURCE
> 

So is this a musl bug?

Paolo
