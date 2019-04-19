Received: from eggs.gnu.org ([209.51.188.92]:45439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHNb4-00051n-Ma
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 03:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHNb3-00081A-PE
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 03:06:06 -0400
References: <20190418111019.4080-1-thuth@redhat.com>
	<6bd7dd96-cd2c-22aa-5533-ae341f942a5c@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0294bc60-d221-653b-ed28-c8392a767e41@redhat.com>
Date: Fri, 19 Apr 2019 09:05:54 +0200
MIME-Version: 1.0
In-Reply-To: <6bd7dd96-cd2c-22aa-5533-ae341f942a5c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/usb/hcd-ohci: Move PCI-related
 code into a separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>

On 18/04/2019 14.35, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 4/18/19 1:10 PM, Thomas Huth wrote:
>> Some machines (like the pxa2xx-based ARM machines) only have a sysbus
>> OHCI controller, but no PCI. With the new Kconfig-style build system,
>> it will soon be possible to create QEMU binaries that only contain
>> such PCI-less machines. However, the two OHCI controllers, for sysbus
>> and for PCI, are currently both located in one file, so the PCI code
>> is still required for linking here. Move the OHCI-PCI device code
>> into a separate file, so that it is possible to use the sysbus OHCI
>> device also without the PCI dependency.
>>
>> Apart from moving code to a new file (and a new header), this patch
>> might also fix one subtle bug: The ohci_die() function always assumed
>> to be running with a OHCI-PCI controller and called some PCI-specific
>> functions - but if I got the code right, ohci_die() might also get
>> called for the sysbus-OHCI device, so it likely failed in that case.
>> I've changed this part of the code now, so that there are two ohci_die=
()
>> implementations now, one for sysbus and one for PCI.
>=20
> Can this be done in 2 patches?

Yeah, maybe that's cleaner... I'll send a v2...

 Thomas
