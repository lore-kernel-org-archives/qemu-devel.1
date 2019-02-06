Received: from eggs.gnu.org ([209.51.188.92]:39115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1grKTW-0006Wc-6b
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1grKTV-0000lk-C0
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:30:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1grKTV-0000lP-6E
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:30:37 -0500
Date: Wed, 6 Feb 2019 11:30:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190206113013.76ec80ff@Igors-MacBook-Pro.local>
In-Reply-To: <a4df9aeb-d82d-8b76-deac-e9faad9c02bf@redhat.com>
References: <20190204160325.4914-1-lersek@redhat.com>
	<20190205160741.44d516d4@Igors-MacBook-Pro.local>
	<a4df9aeb-d82d-8b76-deac-e9faad9c02bf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] add the BiosTablesTest UEFI app,
 build it with the new roms/edk2 submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

On Tue, 5 Feb 2019 16:19:50 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 02/05/19 16:07, Igor Mammedov wrote:
> > On Mon,  4 Feb 2019 17:03:20 +0100
> > Laszlo Ersek <lersek@redhat.com> wrote:
> > 
> > Am I to greedy to ask for prebuilt AVMF image in QEMU repo on top of
> > this App (while you still remember all Makefile magic foo) so test won't
> > have to fish out distro provided firmware or skip testing if firmware
> > is not available?
> > 
> 
> No, not too greedy :) I think that's a reasonable idea; we intended
> bundling "reasonably-built" edk2 firmware binaries with QEMU anyway.
Thanks, I'll postpone ARM's acpi tests respin till we have AVMF blobs
in QEMU tree.

> can work on that once this series is merged. (I wouldn't like to work on
> these assignments simultaneously.)
I think series is practically ready to be merged
(I can live without out of tree builds for blobs that's hardly ever would be rebuilt),
Michael do you concur?

> 
> Thanks,
> Laszlo
