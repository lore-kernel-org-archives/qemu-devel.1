Received: from eggs.gnu.org ([2001:4830:134:3::10]:58066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ef95U-0003GS-7E
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ef95R-0003tn-5M
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:50:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ef95Q-0003tJ-S1
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:50:53 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0QInJVM035279
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 13:50:50 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fr5u82d5j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 13:50:50 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 26 Jan 2018 11:50:49 -0700
References: <20180126120306.19225-1-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 26 Jan 2018 13:50:42 -0500
MIME-Version: 1.0
In-Reply-To: <20180126120306.19225-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e388c419-101f-bfc7-4df3-b387bdeccf80@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] tpm: add CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>

On 01/26/2018 07:03 AM, Marc-Andr=C3=A9 Lureau wrote:
> tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB)
> Interface as defined in TCG PC Client Platform TPM Profile (PTP)
> Specification Family =E2=80=9C2.0=E2=80=9D Level 00 Revision 01.03 v22.
>
> The PTP allows device implementation to switch between TIS and CRB
> model at run time, but given that CRB is a simpler device to
> implement, I chose to implement it as a different device.
>
> The device doesn't implement other locality than 0 for now (my laptop
> TPM doesn't either, so I assume this isn't so bad)
>
> Tested with some success with Linux upstream and Windows 10, seabios &
> modified ovmf. The device is recognized and correctly transmit
> command/response with passthrough & emu. However, we are missing PPI
> ACPI part atm.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

With that other patch squashed in:

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
