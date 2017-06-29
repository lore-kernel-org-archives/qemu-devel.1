Received: from eggs.gnu.org ([2001:4830:134:3::10]:33841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <javierm@redhat.com>) id 1dQiba-0006Dn-OB
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <javierm@redhat.com>) id 1dQibW-0005vR-Pk
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:12:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <javierm@redhat.com>) id 1dQibW-0005uw-Is
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:12:06 -0400
References: <7f0b8d00-236d-37e8-5c1f-e7ea8e4b9146@redhat.com>
	<e24f5884-5c1a-593d-6ae6-c8c4667a07d5@linux.vnet.ibm.com>
	<8c6ec7dd-aaa5-272f-6f75-9440acb10f61@redhat.com>
	<c94973c9-8f32-66d9-88a7-47d957cadab9@linux.vnet.ibm.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <98574929-954e-e6da-97b1-38e48909d777@redhat.com>
Date: Fri, 30 Jun 2017 01:12:00 +0200
MIME-Version: 1.0
In-Reply-To: <c94973c9-8f32-66d9-88a7-47d957cadab9@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] TPM status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, qemu devel list <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Jones <pjones@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 06/29/2017 06:09 PM, Stefan Berger wrote:
> On 06/29/2017 08:39 AM, Javier Martinez Canillas wrote:

[snip]

>>
>>> = TPM backend devices =
>>>
>>> The TPM implementation is split into two parts. The one part is the hardware
>>> interface, such as the TPM TIS interface described earlier, and the TPM backend
>>> interface. The backend interfaces implement the interaction with a TPM device,
>>> which may be a physical or an emulated device. The split between the front-
>>> and backend devices allows a frontend to be connected with any available
>>> backend. This enables the TIS interface to be used with the passthrough backend
>>> or the (future) swtpm backend.
>> So we will need another TPM interface that implements the CRB interface? I
> 
> No. How did you infer that ?
> 

I thought that if the host firmware set the TPM2 Start Method to CRB instead of
TIS1.2+cancel, then the guest would have to use the same interface.

But now with your patch libvirt doesn't complain anymore about a missing cancel
sysfs file and I could access the host TPM2.0 as a pass-through device, even
when the host is using the tpm_crb driver while the guest uses the tpm_tis one.

Sorry for the confusion, I'm just been learning about the TPM and still trying
to make sense of all the different specifications and documents.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
