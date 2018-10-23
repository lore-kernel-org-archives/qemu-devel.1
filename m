Received: from eggs.gnu.org ([2001:4830:134:3::10]:41431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1gEqy1-0002wU-Ce
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1gEqxx-0004ee-9c
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:19:05 -0400
Received: from mout01.posteo.de ([185.67.36.65]:52698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <th.huth@posteo.de>) id 1gEqxw-0004dY-O5
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:19:01 -0400
Received: from submission (posteo.de [89.146.220.130])
	by mout01.posteo.de (Postfix) with ESMTPS id 46624210C2
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 09:18:58 +0200 (CEST)
References: <20181018182856.28001-1-mark.cave-ayland@ilande.co.uk>
	<20181018182856.28001-6-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <th.huth@posteo.de>
Message-ID: <19364d5d-005b-eae5-b61c-e16b211667ea@posteo.de>
Date: Tue, 23 Oct 2018 08:18:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181018182856.28001-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 05/11] hw/m68k: Apple Sound Chip (ASC)
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, yongbok.kim@mips.com, afaerber@suse.de, aurelien@aurel32.net, laurent@vivier.eu

On 2018-10-18 19:28, Mark Cave-Ayland wrote:
> From: Laurent Vivier <laurent@vivier.eu>
> 
> This is broken as the linux driver seems broken too...

So is this required for the initial version, or does Linux also boot
without this device in the emulated machine? In the first case, please
mention it in the cover letter. In the latter case, maybe skip the patch
for now and add it later instead, once this has been fixed...?

 Thomas
