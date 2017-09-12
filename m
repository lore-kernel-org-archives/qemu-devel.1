Received: from eggs.gnu.org ([2001:4830:134:3::10]:54457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drgN7-0000f8-C3
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drgN2-0002ju-1k
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:16:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drgN1-0002im-Ry
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:16:35 -0400
References: <20170713201522.13765-1-rkagan@virtuozzo.com>
	<20170831163727.GA24261@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <053bf04c-5aa9-7306-6fa5-fe8de3fb62f0@redhat.com>
Date: Tue, 12 Sep 2017 10:16:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170831163727.GA24261@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] hyperv: own protocol header instead of
 kernel's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, Igor Mammedov <imammedo@redhat.com>

On 31/08/2017 18:37, Roman Kagan wrote:
> On Thu, Jul 13, 2017 at 11:15:20PM +0300, Roman Kagan wrote:
>> Supersede kernel's header for Hyper-V protocol definitions with our own.
>> The reason is that, since this is a third-party protocol and not a
>> kernel API, the kernel folks are not happy exposing it in the kernel
>> uapi.
>>
>> The patchset is done to allow gradual transition from the kernel's
>> hyperv.h to the new one: the first patch introduces the new header that
>> doesn't conflict with the old one, and the second makes sure the old one
>> isn't imported from the kernel any longer, so that the maintainers can
>> do the next round of kernel header import at their leisure and things
>> will keep working.
>>
>> Once (if) this lands in QEMU I'll post patches to KVM to move its
>> hyperv.h out of uapi.
>>
>> This is the first part split out of my former biggish "hyperv fixes and
>> enhancements" series.  The only change is the underscore replaced with a
>> dash in the header file name.

Queued, thanks.

Paolo

>> Roman Kagan (2):
>>   hyperv: add header with protocol definitions
>>   update-linux-headers: prepare for hyperv.h removal
>>
>>  target/i386/cpu.h               |  10 +-
>>  target/i386/hyperv-proto.h      | 257 ++++++++++++++++++++++++++++++++++++++++
>>  target/i386/cpu.c               |   4 +-
>>  target/i386/hyperv.c            |   6 +-
>>  target/i386/kvm.c               |  57 +++++----
>>  target/i386/machine.c           |  15 +--
>>  scripts/update-linux-headers.sh |   4 +-
>>  7 files changed, 304 insertions(+), 49 deletions(-)
>>  create mode 100644 target/i386/hyperv-proto.h
>>
>> -- 
>> 2.13.0
>>
>>
> 
> Ping?
> 
> Roman.
> 
