Received: from eggs.gnu.org ([2001:4830:134:3::10]:45003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1e2mRz-0003r2-SZ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1e2mRz-0006b1-19
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:59:35 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:47246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1e2mRy-0006al-Os
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:59:34 -0400
Received: by mail-oi0-x232.google.com with SMTP id h200so10877842oib.4
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 15:59:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1111804283.19946669.1507848765955.JavaMail.zimbra@redhat.com>
References: <20171012155027.3277-1-pagupta@redhat.com>
	<20171012155027.3277-3-pagupta@redhat.com>
	<CAPcyv4i7k6aYK_y4zZtL6p8sW-E_Ft58d2HuxO=dYciqQxaoLg@mail.gmail.com>
	<1567317495.19940236.1507843517318.JavaMail.zimbra@redhat.com>
	<CAPcyv4gkri7t+3Unf0sc9AHMnz-v9G_qV_bJppLjUUNAn7drrQ@mail.gmail.com>
	<1363955128.19944709.1507846719987.JavaMail.zimbra@redhat.com>
	<1507847249.21121.207.camel@redhat.com>
	<1111804283.19946669.1507848765955.JavaMail.zimbra@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Oct 2017 15:59:33 -0700
Message-ID: <CAPcyv4jukEoKpH0OvZSNour+m5eQzuhiPAefAhYPqH2=f_ungA@mail.gmail.com>
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
To: Pankaj Gupta <pagupta@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Nitesh Narayan Lal <nilal@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ross Zwisler <ross.zwisler@intel.com>, David Hildenbrand <david@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

On Thu, Oct 12, 2017 at 3:52 PM, Pankaj Gupta <pagupta@redhat.com> wrote:
> Dan,
>
> I have a query regarding below patch [*]. My assumption is its halted
> because of memory hotplug restructuring work? Anything I am missing
> here?
>
> [*] https://www.mail-archive.com/linux-nvdimm@lists.01.org/msg02978.html

It's fallen to the back of my queue since the original driving need of
platform firmware changing offsets from boot-to-boot is no longer an
issue. However, it does mean that you need to arrange for 128MB
aligned devm_memremap_pages() ranges for the foreseeable future.
