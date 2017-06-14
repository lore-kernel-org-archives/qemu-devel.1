Received: from eggs.gnu.org ([2001:4830:134:3::10]:35070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dL8i5-0000Vw-K0
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dL8i2-0003pt-Ig
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:51:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dL8i2-0003pN-Bd
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:51:46 -0400
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7f0b8d00-236d-37e8-5c1f-e7ea8e4b9146@redhat.com>
Date: Wed, 14 Jun 2017 15:51:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] TPM status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, qemu devel list <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, Javier Martinez Canillas <javierm@redhat.com>, Peter Jones <pjones@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

Hi Stefan,

the MAINTAINERS file doesn't seem to cover any of the TPM-related files
in the tree:

  backends/tpm.c
  hw/tpm/
  include/hw/acpi/tpm.h
  include/sysemu/tpm*
  tpm.c

but I have a gut feeling that you are semi-officially maintaining TPM
anyway, so I'm going to ask you. :)

Can you please write a document, to be placed under docs/specs/, that
describes the TPM device from a guest perspective, also explaining how
the guest-visible bits are connected to (current) TPM backend(s)?

The document wouldn't have to be very long; I think all standardized
interfaces could be mentioned by reference only (by spec names and
locations). The document should however describe any QEMU specifics, and
how the relevant specs are brought together in the implementation.

Some text files I'm familiar with and can recommend as examples:
- docs/specs/fw_cfg.txt
- docs/specs/pvpanic.txt
- docs/specs/vmgenid.txt

(There may be more and/or better examples of course.)

This document should be the starting point for developers that want to
support QEMU's TPM(s) in guest firmware that is different from SeaBIOS.
(You've been maintaining the related SeaBIOS feature.)

Would you be willing to author such a design document?

Thank you,
Laszlo
