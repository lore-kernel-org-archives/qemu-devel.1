Received: from eggs.gnu.org ([2001:4830:134:3::10]:55103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRK4K-00023L-1z
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRK4J-0000Bm-90
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:16:52 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fRK4J-0000Be-3o
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:16:51 -0400
Received: by mail-oi0-x243.google.com with SMTP id d5-v6so12315228oib.5
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 09:16:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180608190040-mutt-send-email-mst@kernel.org>
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
	<20180607223111.27792-2-ross.zwisler@linux.intel.com>
	<20180608020724-mutt-send-email-mst@kernel.org>
	<5352d2fb-9244-78b0-4f4b-2818359a4425@redhat.com>
	<20180608190040-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Jun 2018 17:16:30 +0100
Message-ID: <CAFEAcA-h3xxeRFO32pnqrwR_wZ1=us-t0FunS2aJRpQV==3-GQ@mail.gmail.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>

On 8 June 2018 at 17:03, Michael S. Tsirkin <mst@redhat.com> wrote:
> Pull requests are somewhat different, they are usually tested for lack
> of warnings. This change didn't arrive as a result of a pull request
> maybe that's why it slipped through the cracks. Peter?
>
> Maybe we need a "pedantic" flag to fail on any warnings, or just catch
> output to stderr.

If there's a situation that shouldn't exist in the tree (ie
a bug), then make check should catch it, and result in a
failure, not just printing random stuff to stderr. Otherwise
I'm not going to notice it, whether I'm applying a pull request
or an individual patch.

thanks
-- PMM
