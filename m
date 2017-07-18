Received: from eggs.gnu.org ([2001:4830:134:3::10]:41317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dXTrV-00080x-AQ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dXTrR-0006nl-8W
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:52:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dXTrR-0006nM-19
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:52:29 -0400
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
	<1500028867-134709-35-git-send-email-borntraeger@de.ibm.com>
	<a0ad09dd-62aa-88f1-68b0-418199a1ae81@redhat.com>
	<58bdd968-0c2e-fbb7-1727-c2c894ca3af3@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <099e8efe-19be-ca96-b8b8-fff500cc4069@redhat.com>
Date: Tue, 18 Jul 2017 16:52:24 +0200
MIME-Version: 1.0
In-Reply-To: <58bdd968-0c2e-fbb7-1727-c2c894ca3af3@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 34/40] s390x/cpumodel: wire up new hardware
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 17.07.2017 20:14, Christian Borntraeger wrote:
> On 07/17/2017 07:30 PM, David Hildenbrand wrote:
>> On 14.07.2017 12:41, Christian Borntraeger wrote:
>>> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
>>>
>>> Some new guest features have been introduced recently. Let's wire
>>> them up in the CPU model.
>>>
>>> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> [split patch]
>>> ---
>>
>> Would it make sense to add further checks to check_consistency?
>>
>> I think e.g. vx extensions should rely on vx. I can't see a new PoP out
>> there, so I can't check.
> 
> Yes, the vx extensions depend on vx and it makes sense to have a dependeny for
> both extension.

Just realized that I missed these checks, they are already properly in
place :)


-- 

Thanks,

David
