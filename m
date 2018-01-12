Received: from eggs.gnu.org ([2001:4830:134:3::10]:40998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ea35D-0005yU-75
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ea358-0000yH-6c
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:25:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53028
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ea358-0000xt-0p
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:25:30 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0CHPSMK122095
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 12:25:29 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fewx0wg23-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 12:25:27 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 12 Jan 2018 12:24:24 -0500
References: <1515609318-1897-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1515609318-1897-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1C+wFaPWov+sM_UveO92s3tEUDxo1OzSKyMGyS1tRqm+2Q@mail.gmail.com>
	<b1b83637-12cc-04d6-689f-c1d1759e810a@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 12 Jan 2018 12:24:22 -0500
MIME-Version: 1.0
In-Reply-To: <b1b83637-12cc-04d6-689f-c1d1759e810a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e8fcac38-dbca-eed3-61cf-f1e6ac9c30b9@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] tpm: Implement virtual memory
 device for TPM PPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: kevin@koconnor.net, QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 01/12/2018 11:29 AM, Eric Blake wrote:
> On 01/12/2018 08:55 AM, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Wed, Jan 10, 2018 at 7:35 PM, Stefan Berger
>> <stefanb@linux.vnet.ibm.com> wrote:
>>> Implement a virtual memory device for the TPM physical
>>> presence interface. The memory is located at 0xffff0000
>>> and used by ACPI to send messages to the firmware (BIOS).
>>>
>>> This device should be used by all TPM interfaces on x86 and
>>> can be added through by calling tpm_ppi_init_io().
>>>
>>> +#define DEBUG_PPI 1
>> to be switched to 0
>>
>>> +
>>> +#define DPRINTF(fmt, ...) do { \
>>> +    if (DEBUG_PPI) { \
>>> +        printf(fmt, ## __VA_ARGS__); \
>>> +    } \
>>> +} while (0);
> Also, this falls foul of my pending patch to forbid trailing semicolons
> in do/while(0) macros:
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00246.html
>
> But even though it is not a trace point, at least you made sure -Wforma=
t
> will avoid bit-rotting debug statements.
>
Fixing it.
