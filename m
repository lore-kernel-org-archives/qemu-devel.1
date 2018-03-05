Received: from eggs.gnu.org ([2001:4830:134:3::10]:47233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1esqXl-0007nc-L9
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1esqXi-0003Ut-EW
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:52:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1esqXi-0003UD-5Y
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:52:42 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w25DnvUl010560
	for <qemu-devel@nongnu.org>; Mon, 5 Mar 2018 08:52:40 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gh3gh1j5h-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 08:52:40 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 5 Mar 2018 08:52:38 -0500
References: <1519934373-3629-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1519934373-3629-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CLUyeroa3wDDnC2tgAbvo+GChT4aADQUWF5y7Zn6_3KsQ@mail.gmail.com>
	<20180302101427.GB3154@work-vm>
	<57ac3b64-831e-2245-45f4-08d3970bbf6d@linux.vnet.ibm.com>
	<20180305124346.GI3131@work-vm>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 5 Mar 2018 08:52:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180305124346.GI3131@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <385b9762-ae06-11f2-5af0-614ce2ce00bc@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] tpm: extend TPM emulator with state
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Juan Quintela <quintela@redhat.com>, QEMU <qemu-devel@nongnu.org>

On 03/05/2018 07:43 AM, Dr. David Alan Gilbert wrote:
> * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
>> On 03/02/2018 05:14 AM, Dr. David Alan Gilbert wrote:
>>
>> hw/tpm/tpm_emulator.c:909:tpm_emulator_class_init: Object 0x55f4cbc72680 is
>> not an instance of type device
>> Aborted
>>
>> Can we leave it as it is ?
> Oh, not a device, hmmm that's odd; yeh probably best then.

At least it doesn't *need* to be a device that an OS could talk to via 
MMIO or so. That's the TIS or CRB hardware interfaces in this case. If 
we have to convert this 'backend' to a device for some reason, I'd do 
it, but rather leave it as it is if not.

    Stefan
