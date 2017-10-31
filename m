Received: from eggs.gnu.org ([2001:4830:134:3::10]:48497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiaoguangrong.eric@gmail.com>) id 1e9Qjt-0001WT-OG
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 03:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiaoguangrong.eric@gmail.com>) id 1e9Qjo-0003mR-NV
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 03:13:33 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:43566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <xiaoguangrong.eric@gmail.com>)
	id 1e9Qjo-0003ko-HQ
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 03:13:28 -0400
Received: by mail-pg0-x243.google.com with SMTP id s75so13901089pgs.0
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 00:13:28 -0700 (PDT)
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<CAPcyv4hpbk0jgp+mA=q05zVBV8ZSZvCvV68JJ4gjE3QhK70d1w@mail.gmail.com>
	<20170724102330.GE652@quack2.suse.cz>
	<1157879323.33809400.1500897967669.JavaMail.zimbra@redhat.com>
	<20170724123752.GN652@quack2.suse.cz>
	<1888117852.34216619.1500992835767.JavaMail.zimbra@redhat.com>
	<CAPcyv4in28F3FOVKp9abvrggxPuXdbGynF5=ZvBXCrywoa06JA@mail.gmail.com>
	<1501016375.26846.21.camel@redhat.com>
	<1063764405.34607875.1501076841865.JavaMail.zimbra@redhat.com>
	<1501104453.26846.45.camel@redhat.com>
	<CAPcyv4hsqrqBxoipUHPAbSctuzbVWCRnT-gN08i9uhXTWY6iPQ@mail.gmail.com>
	<1501112787.4073.49.camel@redhat.com>
	<CAPcyv4gbC6Hx_4YsCfOd2t=fn=wPGp5h__1QH=-p40TPFNbFzA@mail.gmail.com>
From: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Message-ID: <0a26793f-86f7-29e7-f61b-dc4c1ef08c8e@gmail.com>
Date: Tue, 31 Oct 2017 15:13:44 +0800
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gbC6Hx_4YsCfOd2t=fn=wPGp5h__1QH=-p40TPFNbFzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Dan Williams <dan.j.williams@intel.com>, Rik van Riel <riel@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>



On 07/27/2017 08:54 AM, Dan Williams wrote:

>> At that point, would it make sense to expose these special
>> virtio-pmem areas to the guest in a slightly different way,
>> so the regions that need virtio flushing are not bound by
>> the regular driver, and the regular driver can continue to
>> work for memory regions that are backed by actual pmem in
>> the host?
> 
> Hmm, yes that could be feasible especially if it uses the ACPI NFIT
> mechanism. It would basically involve defining a new SPA (System
> Phyiscal Address) range GUID type, and then teaching libnvdimm to
> treat that as a new pmem device type.

I would prefer a new flush mechanism to a new memory type introduced
to NFIT, e.g, in that mechanism we can define request queues and
completion queues and any other features to make virtualization
friendly. That would be much simpler.
