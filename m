Received: from eggs.gnu.org ([2001:4830:134:3::10]:55059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1e31qh-0005tE-Mn
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 11:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1e31qe-0000dS-Ha
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 11:26:05 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:52929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1e31qe-0000cT-9W
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 11:26:04 -0400
Received: by mail-oi0-x235.google.com with SMTP id c202so14687026oih.9
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 08:26:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171013094431.GA27308@stefanha-x1.localdomain>
References: <20171012155027.3277-1-pagupta@redhat.com>
	<20171012155027.3277-3-pagupta@redhat.com>
	<20171013094431.GA27308@stefanha-x1.localdomain>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 13 Oct 2017 08:25:59 -0700
Message-ID: <CAPcyv4itKNqVbisM7aAZKZ02QRwfvy9XBHZYWTjqJqcGEZVguw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 2/2] KVM: add virtio-pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Rik van Riel <riel@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Nitesh Narayan Lal <nilal@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Zwisler, Ross" <ross.zwisler@intel.com>, David Hildenbrand <david@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

On Fri, Oct 13, 2017 at 2:44 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Thu, Oct 12, 2017 at 09:20:26PM +0530, Pankaj Gupta wrote:
[..]
>> +#ifndef REQ_FLUSH
>> +#define REQ_FLUSH REQ_PREFLUSH
>> +#endif
>
> Is this out-of-tree kernel module compatibility stuff that can be
> removed?

Yes, this was copied from the pmem driver where it can also be
removed, it was used to workaround a merge order problem in linux-next
when these definitions were changed several kernel releases back.
