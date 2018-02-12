Received: from eggs.gnu.org ([2001:4830:134:3::10]:55541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elGgX-0005ZT-Ud
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elGgV-0002eI-CO
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:10:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54804 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elGgV-0002dy-86
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:10:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E62014023112
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 16:10:26 +0000 (UTC)
References: <20180211004013.10784-1-eblake@redhat.com>
	<20180211004013.10784-2-eblake@redhat.com>
	<87inb3g2an.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2b0e0c59-7207-991c-06fd-0457610f019c@redhat.com>
Date: Mon, 12 Feb 2018 10:10:26 -0600
MIME-Version: 1.0
In-Reply-To: <87inb3g2an.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qapi: Pass '-u' when doing non-silent
 diff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 02/11/2018 06:04 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> Ed-script diffs are awful compared to context diffs.  Fix another
>> 'diff -q' while in the area (if the files are different, being
>> noisy makes it easier to diagnose why).
>>
>> Fixes: 46ec4fce
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   tests/Makefile.include | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index f41da235aef..375f31b5bc0 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -919,14 +919,14 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
>>   		$^ >$*.test.out 2>$*.test.err; \
>>   		echo $$? >$*.test.exit, \
>>   		"TEST","$*.out")
>> -	@diff $(SRC_PATH)/$*.out $*.test.out
>> +	@diff -u $(SRC_PATH)/$*.out $*.test.out
>>   	@# Sanitize error messages (make them independent of build directory)
>> -	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff $(SRC_PATH)/$*.err -
>> -	@diff $(SRC_PATH)/$*.exit $*.test.exit
>> +	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -u $(SRC_PATH)/$*.err -
>> +	@diff -u $(SRC_PATH)/$*.exit $*.test.exit
> 
> Let's diff .err before .out, because when .err differs, .out is usually
> useless.

Sure, will improve on v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
