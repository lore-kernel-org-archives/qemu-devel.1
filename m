Received: from eggs.gnu.org ([2001:4830:134:3::10]:40845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dekfm-0007tQ-QY
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dekfh-0001se-VO
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:14:30 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1502117160-24655-15-git-send-email-armbru@redhat.com> (Markus
	Armbruster's message of "Mon, 7 Aug 2017 16:45:18 +0200")
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-15-git-send-email-armbru@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 07 Aug 2017 18:07:01 +0200
Message-ID: <87poc7e50a.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 14/56] migration: Fix
 migrate-set-cache-size error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> qmp_migrate_set_cache_size() calls xbzrle_cache_resize() to do the
> actual work, which in turn calls cache_init() to resize the cache.  If
> cache_init() fails, xbzrle_cache_resize() reports that error with
> error_report() and fails.  qmp_migrate_set_cache_size() detects the
> failure and reports "Parameter 'cache size' expects is smaller than
> page size" with error_setg().  The first error is accurate, the second
> is bogus.  With HMP, we get both.  With QMP, we get the accurate one
> on stderr, and the bogus one via QMP.
>
> Fix by making xbzrle_cache_resize() use error_setg() instead of
> error_report().
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
