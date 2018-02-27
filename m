Received: from eggs.gnu.org ([2001:4830:134:3::10]:54803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benjamin.drung@profitbricks.com>) id 1eqhv7-0004rw-6i
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benjamin.drung@profitbricks.com>) id 1eqhv2-0006mR-Re
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:16:01 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <benjamin.drung@profitbricks.com>)
	id 1eqhv2-0006lx-Hl
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:15:56 -0500
Received: by mail-wm0-x22b.google.com with SMTP id x7so22460305wmc.0
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:15:56 -0800 (PST)
Message-ID: <1519748154.4922.9.camel@profitbricks.com>
From: Benjamin Drung <benjamin.drung@profitbricks.com>
Date: Tue, 27 Feb 2018 17:15:54 +0100
In-Reply-To: <20180217211639.3nmuftec64455qor@var.youpi.perso.aquilenet.fr>
References: <20180216125504.25955-1-benjamin.drung@profitbricks.com>
	<20180217211639.3nmuftec64455qor@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/1] slirp: Add domainname option to
 slirp's DHCP server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

Am Samstag, den 17.02.2018, 22:16 +0100 schrieb Samuel Thibault:
> Hello,
> 
> Benjamin Drung, on ven. 16 févr. 2018 13:55:03 +0100, wrote:
> > Or should the command line option be simpler, but how should it be
> > specified
> > then? Maybe
> > 
> >   -net
> > staticroute=10.0.2.0/24via10.0.2.2,staticroute=192.168.0.0/16via10.
> > 0.2.2
> 
> I guess 
> 
> >   -net
> > staticroute=10.0.2.0/24:10.0.2.2,staticroute=192.168.0.0/16:10.0.2.
> > 2
> 
> would be more mainstream.

Okay. I used this syntax to implement the static route support. See the
"slirp: Add classless static routes support to DHCP server" patch.

> I'm also wondering to which extent we want to extend our dhcp server,
> when a tap device can be used to plug (or proxy) an actual dhcp
> serveR.

I am using slirp's DHCP server to test custom build live images
locally. This should be simple to setup and run in contrast to our
"real" production environment with real hardware and actual DHCP
severs.

-- 
Benjamin Drung
System Developer
Debian & Ubuntu Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Email: benjamin.drung@profitbricks.com
URL: https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Geschäftsführer: Achim Weiss, Matthias Steinberg
