Received: from eggs.gnu.org ([2001:4830:134:3::10]:38825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5S84-0005EU-Jw
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5S81-0006mn-EX
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:26:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5S81-0006mY-8y
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:26:17 -0400
Date: Mon, 9 Apr 2018 10:26:02 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180409082602.oxtcywsc2vbodtcn@sirius.home.kraxel.org>
References: <20180407000117.25640-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180407000117.25640-1-lersek@redhat.com>
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

> +# {
> +#     "executable": {
> +#         "pathname": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
> +#         "description": "OVMF with Secure Boot and SMM-protected varstore",
> +#         "tags": [
> +#             "FD_SIZE_4MB",
> +#             "IA32X64",
> +#             "SECURE_BOOT_ENABLE",
> +#             "SMM_REQUIRE"
> +#         ]
> +#     },
> +#     "type": "uefi",
> +#     "targets": [
> +#         "x86_64"
> +#     ],
> +#     "sysfw-map": {
> +#         "device": "flash",
> +#         "write": "denied"
> +#     },
> +#     "nvram-slots": [
> +#         {
> +#             "slot-id": 1,
> +#             "nvram-map" : {
> +#                 "device": "flash",
> +#                 "write": "restricted-to-secure-context"
> +#             },

What is "slot-id"?  The pflash index?  shouldn't we also specify the
index for the executable somewhere?  Maybe the field should be moved
into FirmwareMapping?

cheers,
  Gerd
