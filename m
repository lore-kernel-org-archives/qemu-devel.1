Received: from eggs.gnu.org ([2001:4830:134:3::10]:34572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1duGEW-0002Zd-Eq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1duGER-0006J7-H8
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:58:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1duGER-0006IP-B5
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:58:23 -0400
Message-ID: <1505818700.12708.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 19 Sep 2017 12:58:20 +0200
In-Reply-To: <20170919100839.GH9536@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
	<1505223994.31639.20.camel@redhat.com>
	<20170912141910.GJ17633@redhat.com>
	<CAFEAcA-tdbzXBkyxXW_e15hVcbcfqSfKqke0PX6y-Cg6A62DzQ@mail.gmail.com>
	<20170912143007.GK17633@redhat.com>
	<1505390103.31557.11.camel@redhat.com>
	<CAFEAcA9JEGbiwKeSMyvnLrdE+2WrkRbYLcVJ+UpFnU1RymC1vQ@mail.gmail.com>
	<20170914124059.GD15518@redhat.com>
	<1505747575.4959.1.camel@redhat.com>
	<20170919100839.GH9536@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> > So I did the keymaps build with a recursive make call too, which
> > doesn't look that pretty ...
> 
> I don't think that's too ugly, but I wonder if there's some way to
> avoid
> the recursive make call.
> 
> It feels like this is a similar scenario to 'config-host.mak' being
> outdated. I don't entirely understand the logic yet, but we manage to
> automatically re-run configure and rebuild config-host.make, when
> configure changes, and that in turn affects which dependancies need
> rebuild.

Can't spot anything special in the Makefile.  Maybe make is clever
enough to figure that a rule updates a include file and starts over
then.

> I wonder if we can somehow integrate into that process, so
> that configure is responsible for checking out the git submodules,
> then make the re-running of configure trigger when .gitmodules
> changes content.

.gitmodules only has the repo links, not the checkout hashes.  So it
wouldn't be touched on updates.

I can't see an easy way for make to figure a submodule has changed,
other than running "git submodule update".

cheers,
  Gerd
