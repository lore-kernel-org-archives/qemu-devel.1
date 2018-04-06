Received: from eggs.gnu.org ([2001:4830:134:3::10]:54352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f4P3Q-0002Kn-SH
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f4P3M-0005nf-04
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:57:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:53679)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f4P3L-0005nM-N4
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:57:07 -0400
References: <6c7ac1ff-b375-f1f7-094e-7fb603c5e40b@msgid.tls.msk.ru>
	<alpine.BSF.2.21.1804021607010.6023@zero.eik.bme.hu>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <5954994b-20c6-3844-cf0e-577a4277720d@msgid.tls.msk.ru>
Date: Fri, 6 Apr 2018 13:57:05 +0300
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1804021607010.6023@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] some ROMs questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

02.04.2018 17:30, BALATON Zoltan wrote:
> On Mon, 2 Apr 2018, Michael Tokarev wrote:
>> roms/u-boot-sam460ex/tools/updater/stubs.c -
>> it is some strange symlink pointing to a strange place, probably should be removed?
> 
> This does not seem to matter for building the rom image but this can be fixed by converting it to a relative path. I've done that and will send a patch to update the submodule as well to use the QEMU repo now that we have a mirror there. Thanks for finding this.

There are 2 more files which we might want to remove:
 tools/multiplier/multiplier.image
 tools/multiplier/multiplier

FWIW.

Thanks,

/mjt
