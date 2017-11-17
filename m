Received: from eggs.gnu.org ([2001:4830:134:3::10]:44058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eFhXN-0006XJ-Pm
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eFhXK-0007qi-D7
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:22:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eFhXK-0007oV-7G
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:22:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E60C267F5
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 14:22:29 +0000 (UTC)
Date: Fri, 17 Nov 2017 14:22:22 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171117142222.GV25830@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
	<20171117103046.15943-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171117103046.15943-3-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/24] sdl: remove -alt-grab and -ctrl-grab
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Nov 17, 2017 at 11:30:24AM +0100, Gerd Hoffmann wrote:
> With absolute pointer devices such as usb-tablet being widely used
> mouse grabs (for relative pointing devices) should be rarely needed
> these days.  So the benefit of the options to configure the hotkey
> modifiers for grab (and other actions) seems questionable.  Which
> is expecially true for the -ctrl-grab which isn't handled in the
> handle_keyup() code.
> 
> Drop the code, print a notice when the option is still used.

These need to go through the proper deprecation process too.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
