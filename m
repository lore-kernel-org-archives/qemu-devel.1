Received: from eggs.gnu.org ([209.51.188.92]:59613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMa37-0006nY-E3
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMa36-0003km-8W
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:24:33 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMa36-0003jp-22
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:24:32 -0400
Received: by mail-oi1-x243.google.com with SMTP id j9so3955276oie.10
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190430071405.16714-1-thuth@redhat.com>
	<3619e259-7256-9199-2cdb-53f980f64c34@redhat.com>
In-Reply-To: <3619e259-7256-9199-2cdb-53f980f64c34@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 16:24:20 +0100
Message-ID: <CAFEAcA_70xU7_Z7vEs+NHuG6L9jZTp7_r2yORn91caqV4LknPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v6 00/30] Kconfig dependencies
 for ARM machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Philippe Mathieu-Daude <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On Fri, 3 May 2019 at 16:15, Thomas Huth <thuth@redhat.com> wrote:
>
> On 30/04/2019 09.13, Thomas Huth wrote:
> > This series reworks the default-configs/arm-softmmu.mak and
> > default-configs/aarch64-softmmu.mak files to use the new Kconfig-style
> > dependencies instead.
> >
> > Some of the patches are slightly based on the work by =C3=81kos Kov=C3=
=A1cs:
> >
> >  https://lists.nongnu.org/archive/html/qemu-devel/2013-08/msg03730.html
> >
> > The other patches have been created by looking at the sources and findi=
ng
> > out the dependencies the hard way via trial-and-error (i.e. by enabling
> > only one machine at a time and checking whether it can be compiled and
> > started).
>
>  Hi Peter,
>
> the two usb-ohci patches have now been merged to master via Gerd's tree
> already, the pci patch has an Ack from Michael and the AHCI patch one
> from John. All patches have been reviewed and/or tested ... so I think
> this series should now be good to go. Could you take it through your Arm
> tree? Or shall I send a separate PULL request for this?

I think it will be easier for me if you just send a pullreq for it.

thanks
-- PMM
