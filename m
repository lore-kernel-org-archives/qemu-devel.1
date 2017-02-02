Received: from eggs.gnu.org ([2001:4830:134:3::10]:40419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cZKVy-00010f-BJ
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cZKVu-0001O6-HB
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:45:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cZKVu-0001Mk-7h
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:45:38 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170202155909.31784-2-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Thu, 2 Feb 2017 15:59:08 +0000")
References: <20170202155909.31784-1-dgilbert@redhat.com>
	<20170202155909.31784-2-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 02 Feb 2017 17:45:28 +0100
Message-ID: <877f58r17b.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] Postcopy: Reset state to avoid cleanup
 assert
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
> On a destination host with no userfault support an incoming
> postcopy would cause the state to enter ADVISE before
> it realised there was no support, and because it was in ADVISE
> state it would perform a cleanup at the end.  Since there
> was no support the cleanup function should be unreachable,
> but ends up being called and asserting.
>
> Reset the state when we realise we have no support, thus the
> cleanup doesn't happen.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
