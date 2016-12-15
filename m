Received: from eggs.gnu.org ([2001:4830:134:3::10]:54063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cHYXx-0006Of-5J
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:06:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cHYXs-0000J8-8N
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:06:17 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <harrynjit@gmail.com>) id 1cHYXs-0000In-4j
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:06:12 -0500
Received: by mail-qk0-f195.google.com with SMTP id n204so7853859qke.2
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 08:06:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <63cae630-b193-0074-8aac-68fef47ec691@redhat.com>
References: <CA+scX6=9y4wDBWzXyqpGh9U__usKUa6sxwdc63iA8YRmpWFPqA@mail.gmail.com>
	<20161214193107.GB20648@stefanha-x1.localdomain>
	<CA+scX6=oc_eGteY8A0d8tuwzJFSu9M_6wnXBd5Tp=XGrg8FotQ@mail.gmail.com>
	<20161215080452.GE26169@stefanha-x1.localdomain>
	<63cae630-b193-0074-8aac-68fef47ec691@redhat.com>
From: Weiwei Jia <harrynjit@gmail.com>
Date: Thu, 15 Dec 2016 11:05:11 -0500
Message-ID: <CA+scX6nWaHnS2utf9qRVbm0a3v-79aBp98Ow_fs5m8kf5c=EGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Lock contention in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, famz@redhat.com

I will try it later on. Thank you.

Best,
Weiwei Jia

On Thu, Dec 15, 2016 at 7:13 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 15/12/2016 09:04, Stefan Hajnoczi wrote:
>>> Does this feature only work for VirtIO? Does it work for SCSI or IDE?
>> This only works for virtio-blk and virtio-scsi.  The virtio-scsi
>> dataplane support is more recent and I don't remember if it is complete.
>> I've CCed Fam and Paolo who worked on virtio-scsi dataplane.
>>
>> Now that you have mentioned that you aren't using virtio devices, there
>> is another source of lock contention that you will encounter.  I/O
>> request submission takes place in the vcpu thread when ioeventfd is not
>> used.  Only virtio uses ioeventfd so your current QEMU configuration is
>> unable to let the vcpu continue execution during I/O request submission.
>>
>> If you care about performance then using virtio devices is probably the
>> best choice.  Try comparing against virtio-scsi dataplane - you should
>> see a lot less jitter.
>
> Yes, virtio-scsi dataplane is complete.
>
> Paolo
>
