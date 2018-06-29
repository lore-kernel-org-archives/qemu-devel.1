Received: from eggs.gnu.org ([2001:4830:134:3::10]:51355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fYsOP-000061-SS
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fYsOL-0000E3-QK
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:20:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49784
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fYsOL-0000DU-Jk
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:20:45 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5TCIwPl130859
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 08:20:45 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jwhyfeuna-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 08:20:44 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 29 Jun 2018 06:20:44 -0600
References: <20180628172657.11646-1-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 29 Jun 2018 08:20:38 -0400
MIME-Version: 1.0
In-Reply-To: <20180628172657.11646-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <89c2a128-3679-8b44-f00a-7f94bd3bdf0d@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/4] Add support for TPM Physical
 Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/28/2018 01:26 PM, Marc-Andr=C3=A9 Lureau wrote:
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
> The edk2 support is merged upstream.

The least I could do now is test this... So, I tested this now with the=20
SeaBIOS support I have for this series. It's here:

https://github.com/stefanberger/seabios-tpm/tree/qemu-ppi.v6

It works fine with at least an attached TPM 1.2. I haven't tried TPM 2=20
yet but would not expect complications from QEMU level. A operation=20
request value put into Linux's PPI interface can be read back also after=20
a VM suspend / resume operation. The list of supported operations is=20
shown correctly (needs Linux extensions for TPM 2 operation values=20
beyond a certain number iirc). The request operation is executed=20
correctly and the response shows the last operation and its result. So=20
it seems to work fine.


 =C2=A0=C2=A0 Stefan
