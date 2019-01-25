Received: from eggs.gnu.org ([209.51.188.92]:39510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gn3Kp-0004Mf-67
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gn3Kn-0003bL-C9
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:23:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gn3Kl-0003aW-FR
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:23:57 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-14-git-send-email-pbonzini@redhat.com>
	<33fa5dfc-23a4-aa40-1644-c5579870655f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f26b2c61-702c-75a7-ced5-d21485e43521@redhat.com>
Date: Fri, 25 Jan 2019 16:23:47 +0100
MIME-Version: 1.0
In-Reply-To: <33fa5dfc-23a4-aa40-1644-c5579870655f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/52] hw/s390/Makefile.objs: Create new
 CONFIG_* variables for s390x boards and devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com

On 25/01/19 16:17, Thomas Huth wrote:
>> +ifeq ($(CONFIG_S390_CCW_VIRTIO),y)
>>  obj-y += s390-virtio-hcall.o
>>  obj-y += sclp.o
>>  obj-y += event-facility.o
>> @@ -33,3 +34,4 @@ obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
>>  obj-y += s390-ccw.o
>>  obj-y += ap-device.o
>>  obj-y += ap-bridge.o
>> +endif
> That won't really work, a lot of code in target/s390x still depends on
> the functions in these files here. I suggest to just disable the file
> that defines the machine initially, i.e.:
> 
> obj-$(CONFIG_S390_CCW_VIRTIO) += s390-virtio-ccw.o
> 
> We can still fine-tune this later.

Ok, I'll leave this and the other changes you suggest to Yang for v6. :)

Paolo
