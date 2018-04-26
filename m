Received: from eggs.gnu.org ([2001:4830:134:3::10]:37259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jmoyer@redhat.com>) id 1fBkdN-0000hp-GS
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jmoyer@redhat.com>) id 1fBkdK-0002ci-7U
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:24:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44060 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jmoyer@redhat.com>) id 1fBkdK-0002cL-3D
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:24:38 -0400
From: Jeff Moyer <jmoyer@redhat.com>
References: <20180425112415.12327-1-pagupta@redhat.com>
	<20180425112415.12327-2-pagupta@redhat.com>
	<CAPcyv4hvrB08XPTbVK0xT2_1Xmaid=-v3OMxJVDTNwQucsOHLA@mail.gmail.com>
	<CAPcyv4hiowWozV527sQA_e4fdgCYbD6xfG==vepAqu0hxQEQcw@mail.gmail.com>
	<x49o9i6885e.fsf@segfault.boston.devel.redhat.com>
	<1499190564.23017177.1524762938762.JavaMail.zimbra@redhat.com>
Date: Thu, 26 Apr 2018 13:24:17 -0400
In-Reply-To: <1499190564.23017177.1524762938762.JavaMail.zimbra@redhat.com>
	(Pankaj Gupta's message of "Thu, 26 Apr 2018 13:15:38 -0400 (EDT)")
Message-ID: <x49in8d6fum.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v2 1/2] virtio: add pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Ross Zwisler <ross.zwisler@intel.com>, Qemu Developers <qemu-devel@nongnu.org>, lcapitulino@redhat.com, Linux MM <linux-mm@kvack.org>, niteshnarayanlal@hotmail.com, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Marcel Apfelbaum <marcel@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Rik van Riel <riel@surriel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Igor Mammedov <imammedo@redhat.com>

Pankaj Gupta <pagupta@redhat.com> writes:

>> Ideally, qemu (seabios?) would advertise a platform capabilities
>> sub-table that doesn't fill in the flush bits.
>
> Could you please elaborate on this, how its related to disabling
> MAP_SYNC? We are not doing entire nvdimm device emulation. 

My mistake.  If you're not providing an NFIT, then you can ignore this
comment.  I'll have a closer look at your patches next week.

-Jeff
