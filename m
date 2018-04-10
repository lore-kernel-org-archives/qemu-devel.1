Received: from eggs.gnu.org ([2001:4830:134:3::10]:40291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f5peG-000498-CG
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f5peB-0004eU-FW
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:33:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f5peB-0004e4-Bt
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:33:03 -0400
References: <20180407000117.25640-1-lersek@redhat.com>
	<bf5fc85b-0695-3bd0-117d-759d5dbd4546@redhat.com>
	<20180409081923.n2ktwrp2jp7xpoon@sirius.home.kraxel.org>
	<43fbc488-20d6-f5de-0a56-6c28355cc4d4@redhat.com>
	<aa289441-f606-d073-3d29-682555c4e9c5@redhat.com>
	<713231ec-05c5-a135-65b1-bd26e08738f6@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9905fe6b-337d-d712-0851-472be3d55aca@redhat.com>
Date: Tue, 10 Apr 2018 11:32:47 +0200
MIME-Version: 1.0
In-Reply-To: <713231ec-05c5-a135-65b1-bd26e08738f6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 10.04.2018 11:22, Laszlo Ersek wrote:
> On 04/10/18 09:33, Thomas Huth wrote:
[...]
>> Alternatively, what about providing some kind of "alias" or "nickname"
>> setting here, too? So the EDK2 builds would get
>> SystemFirmwareType="edk2" and "SystemFirmwareAlias="uefi" for example.
> 
> I hope I understand you right -- I think your suggestion ties in with my
> other email I just sent in this thread. So, we could tell libvirtd,
> "this firmware is of type 'UEFI', and you must use the 'ovmf_smm'
> mapping method to run it, with this file or that file as varstore template".
> 
> We could even describe the parameters for this or that mapping method
> structurally in the schema (in a discriminated union in QAPI JSON, or in
> an XSD choice element). For example, "ovmf" and "ovmf_smm" would both
> take "OvmfSplitFileOptions" -- a list of single varstore template files
> with feature enum contants attached  --, while "SeaBiosOptions" would be
> an empty structure.

Sorry, I've got no clue about ovmf_smm and the other things you've
mentioned here ;-)

> I feel the key question here is whether we are allowed to directly
> reference a mapping method we know libvirt implements. If we are, that
> makes things a lot clearer (and easier, I should hope).

Key question is maybe rather: Do you want to design / implement
something that is libvirt-only here, or rather something generic that
could also be used for other upper layer tools that do not use libvirt?
(... and looks like Daniel just had the same comment in another mail in
this thread ...)

 Thomas
