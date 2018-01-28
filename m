Received: from eggs.gnu.org ([2001:4830:134:3::10]:45019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1efs4u-0004dF-Gj
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 13:53:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1efs4q-0000f5-H6
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 13:53:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1efs4q-0000eI-Bw
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 13:53:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8411B87624
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 18:53:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171215171655.7818-2-dgilbert@redhat.com> (David Alan Gilbert's
	message of "Fri, 15 Dec 2017 17:16:54 +0000")
References: <20171215171655.7818-1-dgilbert@redhat.com>
	<20171215171655.7818-2-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Sun, 28 Jan 2018 19:53:12 +0100
Message-ID: <871si9stlz.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: Allow migrate_fd_connect to
 take an Error *
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
> Allow whatever is performing the connection to pass migrate_fd_connect
> an error to indicate there was a problem during connection, an allow
> us to clean up.
>
> The caller must free the error.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
