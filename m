Received: from eggs.gnu.org ([2001:4830:134:3::10]:41462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5rla-0005Oa-Cs
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5rlZ-0007Zo-Et
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:48:50 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:46641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5rlZ-0007ZI-96
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:48:49 -0400
Received: by mail-ot0-x230.google.com with SMTP id v64-v6so12341198otb.13
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 04:48:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410113444.GR5155@redhat.com>
References: <20180407000117.25640-1-lersek@redhat.com>
	<20180409084940.GE18283@redhat.com>
	<3381bdf1-62ea-9da7-c654-032c0c11fb4e@redhat.com>
	<20180410091832.GG5155@redhat.com>
	<dbb6c144-d8ce-3525-1c9c-7d45b47cc7bc@redhat.com>
	<20180410113444.GR5155@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 12:48:28 +0100
Message-ID: <CAFEAcA8pOM=Ck+vek1Ww7juWF_Y-N0LQ-YChsYUr2BUgKj29Ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Thomas Huth <thuth@redhat.com>

On 10 April 2018 at 12:34, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:
> On Tue, Apr 10, 2018 at 01:27:18PM +0200, Laszlo Ersek wrote:
>
>> Please go through the rest of the emails in this thread, and advise:
>> - if the firmware descriptor schema may perhaps live in the libvirt tree=
,
>> - accordingly, if the schema could be expressed as an XSD (and firmware
>> packages should provide the descriptor documents as XMLs)
>> - if you agree that the descriptor document can uniquely reference
>> mapping methods implemented in libvirtd by simple enum constants (with
>> necessary parameters provided).
>
> No to all three. This is the responsibility of QEMU to define, because
> this information is relevant to anything managing QEMU not just libvirt.

(Please consider this as more of a grenade lobbed into the conversation
rather than a carefully thought out proposal...)

My inclination is to say that it's not really the responsibility
of QEMU to define either -- we provide emulated models of hardware,
and it's up to the user or the management layer or the provider
of the firmware to specify what guest code they want to run and how
it needs to run on that emulated hardware...

Where the QEMU upstream itself is providing firmware blobs
(in tarballs etc) it's probably our job to specify how they work,
but if the firmware is compiled and provided by the distro (as eg happens
for Arm UEFI blobs at the moment) then I don't see how upstream QEMU
can reliably define how that firmware needs to be loaded.

thanks
-- PMM
