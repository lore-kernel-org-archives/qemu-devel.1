Received: from eggs.gnu.org ([2001:4830:134:3::10]:49766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8jcz-0003pt-HD
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8jcw-0001a9-EL
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:43:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55054 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f8jcw-0001Za-8I
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:43:46 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c5e3f942-2c0e-9809-32ae-df97eaf2b7cd@redhat.com>
Date: Wed, 18 Apr 2018 11:43:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180417224054.26363-1-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 18/04/2018 00:40, Laszlo Ersek wrote:
> +#
> +# Lists firmware types commonly used with QEMU virtual machines.
> +#
> +# @bios: The firmware was built from the SeaBIOS project.
> +#
> +# @slof: The firmware was built from the Slimline Open Firmware project.
> +#
> +# @uboot: The firmware was built from the U-Boot project.
> +#
> +# @uefi: The firmware was built from the edk2 (EFI Development Kit II) project.
> +#
> +# Since: 2.13
> +##
> +{ 'enum' : 'FirmwareType',
> +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }

A very basic question (so not likely a suggestion for change).  Why
wouldn't these be features too?  For example a UEFI with CSM could
expose both uefi and bios, a u-boot with UEFI support could expose both
uboot and uefi, etc.

Perhaps there are two dimensions, the FirmwareType tells you how to
configure it and the FirmwareFeature tells you the APIs it exposes to
the guest?

Paolo
