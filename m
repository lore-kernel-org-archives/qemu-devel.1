Received: from eggs.gnu.org ([2001:4830:134:3::10]:40416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRXK1-0002TF-87
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRXJy-0005O5-4H
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:58:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRXJx-0005Nx-VM
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:58:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 382263DE2F
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 06:58:09 +0000 (UTC)
Date: Tue, 27 Nov 2018 07:58:08 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181127065808.ph7pv6brnaeuyqix@sirius.home.kraxel.org>
References: <20181122071613.2889-1-kraxel@redhat.com>
	<87h8g4lyyh.fsf@dusky.pond.sub.org>
	<20181126151325.2pfues2q7vuqin4y@sirius.home.kraxel.org>
	<87zhtvixnr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhtvixnr.fsf@dusky.pond.sub.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

  Hi,

> If it's not too much trouble, please tweak the commit message to be a
> bit more explicit.  Perhaps:
> 
>     Add query-display-options command, which allows querying the qemu
>     display configuration.  This isn't particularly useful, except it
>     exposes QAPI type DisplayOptions in query-qmp-schema, so that
>     libvirt can discover recently added -display parameter rendernode
>     (commit d4dc4ab133b).  Works around lack of sufficiently powerful
>     command line introspection.

Done, pull req with this and other 3.1 fixes sent.

> This should give me a fighting chance to remember deprecating the
> command once we got sufficiently powerful command line introspection.

I'm wondering how difficuilt it would be to add that when limiting that
to the command line switches which already use qapi parsers (-blockdev
and -display as far I know).  Might increase the motivation of others to
help moving parsers from whatever they do today (QemuOpts, ...) to qapi
to get introspection support ;)

cheers,
  Gerd
