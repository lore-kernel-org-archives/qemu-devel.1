Received: from eggs.gnu.org ([2001:4830:134:3::10]:38452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eiyPl-0005Kz-VG
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 03:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eiyPg-000809-UL
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 03:15:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eiyPg-0007zn-MX
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 03:15:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A809C0587D6
	for <qemu-devel@nongnu.org>; Tue,  6 Feb 2018 08:15:35 +0000 (UTC)
Date: Tue, 6 Feb 2018 16:15:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180206081528.GE25932@xz-mi>
References: <20180205093941.21058-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180205093941.21058-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Recover block devices if
 failure in device state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, kwolf@redhat.com

On Mon, Feb 05, 2018 at 09:39:41AM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> In e91d895 I added the new pause-before-switchover mechanism
> to allow migration completion to be delayed; this changes the
> last state prior to completion to MIGRATE_STATUS_DEVICE rather
> than MIGRATE_STATUS_ACTIVE.
> 
> Fix the failure path in migration_completion to recover the block
> devices if it fails in MIGRATE_STATUS_DEVICE, not just the
> MIGRATE_STATUS_ACTIVE that it previously had.
> 
> This corresponds to rh bz:
>   https://bugzilla.redhat.com/show_bug.cgi?id=1538494
> whose symptom is an occasional source crash on a failed migration.
> 
> Fixes: e91d8951d59d483f085f
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
