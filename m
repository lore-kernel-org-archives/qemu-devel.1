Received: from eggs.gnu.org ([2001:4830:134:3::10]:42147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eIDuG-0005gk-86
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eIDuB-00059B-Ej
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:20:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eIDuB-000593-8w
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:20:31 -0500
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<ec5ff7c2-864e-5020-0aaa-6663e78e3756@gmail.com>
	<1511288389.1080.14.camel@redhat.com>
	<d1df875c-5b64-67d9-2b3c-4ec14c03b85b@gmail.com>
	<CAPcyv4ip6m6e9Bh7weJNB3m3kpDpRkhHDZf0JYyr5UbkD41oLg@mail.gmail.com>
	<654f8935-258e-22ef-fae4-3e14e91e8fae@redhat.com>
	<336152896.34452750.1511527207457.JavaMail.zimbra@redhat.com>
	<d5bcb61c-1f7c-faa7-f19b-a8f02f505b4a@redhat.com>
	<919538865.34455774.1511528573448.JavaMail.zimbra@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9357a268-3801-367e-0aaa-a01163ea0cbc@redhat.com>
Date: Fri, 24 Nov 2017 14:20:22 +0100
MIME-Version: 1.0
In-Reply-To: <919538865.34455774.1511528573448.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>, Christoph Hellwig <hch@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Rik van Riel <riel@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Jan Kara <jack@suse.cz>, kvm-devel <kvm@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, Ross Zwisler <ross.zwisler@intel.com>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, ross zwisler <ross.zwisler@linux.intel.com>, Nitesh Narayan Lal <nilal@redhat.com>

On 24/11/2017 14:02, Pankaj Gupta wrote:
> 
>>>    - Suggestion by Paolo & Stefan(previously) to use virtio-blk makes sense
>>>    if just
>>>      want a flush vehicle to send guest commands to host and get reply
>>>      after asynchronous
>>>      execution. There was previous discussion [1] with Rik & Dan on this.
>>>
>>>     [1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg08373.html
>>
>> ... in fact, the virtio-blk device _could_ actually accept regular I/O
>> too.  That would make it easier to boot from pmem.  Is there anything
>> similar in regular hardware?
> 
> there is existing block device associated(hard bind) with the pmem range.
> Also, comment by Christoph [1], about removing block device with DAX support.
> Still I am not clear about this. Am I missing anything here?

The I/O part of the blk device would only be used by the firmware.  In
Linux, the different device id would bind the device to a different
driver that would only be used for flushing.

But maybe this idea makes no sense. :)

Paolo
