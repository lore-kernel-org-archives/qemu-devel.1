Received: from eggs.gnu.org ([2001:4830:134:3::10]:36325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dphnU-0004v9-Gt
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dphnP-0005yK-Rw
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:23:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dphnP-0005y9-NM
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:23:39 -0400
Date: Wed, 6 Sep 2017 17:23:38 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170906212338.GD25558@flamenco>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
	<150472074219.24907.5510718414753398145.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <150472074219.24907.5510718414753398145.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v4 09/20] instrument: Add basic control
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Sep 06, 2017 at 20:59:02 +0300, Lluís Vilanova wrote:
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  Makefile                           |    5 +++
>  configure                          |    1 +
>  instrument/Makefile.objs           |    2 +
>  instrument/control.c               |   28 +++++++++++++++++
>  instrument/control.h               |   44 +++++++++++++++++++++++++++
>  instrument/control.inc.h           |   25 ++++++++++++++++
>  instrument/error.h                 |   28 +++++++++++++++++
>  instrument/events.h                |   37 +++++++++++++++++++++++
>  instrument/events.inc.h            |   11 +++++++

Am I the only one who finds this control vs. events division confusing?

Also, do we need all these many files, even for the public API?

And why the .inc's?

Thanks,
		E.
