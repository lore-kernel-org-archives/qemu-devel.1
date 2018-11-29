Received: from eggs.gnu.org ([2001:4830:134:3::10]:58806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSQSY-0001wZ-Ch
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSQSV-0007k2-2a
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:50:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:6070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSQSU-0007ju-QU
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:50:39 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3412B325AA
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 17:50:38 +0000 (UTC)
References: <20181129090120.28828-1-pbonzini@redhat.com>
	<20181129090120.28828-3-pbonzini@redhat.com>
	<878t1b7t2w.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7e6c5c3-5d43-3ad0-07b4-fac8018ec557@redhat.com>
Date: Thu, 29 Nov 2018 18:50:35 +0100
MIME-Version: 1.0
In-Reply-To: <878t1b7t2w.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 2/4] checkpatch: check
 Signed-off-by in --mailback mode
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

On 29/11/18 17:21, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> Pull the test before the anticipated exits from the process sub.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  scripts/checkpatch.pl | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index d58fcb1efd..c216c55e01 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2866,6 +2866,10 @@ sub process {
>>  		}
>>  	}
>>  
>> +	if ($is_patch && $chk_signoff && $signoff == 0) {
>> +		ERROR("Missing Signed-off-by: line(s)\n");
>> +	}
>> +
>>  	# If we have no input at all, then there is nothing to report on
>>  	# so just keep quiet.
>>  	if ($#rawlines == -1) {
>> @@ -2887,9 +2891,6 @@ sub process {
>>  	if (!$is_patch) {
>>  		ERROR("Does not appear to be a unified-diff format patch\n");
>>  	}
>> -	if ($is_patch && $chk_signoff && $signoff == 0) {
>> -		ERROR("Missing Signed-off-by: line(s)\n");
>> -	}
>>  
>>  	print report_dump();
>>  	if ($summary && !($clean == 1 && $quiet == 1)) {
> 
> Would this make sense for Linux's checkpatch.pl, too?
> 

Yes, but I have never had any luck upstreaming our changes. :(  For
example, e20122ff0faf07cb701d35e39e106d1783c07725 is a genuine bugfix
but it was ignored.

I am willing to give it a try, but I'd rather not hold this change to
QEMU's checkpatch.

(Same answer for 1/4).

Paolo
