Received: from eggs.gnu.org ([2001:4830:134:3::10]:59559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ekOdE-0000px-4g
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 01:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ekOd8-0005Xt-TR
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 01:27:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46996 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ekOd8-0005W4-Q2
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 01:27:22 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180116134217.8725-1-berrange@redhat.com>
	<20180116134217.8725-7-berrange@redhat.com>
	<46fa1e33-70e7-559e-11b9-0ec53bfb8782@redhat.com>
Date: Sat, 10 Feb 2018 07:27:11 +0100
In-Reply-To: <46fa1e33-70e7-559e-11b9-0ec53bfb8782@redhat.com> (Eric Blake's
	message of "Fri, 9 Feb 2018 17:39:58 -0600")
Message-ID: <877erll5q8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 06/14] qapi: remove '-q' arg to diff
 when comparing QAPI output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Eric Blake <eblake@redhat.com> writes:

> On 01/16/2018 07:42 AM, Daniel P. Berrange wrote:
>> When the qapi schema tests fail they merely print that the expected
>> output didn't match the actual output. This is largely useless when
>> trying diagnose what went wrong. Removing the '-q' arg to diff
>> means that it is still silent on successful tests, but when it
>> fails we'll see details of the incorrect output.
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>   tests/Makefile.include | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 39a4b5359d..d65fb4e1b3 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -908,10 +908,10 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
>>   		$^ >$*.test.out 2>$*.test.err; \
>>   		echo $$? >$*.test.exit, \
>>   		"TEST","$*.out")
>> -	@diff -q $(SRC_PATH)/$*.out $*.test.out
>> +	@diff $(SRC_PATH)/$*.out $*.test.out
>
> And just now I'm noticing that this produces an ed-script diff (which
> is useless), instead of a context diff.  We want -c.  I guess I'll be
> submitting the obvious followup patch.

I'd very much prefer -u.

There's a diff -q left a few lines down.
