Received: from eggs.gnu.org ([2001:4830:134:3::10]:43112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cv2Ro-00068V-TB
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cv2Rl-0000Dz-Mn
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:55:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cv2Rl-0000DX-HE
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:55:05 -0400
Date: Mon, 3 Apr 2017 10:54:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170403135445.GD1910@thinpad.lan.raisama.net>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-14-ehabkost@redhat.com>
	<CAFEAcA9bRwneynDYg6Lgowe21=rh8+miSZhqzmW81VLWrxafhQ@mail.gmail.com>
	<20170403133416.GB1910@thinpad.lan.raisama.net>
	<CAFEAcA-9r=Qktj1Oa6kvCPQrQ4XpPcxb2L4xNcPSfHeB9Ogt6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-9r=Qktj1Oa6kvCPQrQ4XpPcxb2L4xNcPSfHeB9Ogt6A@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC 13/19] unimplemented-device: Remove
 user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Apr 03, 2017 at 02:38:15PM +0100, Peter Maydell wrote:
> On 3 April 2017 at 14:34, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >> Wouldn't it be better to just not add that, rather than
> >> add it and then delete it?
> >
> > The device was already user-creatable
> 
> It doesn't seem to be:
> 
>  ./build/x86/arm-softmmu/qemu-system-arm -M virt -device
> unimplemented-device,size=1024,name=foo
> qemu-system-arm: Device unimplemented-device can not be dynamically instantiated

This restriction is implemented by the "virt" machine, not by the
device type itself.

This, on the other hand, currently works:
  $ qemu-system-x86_64 -M q35 -device unimplemented-device,size=1024,name=foo

-- 
Eduardo
