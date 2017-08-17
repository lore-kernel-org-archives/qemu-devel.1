Received: from eggs.gnu.org ([2001:4830:134:3::10]:54150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diLGC-0003CN-Ug
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diLG8-0001XS-43
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:54:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46763)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diLG7-0001XJ-TR
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:54:52 -0400
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-4-git-send-email-thuth@redhat.com>
	<20170817105305.3d845d40.cohuck@redhat.com>
	<af1e5e37-9f68-4824-dd88-49658013a448@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a2c2e0e2-8571-c098-83b5-a3bd060057e9@redhat.com>
Date: Thu, 17 Aug 2017 15:54:38 +0200
MIME-Version: 1.0
In-Reply-To: <af1e5e37-9f68-4824-dd88-49658013a448@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] tests: Enable the drive_del test also
 on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

On 17.08.2017 11:46, David Hildenbrand wrote:
> On 17.08.2017 10:53, Cornelia Huck wrote:
>> On Thu, 17 Aug 2017 08:25:10 +0200
>> Thomas Huth <thuth@redhat.com> wrote:
>>
>>> By using the "virtio-xxx" device name aliases instead of the
>>> "virtio-xxx-pci" names, we can use this test on s390x, too,
>>> to check that adding and deleting also works fine with the
>>> virtio-ccw bus.
>>
>> I don't think we should leak the aliasing stuff into tests, but rather
>> specify the transport on a per-architecture basis explicitly. (We might
>> want to test virtio-pci on s390x in the future as well -- in addition
>> to virtio-ccw, not replacing it.)
> 
> I also remember that using virtio aliases should be avoided (e.g. we are
> not supposed to introduce new ones)

Hmm, maybe the right way is to use virtio-xxx-device and hook it up to
the preferred virtio bus of the current architecture? ... I'll ponder
about that a little bit ...

>>
>> Also, the same question as for the previous patch: Is this supposed to
>> test virtio explicitly, or do we just want a reasonable device?

I think this just needs a reasonable device - but since we've got the
same problem with the virtio tests later in this series again, it's
maybe best to fix this here in the same way, I guess.

 Thomas
