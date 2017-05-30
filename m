Received: from eggs.gnu.org ([2001:4830:134:3::10]:52028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFg5J-0007pu-IO
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFg5G-0004xE-D5
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:17:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dFg5G-0004wM-7A
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:17:10 -0400
References: <20170526023213.18741-1-haozhong.zhang@intel.com>
	<20170526023213.18741-2-haozhong.zhang@intel.com>
	<CAJ+F1C+9o_vv4m7q47gPiaUjmQy7ag_J5ZKaHA9oagxZG2Q5Cg@mail.gmail.com>
	<20170526065132.ayapfebbft5lyigd@hz-desktop>
	<CAJ+F1CLDp7O93TRh2XcGQXXM_ZESiku0jDkcgzYUWAkP01wG9g@mail.gmail.com>
	<20170526071654.kxcqflvpo2tvcrvu@hz-desktop>
	<CAPcyv4hbf0RrjK5t5eN2Cs271JJUEYuiDNZqvso8g7QG4m4hDw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dcee001b-755c-1a88-234b-0ca663958584@redhat.com>
Date: Tue, 30 May 2017 14:17:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hbf0RrjK5t5eN2Cs271JJUEYuiDNZqvso8g7QG4m4hDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RESEND PATCH 2/2] hostmem-file: add an attribute
 'align' to set its alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>



On 26/05/2017 16:24, Dan Williams wrote:
>> For DAX device only, QEMU can figure out the proper alignment by
>> itself. However, I'm not sure whether there are other non-DAX cases
>> requiring non-default alignment, so I think it's better to just add an
>> interface (i.e. align attribute) in QEMU and let other management
>> tools (e.g. libvirt?) fill a proper value.
> I can't imagine any cases where you would want to specify an
> alignment. If it's regular file mmap any alignment is fine, and if
> it's device-dax only the configured alignment of the device instance
> is allowed. So, I don't think this should be a configurable option,
> just read it from the device instance and you're done.

A 2M or 1G alignment lets KVM use EPT hugepages if the host physical
addresses are contiguous and 2M- or 1G-aligned.

QEMU only does this for hugetlbfs currently, where the requirement on
the host physical addresses is always satisfied.  Would the same apply
to NVDIMM device DAX?

Thanks,

Paolo
