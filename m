Received: from eggs.gnu.org ([2001:4830:134:3::10]:56690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsUGk-0002y2-NA
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsUGh-0006kX-GG
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:37:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsUGg-0006ji-Gl
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:37:54 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <0d3a215b-4916-b0a6-5654-5d64fcf6c996@redhat.com> (Thomas Huth's
	message of "Wed, 22 Aug 2018 12:30:31 +0200")
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-8-quintela@redhat.com>
	<0d3a215b-4916-b0a6-5654-5d64fcf6c996@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Aug 2018 16:37:42 +0200
Message-ID: <87y3cyo4ax.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 07/10] check: Only test boot-serial when
 sga is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thomas Huth <thuth@redhat.com> wrote:
> On 2018-08-22 11:54, Juan Quintela wrote:
>> This is only for x86* architecture.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/Makefile.include | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 116e93cdb6..d524e1bdeb 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -257,7 +257,7 @@ check-qtest-i386-y += tests/hd-geo-test$(EXESUF)
>>  gcov-files-i386-y += hw/block/hd-geometry.c
>>  check-qtest-i386-y += tests/boot-order-test$(EXESUF)
>>  check-qtest-i386-y += tests/bios-tables-test$(EXESUF)
>> -check-qtest-i386-y += tests/boot-serial-test$(EXESUF)
>> +check-qtest-i386-$(CONFIG_SGA) += tests/boot-serial-test$(EXESUF)
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> Off-topic: I wonder whether we could even deprecate the SGA device
> nowadays, since the main seabios now can redirect the console to the
> serial port, too?

No idea, but then I think we can deprecate it, we already have enough
weird things around.

Thanks, Juan.
