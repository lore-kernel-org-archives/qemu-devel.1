Received: from eggs.gnu.org ([2001:4830:134:3::10]:40226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCN6w-00029A-7B
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:57:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCN6u-0002vL-BO
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:57:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eCN6u-0002v1-4X
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:57:28 -0500
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
Date: Wed, 8 Nov 2017 10:57:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Yet another git submodule rant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


That automatic git submodule stuff now broke my workflow again. I
usually keep the git repository on my laptop and then simply rsync the
sources (without .git directories) to my target machine to compile it
there. Used to work great for years. Now it's broken, the build process
complains:

GIT submodule checkout is out of date. Please run
  scripts/git-submodule.sh update
from the source directory checkout /home/thuth/devel/qemu

Running "scripts/git-submodule.sh update" did not fix the issue at all -
I first had to tinker with it for a while to find out that I simply have
to delete ".git-submodule-status" in my git tree to fix the issue.

I've got the feeling that all this submodule crap is constantly causing
pain ... do we really need this? Can't we find another solution instead?
Or at least stop modifying files automatically in the $SRC_PATH ?

... ok, sorry for the harsh words, ... but now that I've written this
down, I feel at least a little bit better ...

 Thomas
