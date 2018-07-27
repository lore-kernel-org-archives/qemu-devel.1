Received: from eggs.gnu.org ([2001:4830:134:3::10]:41868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fj0HV-0008Fz-0H
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 06:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fj0HU-0004px-8A
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 06:47:33 -0400
References: <3390c4bf-ffac-3744-fd85-84f4ee8193bf@ilande.co.uk>
	<9c285bce-478f-b786-76e0-f0810336ec23@redhat.com>
	<16432a45-ad8b-6c09-b50d-ab7101214912@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a0593954-0e97-7317-f0ff-f54c194cb137@redhat.com>
Date: Fri, 27 Jul 2018 12:47:18 +0200
MIME-Version: 1.0
In-Reply-To: <16432a45-ad8b-6c09-b50d-ab7101214912@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] How to generate custom fw paths for
 IDE devices?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, marcel@redhat.com, Laszlo Ersek <lersek@redhat.com>, armbru@redhat.com, qemu-block@nongnu.org

On 27/07/2018 12:43, Mark Cave-Ayland wrote:
> The issue here seems to be that according to "info qtree" there is
> *always* an ide-cd device plugged into the location equivalent to that
> of -cdrom, and so with the above command QEMU ends up adding a second
> ide-cd device to the ide.1 bus which confuses OpenBIOS. Is this
> deliberate behaviour?

Yes, the default CD-ROM is always placed as secondary/master.

If you use -device ide-cd the implicit CD-ROM should go away.  However,
-drive alone doesn't have that effect (probably for backwards
compatibility reasons, this predates me even though by only a few months).

Alternatively, you can use -nodefaults of course.

Thanks,

Paolo
