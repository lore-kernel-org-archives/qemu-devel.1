Received: from eggs.gnu.org ([2001:4830:134:3::10]:44488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRIeu-0001cB-Dv
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRIZj-0006av-Dt
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:13:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRIZj-0006Zb-7D
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:13:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 425943082A20
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 15:13:26 +0000 (UTC)
Date: Mon, 26 Nov 2018 16:13:25 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181126151325.2pfues2q7vuqin4y@sirius.home.kraxel.org>
References: <20181122071613.2889-1-kraxel@redhat.com>
	<87h8g4lyyh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8g4lyyh.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3] qapi: add query-display-options command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Nov 26, 2018 at 03:01:42PM +0100, Markus Armbruster wrote:
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
> > Add query-display-options command, which allows querying the qemu
> > display configuration, and -- as an intentional side effect -- makes
> > DisplayOptions discoverable via query-qmp-schema so libvirt can go
> > figure which display options are supported.
> >
> > Use case: commit d4dc4ab1 added rendernode parameter for egl-headless.
> 
> I understand why exposing DisplayOptions in query-qmp-schema is useful.
> But can you think of a use for the new command?
> 
> If not, then this is a workaround for lack of CLI introspection.
> That's okay, ball's in my court on that.  But I'd like to have the
> "workaroundness" spelled out in the commit message then.

Sure.  I assumed the "intentional side effect" message is clear enough
though.

The command itself isn't that helpful, you should know how you have
started qemu ...

cheers,
  Gerd
