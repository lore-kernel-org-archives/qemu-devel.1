Received: from eggs.gnu.org ([2001:4830:134:3::10]:58054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d6Yxl-0007Tm-Dy
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d6Yxg-0000TP-CV
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:51:45 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42892
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d6Yxg-0000T0-5k
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:51:40 -0400
References: <1493624375-12707-1-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <1214137f-b100-23f6-3522-c07c7b20eefc@ilande.co.uk>
Date: Fri, 5 May 2017 09:51:13 +0100
MIME-Version: 1.0
In-Reply-To: <1493624375-12707-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] tcx/cg3: fix warnings reported by
 Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, kraxel@redhat.com

On 01/05/17 08:39, Mark Cave-Ayland wrote:

> This patchset fixes up a couple of issues from my last set of tcx/cg3 updates
> spotted by Coverity as reported by Peter.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Mark Cave-Ayland (2):
>   tcx: fix cut/paste error in update_palette_entries()
>   cg3: add explicit ram_addr_t cast to scanline page variable
> 
>  hw/display/cg3.c |    2 +-
>  hw/display/tcx.c |    1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)

No further comments, so I've added Philippe's R-B and applied to qemu-sparc.


ATB,

Mark.
