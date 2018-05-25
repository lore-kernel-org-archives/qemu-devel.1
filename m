Received: from eggs.gnu.org ([2001:4830:134:3::10]:43111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMBj8-0008Or-59
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMBj7-0000kE-Ac
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:21:46 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:45373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fMBj7-0000jv-5v
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:21:45 -0400
Received: by mail-ot0-x243.google.com with SMTP id 15-v6so5811215otn.12
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 05:21:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180525151719-mutt-send-email-mst@kernel.org>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
	<1527086545-68024-8-git-send-email-mst@redhat.com>
	<CAFEAcA9JwWR29YSBKGS1fmmOE=wrSQY+OeJxQc4kmAEHRXUzWQ@mail.gmail.com>
	<CAFEAcA9mAMCznsf1hao2PFziXnATrCxa8Of33NckUGXxFU6yEQ@mail.gmail.com>
	<20180525151719-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 13:21:24 +0100
Message-ID: <CAFEAcA_bDdefEuy183ma4oso5bZ2QxheDs9oOObBCKPL2hx+Uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 07/28] x86/cpu: use
 standard-headers/asm-x86.kvm_para.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm-devel <kvm@vger.kernel.org>

On 25 May 2018 at 13:18, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, May 25, 2018 at 12:53:44PM +0100, Peter Maydell wrote:
>> For the moment I'm using this workaround (I wanted to do a header
>> update for something else I'm working on):
>>
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -48,6 +48,11 @@
>>  #include "exec/memattrs.h"
>>  #include "trace.h"
>>
>> +/* Work around this kernel header constant changing its name */
>> +#ifndef KVM_HINTS_REALTIME
>> +#define KVM_HINTS_REALTIME KVM_HINTS_DEDICATED
>> +#endif
>> +
>>  //#define DEBUG_KVM
>>
>>  #ifdef DEBUG_KVM
>
> I don't think we need this chunk.

My view is that header update commits should be exactly and only
the result of running update-linux-headers, no manual tweaking.
If you don't add this chunk before the update, compilation with the
update will fail. You can remove the chunk after the update, of course...

thanks
-- PMM
