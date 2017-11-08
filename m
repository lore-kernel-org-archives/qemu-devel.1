Received: from eggs.gnu.org ([2001:4830:134:3::10]:45886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.weil@weilnetz.de>) id 1eCT4c-0006Db-AA
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.weil@weilnetz.de>) id 1eCT4X-0007oZ-C0
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:19:30 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:41560
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.weil@weilnetz.de>)
	id 1eCT4X-0007nS-4N
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:19:25 -0500
References: <CAJSP0QUOCzWfM614zRKme+GecU+NVNOFcoGz1wdBcdgKzrq-LQ@mail.gmail.com>
From: Stefan Weil <stefan.weil@weilnetz.de>
Message-ID: <1a47a48e-0917-23ba-6b83-e22e35289f86@weilnetz.de>
Date: Wed, 8 Nov 2017 17:19:25 +0100
MIME-Version: 1.0
In-Reply-To: <CAJSP0QUOCzWfM614zRKme+GecU+NVNOFcoGz1wdBcdgKzrq-LQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Moving release tarballs to a CDN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Jeff Cody <jcody@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Am 08.11.2017 um 16:33 schrieb Stefan Hajnoczi:
> Hi Mike and Jeff,
> qemu.org's bandwidth usage is dominated by release tarball downloads.
> This puts qemu.org bandwidth usage in the 2+ TB/month range.

Hi Stefan,

how much of this traffic is caused by web spiders?

>From my own binaries I know that the bots of the
different search engines cause most of the traffic,
if they are allowed to do so.

Usually they respect robots.txt. There is no
https://www.qemu.org/robots.txt currently.
Nor is there a https://download.qemu.org/robots.txt.
Adding both would reduce the downloads, maybe
enough to fix the problem.

Or do you see an advantage from bots which download
QEMU tarballs? robots.txt can also block only
selected bots.

Regards
Stefan

PS. There is a https://git.qemu.org/robots.txt.
