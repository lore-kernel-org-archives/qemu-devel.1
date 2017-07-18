Received: from eggs.gnu.org ([2001:4830:134:3::10]:37327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUsQ-0008G9-IN
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUsP-00005c-8T
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:57:34 -0400
Date: Tue, 18 Jul 2017 16:57:24 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170718155724.GR11927@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-8-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1500385286-21142-8-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 07/10] migration: Clean up around
 tls_creds, tls_hostname
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

On Tue, Jul 18, 2017 at 03:41:23PM +0200, Markus Armbruster wrote:
> Optional MigrationParameters members tls_creds and tls_hostname can't
> actually be absent outside qmp_migrate_set_parameters() since commit
> 4af245d (v2.9.0).
> 
> Note that commit 4af245d reverted the part of commit de63ab6 (v2.8.0)
> that made tls_creds and tls_hostname absent instead of "" in the value
> of query-migrate-parameters, even though commit de63ab6 called that a
> mistake.  What a mess.
> 
> Drop the redundant tests for presence, and update documentation.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp.c                 |  6 ++++--
>  migration/migration.c |  4 ++--
>  qapi-schema.json      | 11 +++++------
>  3 files changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
