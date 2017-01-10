Received: from eggs.gnu.org ([2001:4830:134:3::10]:46539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cR0Vn-0004Bi-6o
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cR0Vj-0007Ck-AL
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:47:07 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cR0Vj-0007CL-3y
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:47:03 -0500
Received: by mail-wm0-x243.google.com with SMTP id c85so31237951wmi.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:47:02 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
	<eabc1ecd-439c-69cc-facb-281699a4d26e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e7644a0b-c072-beee-7885-bea34ff34652@redhat.com>
Date: Tue, 10 Jan 2017 18:47:01 +0100
MIME-Version: 1.0
In-Reply-To: <eabc1ecd-439c-69cc-facb-281699a4d26e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org



On 10/01/2017 17:51, Eric Blake wrote:
> On 01/10/2017 10:37 AM, Stefan Hajnoczi wrote:
>> On Fri, Jan 06, 2017 at 03:54:58PM +0000, Daniel P. Berrange wrote:
>>> diff --git a/io/channel-buffer.c b/io/channel-buffer.c
>>> index 43d7959..b4e50d6 100644
>>> --- a/io/channel-buffer.c
>>> +++ b/io/channel-buffer.c
>>> @@ -22,7 +22,7 @@
>>>  #include "io/channel-buffer.h"
>>>  #include "io/channel-watch.h"
>>>  #include "qemu/sockets.h"
>>> -#include "trace.h"
>>> +#include "io/trace.h"
>>
>> Is this change necessary?
> 
> Yes - now that there are more than one trace.h files spread across
> multiple directories, you need a prefix to ensure the correct one gets
> included.  In this particular case, it also matches consistency in
> including "io/channel-buffer.h" rather than just "channel-buffer.h".
> 
>>
>> I think the per-subdir trace.h file should be generated in
>> $BUILD_DIR/<sub-dir>/trace.h and gcc -I. can locate that file.
> 
> It can indeed locate it, but now you are depending on -I ordering to
> make sure it locates the right one before any other wrong one, which
> feels too fragile to me.

The wrong one shouldn't be available at all.  io/channel-buffer.h is in
include/io/, while io/trace.h is in io/.  But I guess this can be
cleaned up through the whole tree later if Stefan wants to merge this
more disrupting series soon.

Paolo
