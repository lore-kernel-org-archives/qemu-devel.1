Received: from eggs.gnu.org ([2001:4830:134:3::10]:59107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fT3wU-0003aB-3d
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fT3wQ-00032W-T5
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:27:58 -0400
References: <1528859749-25286-1-git-send-email-baiyaowei@cmss.chinamobile.com>
	<20180613035030.GB25430@flamenco>
From: Eric Blake <eblake@redhat.com>
Message-ID: <23a38716-196f-53a0-0a3d-61f269b1dab4@redhat.com>
Date: Wed, 13 Jun 2018 06:27:49 -0500
MIME-Version: 1.0
In-Reply-To: <20180613035030.GB25430@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tracing.txt: add missing '-' for trace
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: qemu-trivial@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu, stefanha@redhat.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 06/12/2018 10:50 PM, Emilio G. Cota wrote:
> On Tue, Jun 12, 2018 at 23:15:49 -0400, Yaowei Bai wrote:
>> Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
>> ---
>>   docs/devel/tracing.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
>> index 07abbb3..6ab32cc 100644
>> --- a/docs/devel/tracing.txt
>> +++ b/docs/devel/tracing.txt
>> @@ -18,7 +18,7 @@ for debugging, profiling, and observing execution.
>>   
>>   3. Run the virtual machine to produce a trace file:
>>   
>> -    qemu -trace events=/tmp/events ... # your normal QEMU invocation
>> +    qemu --trace events=/tmp/events ... # your normal QEMU invocation
> 
> The second dash is not missing; both '-args' and '--args' work.
> 
> '-args' seems to be favoured though; see `qemu -h' or `qemu --h' :-)

Actually, we're trying to fix that:
https://wiki.qemu.org/BiteSizedTasks#Consistent_option_usage_in_documentation

The one-vs-two dash usage is only supported in qemu, not in qemu-nbd or 
qemu-img (that is, qemu acts as if it uses getopt_long_only(), while the 
others use getopt_long() - except that we hand-rolled the parser in 
qemu, meaning you might find quirks where it sometimes doesn't even 
match getopt_long_only()).

At any rate, since --trace is an option that is supported across 
multiple binaries, we SHOULD favor the double-dash spelling in our 
documentation, so that you can consistently reuse the same --trace 
invocation without worrying whether the binary parses its arguments with 
getopt_long() (where double is required) or like getopt_long_only() 
(where the double is optional but supported).

So I'm in favor of this patch, although it may need more of a commit 
message summarizing the justification I've just pointed you to.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
