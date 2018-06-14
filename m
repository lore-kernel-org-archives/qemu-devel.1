Received: from eggs.gnu.org ([2001:4830:134:3::10]:39314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fTNgX-0006zk-Fq
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fTNgW-0000eO-QX
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:32:49 -0400
References: <20180613084149.14523-1-kraxel@redhat.com>
	<20180613084149.14523-4-kraxel@redhat.com>
	<20180613135047.5c1ce227@w520.home>
	<20180613223625.lf6xkzgipzkfslit@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c259c930-6082-cb2b-5adf-d8f6c9de7100@redhat.com>
Date: Thu, 14 Jun 2018 10:32:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180613223625.lf6xkzgipzkfslit@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/3] hw/vfio/display: add ramfb support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com, Erik Skultety <eskultet@redhat.com>, Laine Stump <laine@redhat.com>

On 06/14/18 00:36, Gerd Hoffmann wrote:
> On Wed, Jun 13, 2018 at 01:50:47PM -0600, Alex Williamson wrote:

>> I suppose in the UEFI case runtime services can be used to continue
>> writing this display,
> 
> Yes.

Small clarification for the wording -- "UEFI runtime services" do not
include anything display- or graphics-related. Instead, the OS kernel
may inherit the framebuffer properties (base address, size, pixel
format), and continue accessing the framebuffer directly.

Thanks
Laszlo
