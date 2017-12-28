Received: from eggs.gnu.org ([2001:4830:134:3::10]:38059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eUeSx-00054C-62
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 15:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eUeSs-00026b-Q3
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 15:07:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eUeSs-00024l-JH
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 15:07:42 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171228091616.7999-1-vsementsov@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Thu, 28 Dec 2017 12:16:16 +0300")
References: <20171228091616.7999-1-vsementsov@virtuozzo.com>
Reply-To: quintela@redhat.com
Date: Thu, 28 Dec 2017 21:07:37 +0100
Message-ID: <878tdmboqe.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: finalize current_migration
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> current_migration has .instance_finalize callback, but it is not
> called, because nobody unrefs current_migration. Fix that.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
