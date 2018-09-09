Received: from eggs.gnu.org ([2001:4830:134:3::10]:51807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fz8yX-0004fT-73
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 19:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fz8rf-00066v-PK
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 19:11:38 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:50400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fz8rf-00066G-HD
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 19:11:35 -0400
Received: by mail-wm0-x243.google.com with SMTP id s12-v6so19653878wmc.0
	for <qemu-devel@nongnu.org>; Sun, 09 Sep 2018 16:11:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CAKXe6S+5ucQuyA4Ru5J4_WLJWMy4znnmnPAJcPX3+j+uSiSW4Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cfe362e5-fae3-1dc0-37c7-55633c1d236b@redhat.com>
Date: Mon, 10 Sep 2018 01:11:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+5ucQuyA4Ru5J4_WLJWMy4znnmnPAJcPX3+j+uSiSW4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Question] Question about the i440FX device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>, mst@redhat.com
Cc: liqiang02@corp.netease.com

On 07/09/2018 08:32, Li Qiang wrote:
> Hello all,
> 
> I want to know why the i440FX in the following 'info qtree' information is 
> laid under the pci.0 bus.  In the chip spec here:
> -->https://wiki.qemu.org/images/b/bb/29054901.pdf
> I don't see this device.
> 
> Can anyone give me some hints?

Hi,

the device implements what is in "3.2. PCI Configuration Space Mapped
Registers" in the i440FX spec.

Paolo
