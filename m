Received: from eggs.gnu.org ([2001:4830:134:3::10]:58518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gVGVG-0008Kj-0W
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gVGVE-00072C-Ln
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:49:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gVGVC-0006s3-JD
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:49:11 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 791F130043F8
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 13:49:08 +0000 (UTC)
References: <20181206232333.22408-1-pbonzini@redhat.com>
	<20181206232333.22408-7-pbonzini@redhat.com>
	<87d0qd1zh7.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d68f52a8-66e8-316a-31df-12fa1702ae8f@redhat.com>
Date: Fri, 7 Dec 2018 14:49:04 +0100
MIME-Version: 1.0
In-Reply-To: <87d0qd1zh7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] checkpatch: warn about queue/queue.h
 head structs that are not typedef-ed
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

On 07/12/18 10:02, Markus Armbruster wrote:
> Let's state the rationale for requiring a typedef in the commit
> message, or point to a prior commit that has it.

Sure---the rationale is simply that they are structs (or unions in the
case of QTAILQ but it's just an implementation detail), and we use
typedef for structs.

Paolo

> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  scripts/checkpatch.pl | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index a8d6e44107..b4b3495044 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2263,6 +2263,11 @@ sub process {
>>  			}
>>  		}
>>  
>> +		if ($line =~ /^.\s*(Q(?:S?LIST|SIMPLEQ|TAILQ)_HEAD)\s*\(\s*[^,]/ &&
>> +		    $line !~ /^.typedef/) {
>> +		    ERROR("named $1 should be typedefed separately\n" . $herecurr);
>> +		}
>> +
>>  # Need a space before open parenthesis after if, while etc
>>  		if ($line=~/\b(if|while|for|switch)\(/) {
>>  			ERROR("space required before the open parenthesis '('\n" . $herecurr);
