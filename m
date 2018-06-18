Received: from eggs.gnu.org ([2001:4830:134:3::10]:60901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUsIo-00038K-UB
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUsIk-0005RQ-Kt
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:26:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fUsIk-0005QY-Fe
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:26:26 -0400
Date: Mon, 18 Jun 2018 13:26:22 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180618112622.aqih42lyypqfmmpg@sirius.home.kraxel.org>
References: <CAFEAcA_S41uEj=ae1efd042aTJcLUe+LXpD8WUwSkeWLnPCj=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_S41uEj=ae1efd042aTJcLUe+LXpD8WUwSkeWLnPCj=w@mail.gmail.com>
Subject: Re: [Qemu-devel] enabling smart-http git protocol on git.qemu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, Iliya Dyachenko <gandalfthewhite@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

  Hi,

> >   ScriptAliasMatch "^/git/(.*\.git/(HEAD|info/refs))$" \
> >     /usr/libexec/git-core/git-http-backend/$1
> >   ScriptAliasMatch "^/git/(.*\.git/git-(upload|receive)-pack)$" \
> >     /usr/libexec/git-core/git-http-backend/$1
> 
> Sounds like a good idea -- I've cc'd Jeff and Stefan (who
> are the people who care for our git server)...

While being at it: seabios git url has changed, can the mirror be
updated please?  New URL is:

https://git.seabios.org/seabios.git

thanks,
  Gerd
