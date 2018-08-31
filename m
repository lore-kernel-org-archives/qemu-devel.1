Received: from eggs.gnu.org ([2001:4830:134:3::10]:34953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fvefE-0006RH-Uz
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fvefA-0007Az-2H
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:20:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fvef9-0007AQ-Sw
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:20:15 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180830173657.22939-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Thu, 30 Aug 2018 18:36:57 +0100")
References: <20180830173657.22939-1-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 31 Aug 2018 10:20:03 +0200
Message-ID: <87h8jbne18.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: Fix uninitialised
 rdma_return_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, cohuck@redhat.com, jemmy858585@gmail.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Clang correctly errors out moaning that rdma_return_path
> is used uninitialised in the earlier error paths.
> Make it NULL so that the error path ignores it.
>
> Fixes: 55cc1b5937a8e709e4c102e74b206281073aab82
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reprorted by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued
