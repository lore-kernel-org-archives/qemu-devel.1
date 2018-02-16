Received: from eggs.gnu.org ([2001:4830:134:3::10]:54102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benjamin.drung@profitbricks.com>) id 1emhmZ-0008WQ-MP
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:18:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benjamin.drung@profitbricks.com>) id 1emhmV-0000cX-BD
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:18:39 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:40351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <benjamin.drung@profitbricks.com>)
	id 1emhmU-0000bo-Sd
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:18:35 -0500
Received: by mail-wm0-x235.google.com with SMTP id v10so3722198wmh.5
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 07:18:34 -0800 (PST)
Message-ID: <1518794311.4749.64.camel@profitbricks.com>
From: Benjamin Drung <benjamin.drung@profitbricks.com>
Date: Fri, 16 Feb 2018 16:18:31 +0100
In-Reply-To: <ff0868d2-98c0-a0ee-8139-0367c29a03b1@redhat.com>
References: <20180216125504.25955-1-benjamin.drung@profitbricks.com>
	<20180216125504.25955-2-benjamin.drung@profitbricks.com>
	<ff0868d2-98c0-a0ee-8139-0367c29a03b1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/1] slirp: Add domainname option to
 slirp's DHCP server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel@nongnu.org

Am Freitag, den 16.02.2018, 09:15 -0600 schrieb Eric Blake:
> On 02/16/2018 06:55 AM, Benjamin Drung wrote:
> > This patch will allow the user to include the domainname option in
> > replies from the built-in DHCP server.
> > 
> > Signed-off-by: Benjamin Drung <benjamin.drung@profitbricks.com>
> > ---
> > +++ b/qapi/net.json
> > @@ -160,6 +160,8 @@
> >   # @dnssearch: list of DNS suffixes to search, passed as DHCP
> > option
> >   #             to the guest
> >   #
> > +# @domainname: guest-visible domain name of the virtual nameserver
> > +#
> 
> Missing a '(since 2.12)' tag.

Okay, I will add that. Is there a chance to get this patch backported?

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
