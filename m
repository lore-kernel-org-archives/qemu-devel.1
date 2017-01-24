Received: from eggs.gnu.org ([2001:4830:134:3::10]:41086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVxaL-0006JI-4K
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVxaF-00011k-Hi
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:40:17 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1479837270-79005-13-git-send-email-vsementsov@virtuozzo.com>
	(Vladimir Sementsov-Ogievskiy's message of "Tue, 22 Nov 2016 20:54:25
	+0300")
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
	<1479837270-79005-13-git-send-email-vsementsov@virtuozzo.com>
Reply-To: quintela@redhat.com
Date: Tue, 24 Jan 2017 10:40:00 +0100
Message-ID: <87a8agaj9r.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 12/17] migration: add postcopy migration of
 dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> Postcopy migration of dirty bitmaps. Only named dirty bitmaps,
> associated with root nodes and non-root named nodes are migrated.
>
> If destination qemu is already containing a dirty bitmap with the same name
> as a migrated bitmap (for the same node), than, if their granularities are
> the same the migration will be done, otherwise the error will be generated.
>
> If destination qemu doesn't contain such bitmap it will be created.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> new file mode 100644
> index 0000000..28e3732

I only did a fast look at this file, nothing obvious is wrong, but it
was quick O:-)

So

Reviewed-by: Juan Quintela <quintela@redhat.com>
