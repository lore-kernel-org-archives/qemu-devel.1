Received: from eggs.gnu.org ([2001:4830:134:3::10]:60734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwmEN-0005j6-VT
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwmEK-0004Js-O9
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:32:43 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:44757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dwmEK-0004JN-HC
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:32:40 -0400
Received: by mail-wm0-x241.google.com with SMTP id m127so14742546wmm.1
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 02:32:40 -0700 (PDT)
Date: Tue, 26 Sep 2017 10:32:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170926093237.GF16834@stefanha-x1.localdomain>
References: <1504729728-23279-1-git-send-email-cota@braap.org>
	<c9b8e5af-3ccb-5747-78b4-de8e11e5e081@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9b8e5af-3ccb-5747-78b4-de8e11e5e081@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/6] initial plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Sep 26, 2017 at 06:22:31AM +0200, Thomas Huth wrote:
> On 06.09.2017 22:28, Emilio G. Cota wrote:
> > Related threads:
> >   [PATCH 00/13] instrument: Add basic event instrumentation
> >   Date: Mon, 24 Jul 2017 20:02:24 +0300
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07419.html
> > and
> >   [PATCH v4 00/20] instrument: Add basic event instrumentation
> >   Date:	Wed, 6 Sep 2017 20:22:41 +0300
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07419.html
> > 
> > This set does something similar to the instrumentation patches by Lluis,
> > but with a different implementation (and for now less events).
> > 
> > My focus has been on working on the skeleton of a (pseudo) stable API,
> > as Stefan requested. Of course more events would have to be added, but
> > before spending more time on this I'd like to get some feedback on the
> > core of the design. Patch 2 has all the details.
> 
> Sorry for my ignorance, but if you send a patch series like this, could
> you please elaborate a little bit more on the topic what this all is
> about? In this cover letter, you basically give only some pointers about
> other patch series and point the reader to patch 2, but also patch 2
> does not really have a proper *description* of what this is really all
> about. Sure, it's about plugins, but what kind of plugins? Audio? Video?
> CPU? Everything? If you send RFC, you should properly describe your
> vision first, and maybe give some examples, before you jump into the
> details.

Good point.

This series is about introducing a stable API/ABI and loadable
instrumentation plugin interface.  The goal is to offer dynamic binary
instrumentation frameworks like Intel's Pin and DynamoRIO offer.

In other words, performance analysis tasks (especially for TCG) can be
implemented in a shared library that is loaded by QEMU when running a
benchmark.

Stefan
