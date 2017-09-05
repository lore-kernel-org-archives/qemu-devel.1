Received: from eggs.gnu.org ([2001:4830:134:3::10]:60307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpAX3-00019s-Hz
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpAWz-0000PC-18
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:52:33 -0400
Date: Tue, 5 Sep 2017 11:52:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170905095215.GF4633@localhost.localdomain>
References: <20170831110518.10741-1-berrange@redhat.com>
	<20170831110518.10741-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170831110518.10741-3-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] block: use BDRV_SECTOR_SIZE in
 crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

Am 31.08.2017 um 13:05 hat Daniel P. Berrange geschrieben:
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)

I'm actually not sure about this one. Anything that is left after
patch 3 is probably not the arbitrary unit that qemu uses internally
for some interfaces, but the unit in which data is encrypted.

Basically, if just for fun we ever changed the unit of things like
bdrv_write() from 512 to 4096, then everything that needs to or at least
can be changed to use 4096 is BDRV_SECTOR_SIZE. But everything that
needs to stay on 512 (like I suspect most of the occurrences in the
crypto driver) is a different constant really (QCRYPTO_SECTOR_SIZE?).

Kevin
