Received: from eggs.gnu.org ([2001:4830:134:3::10]:39172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1eJkEH-0002yv-Uz
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1eJkEC-0007vp-76
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:03:33 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:37562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1eJkEC-0007vY-1p
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:03:28 -0500
Received: by mail-ot0-x22f.google.com with SMTP id s4so666697ote.4
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 10:03:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <336152896.34452750.1511527207457.JavaMail.zimbra@redhat.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<86754966-281f-c3ed-938c-f009440de563@gmail.com>
	<CAPcyv4iH==cqVAdd8i1y-8A6SuXU75OH1EZzgNMvtA21wfxPpQ@mail.gmail.com>
	<ec5ff7c2-864e-5020-0aaa-6663e78e3756@gmail.com>
	<1511288389.1080.14.camel@redhat.com>
	<d1df875c-5b64-67d9-2b3c-4ec14c03b85b@gmail.com>
	<CAPcyv4ip6m6e9Bh7weJNB3m3kpDpRkhHDZf0JYyr5UbkD41oLg@mail.gmail.com>
	<654f8935-258e-22ef-fae4-3e14e91e8fae@redhat.com>
	<336152896.34452750.1511527207457.JavaMail.zimbra@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 28 Nov 2017 10:03:25 -0800
Message-ID: <CAPcyv4j6nk1cJFuG4DDA9JoNJe2d3rSskdFSUPu4aWzWX+JQeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Rik van Riel <riel@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>

On Fri, Nov 24, 2017 at 4:40 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
[..]
> 1] Expose vNVDIMM memory range to KVM guest.
>
>    - Add flag in ACPI NFIT table for this new memory type. Do we need NVDIMM spec
>      changes for this?

Not a flag, but a new "Address Range Type GUID". See section "5.2.25.2
System Physical Address (SPA) Range Structure" in the ACPI 6.2A
specification. Since it is a GUID we could define a Linux specific
type for this case, but spec changes would allow non-Linux hypervisors
to advertise a standard interface to guests.
