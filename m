Received: from eggs.gnu.org ([2001:4830:134:3::10]:39813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dXToH-00054s-MR
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dXToG-0004R7-Sa
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:49:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dXToG-0004Qo-Ld
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:49:12 -0400
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
	<1500028867-134709-33-git-send-email-borntraeger@de.ibm.com>
	<7c021c65-3824-3c87-2bc6-c8045da1513a@redhat.com>
	<72ab0789-292f-4e7b-16c5-6a44956c83d8@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <92ad75f6-a9d4-6315-103d-892031318e71@redhat.com>
Date: Tue, 18 Jul 2017 16:49:06 +0200
MIME-Version: 1.0
In-Reply-To: <72ab0789-292f-4e7b-16c5-6a44956c83d8@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 32/40] s390x/cpumodel: add zpci,
 aen and ais facilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 17.07.2017 20:12, Christian Borntraeger wrote:
> On 07/17/2017 07:23 PM, David Hildenbrand wrote:
>>
>>> +    /* Try to enable AIS facility */
>>> +    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
>>> +
>>>      qemu_mutex_init(&qemu_sigp_mutex);
>>>  
>>>      return 0;
>>> @@ -2635,6 +2638,10 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>>>          set_bit(S390_FEAT_CMM, model->features);
>>>      }
>>>  
>>> +    /* set zpci and aen facilities */
>>
>> This comment is not helpful. This should rather say something like "we
>> emulate a zPCI bus in QEMU, therefore we don't depend on the host
>> capabilities"
> 
> Yes, you are right, that seems better. Can you send a patch? 

Yes, will do.

-- 

Thanks,

David
