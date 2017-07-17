Received: from eggs.gnu.org ([2001:4830:134:3::10]:52438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXAW3-0002Bm-7t
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXAVz-0003bi-Te
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:13:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dXAVz-0003bC-Jg
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:13:03 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6HI9E6q061127
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 14:13:01 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2brr0g4eqj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 14:13:01 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 17 Jul 2017 12:13:00 -0600
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
	<1500028867-134709-33-git-send-email-borntraeger@de.ibm.com>
	<7c021c65-3824-3c87-2bc6-c8045da1513a@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 17 Jul 2017 20:12:54 +0200
MIME-Version: 1.0
In-Reply-To: <7c021c65-3824-3c87-2bc6-c8045da1513a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <72ab0789-292f-4e7b-16c5-6a44956c83d8@de.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 07/17/2017 07:23 PM, David Hildenbrand wrote:
> 
>> +    /* Try to enable AIS facility */
>> +    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
>> +
>>      qemu_mutex_init(&qemu_sigp_mutex);
>>  
>>      return 0;
>> @@ -2635,6 +2638,10 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>>          set_bit(S390_FEAT_CMM, model->features);
>>      }
>>  
>> +    /* set zpci and aen facilities */
> 
> This comment is not helpful. This should rather say something like "we
> emulate a zPCI bus in QEMU, therefore we don't depend on the host
> capabilities"

Yes, you are right, that seems better. Can you send a patch? 
> 
>> +    set_bit(S390_FEAT_ZPCI, model->features);
>> +    set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
>> +
>>      if (s390_known_cpu_type(cpu_type)) {
>>          /* we want the exact model, even if some features are missing */
>>          model->def = s390_find_cpu_def(cpu_type, ibc_gen(unblocked_ibc),
>>
> 
