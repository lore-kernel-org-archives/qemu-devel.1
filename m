Received: from eggs.gnu.org ([209.51.188.92]:60204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gj6q4-0007HT-5m
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:19:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gj6dV-0007q0-Gp
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:06:59 -0500
Date: Mon, 14 Jan 2019 13:06:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114130617-mutt-send-email-mst@kernel.org>
References: <20190114130829.21790-1-philmd@redhat.com>
	<20190114130829.21790-2-philmd@redhat.com>
	<20190114104559-mutt-send-email-mst@kernel.org>
	<c7323df9-a2c0-80f9-d9ba-065279ff6126@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c7323df9-a2c0-80f9-d9ba-065279ff6126@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] hw/nvram/fw_cfg: Remove various
 typedefs from "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Ben Warren <ben@skyportsystems.com>, "open list:Virt" <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Mon, Jan 14, 2019 at 06:52:21PM +0100, Paolo Bonzini wrote:
> On 14/01/19 16:49, Michael S. Tsirkin wrote:
> > On Mon, Jan 14, 2019 at 02:08:27PM +0100, Philippe Mathieu-Daud=E9 wr=
ote:
> >> There are only three include files requiring these typedefs, let the=
m
> >> include "hw/nvram/fw_cfg.h" directly to simplify "qemu/typedefs.h".
> >>
> >> To clean "qemu/typedefs.h", move the declarations to "hw/nvram/fw_cf=
g.h".
> >> Reorder two function declarations to avoid forward typedef declarati=
ons.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> >> ---
> >>  include/hw/acpi/vmgenid.h |  1 +
> >>  include/hw/arm/virt.h     |  1 +
> >>  include/hw/mem/nvdimm.h   |  1 +
> >>  include/hw/nvram/fw_cfg.h | 22 ++++++++++++----------
> >>  include/qemu/typedefs.h   |  4 ----
> >>  5 files changed, 15 insertions(+), 14 deletions(-)
> >=20
> > I am sorry I don't understand what this patchset is about.
> > Supposed to be a cleanup but instead it pulls
> > fw cfg into any user of unrelated headers.
> >=20
> > More lines of code slower builds what's to like?
> >=20
> > Shared typedefs is what typedefs.h is about.
> > These are clearly shared so let's keep it simple.
>=20
> I can see why this patch can be a bit controversial.  Personally I thin=
k
> it's okay either way (which generally tends to favor the status quo).
>=20
> Paolo

True - not something to lose sleep over.

--=20
MST
