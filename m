Received: from eggs.gnu.org ([2001:4830:134:3::10]:56356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dRPHI-0002DN-E3
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 16:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dRPHD-0002xK-Jv
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 16:46:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dRPHD-0002wk-Ec
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 16:45:59 -0400
References: <7f0b8d00-236d-37e8-5c1f-e7ea8e4b9146@redhat.com>
	<e24f5884-5c1a-593d-6ae6-c8c4667a07d5@linux.vnet.ibm.com>
	<6fc5cb94-2cbe-e8ec-7ad7-1aa64cd3a0d1@redhat.com>
	<1e0889cf-5b50-eae9-037c-5f2b51afc9d7@linux.vnet.ibm.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8dc1f1cb-65b5-2c3e-4a9f-3ae45b97e342@redhat.com>
Date: Sat, 1 Jul 2017 22:45:51 +0200
MIME-Version: 1.0
In-Reply-To: <1e0889cf-5b50-eae9-037c-5f2b51afc9d7@linux.vnet.ibm.com>
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
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, qemu devel list <qemu-devel@nongnu.org>, Javier Martinez Canillas <javierm@redhat.com>, Peter Jones <pjones@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 06/29/17 21:31, Stefan Berger wrote:
> On 06/27/2017 12:32 PM, Laszlo Ersek wrote:
>>
>> Looks great to me, thank you!
>>
>> Two requests in addition to the above remarks:
>> - can you provide command line options / examples wherever appropriate?
> 
> I didn't add it because we describe that on this page here:
> 
> http://download.qemu.org/qemu-doc.html
> 
> 
> "To create a passthrough TPM use the following two options:
> 
> -tpmdev passthrough,id=tpm0 -device tpm-tis,tpmdev=tpm0"

Yes, I saw that in the manual. The manual is huge, and personally I'd
prefer either an embedded example or a more targeted reference.

At least in "docs/pcie.txt", Marcel added a whole bunch of command line
snippets, and it is *very* useful (to me anyway).
"docs/specs/fw_cfg.txt" also talks about the command line under
"Externally Provided Items".

Thanks for considering it,
Laszlo
