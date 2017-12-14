Received: from eggs.gnu.org ([2001:4830:134:3::10]:60523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ePX9P-00064I-Os
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:18:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ePX9N-0006Ie-SW
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:18:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ePX9N-0006HX-LM
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:18:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1A37883A4
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 17:18:24 +0000 (UTC)
Date: Thu, 14 Dec 2017 18:18:20 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171214171820.rmoeze7kizr6vq2s@eukaryote>
References: <20171212135600.14965-1-dgilbert@redhat.com>
	<20171212182353.hme665vsaohxdvzv@eukaryote>
	<20171213201145.GB8501@work-vm>
	<20171214112603.7gkt3dwgxoioybse@eukaryote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171214112603.7gkt3dwgxoioybse@eukaryote>
Subject: Re: [Qemu-devel] [PATCH] docs: Convert migration.txt to rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com

On Thu, Dec 14, 2017 at 12:26:03PM +0100, Kashyap Chamarthy wrote:
> On Wed, Dec 13, 2017 at 08:11:46PM +0000, Dr. David Alan Gilbert wrote:

[...]

> > > > -   Command: 'postcopy listen'
> > > > -   The device state
> > > 
> > > In my local Sphinx-based HTML rendering, the above "The device state"
> > > ended up being bold somehow.
> > 
> > Any idea why? It's fine both in vim and rst2html-3's output.
> 
> Don't know yet.  You can see here in the Sphinx-rendered HTML version:

So it's due to the indentation below the line "The device state".  You
can either put an extra blank line before indenting the next line:

   - The device state:

       A series of sections, identical to the precopy streams device
       state stream containing everything except postcopiable devices
       (i.e. RAM)

Or, just indent it to the same level:

   - The device state: A series of sections, identical to the precopy
     streams device state stream containing everything except
     postcopiable devices (i.e.  RAM)

Same applies for other places where bold text came in at unwanted places.

[...]

-- 
/kashyap
