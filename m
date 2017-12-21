Received: from eggs.gnu.org ([2001:4830:134:3::10]:36141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eS9qn-0006jx-5o
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eS9qm-0000lV-I1
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:02:05 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20171221223727-mutt-send-email-mst@kernel.org>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
	<1513866427-27125-16-git-send-email-mst@redhat.com>
	<20171221223727-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Dec 2017 20:02:03 -0300
Message-ID: <CAAdtpL4dudnESw9rN_5JHowS_gAxakb8GVikRgTrB1iOSupq3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 15/25] hw/block/nvme: QOM'ify PCI NVME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Hi Michael,

On Thu, Dec 21, 2017 at 5:38 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Dec 21, 2017 at 04:29:21PM +0200, Michael S. Tsirkin wrote:
>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> Dropped due to merge conflicts. Pls rebase and ask
> storage maintainers to apply as appropriate.

Ok, sorry about this.
Many patch queue during freezing in different trees lead to this.

However you must also drop the patch "hw/pci: remove obsolete
PCIDevice->init()" else the NVME device won't work.

Regards,

Phil.
