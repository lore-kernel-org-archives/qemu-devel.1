Received: from eggs.gnu.org ([2001:4830:134:3::10]:35007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gK32G-0001ub-C2
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:13:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gK2pf-0006fj-Db
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:59:56 -0500
References: <20181102152257.20637-1-mark.cave-ayland@ilande.co.uk>
	<20181102152257.20637-3-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <f38b5fc8-dda0-3560-5b6d-78a0aa35828a@tuxfamily.org>
Date: Tue, 6 Nov 2018 15:59:47 +0100
MIME-Version: 1.0
In-Reply-To: <20181102152257.20637-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 02/10] hw/m68k: implement ADB bus
 support for via
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net, laurent@vivier.eu

On 2018-11-02 16:22, Mark Cave-Ayland wrote:
> From: Laurent Vivier <laurent@vivier.eu>
> 
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>  hw/misc/mac_via.c         | 190 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/misc/mac_via.h |   7 ++
>  2 files changed, 197 insertions(+)

Looks ok to me at a quick glance now (can't say much about the details
since I don't know the ADB stuff at all), so FWIW, a weak:

Reviewed-by: Thomas Huth <huth@tuxfamily.org>
