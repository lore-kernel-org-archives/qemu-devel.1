Received: from eggs.gnu.org ([2001:4830:134:3::10]:44873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eF7jq-00071u-HP
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 19:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eF7jn-0007dS-9z
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 19:09:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eF7jn-0007bn-3y
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 19:08:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0121CC047B8E
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 00:08:57 +0000 (UTC)
Date: Thu, 16 Nov 2017 08:08:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171116000853.GA14771@lemon>
References: <20171115121932.x4oh4aok5j5x6kxr@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171115121932.x4oh4aok5j5x6kxr@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] building user interfaces as modules
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

On Wed, 11/15 13:19, Gerd Hoffmann wrote:
>   Hi,
> 
> I'm trying to revamp the display initialization code:
> 
>   * First use a qapi type for the display options, so we can use
>     -blockdev style command line parsing for -display (not there yet,
>     but closer).
>   * Second initialize all user interfaces the same way and build a
>     registry for UIs.  Drops lots of #ifdefs from vl.c
>   * Finally this should make it *alot* easier to build user interfaces
>     as modules.
> 
> For SDL we already have sdl.mo defined in ui/Makefile.objs. so I tried
> that first.  Just flipping CONFIG_SDL from 'y' to 'm' doesn't work
> though.  sdl support isn't build, neither with nor without
> --enable-modules.

Perhaps you're missing a

    common-obj-m += ui/

line in Makefile?

Fam
