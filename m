Received: from eggs.gnu.org ([2001:4830:134:3::10]:51750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRb3f-0005fs-Mw
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 03:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRb3X-0007Vi-5R
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 03:48:31 -0500
Received: from mail-wj0-x243.google.com ([2a00:1450:400c:c01::243]:33894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cRb3W-0007VF-TW
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 03:48:23 -0500
Received: by mail-wj0-x243.google.com with SMTP id qs7so1102849wjc.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 00:48:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
	<eabc1ecd-439c-69cc-facb-281699a4d26e@redhat.com>
	<20170111171202.GG9269@stefanha-x1.localdomain>
	<20170111171646.GR12072@redhat.com>
	<6d64c194-bb64-9ac2-3281-9a9329f6a52b@redhat.com>
	<20170111174045.GT12072@redhat.com>
	<6ff77c17-5516-e967-27ec-6fb3bf2160d4@redhat.com>
	<87fukpf5ub.fsf@ac.upc.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9456f50a-811a-03a7-2bf7-0533dabb0650@redhat.com>
Date: Thu, 12 Jan 2017 09:48:20 +0100
MIME-Version: 1.0
In-Reply-To: <87fukpf5ub.fsf@ac.upc.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>



On 12/01/2017 02:02, Lluís Vilanova wrote:
> Paolo Bonzini writes:
> [...]
>> A weird idea: what about doing
> 
>>     -DGENERATED_TRACERS_H=\"hw/scsi/generated-tracers.h\"
> 
>> and then having
> 
>>      #ifdef GENERATED_TRACE_H
>>      #include GENERATED_TRACE_H
>>      #endif
> 
>> in include/trace.h?
> 
>> Then you can use full include path for special cases such as
>> include/hw/xen/xen_common.h, but the common case is handled directly
>> with just
> 
>>      #include "trace.h"
> 
>> which refers to $(srcdir)/include/trace.h? (Take the above with a grain
>> of salt because I haven't reviewed the patches closely).
> 
> Feels like too much black magic to me for the benefit of a bit less typing.

It's not less typing, it's about consistency.   Includes from the
current directory are currently included with no path.

Paolo
