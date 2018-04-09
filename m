Received: from eggs.gnu.org ([2001:4830:134:3::10]:48240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5a30-0001aK-C7
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5a2w-0007kK-DM
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:53:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40974 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f5a2w-0007jw-8P
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:53:34 -0400
References: <20180407000117.25640-1-lersek@redhat.com>
	<20180409082602.oxtcywsc2vbodtcn@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2f16cf7d-66c7-0280-8e2c-29061741784f@redhat.com>
Date: Mon, 9 Apr 2018 18:53:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180409082602.oxtcywsc2vbodtcn@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 04/09/18 10:26, Gerd Hoffmann wrote:
>> +# {
>> +#     "executable": {
>> +#         "pathname": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
>> +#         "description": "OVMF with Secure Boot and SMM-protected varstore",
>> +#         "tags": [
>> +#             "FD_SIZE_4MB",
>> +#             "IA32X64",
>> +#             "SECURE_BOOT_ENABLE",
>> +#             "SMM_REQUIRE"
>> +#         ]
>> +#     },
>> +#     "type": "uefi",
>> +#     "targets": [
>> +#         "x86_64"
>> +#     ],
>> +#     "sysfw-map": {
>> +#         "device": "flash",
>> +#         "write": "denied"
>> +#     },
>> +#     "nvram-slots": [
>> +#         {
>> +#             "slot-id": 1,
>> +#             "nvram-map" : {
>> +#                 "device": "flash",
>> +#                 "write": "restricted-to-secure-context"
>> +#             },
> 
> What is "slot-id"?  The pflash index?

Yes, it might be defined like that, for the i440fx and q35 machine
types. This correspondence would be implemented in libvirtd, I suppose.

However, I don't think such a correspondence is mandatory. At first
approach, slot-id is just the key that tells the nvramslots apart.

> shouldn't we also specify the
> index for the executable somewhere?

Maybe :)

> Maybe the field should be moved
> into FirmwareMapping?

I couldn't come up with a good use case where you wouldn't map the
*system* firmware in a predefined pflash unit (or other device unit). So
I thought that needed no slot-id.

Thanks
Laszlo
