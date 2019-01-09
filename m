Received: from eggs.gnu.org ([209.51.188.92]:34315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1ghGCV-0005lq-HP
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:55:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1ghGCT-0000jF-Ks
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:55:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1ghGCR-0000bP-Kh
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:55:25 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x09FndxY026964
	for <qemu-devel@nongnu.org>; Wed, 9 Jan 2019 10:55:13 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pwkhphgm5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 10:55:13 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Wed, 9 Jan 2019 15:55:12 -0000
References: <20190109082902.32271-1-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Wed, 9 Jan 2019 10:55:05 -0500
MIME-Version: 1.0
In-Reply-To: <20190109082902.32271-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <25b65783-0808-09b4-a7cd-0149bf9d9a5e@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v15 0/6] Add support for TPM Physical
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, f4bug@amsat.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On 1/9/19 3:28 AM, Marc-Andr=C3=A9 Lureau wrote:
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


Tested-by: Stefan Berger <stefanb@linux.ibm.vom>
