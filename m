Received: from eggs.gnu.org ([2001:4830:134:3::10]:58920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fedM4-00025C-Le
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 05:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fedLz-00036x-Km
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 05:30:12 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:28190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fedLz-0002oG-Ck
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 05:30:07 -0400
Date: Sun, 15 Jul 2018 11:29:56 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1807151041060.88858@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] hw/display/sm501* status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>, Sebastian Bauer <mail@sebastianbauer.info>
Cc: qemu-devel@nongnu.org

Hello,

I plan to make more changes to sm501 emulation to make it more usable for 
AmigaOS and other Amiga like OSes. This would include first cleaning up of 
current state, then trying to optimise 2D ops and display updates because 
it was found these are currently quite slow. (Especially when using 8bit 
or 16bit screen modes as AmigaOS does where every screen update does pixel 
format conversion with a simple loop in a suboptimal way. Maybe we can use 
more optimal pixman routines for these.)

We have found while merging previous patches that the status of sm501 is 
not clear. It was originally part of SH emulation added for the R2D board 
but now it's also used by PPC sam460ex board (and can be used with mac99 
as well to run MorphOS that does not yet boot on sam460ex). David Gibson, 
the PPC maintainer has indicated that he can't review changes to this 
device and it is not really related to PPC so the practice of merging 
sm501 patches via his PPC tree is not preferred.

So before sending more patches I'd like to clear who can review and merge 
patches for sm501 in the future and what is the maintainership of this 
device?

Regards,
BALATON Zoltan
