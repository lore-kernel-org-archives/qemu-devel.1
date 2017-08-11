Received: from eggs.gnu.org ([2001:4830:134:3::10]:49326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dgA5x-0002pH-4S
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dgA5t-00066Z-3j
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:35:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dgA5s-000666-Ti
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:35:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C759C69F13
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 13:35:15 +0000 (UTC)
References: <20170811131801.21763-1-cohuck@redhat.com>
	<20170811132953.GM2554@redhat.com>
	<20170811153411.26f02e53.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f81bcfec-a44e-ec53-843e-0686545727fa@redhat.com>
Date: Fri, 11 Aug 2017 15:35:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170811153411.26f02e53.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] boot-serial-test: fallback to kvm
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On 11/08/2017 15:34, Cornelia Huck wrote:
> On Fri, 11 Aug 2017 14:29:53 +0100
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
> 
>> On Fri, Aug 11, 2017 at 03:18:01PM +0200, Cornelia Huck wrote:
>>> Currently, at least x86_64 and s390x support building with --disable-tcg.
>>> Instead of forcing tcg (which causes the test to fail on such builds),
>>> allow to use kvm as well.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>
>>> v1->v2: switch around kvm and tcg
>>>
>>> Added Paolo on cc:; I can still take this through the s390x tree, though.
>>>
>>> ---
>>>  tests/boot-serial-test.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
>>> index 11f48b049c..78303b14ce 100644
>>> --- a/tests/boot-serial-test.c
>>> +++ b/tests/boot-serial-test.c
>>> @@ -78,7 +78,8 @@ static void test_machine(const void *data)
>>>      fd = mkstemp(tmpname);
>>>      g_assert(fd != -1);
>>>  
>>> -    args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
>>> +    args = g_strdup_printf("-M %s,accel=kvm:tcg "
>>> +                           "-chardev file,id=serial0,path=%s"
>>>                             " -no-shutdown -serial chardev:serial0 %s",
>>>                             test->machine, tmpname, test->extra);  
>>
>> Total nit-pick - the first line has a trailing ' ', while the second
>> line has no leading or trailing ' ', and the third line has a leading
>> ' '. The inconsistency bugs me - suggest using trailing ' ' in both
>> lines.
> 
> Yes, I prefer trailing ' ' as well, just did not want to touch more
> lines than necessary.

Go ahead and fix it + send the pull request yourself.

Paolo
