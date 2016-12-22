Received: from eggs.gnu.org ([2001:4830:134:3::10]:51014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cK9R9-00072u-Gf
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 14:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cK9R8-00015c-DM
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 14:53:59 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <harrynjit@gmail.com>) id 1cK9R8-00015M-8Q
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 14:53:58 -0500
Received: by mail-qt0-x243.google.com with SMTP id 41so3028173qtn.0
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 11:53:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161222093015.GI965@redhat.com>
References: <CA+scX6=rRiGHsOj8oxjTe4KqEF7S_GUao3k=TUQeE7FpyT_K8w@mail.gmail.com>
	<20161222093015.GI965@redhat.com>
From: Weiwei Jia <harrynjit@gmail.com>
Date: Thu, 22 Dec 2016 14:53:56 -0500
Message-ID: <CA+scX6msC1t4T0YATV8A4tRrCAcJ9Bss37OnZRbAD-rp2-OJBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [libvirt] Performance about x-data-plane
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, libvir-list@redhat.com, qemu-devel@nongnu.org

On Thu, Dec 22, 2016 at 4:30 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Thu, Dec 22, 2016 at 01:34:47AM -0500, Weiwei Jia wrote:
>> Hi,
>>
>> With QEMU x-data-plane, I find the performance has not been improved
>> very much. Please see following two settings.
>>
>> Setting 1: I/O thread in host OS (VMM) reads 4KB each time from disk
>> (8GB in total). Pin the I/O thread to pCPU 5 which will serve I/O
>> thread dedicatedly. I find the performance is around 250 MB/s.
>>
>> Setting 2: I/O thread in guest OS (VMM) reads 4KB each time from
>> virtual disk (8GB in total). Pin the I/O thread to vCPU 5 and pin vCPU
>> 5 thread to pCPU5 so that vCPU 5 handles this I/O thread dedicatedly
>> and pCPU5 serve vCPU5 dedicatedly. In order to keep vCPU5 not to be
>> idle, I also pin one cpu intensive thread (while (1) {i++}) on vCPU 5
>> so that the I/O thread on it can be served without delay. For this
>> setting, I find the performance for this I/O thread is around 190
>> MB/s.
>>
>> NOTE: For setting 2, I also pin the QEMU dedicated IOthread
>> (x-data-plane) in host OS to pCPU to handle I/O requests from guest OS
>> dedicatedly.
>>
>> I think for setting 2, the performance of I/O thread should be almost
>> the same as setting 1. I cannot understand why it is 60 MB/s lower
>> than setting 1. I am wondering whether there are something wrong with
>> my x-data-plane setting or virtio setting for VM.  Would you please
>> give me some hints? Thank you.
>
> The x-data-plane option is obsolete and should not be used. You should
> use the modern iothread option instead, which is explicitly supported
> by libvirt XML.
>
> http://libvirt.org/formatdomain.html#elementsIOThreadsAllocation

Thanks for your reply. However, I think this is not the main points of
my question. Let me see whether Stefan has some comments. Thank you.


Best,
Weiwei Jia
