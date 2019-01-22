Received: from eggs.gnu.org ([209.51.188.92]:45028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1gm1nj-0007fO-TB
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1gm1g0-0004PE-5H
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:25:37 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1gm1fp-0003la-Se
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:25:30 -0500
Received: by mail-ot1-x341.google.com with SMTP id w25so24685328otm.13
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:25:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547624239.git.yi.z.zhang@linux.intel.com>
	<64bea1ff5f80647cc4592ee94d399d647bdd9862.1547624239.git.yi.z.zhang@linux.intel.com>
	<20190116104105-mutt-send-email-mst@kernel.org>
	<20190118181147.GJ4136@habkost.net>
	<20190121051535.GA21562@tiger-server>
	<20190121144400.GM4136@habkost.net>
	<20190122032124.GA30317@tiger-server>
	<20190121222305-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190121222305-mutt-send-email-mst@kernel.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 22 Jan 2019 09:33:37 -0800
Message-ID: <CAPcyv4iMO1jxKakMOvePUwPx3GuLDSRf=H2HoqenPP-wGV+n_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V9 4/6] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, yu.c.zhang@linux.intel.com, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

On Mon, Jan 21, 2019 at 7:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
[..]
> > 2. The reset of cases:
> >       - we will never pass the MAP_SYNC to mmap2
>
> I don't see code probing for MAP_SYNC support. Did I miss it?
> But if all you want is to have old linux ignore MAP_SYNC,
> I think you got your wish automatically - just do not set
> MAP_SHARED_VALIDATE.

That will also cause new Linux to ignore MAP_SYNC.
