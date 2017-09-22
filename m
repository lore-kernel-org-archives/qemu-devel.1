Received: from eggs.gnu.org ([2001:4830:134:3::10]:51542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dwW4t-0003fJ-95
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dwW4r-0006yR-6v
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:17:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45199)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dwW4r-0006yF-2E
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:17:49 -0400
Date: Fri, 22 Sep 2017 18:48:55 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170922224855.GA6905@flamenco>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v6 00/22] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Sep 13, 2017 at 12:53:43 +0300, Lluís Vilanova wrote:
> The instrumentation code is dynamically loaded as a library into QEMU either
> when it starts or later using its remote control interfaces. The loaded code
> only has access to function explicitly exported through the QI_VPUBLIC macro.
> 
> This series is branch 'devel-instrument' in
> https://code.gso.ac.upc.edu/git/qemu-dbi.

Is this up to date? That tree doesn't build for me with --enable-instrument; I
get the same error I got in v4:

  CC      x86_64-linux-user/instrument/state.o
/data/src/qemu2/instrument/trace.c:13:30: fatal error: qemu-instr/trace.h: No such file or directory
compilation terminated.
/data/src/qemu2/rules.mak:66: recipe for target 'instrument/trace.o' failed

Or maybe I'm doing something wrong?
I'm configuring with `configure --target-list=x86_64-linux-user --enable-instrument'.

Thanks,

		Emilio
