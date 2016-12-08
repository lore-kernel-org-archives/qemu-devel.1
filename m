Received: from eggs.gnu.org ([2001:4830:134:3::10]:55846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEzT1-0007SK-VT
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEzT1-0005bE-1f
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:14:35 -0500
Date: Thu, 8 Dec 2016 14:14:23 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161208141423.GK26641@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
	<1481203391-9523-6-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481203391-9523-6-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 5/6] iscsi: Add timeout option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, pl@kamp.de, ptoscano@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Thu, Dec 08, 2016 at 02:23:10PM +0100, Kevin Wolf wrote:
> This was previously only available with -iscsi. Again, after this patch,
> the -iscsi option only takes effect if an URL is given. New users are
> supposed to use the new driver-specific option.
> 
> All -iscsi options have a corresponding driver-specific option for the
> iscsi block driver now.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/iscsi.c | 37 +++++++++++--------------------------
>  1 file changed, 11 insertions(+), 26 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
