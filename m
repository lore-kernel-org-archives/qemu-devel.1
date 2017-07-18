Received: from eggs.gnu.org ([2001:4830:134:3::10]:33766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUiX-0005uc-AX
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUiW-00020K-IG
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:47:21 -0400
Date: Tue, 18 Jul 2017 16:47:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170718154707.GN11927@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-4-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1500385286-21142-4-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 03/10] qapi: Introduce a first
 class 'null' type
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

On Tue, Jul 18, 2017 at 03:41:19PM +0200, Markus Armbruster wrote:
> I expect the 'null' type to be useful mostly for members of alternate
> types.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/qobject.h              |  4 ++--
>  include/qemu/typedefs.h                 |  1 +
>  scripts/qapi.py                         |  5 ++++-
>  tests/qapi-schema/qapi-schema-test.json |  3 ++-
>  tests/qapi-schema/qapi-schema-test.out  |  1 +
>  tests/test-qobject-input-visitor.c      |  5 +++++
>  tests/test-qobject-output-visitor.c     | 10 ++++++++++
>  7 files changed, 25 insertions(+), 4 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
