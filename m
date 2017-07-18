Received: from eggs.gnu.org ([2001:4830:134:3::10]:33405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUhY-0004Tz-KS
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUhX-0001Hc-Os
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:46:20 -0400
Date: Tue, 18 Jul 2017 16:46:04 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170718154604.GM11927@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-3-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1500385286-21142-3-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 02/10] qapi: Use QNull for a more
 regular visit_type_null()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

On Tue, Jul 18, 2017 at 03:41:18PM +0200, Markus Armbruster wrote:
> Make visit_type_null() take an @obj argument like its buddies.  This
> helps keeing the next commit simple.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/ppc/spapr_drc.c                  |  4 +++-
>  include/qapi/visitor-impl.h         |  3 ++-
>  include/qapi/visitor.h              |  8 ++++----
>  qapi/qapi-clone-visitor.c           |  5 +++--
>  qapi/qapi-dealloc-visitor.c         |  6 +++++-
>  qapi/qapi-visit-core.c              |  7 ++++---
>  qapi/qobject-input-visitor.c        |  6 +++++-
>  qapi/qobject-output-visitor.c       |  3 ++-
>  qapi/string-input-visitor.c         |  8 +++++++-
>  qapi/string-output-visitor.c        |  3 ++-
>  qapi/trace-events                   |  2 +-
>  tests/check-qnull.c                 |  9 +++++++--
>  tests/test-qobject-input-visitor.c  | 13 +++++++++----
>  tests/test-qobject-output-visitor.c |  3 ++-
>  14 files changed, 56 insertions(+), 24 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
