Received: from eggs.gnu.org ([2001:4830:134:3::10]:38094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7cHJ-0004rI-7x
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 04:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7cHF-0003M5-Tv
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 04:13:05 -0400
MIME-Version: 1.0
References: <20181002215315.16851-1-f4bug@amsat.org>
	<a6d996ce-0ff6-7ff3-f54a-1be747061ff9@kaod.org>
In-Reply-To: <a6d996ce-0ff6-7ff3-f54a-1be747061ff9@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 3 Oct 2018 10:12:49 +0200
Message-ID: <CAAdtpL7oyoGRn1Cx8SZ8r=Nx0sC-wyWQUfZV+kf3q0=wqE5KBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/pci-host/ppce500: Use
 DeviceState::realize rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>

On Wed, Oct 3, 2018 at 7:39 AM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 10/2/18 11:53 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Move from the legacy SysBusDevice::init method to using DeviceState::re=
alize.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> That patch was already reviewed by you and merged by David :)

Memory failure :/ This sounded somehow familiar although...
