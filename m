Received: from eggs.gnu.org ([2001:4830:134:3::10]:44381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX7Jm-0007qv-UH
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 11:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX7Jh-0002Hr-DH
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 11:25:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gX7Jf-0002Gb-PT
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 11:24:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id j10so18303457wru.4
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 08:24:55 -0800 (PST)
References: <20180910083222.8245-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <75f0819a-78dd-9ee2-5559-4d975412ffa3@redhat.com>
Date: Wed, 12 Dec 2018 17:24:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180910083222.8245-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 0/6] Add support for TPM Physical
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanb@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>

Hi Marc-André,

On 9/10/18 10:32 AM, Marc-André Lureau wrote:
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

I made trivial review comments in indivial patches.
Can you respin a rebased version for further testing?

Thanks,

Phil.
