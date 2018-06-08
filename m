Received: from eggs.gnu.org ([2001:4830:134:3::10]:54528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRK23-0008Ig-EL
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRK22-0007pa-J9
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:14:31 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:40937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fRK22-0007pJ-EK
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:14:30 -0400
Received: by mail-ot0-x243.google.com with SMTP id w9-v6so10806163otj.7
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 09:14:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180608185714-mutt-send-email-mst@kernel.org>
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
	<20180607223111.27792-2-ross.zwisler@linux.intel.com>
	<20180608020724-mutt-send-email-mst@kernel.org>
	<5352d2fb-9244-78b0-4f4b-2818359a4425@redhat.com>
	<20180608153402.GA27156@linux.intel.com>
	<20180608185714-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Jun 2018 17:14:09 +0100
Message-ID: <CAFEAcA943cBfMbjBJcheTWAL+mWa4vu5uL62LvKXS4agd+ZRMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [qemu PATCH 2/5] acpi: "make check" should fail on
 asl mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On 8 June 2018 at 16:59, Michael S. Tsirkin <mst@redhat.com> wrote:
> The expected value tests are a debugging aid. They do not catch bugs and
> aren't designed to. In particular the comparisons do not even run if
> IASL isn't installed.

If they're not actually tests to catch bugs, maybe we shouldn't
be running them in "make check" ?

thanks
-- PMM
