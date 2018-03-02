Received: from eggs.gnu.org ([2001:4830:134:3::10]:51672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1ergz1-0000UN-3i
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1ergyy-0007if-GW
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:28:07 -0500
Received: from smtp29.i.mail.ru ([94.100.177.89]:52992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1ergyy-0007gv-3H
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:28:04 -0500
References: <1519978965-16865-1-git-send-email-jusual@mail.ru>
	<d5bfb4a6-670c-9a0f-18b9-a44d307140b5@redhat.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <e4f07045-bec3-89b3-8c66-1c835ab4c2d4@mail.ru>
Date: Fri, 2 Mar 2018 12:27:57 +0300
MIME-Version: 1.0
In-Reply-To: <d5bfb4a6-670c-9a0f-18b9-a44d307140b5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] checkpatch: add a warning for
 basename/dirname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>



On 02.03.2018 11:56, Paolo Bonzini wrote:
> On 02/03/2018 09:22, Julia Suvorova wrote:
>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>> ---
>>  scripts/checkpatch.pl | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 1b4b812..6c4fb42 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2584,6 +2584,11 @@ sub process {
>>  			ERROR("__func__ should be used instead of gcc specific __FUNCTION__\n"  . $herecurr);
>>  		}
>>  
>> +# recommend g_path_get_* over basename(3) and dirname(3)
>> +		if ($line =~ /\b(basename|dirname)\s*\(/) {
>> +			WARN("consider using g_path_get_$1 in preference to $1(3)\n" . $herecurr);
>> +		}
>> +
>>  # recommend qemu_strto* over strto* for numeric conversions
>>  		if ($line =~ /\b(strto[^kd].*?)\s*\(/) {
>>  			ERROR("consider using qemu_$1 in preference to $1\n" . $herecurr);
>>
> 
> Hi Julia, the patch is fine, but given Alex's objections let's warn only
> if you are doing g_strdup(basename(...)) or g_strdup(dirname(...)).
> 

Ok.

> (No other action is needed on your other patch).
> 
> Thanks!
> 
> Paolo
> 
