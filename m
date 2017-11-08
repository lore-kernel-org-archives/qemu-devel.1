Received: from eggs.gnu.org ([2001:4830:134:3::10]:53686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eCNzH-0003U4-A0
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:53:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eCNzC-0007tQ-F3
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:53:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eCNzC-0007t6-9O
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:53:34 -0500
Date: Wed, 8 Nov 2017 11:53:32 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171108105332.etwcm4nyb6rqmprn@sirius.home.kraxel.org>
References: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
Subject: Re: [Qemu-devel] Yet another git submodule rant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Wed, Nov 08, 2017 at 10:57:21AM +0100, Thomas Huth wrote:
> 
> That automatic git submodule stuff now broke my workflow again. I
> usually keep the git repository on my laptop and then simply rsync the
> sources (without .git directories) to my target machine to compile it
> there.

How about excluding all files listed in .gitignore from rsync?  Which I
guess would be a good idea anyway because you don't want sync over the
build artifacts to the target machine if you want compile there.  Might
be as simple as "rsync --exclude-from .gitignore" (didn't test though).

Or syncronize using git instead of rsync.  This is what I am doing.

cheers,
  Gerd
