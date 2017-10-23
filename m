Received: from eggs.gnu.org ([2001:4830:134:3::10]:33941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6d3X-0001bi-DC
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 09:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6d3R-00085a-CA
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 09:46:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40101)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e6d3R-00085A-5F
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 09:46:09 -0400
Date: Mon, 23 Oct 2017 14:46:03 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171023134603.GL16472@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1B925CC0CD9F3341B32D442251E7E1DC391048B2@shsmsx102.ccr.corp.intel.com>
	<CAFEAcA81-ht6tTc-nwiios3pjnWjNC49gZp8RQAOdNntM3tkUw@mail.gmail.com>
	<1B925CC0CD9F3341B32D442251E7E1DC39106402@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1B925CC0CD9F3341B32D442251E7E1DC39106402@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] qemu compile error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Chen, Farrah" <farrah.chen@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Hu, Robert" <robert.hu@intel.com>

On Mon, Oct 23, 2017 at 01:43:30PM +0000, Chen, Farrah wrote:
> Thank you very much!
> I removed "1>/dev/null 2>&1" in scripts/git-submodule.sh and found I can't
> git clone git://git.qemu-project.org/dtc.git without tsocks.
> I used Daniel's approach, created the wrapper script called 'git' that runs
> 'exec tsocks /usr/bin/git "$@"', it succeeded.
> Considering we still need to use bare 'git'  to access our internal repo,
> so, for the time being, I use tsocks to git clone
> git://git.qemu-project.org/dtc.git and git://git.qemu.org/keycodemapdb.git
> first, then modified url in .gitmodules before compiling. It works.

To avoid need to create the wrapper script, I copied you on a patch that
would let you run

  ./configure --with-git="tsocks git"

As a further alternative, I think it might also be possible to just run

  tsocks ./scripts/git-submodule.sh dtc ui/keycodemapdb

immediately after configure, but before running make.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
