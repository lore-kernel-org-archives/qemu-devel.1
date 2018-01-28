Received: from eggs.gnu.org ([2001:4830:134:3::10]:45100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1efs5W-00057y-M1
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 13:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1efs5S-0000pJ-RR
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 13:53:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1efs5S-0000p2-Lv
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 13:53:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E10665F7B1
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 18:53:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171215171655.7818-3-dgilbert@redhat.com> (David Alan Gilbert's
	message of "Fri, 15 Dec 2017 17:16:55 +0000")
References: <20171215171655.7818-1-dgilbert@redhat.com>
	<20171215171655.7818-3-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Sun, 28 Jan 2018 19:53:54 +0100
Message-ID: <87wp01rf0d.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: Route errors down through
 migration_channel_connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Route async errors (especially from sockets) down through
> migration_channel_connect and on to migrate_fd_connect where they
> can be cleaned up.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
