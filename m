Received: from eggs.gnu.org ([2001:4830:134:3::10]:52385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVcti-0007fh-JY
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVcth-0007Fz-CI
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:11:42 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:50403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fVcth-0007Fl-3S
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:11:41 -0400
Received: by mail-wm0-x244.google.com with SMTP id e16-v6so5932422wmd.0
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 06:11:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180515121433.6112-1-marcandre.lureau@redhat.com>
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 Jun 2018 15:11:39 +0200
Message-ID: <CAJ+F1C+9bW4nh5EuFSYRtMy9M0hfG55qQqhM-5q=4u+Rdh+bvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Add support for TPM Physical
 Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, May 15, 2018 at 2:14 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Hi,
>
> The following patches implement the TPM Physical Presence Interface
> that allows a user to set a command via ACPI (sysfs entry in Linux)
> that, upon the next reboot, the firmware looks for and acts upon by
> sending sequences of commands to the TPM.
>
> A dedicated memory region is added to the TPM CRB & TIS devices, at
> address/size 0xFED45000/0x400. A new "etc/tpm/config" fw_cfg entry
> holds the location for that PPI region and some version details, to
> allow for future flexibility.
>
> With the associated edk2/ovmf firmware, the Windows HLK "PPI 1.3" test
> now runs successfully.
>
> It is based on previous work from Stefan Berger ("[PATCH v2 0/4]
> Implement Physical Presence interface for TPM 1.2 and 2")
>
> Git branches:
> https://github.com/elmarco/qemu tpm-ppi
> https://github.com/elmarco/edk2 tpm-ppi
>
> Marc-Andr=C3=A9 Lureau (1):
>   tpm: add a fake ACPI memory clear interface
>
> Stefan Berger (3):
>   tpm: implement virtual memory device for TPM PPI
>   acpi: add fw_cfg file for TPM and PPI virtual memory device
>   acpi: build TPM Physical Presence interface

ping

>
>  hw/tpm/tpm_ppi.h      |  26 ++++
>  include/hw/acpi/tpm.h |  30 ++++
>  hw/i386/acpi-build.c  | 318 ++++++++++++++++++++++++++++++++++++++++++
>  hw/tpm/tpm_crb.c      |   5 +
>  hw/tpm/tpm_ppi.c      |  56 ++++++++
>  hw/tpm/tpm_tis.c      |   5 +
>  docs/specs/tpm.txt    |  20 +++
>  hw/tpm/Makefile.objs  |   2 +-
>  hw/tpm/trace-events   |   4 +
>  9 files changed, 465 insertions(+), 1 deletion(-)
>  create mode 100644 hw/tpm/tpm_ppi.h
>  create mode 100644 hw/tpm/tpm_ppi.c
>
> --
> 2.17.0.253.g3dd125b46d
>
>



--=20
Marc-Andr=C3=A9 Lureau
