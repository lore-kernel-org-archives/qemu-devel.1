Received: from eggs.gnu.org ([2001:4830:134:3::10]:57289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1daeZd-0000AD-Nj
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1daeZd-0002Fk-3r
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:55:13 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:43218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1daeZc-0002EO-Uc
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:55:13 -0400
Date: Thu, 27 Jul 2017 10:55:09 +0200 (CEST)
From: Stefan Fritsch <sf@sfritsch.de>
In-Reply-To: <1500617358.12926.1.camel@redhat.com>
Message-ID: <alpine.DEB.2.11.1707271052020.31093@manul.sfritsch.de>
References: <1500541371-24788-1-git-send-email-sf@sfritsch.de>
	<1500541371-24788-2-git-send-email-sf@sfritsch.de>
	<1500617358.12926.1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [Qemu-devel] [PATCH v2 1/8] usb-ccid: Add support to dump all
 USB packets
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

On Fri, 21 Jul 2017, Gerd Hoffmann wrote:

> > index bef1f03c42..624dc2c447 100644
> > --- a/hw/usb/dev-smartcard-reader.c
> > +++ b/hw/usb/dev-smartcard-reader.c
> > @@ -54,9 +54,25 @@ do { \
> >  #define D_INFO 2
> >  #define D_MORE_INFO 3
> >  #define D_VERBOSE 4
> > +#define D_TRACE 5
> > +#define D_REMOTEIO 10
> 
> Considered converting all DPRINTFs into tracepoints instead?
> 
> Then you can turn then on/off individually as needed.

I want to have D_WARN enabled by default, so those cannot be trace points. 
And there are some that use qemu_hexdump which cannot be converted, 
either. I don't think it makes sense to convert the rest.

Cheers,
Stefan
