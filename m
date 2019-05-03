Received: from eggs.gnu.org ([209.51.188.92]:57680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMZtm-0001hf-A4
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMZtl-0003Oc-BT
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:14:54 -0400
From: Thomas Huth <thuth@redhat.com>
References: <20190430071405.16714-1-thuth@redhat.com>
Message-ID: <3619e259-7256-9199-2cdb-53f980f64c34@redhat.com>
Date: Fri, 3 May 2019 17:14:32 +0200
MIME-Version: 1.0
In-Reply-To: <20190430071405.16714-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/30] Kconfig dependencies for ARM
 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org, qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>, Philippe Mathieu-Daude <f4bug@amsat.org>

On 30/04/2019 09.13, Thomas Huth wrote:
> This series reworks the default-configs/arm-softmmu.mak and
> default-configs/aarch64-softmmu.mak files to use the new Kconfig-style
> dependencies instead.
>=20
> Some of the patches are slightly based on the work by =C3=81kos Kov=C3=A1=
cs:
>=20
>  https://lists.nongnu.org/archive/html/qemu-devel/2013-08/msg03730.html
>=20
> The other patches have been created by looking at the sources and findi=
ng
> out the dependencies the hard way via trial-and-error (i.e. by enabling
> only one machine at a time and checking whether it can be compiled and
> started).

 Hi Peter,

the two usb-ohci patches have now been merged to master via Gerd's tree
already, the pci patch has an Ack from Michael and the AHCI patch one
from John. All patches have been reviewed and/or tested ... so I think
this series should now be good to go. Could you take it through your Arm
tree? Or shall I send a separate PULL request for this?

 Thomas
