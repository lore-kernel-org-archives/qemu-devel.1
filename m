Received: from eggs.gnu.org ([2001:4830:134:3::10]:57440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1F2M-0004k4-JP
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1F2K-0005hJ-1w
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:39:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59392 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f1F2J-0005hF-Td
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:38:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E09DA1BCD
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 17:38:59 +0000 (UTC)
References: <20180328170207.49512-1-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6c7d24c3-90dc-f891-a20f-b6788c4d13aa@redhat.com>
Date: Wed, 28 Mar 2018 12:38:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180328170207.49512-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] migration: Don't activate block
 devices if using -S
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, famz@redhat.com, kwolf@redhat.com, jdenemar@redhat.com, peterx@redhat.com

On 03/28/2018 12:02 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Activating the block devices causes the locks to be taken on
> the backing file.  If we're running with -S and the destination libvirt
> hasn't started the destination with 'cont', it's expecting the locks are
> still untaken.
> 
> Don't activate the block devices if we're not going to autostart the VM;
> 'cont' already will do that anyway.
> 
> bz: https://bugzilla.redhat.com/show_bug.cgi?id=1560854
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   migration/migration.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)

Sounds like 2.12 material.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
