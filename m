Received: from eggs.gnu.org ([209.51.188.92]:58271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giy34-0001UK-Gt
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 03:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giy33-0006kz-OD
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 03:56:46 -0500
References: <20190111140857.4211-1-philmd@redhat.com>
	<20190111140857.4211-11-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3d52c4eb-1254-08e2-440c-3edb42c2ba01@redhat.com>
Date: Mon, 14 Jan 2019 09:56:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190111140857.4211-11-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/15] range: Remove Range from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

On 2019-01-11 15:08, Philippe Mathieu-Daud=C3=A9 wrote:
> Range is only used in "hw/pci-host/q35.h" in the MCHPCIState, and
> in "hw/pci/pci.h" by pci_bus_get_w64_range().  Let them include
> "qemu/range.h" directly to simplify "qemu/typedefs.h".
>=20
> To clean "qemu/typedefs.h", move the declaration to "qemu/range.h"
> (removing the forward declaration).

Since Range seems to be meant as a common type (i.e. not specific to any
device like the other typedefs that you move in this series), I think
it's should be OK if this resides in typedefs.h ?

 Thomas
