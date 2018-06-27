Received: from eggs.gnu.org ([2001:4830:134:3::10]:41885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fY6Fn-0006eB-HS
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fY6Fj-0005sK-9A
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:56:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fY6Fj-0005sA-3y
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:56:39 -0400
Date: Wed, 27 Jun 2018 10:56:37 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180627085637.fyfyhcsnccxjtce6@sirius.home.kraxel.org>
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
	<0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com>
	<87fu18ach6.fsf_-_@dusky.pond.sub.org>
	<aa9afd06-19da-1f48-c20c-2f1eff2e861a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa9afd06-19da-1f48-c20c-2f1eff2e861a@redhat.com>
Subject: Re: [Qemu-devel] Drop support for 32bit hosts in qemu?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org

  Hi,

> > "Compiles on host X" is also a need, but it's a different one.
> > Evidence: "Supported build platforms" has its own appendix, separate
> > from "Deprecated features".  It's mum on 32-bit hosts.
> 
> Theoretically I'd agree, but actually it's more than that: If we drop
> support for 32-bit hosts, we could also drop the qemu-system-i386,
> qemu-system-ppc and qemu-system-arm targets, since qemu-system-x86_64,
> qemu-system-ppc64 and qemu-system-aarch64 are a clear superset of these.
> But that would also mean a change of the user interface, since the name
> of the executable changes, and at least for ppc, there are also subtle
> differences (different default machine type, different default CPU types).

We don't have to do it all at once though.  We could drop 32bit host
support now and figure how to handle qemu-system-i386 & friends later.

Just removing them would be one option.  Or have them check the
executable name and pick defaults based on that, so we can just symlink
qemu-system-ppc to qemu-system-ppc64.

cheers,
  Gerd
