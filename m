Received: from eggs.gnu.org ([2001:4830:134:3::10]:49708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJJEJ-0003f3-Od
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJJEG-000664-Nl
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:46:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54510 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJJEG-00065k-Ig
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:46:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AFC7BB413
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 13:46:00 +0000 (UTC)
Date: Thu, 17 May 2018 15:45:59 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180517134559.uwne63xmqh2lucwq@sirius.home.kraxel.org>
References: <1526560782-18732-1-git-send-email-pbonzini@redhat.com>
	<20180517124403.GJ5657@redhat.com>
	<20180517125110.lhipiezmvifrg3n6@sirius.home.kraxel.org>
	<6e0213c3-017e-c794-a222-fde38676d7c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e0213c3-017e-c794-a222-fde38676d7c8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui: add x_keymap.o to modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, qemu-devel@nongnu.org

  Hi,

> > Related: can modules depend on modules, so we could make x_keymap a
> > module of its own and have both gtk and sdl depend on it?
> > 
> > That would also be useful when trying to modularize spice.
> 
> How hard would it be to modularize the libspice-server side?  The part
> of the library that is used by QXL rendering should have much fewer
> dependencies than the part that is used for keyboard, mouse, audio,
> vmchannel/agent, etc.

kbd, mouse, audio is needed on the client side and is not part of
libspice-server anyway.  So spice is much less of a burden compared
to sdl/gtk which bring alot of ui toolkit deps.

cheers,
  Gerd
