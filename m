Received: from eggs.gnu.org ([2001:4830:134:3::10]:57534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK8tK-0002MV-85
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK8tF-0000Br-MN
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:28:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gK8tE-0003z8-T9
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:28:01 -0500
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
	<f5712b07-05a1-650c-332a-a24462fed977@redhat.com>
	<454d6ffd-bc43-4f2e-0916-b4c4a14fe788@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f73747fa-0d66-71e1-542e-27953e06c96b@redhat.com>
Date: Tue, 6 Nov 2018 22:26:40 +0100
MIME-Version: 1.0
In-Reply-To: <454d6ffd-bc43-4f2e-0916-b4c4a14fe788@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] List of files containing devices which have not
 been QOMified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 06/11/2018 22:23, John Snow wrote:
> 
> 
> On 11/06/2018 02:46 PM, Paolo Bonzini wrote:
>> On 06/11/2018 19:43, Peter Maydell wrote:
> 
>>> hw/ide/ahci.c
>>
>> Even though AHCIState is not a QOM object, all of its users are
>> (TYPE_SYSBUS_AHCI is in this file, TYPE_ICH9_AHCI is in hw/ide/ich.c).
> 
> Yeah, if there's something *further* that needs to happen, let me know.
> I'm not sure what the QOM ideal is.

I think it's okay.  The virtio-*-device approach (which is contained in
virtio-*-pci and virtio-*-ccw) made sense for virtio where you could
have "socket" virtio-mmio devices and the virtio-*-device "plugs" are
specified in the command line.  However, for AHCI it's overkill.

Paolo
