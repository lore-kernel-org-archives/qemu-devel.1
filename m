Received: from eggs.gnu.org ([2001:4830:134:3::10]:55511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f4PuR-0006TV-Gs
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 07:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f4PuO-0000Ym-GD
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 07:51:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:24394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1f4PuO-0000YK-8n
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 07:51:56 -0400
Date: Fri, 6 Apr 2018 13:51:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <5954994b-20c6-3844-cf0e-577a4277720d@msgid.tls.msk.ru>
Message-ID: <alpine.BSF.2.21.1804061349020.50304@zero.eik.bme.hu>
References: <6c7ac1ff-b375-f1f7-094e-7fb603c5e40b@msgid.tls.msk.ru>
	<alpine.BSF.2.21.1804021607010.6023@zero.eik.bme.hu>
	<5954994b-20c6-3844-cf0e-577a4277720d@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 6 Apr 2018, Michael Tokarev wrote:
> 02.04.2018 17:30, BALATON Zoltan wrote:
>> On Mon, 2 Apr 2018, Michael Tokarev wrote:
>>> roms/u-boot-sam460ex/tools/updater/stubs.c -
>>> it is some strange symlink pointing to a strange place, probably should be removed?
>>
>> This does not seem to matter for building the rom image but this can be fixed by converting it to a relative path. I've done that and will send a patch to update the submodule as well to use the QEMU repo now that we have a mirror there. Thanks for finding this.
>
> There are 2 more files which we might want to remove:
> tools/multiplier/multiplier.image
> tools/multiplier/multiplier

These all come from the upstream source from the hardware vendor which 
I've taken as is to follow GPL. Thanks for noticing, I've removed these 
and will send another patch to update the submodule. Are there any more of 
these before I do that?

Regards,
BALATON Zoltan
