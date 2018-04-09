Received: from eggs.gnu.org ([2001:4830:134:3::10]:41894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1f5TrH-0006jn-Pn
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 06:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1f5TrC-0003Gv-SN
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 06:17:07 -0400
Received: from chuckie.co.uk ([82.165.15.123]:50484
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1f5TrC-00037Z-LG
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 06:17:02 -0400
References: <20180321135041.15768-1-kraxel@redhat.com>
	<alpine.BSF.2.21.1804081251340.49362@zero.eik.bme.hu>
	<20180409094321.ekuzanlgynm3nb2o@sirius.home.kraxel.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ea9a8a44-270c-6b8f-554a-0a66dddf3d3f@ilande.co.uk>
Date: Mon, 9 Apr 2018 11:16:46 +0100
MIME-Version: 1.0
In-Reply-To: <20180409094321.ekuzanlgynm3nb2o@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] sdl2 text console fixes and cleanups.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org

On 09/04/18 10:43, Gerd Hoffmann wrote:

> On Sun, Apr 08, 2018 at 12:52:18PM +0200, BALATON Zoltan wrote:
>> On Wed, 21 Mar 2018, Gerd Hoffmann wrote:
>>> Gerd Hoffmann (5):
>>>   ui: add ctrl modifier support to kbd_put_qcode_console()
>>>   sdl2: track kbd modifier state unconditionally
>>>   sdl2: enable ctrl modifier keys for text consoles
>>>   sdl2: drop QEMU_KEY_BACKSPACE special case
>>>   sdl2: drop dead code
>>>
>>> include/ui/console.h |  2 +-
>>> ui/console.c         | 15 +++++++++++++--
>>> ui/gtk.c             |  4 ++--
>>> ui/sdl2-input.c      | 46 ++++++++++++++++++++--------------------------
>>> 4 files changed, 36 insertions(+), 31 deletions(-)
>>
>> Will this be included in 2.12? I haven't seen it reaching master yet.
> 
> Oops.  Thanks for the reminder.  Pull request sent.

FWIW I think we're also missing the patch for the GTK errors: 
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg04315.html.


ATB,

Mark.
