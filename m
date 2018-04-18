Received: from eggs.gnu.org ([2001:4830:134:3::10]:53819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8ldT-0001NJ-81
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8ldQ-00054a-3K
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:52:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57338 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f8ldP-00054S-VB
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:52:24 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
	<c5e3f942-2c0e-9809-32ae-df97eaf2b7cd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <762b3dc8-a86f-a21f-1e21-334ec46677ef@redhat.com>
Date: Wed, 18 Apr 2018 13:52:19 +0200
MIME-Version: 1.0
In-Reply-To: <c5e3f942-2c0e-9809-32ae-df97eaf2b7cd@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 04/18/18 11:43, Paolo Bonzini wrote:
> On 18/04/2018 00:40, Laszlo Ersek wrote:
>> +#
>> +# Lists firmware types commonly used with QEMU virtual machines.
>> +#
>> +# @bios: The firmware was built from the SeaBIOS project.
>> +#
>> +# @slof: The firmware was built from the Slimline Open Firmware project.
>> +#
>> +# @uboot: The firmware was built from the U-Boot project.
>> +#
>> +# @uefi: The firmware was built from the edk2 (EFI Development Kit II) project.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'enum' : 'FirmwareType',
>> +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }
> 
> A very basic question (so not likely a suggestion for change).  Why
> wouldn't these be features too?  For example a UEFI with CSM could
> expose both uefi and bios, a u-boot with UEFI support could expose both
> uboot and uefi, etc.

Good point. I considered "type" to be a given, from the initial
brainstorming, but if Dan is OK with your suggestion, I can turn these
into features as well.

> Perhaps there are two dimensions, the FirmwareType tells you how to
> configure it and the FirmwareFeature tells you the APIs it exposes to
> the guest?

I don't know enough firmware types to answer this :) I believe I agree
about the FirmwareFeature statement (if we also include "platform
requirements" there), but I have no clue about any generalizations for
firmware configuration.

Thanks,
Laszlo
