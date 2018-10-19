Received: from eggs.gnu.org ([2001:4830:134:3::10]:46563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDT9o-0000e7-8E
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDT9W-0001bL-7f
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:41:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDT9V-0001Om-TQ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:41:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so37076335wrt.10
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 04:41:09 -0700 (PDT)
References: <20180321153124.5357-1-berrange@redhat.com>
	<20181019112554.GA19770@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7e8b7f73-b074-b96b-246f-684978d699e6@redhat.com>
Date: Fri, 19 Oct 2018 13:41:06 +0200
MIME-Version: 1.0
In-Reply-To: <20181019112554.GA19770@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] block: drop moderated sheepdog mailing
 list from MAINTAINERS file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Paolo Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Liu Yuan <namei.unix@gmail.com>

On 19/10/2018 13:25, Daniel P. Berrangé wrote:
> Paolo, I think this is a patch for your misc patches queue.

It looks to me than this is more block/trivial than the busy misc queue.

> 
> On Wed, Mar 21, 2018 at 03:31:24PM +0000, Daniel P. Berrangé wrote:
>> The sheepdog mailing list is setup to stop and queue messages from
>> non-subscribers, pending moderator approval. Unfortunately it seems
>> that the moderation queue is not actively dealt with. Even when messages
>> are approved, the sender is never added to the whitelist, so every
>> future mail the same sender continues to get stopped for moderation.
>>
>> MAINTAINERS entries should be responsive and not uneccessarily block
>> mails from QEMU contributors, so drop the sheepdog mailing list.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>  MAINTAINERS | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 354a18ce49..7eea869dcd 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1871,7 +1871,6 @@ M: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
>>  M: Liu Yuan <namei.unix@gmail.com>
>>  M: Jeff Cody <jcody@redhat.com>
>>  L: qemu-block@nongnu.org
>> -L: sheepdog@lists.wpkg.org
>>  S: Supported
>>  F: block/sheepdog.c
>>  T: git git://github.com/codyprime/qemu-kvm-jtc.git block
>> -- 
>> 2.14.3
>>
> 
> Regards,
> Daniel
> 
