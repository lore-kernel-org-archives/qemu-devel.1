Received: from eggs.gnu.org ([2001:4830:134:3::10]:59923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecAZn-0000BF-0s
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecAZj-000845-Qm
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:49:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ecAZj-00083B-KX
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:49:51 -0500
Date: Thu, 18 Jan 2018 13:49:46 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180118134946.GB16350@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171101142526.1006-1-ross.lagerwall@citrix.com>
	<20171101142526.1006-3-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171101142526.1006-3-ross.lagerwall@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] io: Fix QIOChannelFile when
 creating and opening read-write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: qemu-devel@nongnu.org

On Wed, Nov 01, 2017 at 02:25:24PM +0000, Ross Lagerwall wrote:
> The code wrongly passes the mode to open() only if O_WRONLY is set.
> Instead, the mode should be passed when O_CREAT is set (or O_TMPFILE on
> Linux). Fix this by always passing the mode since open() will correctly
> ignore the mode if it is not needed. Add a testcase which exercises this
> bug and also change the existing testcase to check that the mode of the
> created file is correct.
> 
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
> Changed in v2:
> * Separated from qemu_open() change.
> 
>  include/io/channel-file.h    |  2 +-
>  io/channel-file.c            |  6 +-----
>  tests/test-io-channel-file.c | 29 +++++++++++++++++++++++++----
>  3 files changed, 27 insertions(+), 10 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
