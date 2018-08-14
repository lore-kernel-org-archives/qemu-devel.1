Received: from eggs.gnu.org ([2001:4830:134:3::10]:49689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpdpa-00005g-39
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpdpG-0002xl-3u
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:14:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpdpF-0002xh-Uz
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:13:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88C9F402B032
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 18:13:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180814154139.28604-1-pbonzini@redhat.com>
	<7124fc52-106b-840a-ea63-4680def9a377@redhat.com>
Date: Tue, 14 Aug 2018 20:13:48 +0200
In-Reply-To: <7124fc52-106b-840a-ea63-4680def9a377@redhat.com> (Thomas Huth's
	message of "Tue, 14 Aug 2018 17:55:25 +0200")
Message-ID: <87mutostnn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: add maintainers for qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com

Thomas Huth <thuth@redhat.com> writes:

> On 08/14/2018 05:41 PM, Paolo Bonzini wrote:
>> Thomas has been doing a lot of work on qom-test and device-introspection-test,
>> and Laurent has ported libqos to sPAPR and co-mentored Emanuele on the
>> upcoming qtest device framework.  They deserve recognition. :)
>> 
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  MAINTAINERS | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 666e936812..657595e6be 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1685,7 +1685,6 @@ F: qom/
>>  X: qom/cpu.c
>>  F: tests/check-qom-interface.c
>>  F: tests/check-qom-proplist.c
>> -F: tests/qom-test.c
>
> I think you could also leave the entry here ... it should not hurt if a
> test has multiple maintainers.
>
>>  QMP
>>  M: Markus Armbruster <armbru@redhat.com>
>> @@ -1697,6 +1696,16 @@ F: scripts/qmp/
>>  F: tests/qmp-test.c
>>  T: git git://repo.or.cz/qemu/armbru.git qapi-next
>>  
>> +qtest
>> +M: Paolo Bonzini <pbonzini@redhat.com>
>> +M: Thomas Huth <thuth@redhat.com>
>> +M: Laurent Vivier <lvivier@redhat.com>
>> +S: Maintained
>> +F: qtest.c
>> +F: tests/libqtest.*
>> +F: tests/libqos/
>> +F: tests/*-test.c
>
> Basically
> Acked-by: Thomas Huth <thuth@redhat.com>
> (and thanks for adding me here!), but I think there are even more files
> related to qtest:
>
> $ grep -l qtest tests/*.c | grep -v 'test\.c'
> tests/boot-sector.c
> tests/ptimer-test-stubs.c
> tests/test-arm-mptimer.c
> tests/test-filter-mirror.c
> tests/test-filter-redirector.c
> tests/test-hmp.c
> tests/test-netfilter.c
> tests/test-qga.c
> tests/test-rcu-list.c
> tests/test-x86-cpuid-compat.c
> tests/tpm-tests.c
> tests/tpm-util.c
>
> Maybe we should "fix" this properly and move all qtest-related files
> into a separate folder tests/qtest now (or at least after the current
> qtest-related patch series that are currently in flight hit the master
> branch)? Or rename the test-*.c files to *-test.c files?

The tests/ directory has become a bit crowded.  Separating unit tests
and qtests make sense to me.
