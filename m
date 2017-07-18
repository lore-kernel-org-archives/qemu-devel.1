Received: from eggs.gnu.org ([2001:4830:134:3::10]:39154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUwK-00044A-7p
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUwJ-0002HI-5l
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:01:36 -0400
Date: Tue, 18 Jul 2017 17:01:18 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170718160118.GT11927@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-10-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1500385286-21142-10-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 09/10] migration: Unshare
 MigrationParameters struct for now
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

On Tue, Jul 18, 2017 at 03:41:25PM +0200, Markus Armbruster wrote:
> Commit de63ab6 "migrate: Share common MigrationParameters struct"
> reused MigrationParameters for the arguments of
> migrate-set-parameters, with the following rationale:
> 
>     It is rather verbose, and slightly error-prone, to repeat
>     the same set of parameters for input (migrate-set-parameters)
>     as for output (query-migrate-parameters), where the only
>     difference is whether the members are optional.  We can just
>     document that the optional members will always be present
>     on output, and then share a common struct between both
>     commands.  The next patch can then reduce the amount of
>     code needed on input.
> 
> I need to unshare them to correct a design flaw in a stupid, but
> minimally invasive way, in the next commit.  We can restore the
> sharing when we redo that patch in a less stupid way.  Add a suitable
> TODO comment.
> 
> Note that I revert only the sharing part of commit de63ab6, not the
> part that made the members of query-migrate-parameters' result
> optional.  The schema (and thus introspection) remains inaccurate for
> query-migrate-parameters.  If we decide not to restore the sharing, we
> should revert that part, too.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp.c                 |  4 +--
>  migration/migration.c | 12 +++++---
>  qapi-schema.json      | 85 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 87 insertions(+), 14 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
