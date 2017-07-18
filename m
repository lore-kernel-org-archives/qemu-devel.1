Received: from eggs.gnu.org ([2001:4830:134:3::10]:33947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUj6-0006i0-Rv
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUj5-0002Rq-RE
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:47:56 -0400
Date: Tue, 18 Jul 2017 16:47:39 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170718154739.GO11927@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-5-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1500385286-21142-5-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 04/10]
 tests/test-qobject-input-visitor: Drop redundant test
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

On Tue, Jul 18, 2017 at 03:41:20PM +0200, Markus Armbruster wrote:
> test_visitor_in_alternate() tests UserDefAlternate with inadmissible
> input.  test_visitor_in_fail_alternate() does basically the same.
> Drop the former, keep the latter.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qobject-input-visitor.c | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
