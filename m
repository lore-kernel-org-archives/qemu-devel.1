Received: from eggs.gnu.org ([2001:4830:134:3::10]:59134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWi73-0002dl-6X
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWi72-0000Qn-Bs
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:25:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWi72-0000P0-6G
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:25:40 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AA1E368E6
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 12:25:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180103122017.14794-5-peterx@redhat.com> (Peter Xu's message of
	"Wed, 3 Jan 2018 20:20:08 +0800")
References: <20180103122017.14794-1-peterx@redhat.com>
	<20180103122017.14794-5-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 03 Jan 2018 13:25:34 +0100
Message-ID: <87o9mbyvr5.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 04/13] migration: split use of
 MigrationState.total_time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> It was used either to:
>
> 1. store initial timestamp of migration start, and
> 2. store total time used by last migration
>
> Let's provide two parameters for each of them.  Mix use of the two is
> slightly misleading.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
