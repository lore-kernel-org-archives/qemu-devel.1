Received: from eggs.gnu.org ([2001:4830:134:3::10]:44034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmdz9-0008GA-QJ
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmdz5-0000aA-Sr
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:43:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dmdz5-0000a0-MN
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:43:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A49A051B
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 10:43:02 +0000 (UTC)
Date: Tue, 29 Aug 2017 11:42:54 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170829104254.GF3783@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-17-marcandre.lureau@redhat.com>
	<87d17ur7y1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d17ur7y1.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 16/26] qapi: add conditions to VNC
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Aug 17, 2017 at 09:04:38AM +0200, Markus Armbruster wrote:
> Copying our resident VNC maintainer^Wodd fixer Gerd.
> 
> Also copying Dan for QCryptoCipherAlgorithm.
> 
> Gerd, Dan, this patch is about making VNC support visible in
> query-qmp-schema, by having the QAPI generators generate suitable
> ifdeffery.  Bonus: no need for QMP command stubs for
> !defined(CONFIG_VNC).

[snip]

> * QCryptoCipherAlgorithm
> 
>   This:
> 
>     # @des-rfb: RFB specific variant of single DES. Do not use except in VNC.
> 
>   I guess we could compile this out if we wanted to.  I doubt we do, but
>   Dan might have other ideas.

It isn't worth the effort to make that conditionally compiled. We getting
DES from nettle/gcrypt these days, instead of our custom in-tree desrfb.c
file, so its no burden to have it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
