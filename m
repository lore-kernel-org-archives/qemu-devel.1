Received: from eggs.gnu.org ([2001:4830:134:3::10]:48329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dQkE0-0001Q2-Fv
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dQkDv-0001dB-F2
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:55:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dQkDv-0001bd-51
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:55:51 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5U0s1Me054545
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 20:55:48 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bcy9rhy6y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 20:55:48 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 29 Jun 2017 18:55:47 -0600
References: <7f0b8d00-236d-37e8-5c1f-e7ea8e4b9146@redhat.com>
	<e24f5884-5c1a-593d-6ae6-c8c4667a07d5@linux.vnet.ibm.com>
	<8c6ec7dd-aaa5-272f-6f75-9440acb10f61@redhat.com>
	<c94973c9-8f32-66d9-88a7-47d957cadab9@linux.vnet.ibm.com>
	<98574929-954e-e6da-97b1-38e48909d777@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 20:55:37 -0400
MIME-Version: 1.0
In-Reply-To: <98574929-954e-e6da-97b1-38e48909d777@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <2ea4c4cd-ed4b-41b6-479e-d80f1e1893d8@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] TPM status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Javier Martinez Canillas <javierm@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, qemu devel list <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Jones <pjones@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 06/29/2017 07:12 PM, Javier Martinez Canillas wrote:
> On 06/29/2017 06:09 PM, Stefan Berger wrote:
>> On 06/29/2017 08:39 AM, Javier Martinez Canillas wrote:
> [snip]
>
>>>> = TPM backend devices =
>>>>
>>>> The TPM implementation is split into two parts. The one part is the hardware
>>>> interface, such as the TPM TIS interface described earlier, and the TPM backend
>>>> interface. The backend interfaces implement the interaction with a TPM device,
>>>> which may be a physical or an emulated device. The split between the front-
>>>> and backend devices allows a frontend to be connected with any available
>>>> backend. This enables the TIS interface to be used with the passthrough backend
>>>> or the (future) swtpm backend.
>>> So we will need another TPM interface that implements the CRB interface? I
>> No. How did you infer that ?
>>
> I thought that if the host firmware set the TPM2 Start Method to CRB instead of
> TIS1.2+cancel, then the guest would have to use the same interface.
>
> But now with your patch libvirt doesn't complain anymore about a missing cancel
> sysfs file and I could access the host TPM2.0 as a pass-through device, even
> when the host is using the tpm_crb driver while the guest uses the tpm_tis one.

For passthrough really only /dev/tpm0 matters. The rest of the interface 
and what interface the host device has doesn't matter, at least not with 
the TPM device.

Regards,
     Stefan
