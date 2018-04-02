Received: from eggs.gnu.org ([2001:4830:134:3::10]:55159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f30Te-0007nF-Gr
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 10:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f30Tb-0000mU-SN
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 10:30:30 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:16885)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1f30Tb-0000Uc-LI
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 10:30:27 -0400
Date: Mon, 2 Apr 2018 16:30:12 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <6c7ac1ff-b375-f1f7-094e-7fb603c5e40b@msgid.tls.msk.ru>
Message-ID: <alpine.BSF.2.21.1804021607010.6023@zero.eik.bme.hu>
References: <6c7ac1ff-b375-f1f7-094e-7fb603c5e40b@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] some ROMs questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On Mon, 2 Apr 2018, Michael Tokarev wrote:
> roms/u-boot-sam460ex/tools/updater/stubs.c -
> it is some strange symlink pointing to a strange place, probably should be removed?

This does not seem to matter for building the rom image but this can be 
fixed by converting it to a relative path. I've done that and will send a 
patch to update the submodule as well to use the QEMU repo now that we 
have a mirror there. Thanks for finding this.

> When making u-boot-am460ex image, in roms/Makefile, we do a plain copy, while 5
> lines above, u-boot image is being stripped on copy. Should we perform strip for
> u-boot-am460ex image too, if not only to be consistent?

No, this is correct. These use different images. For e500 the u-boot ELF 
image is used after stripping it while for sam460ex the u-boot.bin is 
needed which is another build target and does not contain symbols to be 
stripped so a plain copy is enough.

> BTW, can't u-boot-am460ex image be made from regular u-boot sources, maybe with an
> additional board added? :)

No. This was discussed before several times. Look up those threads for 
more info or if you don't beleive it just compare the two u-boot versions. 
I don't intend to take up the task of supporting this board in latest 
u-boot versions which even removed support for the CPU type it needs. Also 
we aim to be as compatible to real hardware as possible because of 
assumptions of closed source guests.

Regards,
BALATON Zoltan
