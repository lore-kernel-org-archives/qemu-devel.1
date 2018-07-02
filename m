Received: from eggs.gnu.org ([2001:4830:134:3::10]:34545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2FC-0003Gr-EU
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2F8-00087S-EL
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:04:06 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:42823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2F8-000870-AV
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:04:02 -0400
Received: by mail-qt0-x241.google.com with SMTP id y31-v6so14366581qty.9
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 10:04:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180702163345.17892-1-kraxel@redhat.com>
	<20180702163345.17892-2-kraxel@redhat.com>
	<20180702164326.ry3qghgjkjrshouh@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6fba740c-3006-e6fd-9008-4ff3ed221b9b@amsat.org>
Date: Mon, 2 Jul 2018 14:03:58 -0300
MIME-Version: 1.0
In-Reply-To: <20180702164326.ry3qghgjkjrshouh@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] warn about two vga cards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 07/02/2018 01:43 PM, Gerd Hoffmann wrote:
> On Mon, Jul 02, 2018 at 06:33:45PM +0200, Gerd Hoffmann wrote:
>> Two vga cards will try to register for the same legacy (isa) ioports.
>> Due to this conflict only one of the two cards will work correctly in
>> vga mode.
>>
>> Print a warning message in that case.  Also try registering the ports
>> only once, so the first vga added to the system will work properly.
> 
> Scratch that, not working as expected.

Uh what's wrong?

/me missed it.

> Looked like a simple change but appearently isn't.
> 
> cheers,
>   Gerd
> 
> 
