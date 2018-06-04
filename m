Received: from eggs.gnu.org ([2001:4830:134:3::10]:39189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPgYU-0006XR-Rp
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 23:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPgYT-00028h-VH
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 23:53:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39686 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fPgYT-00028a-RO
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 23:53:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5EA894005F67
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 03:53:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180416170930.35504-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 16 Apr 2018 18:09:30 +0100")
References: <20180416170930.35504-1-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 04 Jun 2018 05:56:07 +0200
Message-ID: <87lgbv8aso.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 for 2.13] migration: Don't activate
 block devices if using -S
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Activating the block devices causes the locks to be taken on
> the backing file.  If we're running with -S and the destination libvirt
> hasn't started the destination with 'cont', it's expecting the locks are
> still untaken.
>
> Don't activate the block devices if we're not going to autostart the VM;
> 'cont' already will do that anyway.   This change is tied to the new
> migration capability 'late-block-activate' that defaults to off, keeping
> the old behaviour by default.
>
> bz: https://bugzilla.redhat.com/show_bug.cgi?id=1560854
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
