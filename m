Received: from eggs.gnu.org ([209.51.188.92]:34460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hCi2Z-0007ij-LX
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 05:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hChzo-0001wC-Sk
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 05:52:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hChzk-0001rq-QK
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 05:52:18 -0400
References: <20190405184037.16799-1-dgilbert@redhat.com>
	<29aaecc0-8dff-9506-6d1b-88e80d121437@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5803ee45-4f00-49a0-90e1-aac6cb506b14@redhat.com>
Date: Sat, 6 Apr 2019 11:52:07 +0200
MIME-Version: 1.0
In-Reply-To: <29aaecc0-8dff-9506-6d1b-88e80d121437@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] test qgraph.c: Fix segs due to out of
 scope default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, e.emanuelegiuseppe@gmail.com

On 05/04/2019 23.16, Paolo Bonzini wrote:
> On 05/04/19 20:40, Dr. David Alan Gilbert (git) wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> The test uses the trick:
>>    if (!opts) {
>>      opts = &(QOSGraph...Options) { };
>>    }
>>
>>   in a couple of places, however the temporary created
>> by the &() {}  goes out of scope at the bottom of the if,
>> and results in a seg or assert when opts-> fields are
>> used (on fedora 30's gcc 9).
>>
>> Fixes: fc281c802022cb3a73a5
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Thomas, can you pick this up?

Sure, queued it to my qtest-next branch now:

 https://gitlab.com/huth/qemu/tree/qtest-next

I'll send a PULL request on Monday.

 Thomas
