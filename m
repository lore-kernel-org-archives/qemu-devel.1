Received: from eggs.gnu.org ([2001:4830:134:3::10]:40235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dugl9-0006Bq-Ay
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dugkr-0002A8-8b
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:17:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dugkq-00028q-Rs
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:17:37 -0400
References: <20170919142654.16369-1-david@redhat.com>
	<20170920171458.0f6d88a3.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b671b12b-daa6-13a8-d673-1641c243669b@redhat.com>
Date: Wed, 20 Sep 2017 17:17:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170920171458.0f6d88a3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Implement basic MSA functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 20.09.2017 17:14, Cornelia Huck wrote:
> On Tue, 19 Sep 2017 16:26:51 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Some leftover from "target/s390x: tcg improvments + MSA functions".
>>
>> Implement all basic MSA (cpacf/crypto) instructions <= z13. Only provide
>> the query subfunction (to query available subfunctions), no actual
>> de/encryption yet. Good enough to unlock the STFL bits.
>>
>> I have written kvm-unit-tests for MSA functions and for SPM/IPM. Will
>> send them out soon. I use the following cpu model to test with an upstream
>> kernel compiled for z10:
>>
>> ... -cpu qemu,mvcos=on,stfle=on,ldisp=on,ldisphp=on,\
>>               eimm=on,stckf=on,csst=on,csst2=on,ginste=on,\
>>               exrl=on,msa-base=on,msa3-base=on,msa4-base=on,msa5-base=on ...
>>
>> Based on: https://github.com/cohuck/qemu.git s390-next
>> Available on: https://github.com/davidhildenbrand/qemu.git s390x-msa
> 
> Do I understand correctly that you'll send a v3 with changes to patch 3?
> 
> If yes, I'll just wait and pick that.
> 

It is really just dropping one superfluous check in patch nr 3.

So you can either fix that up or I can resend, whatever you prefer.

-- 

Thanks,

David
