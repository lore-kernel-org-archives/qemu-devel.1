Received: from eggs.gnu.org ([209.51.188.92]:56125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guKev-0007PH-Hm
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guKPM-0004h7-9k
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:02:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1guKPL-0004ev-OK
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:02:44 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-43-git-send-email-pbonzini@redhat.com>
	<a67e6380-daf5-62d1-0f37-45f7015cc0fa@redhat.com>
	<b6cfc7bf-3eb0-3211-a008-0e891908a15c@redhat.com>
	<20190214114744-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3b314bb-d651-482d-0365-8cd9120147d1@redhat.com>
Date: Thu, 14 Feb 2019 18:02:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190214114744-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 42/52] i386: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, yang.zhong@intel.com, thuth@redhat.com

On 14/02/19 17:54, Michael S. Tsirkin wrote:
> On Thu, Feb 14, 2019 at 05:47:08PM +0100, Paolo Bonzini wrote:
>> On 01/02/19 16:05, Philippe Mathieu-Daud=C3=A9 wrote:
>>> This lacks a DISPLAY dependency?
>>>
>>> $ i386-softmmu/qemu-system-i386 -M q35
>>> qemu-system-i386: Unknown device 'VGA' for bus 'PCIE'
>>> Aborted (core dumped)
>>
>> If you got this with --without-default-devices, then it's intended beh=
avior.
>>
>> VGA_PCI is selected via CONFIG_PCI_DEVICES.
>=20
> OK but I guess as a follow-up patch we can hide things that don't work,
> or select things that are required?

It is not required; if you use "-nodefaults" you can build without
CONFIG_VGA_PCI (the failure mode is horrible, granted; it's the same
today if you modify pci.mak).  The documentation explains this for
--without-default-devices:

  When QEMU is built with this option, the user will probably
  want to change some lines in the first group, for example like this::

    CONFIG_PCI_DEVICES=3Dy
    #CONFIG_TEST_DEVICES=3Dn

  and/or pick a subset of the devices in those device groups.

Paolo
