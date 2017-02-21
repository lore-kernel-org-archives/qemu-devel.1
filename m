Received: from eggs.gnu.org ([2001:4830:134:3::10]:36938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cgFZd-0006TQ-JU
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cgFZa-00069a-It
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:54:05 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cgFZa-00069N-By
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:54:02 -0500
Received: by mail-wm0-x243.google.com with SMTP id r18so21314634wmd.3
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 10:54:02 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<20170221092137.5b6cecbb@t450s.home>
	<27972408-a43b-60f9-86ad-e4e47f4f8f14@redhat.com>
	<CAFEAcA-L-ofsPmyOMhnAxUnkhHy0Zs1j2uCbUVRHV6a+WG0Thw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1c59cdd0-8cf5-9e66-6457-d01852a5ec37@redhat.com>
Date: Tue, 21 Feb 2017 19:53:56 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-L-ofsPmyOMhnAxUnkhHy0Zs1j2uCbUVRHV6a+WG0Thw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, zhong@linux.vnet.ibm.com



On 21/02/2017 19:09, Peter Maydell wrote:
> In this instance I don't understand the patch. The ram_device
> mem-ops are there to deal with memory regions backed by a
> lump of RAM, right? Lumps of memory are always the endianness
> of the host CPU by definition, so DEVICE_NATIVE_ENDIAN and
> no swapping in the accessors seems like it ought to be the right
> thing...

DEVICE_NATIVE_ENDIAN is the endianness of the target CPU however.

So perhaps we need to add DEVICE_HOST_ENDIAN instead?

Paolo
