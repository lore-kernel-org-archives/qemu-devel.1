Received: from eggs.gnu.org ([2001:4830:134:3::10]:44445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRZXt-0006mh-Vf
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRZXq-0005BM-QS
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:20:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRZXq-0005A3-Hu
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:20:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id 125so21077635wmh.0
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 01:20:38 -0800 (PST)
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-26-philmd@redhat.com>
	<5fedf421-a138-041a-638b-98f3fd3ffeef@redhat.com>
	<87h8g2uc9f.fsf@dusky.pond.sub.org>
	<16ab3c47-f521-3172-6e49-acb7a3d7d233@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <45adf9ec-e173-0a0e-1b3f-7d12881573d8@redhat.com>
Date: Tue, 27 Nov 2018 10:20:34 +0100
MIME-Version: 1.0
In-Reply-To: <16ab3c47-f521-3172-6e49-acb7a3d7d233@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 25/25] MAINTAINERS: Remove
 duplicate entries of qemu-devel@nongnu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 27/11/18 10:18, Paolo Bonzini wrote:
> On 27/11/18 09:59, Markus Armbruster wrote:
>>>>  LINUX
>>>> -L: qemu-devel@nongnu.org
>>>>  S: Maintained
>>>>  F: linux-*
> 
> This pattern only matches
> 
> ./block/linux-aio.c
> ./stubs/linux-aio.c
> 
> so it can be removed
> 

OK

>>>>  F: linux-headers/
> 
> For this I propose mst, Conny and myself.

Or remove... I'll let them opinate.

> 
>>>>  POSIX
>>>> -L: qemu-devel@nongnu.org
>>>>  S: Maintained
>>>>  F: *posix*
>>>
>>> I agree that we can remove the "L: qemu-devel" entries everywhere, but
>>> for these subsystems that have no "M:" entry, but "S: Maintained", this
>>> now looks somewhat strange - the subsystem is "Maintained" but has no
>>> maintainer? I think we need somebody who feels responsible to pick up
>>> patches here...?
>>
>> It looks strange because it *is* strange.  If we take the definition of
>> S: in MAINTAINERS seriously, we need to appoint a maintainer (a person,
>> not a mailing list), or downgrade to S: Orphan.
> 
> I can volunteer for this one too, but please change the F: patterns to
> 
> F: os-posix.c
> F: include/sysemu/os-posix.h
> F: util/*posix*.c
> F: include/qemu/*posix*.h

OK, will do.

Thanks Paolo,

Phil.

> 
> Thanks,
> 
> Paolo
> 
