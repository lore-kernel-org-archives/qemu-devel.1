Received: from eggs.gnu.org ([2001:4830:134:3::10]:33310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1eaFDl-0000zH-S5
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 01:23:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1eaFDg-00042s-Ss
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 01:23:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1eaFDg-00041a-M1
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 01:23:08 -0500
Date: Sat, 13 Jan 2018 01:23:05 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <326660076.6160176.1515824585284.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4j6nk1cJFuG4DDA9JoNJe2d3rSskdFSUPu4aWzWX+JQeQ@mail.gmail.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<ec5ff7c2-864e-5020-0aaa-6663e78e3756@gmail.com>
	<1511288389.1080.14.camel@redhat.com>
	<d1df875c-5b64-67d9-2b3c-4ec14c03b85b@gmail.com>
	<CAPcyv4ip6m6e9Bh7weJNB3m3kpDpRkhHDZf0JYyr5UbkD41oLg@mail.gmail.com>
	<654f8935-258e-22ef-fae4-3e14e91e8fae@redhat.com>
	<336152896.34452750.1511527207457.JavaMail.zimbra@redhat.com>
	<CAPcyv4j6nk1cJFuG4DDA9JoNJe2d3rSskdFSUPu4aWzWX+JQeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Dan Williams <dan.j.williams@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Rik van Riel <riel@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>


Hello Dan,

> Not a flag, but a new "Address Range Type GUID". See section "5.2.25.2
> System Physical Address (SPA) Range Structure" in the ACPI 6.2A
> specification. Since it is a GUID we could define a Linux specific
> type for this case, but spec changes would allow non-Linux hypervisors
> to advertise a standard interface to guests.
> 

I have added new SPA with a GUUID for this memory type and I could add 
this new memory type in System memory map. I need help with the namespace
handling for this new type As mentioned in [1] discussion:

- Create a new namespace for this new memory type
- Teach libnvdimm how to handle this new namespace 

I have some queries on this:

1] How namespace handling of this new memory type would be?
  
2] There are existing namespace types: 
  ND_DEVICE_NAMESPACE_IO, ND_DEVICE_NAMESPACE_PMEM, ND_DEVICE_NAMESPACE_BLK

  How libnvdimm will handle this new name-space type in conjuction with existing
  memory type, region & namespaces?  

3] For sending guest to host flush commands we still have to think about some 
   async way?
    
[1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg08404.html 

Thanks,
Pankaj
