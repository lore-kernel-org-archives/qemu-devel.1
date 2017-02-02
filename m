Received: from eggs.gnu.org ([2001:4830:134:3::10]:40440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cZKWA-00017i-Am
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cZKW7-0001aX-0I
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:45:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cZKW6-0001Zq-R5
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:45:50 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170202155909.31784-3-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Thu, 2 Feb 2017 15:59:09 +0000")
References: <20170202155909.31784-1-dgilbert@redhat.com>
	<20170202155909.31784-3-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 02 Feb 2017 17:45:43 +0100
Message-ID: <8737fwr16w.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] postcopy: Recover block devices on
 early failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, zhang.zhanghailiang@huawei.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> An early postcopy failure can be recovered from as long as we know
> we haven't sent the command to run the destination.
> We have to undo the bdrv_inactivate_all by calling
> bdrv_invalidate_cache_all
>
> Note that I'm not using ms->block_inactive because once we've
> sent the postcopy package we dont want anything else to try
> and recover the block storage on the source; the destination
> might have started writing to it.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
