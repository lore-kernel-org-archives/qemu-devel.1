Received: from eggs.gnu.org ([2001:4830:134:3::10]:46233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1eAiLF-0004lx-Ip
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1eAiLC-0006fX-El
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:13:25 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:44459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1eAiLC-0006eR-8z
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:13:22 -0400
Received: by mail-qt0-x22d.google.com with SMTP id 8so4680751qtv.1
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 13:13:21 -0700 (PDT)
Date: Fri, 3 Nov 2017 16:13:19 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20171103201319.GA26212@morn.lan>
References: <1509638660.11873.13.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1509638660.11873.13.camel@redhat.com>
Subject: Re: [Qemu-devel] [SeaBIOS] seabios serial console vs. sgabios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: seabios <seabios@seabios.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Nov 02, 2017 at 05:04:20PM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> One problem we have with the serial console support in seabios and
> sgabios:  It can happen that both are activated.  We'll go fix that in
> qemu, but that'll work for new qemu versions only, not for the old
> already released ones.
> 
> So I think it would be useful if seabios makes sure sgabios and serial
> console are not both active at the same time, i.e. in case we find
> "vgaroms/sgabios.bin" being present either turn off builtin serial
> console, or don't load sgabios (and possibly also enable builtin serial
> console).

I'm not sure on this one.  If qemu tells seabios to load a rom, I
think it really should do that.

If future versions of qemu will be changed to not request sgabios when
sercon is enabled, then maybe the issue isn't large enough to worry
about (it only affects no-graphics, new seabios, old qemu).  If that's
not safe, perhaps we should revisit how seabios enables sercon so
there is no confusion.

-Kevin
