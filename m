Received: from eggs.gnu.org ([209.51.188.92]:46764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxedT-00056i-4S
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxedS-0005Bd-DE
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:15:03 -0500
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-5-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bbcf825a-4c83-2dbc-23ab-96de3d554af1@redhat.com>
Date: Sat, 23 Feb 2019 15:14:39 -0600
MIME-Version: 1.0
In-Reply-To: <20190223000614.13894-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 04/10] block/dirty-bitmap: change
 semantics of enabled predicate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

On 2/22/19 6:06 PM, John Snow wrote:
> Currently, the enabled predicate means something like:
> "the QAPI status of the bitmap is ACTIVE."
> After this patch, it should mean exclusively:
> "This bitmap is recording guest writes, and is allowed to do so."
> 
> In many places, this is how this predicate was already used.
> Internal usages of the bitmap QPI can call user_locked to find out if
> the bitmap is in use by an operation.
> 
> To accommodate this, modify the create_successor routine to now
> explicitly disable the parent bitmap at creation time.
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
