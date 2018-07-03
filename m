Received: from eggs.gnu.org ([2001:4830:134:3::10]:41435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faLzO-00070x-62
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faLzI-0000tI-DB
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:09:06 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:34195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faLzI-0000sy-7w
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:09:00 -0400
Received: by mail-qt0-x236.google.com with SMTP id m13-v6so1650600qth.1
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 07:09:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180702163345.17892-1-kraxel@redhat.com>
	<20180702163345.17892-2-kraxel@redhat.com>
	<20180702164326.ry3qghgjkjrshouh@sirius.home.kraxel.org>
	<6fba740c-3006-e6fd-9008-4ff3ed221b9b@amsat.org>
	<20180703062559.dn2dpecvicb6oelf@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <88fdebab-9982-eaa2-c62f-c48765b9647c@amsat.org>
Date: Tue, 3 Jul 2018 11:08:56 -0300
MIME-Version: 1.0
In-Reply-To: <20180703062559.dn2dpecvicb6oelf@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] warn about two vga cards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 07/03/2018 03:25 AM, Gerd Hoffmann wrote:
> On Mon, Jul 02, 2018 at 02:03:58PM -0300, Philippe Mathieu-Daudé wrote:
>> On 07/02/2018 01:43 PM, Gerd Hoffmann wrote:
>>> On Mon, Jul 02, 2018 at 06:33:45PM +0200, Gerd Hoffmann wrote:
>>>> Two vga cards will try to register for the same legacy (isa) ioports.
>>>> Due to this conflict only one of the two cards will work correctly in
>>>> vga mode.
>>>>
>>>> Print a warning message in that case.  Also try registering the ports
>>>> only once, so the first vga added to the system will work properly.
>>>
>>> Scratch that, not working as expected.
>>
>> Uh what's wrong?
> 
> Well, current behavior (with patch 1/2 applied, or with virtio-vga
> which doesn't use global_vmstate) is "last vga card wins", and that card
> actually works.  This patch breaks the vga display, even when tweaked
> that both vga and vbe ports are handled (so they don't end up being
> assigned to two different cards).  Didn't figure yet why.

With this patch the I/O registered is "first vga card wins", maybe there
is now a discrepancy...

> 
> Beside that I've noticed cirrus-vga doesn't use that function, so even
> the warning message doesn't work as intended in case cirrus is involved.

Oh... weird, OK.

Regards,

Phil.
