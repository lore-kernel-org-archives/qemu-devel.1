Received: from eggs.gnu.org ([2001:4830:134:3::10]:32873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6p8a-0007AE-Nn
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6p8W-0003ZF-R1
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:40:16 -0400
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:44002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6p8W-0003Yf-KU
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:40:12 -0400
Received: by mail-qt0-x22e.google.com with SMTP id j58so28733517qtj.0
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 19:40:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1058f4a0-9b2f-ab3f-d789-da5ae782acdf@amsat.org>
Date: Mon, 23 Oct 2017 23:40:09 -0300
MIME-Version: 1.0
In-Reply-To: <20171023210803.20998-1-makovick@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] SDL2 various fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jindrich Makovicka <makovick@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Cc'ing Gerd, the maintainer of this area, please include him if you respin.

On 10/23/2017 06:07 PM, Jindrich Makovicka wrote:
> I am sending a couple of patches I needed to apply to make the
> SDL2 GUI work reasonably on Debian Sid, which recently switched
> from SDL1.
> 
> The main issue is that the QEMU window stops updating when it is
> minimized, or after a virtual desktop switch. Then, there are
> some regressions due to recently added terminals in multiple
> windows, and some issues with fullscreen mode and window scaling.
> 
> I am using MATE desktop 1.18 and SDL 2.0.6.
