Received: from eggs.gnu.org ([2001:4830:134:3::10]:38623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eicPq-0002bl-5h
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 03:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eicPm-0005mE-Cd
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 03:46:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eicPm-0005lX-7J
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 03:46:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9250081DF4
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 08:46:12 +0000 (UTC)
Date: Mon, 5 Feb 2018 09:46:11 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180205084611.cmmb5xvf3ggivfqw@sirius.home.kraxel.org>
References: <20180202111022.19269-1-kraxel@redhat.com>
	<20180202111022.19269-3-kraxel@redhat.com>
	<3d0177d1-130b-6528-30ae-7f21e4bb56dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d0177d1-130b-6528-30ae-7f21e4bb56dd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 02/12] vl: deprecate -alt-grab and
 -ctrl-grab
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

  Hi,

> > +@subsection -alt-grab and -ctrl-grab (since 2.12.0)
> > +
> > +The ``-alt-grab'' and ``-ctrl-grab'' arguments are deprecated.  They
> > +work with SDL only.  They will eventually replaced with a new way to
> > +configure hotkeys which works consistently across all user interfaces.
> 
> Should the error message printed to the user document the new interface
> to be used instead? But that implies that we shouldn't deprecate this
> until the new interface for configuring hotkeys has been finalized...

Supporting two ways of specifying hotkeys at the same time isn't going
to fly.  So my plan is to deprecate the old way now, and then some day
in the future drop the old args and support the new ones.

cheers,
  Gerd
