Received: from eggs.gnu.org ([2001:4830:134:3::10]:58465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dL9mg-0004m6-Fy
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dL9mc-0005rz-Kj
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:00:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dL9mc-0005rH-BT
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:00:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5EExMEO129407
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 11:00:32 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2b32ujqppm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 11:00:31 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 14 Jun 2017 09:00:28 -0600
References: <7f0b8d00-236d-37e8-5c1f-e7ea8e4b9146@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 14 Jun 2017 11:00:23 -0400
MIME-Version: 1.0
In-Reply-To: <7f0b8d00-236d-37e8-5c1f-e7ea8e4b9146@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <23b82458-1c39-b728-986a-685f64c63a47@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] TPM status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, qemu devel list <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Jones <pjones@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Javier Martinez Canillas <javierm@redhat.com>

On 06/14/2017 09:51 AM, Laszlo Ersek wrote:
> Hi Stefan,
>
> the MAINTAINERS file doesn't seem to cover any of the TPM-related files
> in the tree:
>
>    backends/tpm.c
>    hw/tpm/
>    include/hw/acpi/tpm.h
>    include/sysemu/tpm*
>    tpm.c
>
> but I have a gut feeling that you are semi-officially maintaining TPM
> anyway, so I'm going to ask you. :)
>
> Can you please write a document, to be placed under docs/specs/, that
> describes the TPM device from a guest perspective, also explaining how
> the guest-visible bits are connected to (current) TPM backend(s)?
>
> The document wouldn't have to be very long; I think all standardized
> interfaces could be mentioned by reference only (by spec names and
> locations). The document should however describe any QEMU specifics, and
> how the relevant specs are brought together in the implementation.
>
> Some text files I'm familiar with and can recommend as examples:
> - docs/specs/fw_cfg.txt
> - docs/specs/pvpanic.txt
> - docs/specs/vmgenid.txt
>
> (There may be more and/or better examples of course.)
>
> This document should be the starting point for developers that want to
> support QEMU's TPM(s) in guest firmware that is different from SeaBIOS.
> (You've been maintaining the related SeaBIOS feature.)
>
> Would you be willing to author such a design document?

I'll look into that. Give me some time...

    Stefan


>
> Thank you,
> Laszlo
>
