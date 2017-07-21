Received: from eggs.gnu.org ([2001:4830:134:3::10]:52579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dYbjQ-0006SI-Aw
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dYbjL-0001cw-9g
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:28:52 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1dYbjL-0001c4-35
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:28:47 -0400
Received: by mail-qt0-x243.google.com with SMTP id p25so6896040qtp.2
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 10:28:45 -0700 (PDT)
Date: Fri, 21 Jul 2017 13:28:43 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170721172843.GA6606@morn.lan>
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
	<1500533554.6553.1.camel@redhat.com>
	<3e0f92ea-58ce-abfb-1aed-4d56c1fa68b2@redhat.com>
	<1500631461.12926.5.camel@redhat.com>
	<eeba9fcf-4b52-2c24-af03-d88333cd2dc6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeba9fcf-4b52-2c24-af03-d88333cd2dc6@redhat.com>
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC PATCH 0/2] Allow RedHat PCI bridges
 reserve more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

On Fri, Jul 21, 2017 at 03:15:46PM +0300, Marcel Apfelbaum wrote:
> On 21/07/2017 13:04, Gerd Hoffmann wrote:
> > I'd prefer to have a single vendor capability for all resource
> > allocation hints provided by qemu.
> Sure, the capability looking something like:
> 
>    [flags: reserve-buses|reserve-IO|reserve-MEM|...]
>    [extra-buses][IO-size][MEM-size]
> 
>    if reserve-buses -> use 'extra-buses' value and so on

I don't have any objection to using a PCI capability, but I do wonder
if fw_cfg would be a better fit.  This information is purely qemu ->
firmware, right?

-Kevin
