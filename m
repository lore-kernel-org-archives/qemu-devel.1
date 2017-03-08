Received: from eggs.gnu.org ([2001:4830:134:3::10]:52514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1clRzP-0004pE-CE
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 22:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1clRzM-0002UN-94
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 22:10:11 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1clRzM-0002To-41
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 22:10:08 -0500
Received: by mail-qk0-x243.google.com with SMTP id o135so7098823qke.2
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 19:10:08 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170308001637.9838-1-git@kirschju.re>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a01a515b-4296-4f5f-0509-2227a68e6770@twiddle.net>
Date: Wed, 8 Mar 2017 14:09:58 +1100
MIME-Version: 1.0
In-Reply-To: <20170308001637.9838-1-git@kirschju.re>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] X86/HMP: Expose x86 model specific
 registers via human monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Kirsch <git@kirschju.re>, qemu-devel@nongnu.org
Cc: Julian Kirsch <mail@kirschju.re>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

On 03/08/2017 11:16 AM, Julian Kirsch wrote:
> For instance, many modern x86-64 operating systems maintain access to internal
> data structures via the MSR_GSBASE/MSR_KERNELGSBASE MSRs. Giving
> introspection utilities (such as a remotely attached gdb) a way of
> accessing these registers improves analysis results drastically.

If this is just for gdb, then we should provide access via the normal gdbstub, 
plus appropriate xml files.  There are plenty of examples of this for other cpus.


r~
